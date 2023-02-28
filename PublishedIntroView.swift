//
//  PublishedIntroView.swift
//  CombineApp
//
//  Created by AndreMacBook on 2023-02-27.
//

import SwiftUI
import Combine

class Published_IntroductionViewModel: ObservableObject {
  var characterLimit = 10
  @Published var data: String = ""
  @Published var characterCount: Int = 0
  @Published var countColor: Color = Color.gray
  
  init() {
    $data
      .map { data -> Int in
        return data.count
      }
      .assign(to: &$characterCount)
      
    
    $characterCount
      .map { [unowned self ] count -> Color in
        let eightyPercent = Int(Double(self.characterLimit) * 0.8)
        
        if(eightyPercent...characterLimit).contains(count) {
          return Color.yellow
        } else if count > characterLimit {
          return Color.red
        }
        return Color.gray
      }
      .assign(to: &$countColor)
    
  }//init
}

struct PublishedIntroView: View {
  @StateObject private var vm = Published_IntroductionViewModel()
  
    var body: some View {
      VStack(spacing: 30) {
        Text("Published")
        
        TextEditor(text: $vm.data)
          .border(.gray, width: 1)
          .frame(height: 200)
          .padding()
        
        Text("\(vm.characterCount) / \(vm.characterLimit)")
          .foregroundColor(vm.countColor)
      }
    }
}

struct PublishedIntroView_Previews: PreviewProvider {
    static var previews: some View {
        PublishedIntroView()
    }
}
