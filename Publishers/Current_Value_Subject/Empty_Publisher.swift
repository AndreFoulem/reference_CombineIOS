//
//  Empty_Publisher.swift
//  CombineApp
//
//  Created by AndreMacBook on 2023-02-28.
//

//-> ! Using the catch operator you can intercept all errors coming down from an upstream publisher and replace them with an EMPTY PUBLISHER.

import SwiftUI
import Combine

class Empty_IntroViewModel: ObservableObject {
  @Published var dataToView: [String] = []
  
  enum myError: Error {
    case fail
  }
  
  func fetch() {
    let dataIn = ["Value 1", "Value2", "T", "Value 3"]
    
    _ = dataIn.publisher
      .tryMap { item in
        if item == "T" { throw myError.fail }
        return item
      }
      .catch { error in
        Empty()
      }
      .sink { [unowned self] item in
        dataToView.append(item)
      }
  }
  
}

struct Empty_Publisher: View {
  @StateObject var vm = Empty_IntroViewModel()
  
    var body: some View {
      List(vm.dataToView, id: \.self) { item in
        Text(item)
      }
      .onAppear() {
        vm.fetch()
      }
    }
  
}

struct Empty_Publisher_Previews: PreviewProvider {
    static var previews: some View {
        Empty_Publisher()
    }
}
