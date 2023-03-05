//
//  MeasureInterval.swift
//  CombineApp
//
//  Created by AndreMacBook on 2023-03-04.
//

import SwiftUI
import Combine
import Foundation

class MeasureInterval_Model: ObservableObject {
  @Published var speed: TimeInterval = 0.0
  var timeEvent = PassthroughSubject<Void, Never>()

  
  private var cancellable: AnyCancellable?
  
  init() {
    cancellable = timeEvent
      .measureInterval(using: RunLoop.main)
      .sink { [unowned self] (stride) in
        speed = stride.timeInterval
      }
  }
  
}

struct MeasureInterval: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct MeasureInterval_Previews: PreviewProvider {
    static var previews: some View {
        MeasureInterval()
    }
}
