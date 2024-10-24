import Foundation

// Частина 1
class Operand {
    var number: Int
    var operand: Operand?

    var sumClosure: (() -> Int)?

    init(number: Int) {
        self.number = number
        sumClosure = {
            return self.number + (self.operand?.number ?? 0)
        }
    }

    deinit {
        print("Operand with number \(number) is deallocated")
    }
}

// Функція для створення retainCycle
func createRetainCycle() {
    let op1 = Operand(number: 5)
    let op2 = Operand(number: 10)
    op1.operand = op2
    op2.operand = op1 // Це призводить до циклу утримання

    // Виклик closure
    print("Sum: \(op1.sumClosure!())") // Виведе: Sum: 15
}

// Викликаємо функцію для створення циклу утримання
createRetainCycle()

// Функція для усунення циклу утримання
func createRetainCycleFixed() {
    class Operand {
        var number: Int
        weak var operand: Operand? // Використовуємо weak для уникнення циклу утримання

        var sumClosure: (() -> Int)?

        init(number: Int) {
            self.number = number
            sumClosure = { [weak self] in
                return self?.number ?? 0 + (self?.operand?.number ?? 0)
            }
        }

        deinit {
            print("Operand with number \(number) is deallocated")
        }
    }

    let op1 = Operand(number: 5)
    let op2 = Operand(number: 10)
    op1.operand = op2
    op2.operand = op1 // Тепер це не призводить до циклу утримання

    // Виклик closure
    print("Sum: \(op1.sumClosure!())") // Виведе: Sum: 15
}

// Викликаємо функцію для усунення циклу утримання
createRetainCycleFixed()

// Частина 2
class OperandWithClosure {
    var number: Int
    var operationClosure: (() -> Void)?

    init(number: Int) {
        self.number = number
        print("init for \(number)")

        operationClosure = { [weak self] in
            print("Executing closure for \(self?.number ?? 0)")
        }
    }

    deinit {
        print("deinit for \(number)")
    }
}

// Створюємо об'єкт типу Operand і відразу занілити його
var opWithClosure: OperandWithClosure? = OperandWithClosure(number: 20)

// Виклик closure
opWithClosure?.operationClosure?() // Виведе: Executing closure for 20

// Занулюємо об'єкт, щоб перевірити деініціалізацію
opWithClosure = nil

// Модифікація з використанням weak
class OperandWithClosureFixed {
    var number: Int
    var operationClosure: (() -> Void)?

    init(number: Int) {
        self.number = number
        print("init for \(number)")

        // Використовуємо weak в capture list
        operationClosure = { [weak self] in
            print("Executing closure for \(self?.number ?? 0)")
        }
    }

    deinit {
        print("deinit for \(number)")
    }
}

// Створюємо об'єкт
var opWithClosureFixed: OperandWithClosureFixed? = OperandWithClosureFixed(number: 30)

// Виклик closure
opWithClosureFixed?.operationClosure?() // Виведе: Executing closure for 30

// Занулюємо об'єкт
opWithClosureFixed = nil
