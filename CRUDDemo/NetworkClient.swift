//
//  NetworkClient.swift
//  CRUDDemo
//
//  Created by Agustín Embuena on 4/11/21.
//


import Foundation
import Alamofire

struct NetworkClient {
  static let shared = NetworkClient()
  let session: Session
  
  init() {
    self.session = Session()
  }
  
  static func request(_ convertible: URLRequestConvertible) -> DataRequest {
    shared.session.request(convertible).validate()
  }
  
  
}
