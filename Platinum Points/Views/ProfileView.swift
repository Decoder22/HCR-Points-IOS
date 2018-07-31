//
//  ProfileView.swift
//  Platinum Points
//
//  Created by Brian Johncox on 7/15/18.
//  Copyright © 2018 DecodeProgramming. All rights reserved.
//

import UIKit

class ProfileView: UIView {

    @IBOutlet var backgroundView: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var totalPointsLabel: UILabel!
    //@IBOutlet var achievementLabel: UILabel!
    @IBOutlet var pointsButton: UILabel! // change back to button for the Medals update
    
    
    var transitionFunc: () ->() = {print("NO IMPLEMENTATION")}
    
    override init(frame: CGRect){
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("ProfileView", owner: self, options: nil)
        addSubview(backgroundView)
        backgroundView.frame = self.bounds
        backgroundView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        pointsButton.text = "Stay tuned for:\n The Medals Update!"
        pointsButton.layer.borderWidth = 1.0
        pointsButton.layer.borderColor = UIColor.lightGray.cgColor
        reloadData()
    }
    
    func reloadData(){
        nameLabel.text = User.get(.name) as! String + "\nWelcome"
        totalPointsLabel.text = (User.get(.points) as! Int).description + "\npoints"
        totalPointsLabel.layer.borderWidth = 1.0
        totalPointsLabel.layer.borderColor = UIColor.lightGray.cgColor
        //achievementLabel.text = "You haven't done\n anything yet."
        //achievementLabel.layer.borderWidth = 1.0
        //achievementLabel.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func transition(_ sender: Any) {
        transitionFunc()
    }
    
}
