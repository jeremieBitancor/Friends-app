//
//  FriendViewController.swift
//  Friends
//
//  Created by jeremie bitancor on 6/12/21.
//

import UIKit
import MessageUI

class FriendViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var portrait: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var emailButton: UIButton!
    
    var friend: Friend?
    let mail = MFMailComposeViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Set image view to a circle
        portrait.layer.cornerRadius = portrait.frame.height / 2
        portrait.layer.masksToBounds = false
        portrait.clipsToBounds = true
        
        if let sf = friend {
            name.text = "\(sf.name.first) \(sf.name.last)"
            address.text = "\(sf.location.street.number), \(sf.location.street.name), \(sf.location.city), \(sf.location.state), \(sf.location.country)"
            phone.text = sf.cell
            emailButton.setTitle(sf.email, for: .normal)
            if let imageUrl = URL(string: sf.picture.large) {
                portrait.loadImage(withUrl: imageUrl)
            }
            
        }
        
    }

    @IBAction func emailTap(_ sender: UIButton) {
        /// Function for opening mail app when email is tap
        if MFMailComposeViewController.canSendMail() {
            mail.mailComposeDelegate = self
            guard let email = sender.titleLabel?.text else {return}
            mail.setToRecipients([email])            
            present(mail, animated: true)
        } else {
            print("error")
        }
    }
    
    /// Function that dismiss the email app when finished or canceled
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        mail.dismiss(animated: true, completion: nil)
    }
}



