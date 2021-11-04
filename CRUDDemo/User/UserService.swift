//
//  UserFactory.swift
//  CRUDDemo
//
//  Created by Agustín Embuena on 4/11/21.
//
import  Alamofire

class UserService {

    static let service = UserService()
    
    
    func editUser(_ user: User, completion: @escaping (Bool) -> Void) {
        NetworkClient.request(UserRouter.update(user)).response { response in
            switch response.result {
            case .failure(let error):
                print("Error updating user: \(String(describing: error))")
                completion(false)
            case .success:
                completion(true)
            }
        }
    }
    
    
    func getAllUsers(completion: @escaping ([User]?) -> Void) {
        NetworkClient.request(UserRouter.getAll).response { response in
            switch response.result {
            case .failure(let error):
                print("Error while fetching users: \(String(describing: error))")
                completion(nil)
                return
            case .success(let usersResponse):
                
                
                do{
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                let allUsers = try decoder.decode([User].self, from: usersResponse!)
                    
                    completion(allUsers)
                }catch {
                    print("Error: \(error)")
                }
                
                return
            }
        }
    }
    
    
    func getUser(_ userID: Int, completion: @escaping (Bool) -> Void) {
        NetworkClient.request(UserRouter.getOne(userID)).response  { response in
            switch response.result {
            case .failure(let error):
                print("Error getting user: \(String(describing: error))")
                completion(false)
            case .success:
                completion(true)
            }
        }
    }
    
    
    func deleteUser(_ userID: Int, completion: @escaping (Bool) -> Void) {
        NetworkClient.request(UserRouter.delete(userID)).response { response in
            switch response.result {
            case .failure(let error):
                print("Error deleting user: \(String(describing: error))")
                completion(false)
            case .success:
                completion(true)
            }
        }
    }
    
    
    func prettyDate(_ dateString:String) -> String{
        let date = dateString.toDate()
        return date.toString()
    }
    
    func requestDate(_ dateString:String) -> String{
        let date = dateString.toDateRequest()
        return date.toRequestString()
    }
    
    
}


