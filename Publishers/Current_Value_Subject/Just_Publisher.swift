//
//  Just_Publisher.swift
//  CombineApp
//
//  Created by AndreMacBook on 2023-03-01.
//

import SwiftUI
import Combine


class JustPublisherModel: ObservableObject {
  @Published var data = ""
  @Published var dataToView: [String] = []
  
  func fetch() {
    let dataIn = ["all","john","andre"]
    
    _ = dataIn.publisher
      .sink { [unowned self] item in
        dataToView.append(item)
      }
    
    if dataIn.count > 0 {
      Just(dataIn[0])
        .map { item in
          item.uppercased()
        }
        .assign(to: &$data)
    }
  }
}

struct Just_Publisher: View {
  @StateObject private var vm = JustPublisherModel()
   
  var body: some View {
    VStack {
      Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
      Text(vm.data)
 
    }
    .onAppear {
      vm.fetch()
    }
  }
}

struct Just_Publisher_Previews: PreviewProvider {
    static var previews: some View {
        Just_Publisher()
    }
}
