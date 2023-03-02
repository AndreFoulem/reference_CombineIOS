//
//  Sequence_Publisher.swift
//  CombineApp
//
//  Created by AndreMacBook on 2023-03-02.
//
//* Array built-in Sequence Publisher


import SwiftUI
import Combine


class SequencePubModel: ObservableObject {
  @Published var dataToView: [String] = []
  var cancellables: Set<AnyCancellable> = []
  
  var dataIn = ["Paul", "Lem", "andre", "joe", "steve"]
  
  // fetch data
  func fetch() {
    dataIn.publisher
      .sink(receiveCompletion: { (completion) in
         print(completion)
      }, receiveValue: { [unowned self] datum in
        self.dataToView.append(datum)
        print(datum)
      })
      .store(in: &cancellables)
}

struct Sequence_Publisher: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}


struct Sequence_Publisher_Previews: PreviewProvider {
    static var previews: some View {
        Sequence_Publisher()
    }
}
