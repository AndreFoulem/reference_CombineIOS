//
//  Timer_Publisher.swift
//  CombineApp
//
//  Created by AndreMacBook on 2023-03-02.
//

import SwiftUI
import Combine

class TimerPub: ObservableObject {
  @Published var data: [String] = []
  @Published var interval: Double = 2.0
  
  private var timerCancellable: AnyCancellable?
  private var intervalCancellable: AnyCancellable?
  
  let timeFormatter = DateFormatter()
  
  init() {
    timeFormatter.dateFormat = "HH:mm:ss.SSS"
    
    intervalCancellable = $interval
      .dropFirst()
      .sink { [unowned self] interval in
        // restart the timer pipe
        timerCancellable?.cancel()
        data.removeAll()
        self.start()
      }
  }//init
  
  func start() {
    timerCancellable = Timer
      .publish(every: interval, on: .main, in: .common)
      .autoconnect()
      .sink { [unowned self] (datum) in
        data.append(timeFormatter.string(from: datum))
      }
  }
  
}


struct Timer_Publisher: View {
  @StateObject private var vm = TimerPub()
  
    var body: some View {
      VStack {
        Slider(value: $vm.interval , in: 0.1...2.0,
               minimumValueLabel: Image(systemName: "hare"),
               maximumValueLabel: Image(systemName: "tortoise"),
               label: { Text("interval") })
        .padding(.horizontal)
        
        
        List(vm.data, id: \.self) { datum in
          Text(datum)
        }
      }
      .onAppear {
        vm.start()
      }
  }
}

struct Timer_Publisher_Previews: PreviewProvider {
    static var previews: some View {
        Timer_Publisher()
    }
}

