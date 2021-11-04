//
//  UserRouter.swift
//  CRUDDemo
//
//  Created by Agustín Embuena on 4/11/21.
//

import Foundation
import Alamofire

enum UserRouter: URLRequestConvertible {
    enum Constants {
        static let baseURLPath = Endpoints.baseURL
    }
    
    case getAll
    case getOne(Int)
    case update(User)
    case delete(Int)
    case create(User)
    
    var method: HTTPMethod {
        switch self {
        case .getAll, .getOne:
            return .get
        case .create:
            return .post
        case .update:
            return .put
        case .delete:
            return .delete
        }
    }
    
    var path: String {
      switch self {
      case .delete(let userID), .getOne(let userID):
          return "User/\(userID)"
      default:
          return "User"
      }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .create(let user):
            return ["name": user.name, "birthdate": user.birthdate, "id":0]
        case .update(let user):
            return ["name": user.name, "birthdate": user.birthdate, "id":user.id]
        default:
            return [:]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseURLPath.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.timeoutInterval = TimeInterval(10*1000)
        if parameters.count > 0 {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                request.httpBody = jsonData
            }catch{
                print("serialize params error ")
            }
        }
        return request
    }
}
