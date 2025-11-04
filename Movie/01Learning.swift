//
//  Templates.swift
//  Movie
//
//  Created by viraj shah on 04/11/25.
//

//comand + option + left arrow  == fold the code

import Foundation

class ABC{
    func display() -> Void {
        print("Hello")
    }
}

//here inheritance is done
class BCD: ABC {
    func display2() -> Void{
        print("Hello2")
    }
}

//you can add the functionality without changing the ABC class
extension ABC{
    func display1() -> Void{
        print("Hello1")
    }
}

/*
 // this is forEach loop (moved out of top level to avoid build errors)
 let names = ["Viraj", "Aarav", "Maya"]

 func demoForEach() {
     names.forEach { name in
         print("Hello, \(name)")
     }
 }

 // here ForEach() is different
 // Here ForEach is a SwiftUI View that repeats a subview for each item.
 // This must be inside a SwiftUI View type, not at the top level.

 // import SwiftUI
 // struct DemoForEachView: View {
 //     let items = [1, 2, 3]
 //     var body: some View {
 //         VStack {
 //             ForEach(items, id: \.self) { item in
 //                 Text("Item \(item)")
 //             }
 //         }
 //     }
 // }
*/
