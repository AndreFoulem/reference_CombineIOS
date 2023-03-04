//  //
//  //  AllStatisfy_Ops.swift
//  //  CombineApp
//  //
//  //  Created by AndreMacBook on 2023-03-03.
//  //
//
//import SwiftUI
//import Combine
//
//struct InvalidNumberError: Error, Identifiable {
//  var id = UUID()
//  // conforms to identifiable so it can throws an alert in the view
//}
//
//class TryAllSatisfyModel: ObservableObject {
//  @Published var numbers: [Int] = []
//  @Published var allFibonacciNumbers = false
//  @Published var invalidNumberError: InvalidNumberError?
//  
//  func allFibonacciCheck() {
//    let fibTo144 = [0,1,1,2,3,5,8,13]
//    
//    numbers.publisher
//      .tryAllSatisfy { (number) in
//        if number > 13 { throw InvalidNumberError() }
//        return fibTo144.contains(number)
//      }
//      .sink { [unowned self] (completion) in
//        switch completion {
//          case .failure(let error):
//            self.invalidNumberError = error as? InvalidNumberError
//          default:
//            break
//        }
//      } receiveValue: { [unowned self] (result) in
//        allFibonacciNumbers = result
//      }
//  }
//  
//  func add(number: String) {
//    if numbers.isEmpty { return }
//    numbers.append(Int(number) ?? 0)
//  }
//}
//
//struct TryAllStatisfy_Ops: View {
//  @StateObject var vm = AllSatisfyModel()
//  @State var number = ""
//  @State var resultVisible = false
//  
//  var body: some View {
//    VStack {
//      TextField("add a number", text: $number)
//      
//      Button(action: {
//        vm.add(number: number)
//        number = ""
//      }, label: { Image(systemName: "plus")})
//      
//      List(vm.numbers, id:\.self) {
//        Text("\($0)nnn")
//      }
//      
//      Button("fib numbers") {
//        vm.allFibonacciCheck()
//        resultVisible = true
//      }
//      
//      Text(vm.allFibonacciNumbers ? "yes" : "no")
//    }//VS
//    .alert(item: $vm.invalidNumberError) { error in
//      Alert(title: Text("asdf"),
//            primaryButton: .default(Text("start"),
//            action: {
//                  vm.numbers.removeAll()
//            }),
//            secondaryButton: .cancel()
//      )
//    }
//  }
//}
//
//struct TryAllStatisfy_Ops_Previews: PreviewProvider {
//  static var previews: some View {
//    AllStatisfy_Ops()
//  }
//}
