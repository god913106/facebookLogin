//
//  ViewController.swift
//  FacebookLogin
//
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let loginButton = FBSDKLoginButton()
        loginButton.center = view.center
        
        // 用戶會看見您應用程式要求授權的提示。請注意，部分權限需要經過登入審查。
        // Add to your viewDidLoad method:
        loginButton.readPermissions = ["public_profile", "email"]
        loginButton.delegate = self
        view.addSubview(loginButton)
        
    }

    //MARK: - FBSDKLoginButtonDelegate
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
        }else if result.isCancelled{
            print("用戶取消登入")
        }else {
            if result.grantedPermissions.contains("email") {
                if let graphRequest = FBSDKGraphRequest (graphPath: "me", parameters: ["fields":"email, name"]){
                    graphRequest.start { (connection, result, error) in
                        if error != nil {
                            print(error!)
                        }else {
                            if let userDeets = result {
                                print(userDeets)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("登出")
    }

}

