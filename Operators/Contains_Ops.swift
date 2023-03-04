//
//  Contains_Ops.swift
//  CombineApp
//
//  Created by AndreMacBook on 2023-03-03.
//

import SwiftUI
import Combine

class ContainsOpsModel: ObservableObject {
  @Published var description = ""
  @Published var airconditioning = false
  @Published var heating = false
  @Published var basement = false
  
  private var cancellables: [AnyCancellable] = []
  
  func fetch() {
    let inData = ["3 bedrooms", "2 bedrooms", "Air conditioning", "Basement"]
    
    inData.publisher
      .prefix(2)
      .sink { [unowned self] (item) in
        description += item + "\n"
      }
      .store(in: &cancellables)
    
    inData.publisher
      .contains("Air conditioning")
      .assign(to: &$airconditioning)
    
    inData.publisher
      .contains("Heating")
      .assign(to: &$heating)
    
    inData.publisher
      .contains("Basement")
      .assign(to: &$basement)
  }
}

struct Contains_Ops: View {
  @StateObject var vm = ContainsOpsModel()
  
    var body: some View {
     VStack {
        Text(vm.description)
        Toggle("basement", isOn: $vm.basement)
        Toggle("Air conditionent", isOn: $vm.airconditioning)
        Toggle("heating", isOn: $vm.heating)
      }
      .onAppear{
        vm.fetch()
      }
    }
}

struct Contains_Ops_Previews: PreviewProvider {
    static var previews: some View {
        Contains_Ops()
    }
}
