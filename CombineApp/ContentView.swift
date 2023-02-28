//
//  ContentView.swift
//  CombineApp
//
//  Created by AndreMacBook on 2023-02-27.
//

import SwiftUI
import Combine

class MultiplePipeline: ObservableObject {
  
  @Published var firstName: String = ""
  @Published var firstNameValidation: String = ""
  @Published var lastName: String = ""
  @Published var lastNameValidation: String = ""
  
  private var validationCancellables: Set<AnyCancellable> = []
  
  init() {
    $firstName
      .map { $0.isEmpty ? "X" : "ok" }
      .sink { [unowned self] value in
        self.firstNameValidation = value
      }
      .store(in: &validationCancellables)
    
    $lastName
      .map { $0.isEmpty ? "X" : "ok" }
      .sink { [unowned self] value in
        self.lastNameValidation = value
      }
      .store(in: &validationCancellables)
  }// init
  
  func cancelAllvalidation() {
    validationCancellables.removeAll()
  }
}

//  func refreshData() {
//    data = "Finished Process"
//  }
//
//  func cancel() {
//    cancellablePipeline = nil
//    status = "Cancelled"
////      cancellablePipeline?.cancel()
//  }
//
//}

struct ContentView: View {
  @StateObject private var vm = MultiplePipeline()
  
    var body: some View {
      VStack {
        Text("Pipeline")
          .font(.largeTitle)
        Divider()
        
        Group {
          HStack {
            TextField("first name", text:  $vm.firstName)
              .textFieldStyle(RoundedBorderTextFieldStyle())
            Text(vm.firstNameValidation)
          }
          HStack {
            TextField("last name", text:  $vm.lastName)
              .textFieldStyle(RoundedBorderTextFieldStyle())
            Text(vm.lastNameValidation)
          }
        }
        
        Button("Cancel all") {
          vm.cancelAllvalidation()
        }
        
      }//vstack
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
