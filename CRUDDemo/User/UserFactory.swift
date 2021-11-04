//
//  UserModule.swift
//  CRUDDemo
//
//  Created by Agustín Embuena on 4/11/21.
//

class UserFactory {

    static let factory = UserFactory()
 
    func createUser(_ user: User, completion: @escaping (Bool) -> Void) {
        NetworkClient.request(UserRouter.create(user)).response { response in
            switch response.result {
            case .failure(let error):
                print("Error saving user: \(String(describing: error))")
                completion(false)
            case .success:
                completion(true)
            }
        }
    }
}
