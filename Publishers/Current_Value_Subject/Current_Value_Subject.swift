//////
//////  CurrentValueSubject.swift
//////  CombineApp
//////
//////  Created by AndreMacBook on 2023-02-27.
//////
////
//import Foundation
//import Combine
//
//struct Uploader {
//  enum State {
//    case pending, uploading, finished
//  }
//  enum Error: Swift.Error {
//    case uploadFailed
//  }
//  
//  let subject = CurrentValueSubject<State, Error>(.pending)
//  
//  func startUpload() {
//    subject.send(.uploading)
//  }
//  
//  func finishUpload() {
//    subject.value = .finished
//    subject.send(completion: .finished)
//  }
//  
//  func failUpload() {
//    subject.send(completion: .failure(.uploadFailed))
//  }
//}
//
//let uploader = Uploader()
//
//func test() {
//  uploader.subject.sink { completion in
//    
//    switch completion {
//      case .finished:
//        print("recieved finished")
//      case .failure(let error):
//        print("received error")
//        
//    } receiveValue: { message in
//      print("receive message: \(message)")
//    }
//    
//  }
//  
//}


