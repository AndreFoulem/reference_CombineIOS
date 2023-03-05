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
  @StateObject var vm = MeasureInterval_Model()
  @State var ready = false
  @State var showSpeed = false
  
    var body: some View {
      VStack {
        Button("Start") {
          DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.5...2.0)) {
            ready = true
            vm.timeEvent.send()
          }
        }
        
        Button(action: {
          vm.timeEvent.send()
          showSpeed = true
        },
               label: {
          RoundedRectangle(cornerRadius: 25.0).fill(ready ? Color.green : Color.secondary)
        })
        
        Text("Reaction spped: \(vm.speed)")
          .opacity(showSpeed ? 1 : 0)
      }
    }
}

struct MeasureInterval_Previews: PreviewProvider {
    static var previews: some View {
        MeasureInterval()
    }
}
