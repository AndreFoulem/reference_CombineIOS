//
//  Fail_Publisher.swift
//  CombineApp
//
//  Created by AndreMacBook on 2023-02-28.
//

//-> Fail is a publisher that publishes a failure (with an error). Ex: You put publishers insinde of props and functions. Within the property getter or the fn body you can evaluate the input. If input valid return a publisher, else return a fail publisher.
enum InvalidAgeError: String, Error, Identifiable {
  var id: String { rawValue }
  case lessThanZero
}

class Validators {
  
  static func validAgePublisher(age: Int) -> AnyPublisher<Int, InvalidAgeError> {
    if age < 30 {
      return Fail(error: InvalidAgeError.lessThanZero)
        .eraseToAnyPublisher()
    }
    
    return Just(age)
      .setFailureType(to: InvalidAgeError.self)
      .eraseToAnyPublisher()
    
  }
}

class Fail_IntroViewModel: ObservableObject {
  @Published var age = 0
  @Published var error: InvalidAgeError?
  
  func save(age: Int) {
    _ = Validators.validAgePublisher(age: age)
      .sink { [unowned self] completion in
        if case .failure(let error) = completion {
          self.error = error
        }
      } receiveValue: { [unowned self] age in
        self.age = age
      }
  }
}

import SwiftUI
import Combine

struct Fail_Publisher: View {
  
  @StateObject private var vm = Fail_IntroViewModel()
  @State private var age = ""
  
  var body: some View {
    VStack{
      TextField("Enter Age", text: $age)
        .keyboardType(.numberPad)
        .padding()
      
      Button("Save") {
        vm.save(age: Int(age) ?? -1)
      }
    }
    .alert(item: $vm.error) { error in
      Alert(title: Text("invalid"), message: Text(error.rawValue))
    }
    
  }
  
}

struct Fail_Publisher_Previews: PreviewProvider {
    static var previews: some View {
        Fail_Publisher()
    }
}
