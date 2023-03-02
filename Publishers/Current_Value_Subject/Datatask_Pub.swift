//
//  Datatask_Pub.swift
//  CombineApp
//
//  Created by AndreMacBook on 2023-03-02.
//

import SwiftUI
import Combine

struct CatFact: Decodable {
  let _id: String
  let text: String
}

class URLDataTaskPub: ObservableObject {
  @Published var dataToView: [CatFact] = []
  var cancellables: Set<AnyCancellable> = []
  
  let url = URL(string: "https://cat-fact.herokuapp.com/facts")!
  func fetch() {
    URLSession.shared.dataTaskPublisher(for: url)
      .map { (data: Data, response: URLResponse) in
        return data
      }
      .decode(type: [CatFact].self, decoder: JSONDecoder())
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        print(completion)
      }, receiveValue: { [unowned self] catFact in
        self.dataToView = catFact
            })
      .store(in: &cancellables)
  }
}

struct Datatask_Pub: View {
  @StateObject private var vm = URLDataTaskPub()
  
    var body: some View {
      VStack {
        List(vm.dataToView, id: \._id) { catFact in
          Text(catFact.text)
        }
      }
      .onAppear {
        vm.fetch()
      }
    }
}

struct Datatask_Pub_Previews: PreviewProvider {
    static var previews: some View {
        Datatask_Pub()
    }
}
