//
//  LoginViewController.swift
//  Login
//
//  Created by Paige Plander on 4/5/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var login : UITextField!
    var pass : UITextField!
    
    // Constants used in the LoginViewController
    struct Constants {
        static let backgroundColor: UIColor = UIColor(hue: 0.5389, saturation: 1, brightness: 0.92, alpha: 1.0)
        static let invalidEmailTitle = "Invalid username or password"
        static let invalidEmailMessage = "Please try again"
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
    
        // UILabel
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 80))
        label.center = CGPoint(x: 160, y: 120)
        label.textAlignment = .center
        label.text = "Login View Controller"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 25)
        self.view.addSubview(label)
        
        // UIView
        let newView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 140))
        newView.center = CGPoint(x: 160, y: 250)
        newView.backgroundColor = UIColor.white
        self.view.addSubview(newView)
        
        // UITextField : Login Name
        login = UITextField(frame: CGRect(x: 0, y: 0, width: 150, height: 80))
        login.center = CGPoint(x: 90, y: 25)
        login.placeholder = "berkeley.edu account"
        login.font = UIFont.systemFont(ofSize: 15)
        newView.addSubview(login)
        
        // UITextField : Password
        pass = UITextField(frame: CGRect(x: 0, y: 0, width: 150, height: 80))
        pass.center = CGPoint(x: 90, y: 65)
        pass.placeholder = "password"
        pass.font = UIFont.systemFont(ofSize: 15)
        newView.addSubview(pass)
        
        // UIButton
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 30))
        button.center = CGPoint(x: 150, y: 105)
        button.backgroundColor = UIColor(hue: 0.5389, saturation: 1, brightness: 0.92, alpha: 1.0)
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: UIControlEvents.touchUpInside)
        button.tag = 1
        newView.addSubview(button)
        
        
        // TODO: Add your views either as subviews of `view` or subviews of each other using `addSubview`
        
        // TODO: layout your views using frames or AutoLayout
    }
    
    // TODO: create an IBAction for your login button
    @IBAction func buttonAction(sender: UIButton) {
        var senderTag: UIButton = sender
        if senderTag.tag == 1 {
            print("button was pressed!")
            authenticateUser(username: login.text, password: pass.text)
        }
    }
    
    
    /// YOU DO NOT NEED TO MODIFY ANY OF THE CODE BELOW (but you will want to use `authenticateUser` at some point)
    
    // Model class to handle checking if username/password combinations are valid.
    // Usernames and passwords can be found in the Lab6Names.csv file
    let loginModel = LoginModel(filename: "Lab6Names")

    /// Imageview for login success image (do not need to modify)
    let loginSuccessView = UIImageView(image: UIImage(named: "oski"))
    
    /// If the provided username/password combination is valid, displays an
    /// image (in the "loginSuccessView" imageview). If invalid, displays an alert
    /// telling the user that the login was unsucessful.
    /// You do not need to edit this function, but you will want to use it for the lab.
    ///
    /// - Parameters:
    ///   - username: the user's berkeley.edu address
    ///   - password: the user's first name (what a great password!)
    func authenticateUser(username: String?, password: String?) {
        
        // if username / password combination is invalid, present an alert
        if !loginModel.authenticate(username: username, password: password) {
            loginSuccessView.isHidden = true
            let alert = UIAlertController(title: Constants.invalidEmailTitle, message: Constants.invalidEmailMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        // If username / password combination is valid, display success image
        else {
            if !loginSuccessView.isDescendant(of: view) {
                view.addSubview(loginSuccessView)
                loginSuccessView.contentMode = .scaleAspectFill
            }
            
            loginSuccessView.isHidden = false
            
            // Constraints for the login success view
            loginSuccessView.translatesAutoresizingMaskIntoConstraints = false
            loginSuccessView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            loginSuccessView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            loginSuccessView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            loginSuccessView.heightAnchor.constraint(equalToConstant: view.frame.height/4).isActive = true
        }
    }
}
