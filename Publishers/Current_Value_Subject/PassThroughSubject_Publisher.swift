//
//  PassThroughSubject_Publisher.swift
//  CombineApp
//
//  Created by AndreMacBook on 2023-03-01.
//

import SwiftUI
import Combine

enum CreditCardStatus {
  case ok, invalid, notEvaluated
}

class PTSModel: ObservableObject {
  @Published var creditCard: String = ""
  @Published var status = CreditCardStatus.notEvaluated
  let verifyCreditCard = PassthroughSubject<String, Never>()
  
  init() {
    
    verifyCreditCard
      .map{ creditCard -> CreditCardStatus
        if creditCard.count == 16 {
          return CreditCardStatus.ok
        } else {
          return CreditCardStatus.invalid
        }
      }//map
      .assign(to: &$status)
    
    }
}



struct PassThroughSubject_Publisher: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PassThroughSubject_Publisher_Previews: PreviewProvider {
    static var previews: some View {
        PassThroughSubject_Publisher()
    }
}
