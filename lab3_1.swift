import Foundation

// 1. Створити клас Person і описати в ньому властивість name.
class Person {
    var name: String
    var child: Son? // властивість child для зберігання посилання на об'єкт типу Son

    // 2. В ініціалізаторі присвоїти ім'я і вивести в лог
    init(name: String) {
        self.name = name
        print("\(name) was initialized")
    }

    // 3. Описати deinit і вивести в лог інформацію
    deinit {
        print("\(name) was deallocated")
    }
}

// 7. Створити об’єкт Son (з логами в init/deinit як і в Person) з властивістю parent
class Son {
    var name: String
    weak var parent: Person? // використовуємо weak для уникнення циклу утримання

    init(name: String) {
        self.name = name
        print("\(name) (Son) was initialized")
    }

    deinit {
        print("\(name) (Son) was deallocated")
    }
}

// 4. Створити об’єкт типу Person
var john: Person? = Person(name: "John")

// 6. Створимо scope (do {}), щоб спостерігати за логами деініціалізації
do {
    let mike: Son? = Son(name: "Mike")
    john?.child = mike
    mike?.parent = john
}

// 5. Після завершення блока do, об'єкт має бути деалокований, якщо немає циклів утримання
john = nil
