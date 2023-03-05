//
//  MeasureInterval.swift
//  CombineApp
//
//  Created by AndreMacBook on 2023-03-04.
//

import SwiftUI
import Combine

class MeasureInterval_Model: ObservableObject {
  @published var speed: TimeInterval = 0.0
  var item = PassThroughSubject<Void, Never>()
  
  private var cancellable: AnyCancellable?
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
