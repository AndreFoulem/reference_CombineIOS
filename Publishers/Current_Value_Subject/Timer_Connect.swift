//
//  Timer_Connect.swift
//  CombineApp
//
//  Created by AndreMacBook on 2023-03-02.
//

import SwiftUI
import Combine

class TimerConnectModel: ObservableObject {
  @Published var data: [String] = []
 
  private var timerPublisher = Timer.publish(every: 1, on: .main, in: .common)
  private var timerCancellable: Cancellable?
  private var cancellables: Set<AnyCancellable> = []
  
  let timeFormatter = DateFormatter()
  
  init() {
    timeFormatter.dateFormat = "HH:mm:ss.SSS"
    
    timerPublisher
      .sink { [unowned self] (datum) in
        data.append(timeFormatter.string(from: datum))
      }
      .store(in: &cancellables)
   
  }//init
  
  
  func start() {
    timerCancellable = timerPublisher.connect()
  }
  
  func stop() {
    timerCancellable?.cancel()
    data.removeAll()
  }
}


struct Timer_Connect: View {
  @StateObject var vm = TimerConnectModel()
  
    var body: some View {
      VStack {
        Button("connect") { vm.start() }
        Button("sto") { vm.stop() }
        List(vm.data, id: \.self) { datum in
          Text(datum)
        }
      }
    }
}

struct Timer_Connect_Previews: PreviewProvider {
    static var previews: some View {
        Timer_Connect()
    }
}
