//
//  AllStatisfy_Ops.swift
//  CombineApp
//
//  Created by AndreMacBook on 2023-03-03.
//

import SwiftUI
import Combine

class AllSatisfyModel: ObservableObject {
  @Published var numbers: [Int] = []
  @Published var allFibonacciNumbers = false
  
  func allFibonacciCheck() {
    let fibTo144 = [0,1,1,2,3,5,8,13]
    
    numbers.publisher
      .allSatisfy { fibTo144.contains($0) }
    //-> assigned True or False from .allSatisfy
      .assign(to: &$allFibonacciNumbers)
  }
  
  func add(number: String) {
    if numbers.isEmpty { return }
    numbers.append(Int(number) ?? 0)
  }
}

struct AllStatisfy_Ops: View {
  @StateObject var vm = AllSatisfyModel()
  @State var number = ""
  @State var resultVisible = false
  
    var body: some View {
      VStack {
        TextField("add a number", text: $number)
        
        Button(action: {
          vm.add(number: number)
          number = ""
        }, label: { Image(systemName: "plus")})
        
        List(vm.numbers, id:\.self) {
          Text("\($0)nnn")
        }
        
        Button("fib numbers") {
          vm.allFibonacciCheck()
          resultVisible = true
        }
        
        Text(vm.allFibonacciNumbers ? "yes" : "no")
      }
    }
}

struct AllStatisfy_Ops_Previews: PreviewProvider {
    static var previews: some View {
        AllStatisfy_Ops()
    }
}
