//
//  Future_Promise_Publisher.swift
//  CombineApp
//
//  Created by AndreMacBook on 2023-02-28.
//
//** NewApiPublisher -> {Deffered { Future: Promise(Result.success(type) or Result.failure(error) } }

import SwiftUI
import Combine

class Future_IntroViewModel: ObservableObject {
   @Published var hello = ""
   @Published var goodbye = ""
  
   var goodbuyCancellable: AnyCancellable?
  //-> promise Result.success and Result.failure
  //-> Sink returns any cancellable
  //-> Future publishers execute immediatly
  
  //-> The deffered publisher is a wrapper for the Future<promise> publisher. The Future publisher will execute everytime the wrapper is called. The wrapper will called a different instance of promise
  func sayHello() {
    Future<String, Never> { promise in
      promise(Result.success("Hello World"))
    }
    .assign(to: &$hello)
  }
  
  func sayGoodbuy() {
    let futurePublisher = Deferred {
      
      Future<String, Never> { promise in
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {      promise(Result.success("GoodBuy"))
        }
        
      }
    }
   
    self.goodbuyCancellable = futurePublisher
      .sink { [unowned self ] message in
        self.goodbye = message
      }
  }
  
}

struct Future_Promise_Publisher: View {
  @StateObject private var vm = Future_IntroViewModel()
  
    var body: some View {
      VStack {
        Button("Say Hello") {
          vm.sayHello()
        }
        Text(vm.hello)
          .padding(.bottom)
        Button("Say Goodbuy"){
          vm.sayGoodbuy()
        }
        Text(vm.goodbye)
        
      }
 
    }
}

struct Future_Promise_Publisher_Previews: PreviewProvider {
    static var previews: some View {
        Future_Promise_Publisher()
    }
}
