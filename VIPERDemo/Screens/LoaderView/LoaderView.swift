//
//  LoaderView.swift
//  VIPERDemo
//
//  Created by Macmini on 10/5/19.
//  Copyright © 2019 Macmini. All rights reserved.
//

import Foundation
import UIKit


class LoaderView: UIView {
    
    // MARK: - Instance Properties
    
    /// Identifier to track how much strongly refered these LoaderView in App and how many relinquished ownership for this loader.
    var retainCountValue : Int = 0
    
    // MARK: - IBoutlets
    @IBOutlet      var view : UIView!
    @IBOutlet weak var activity : UIActivityIndicatorView!
    @IBOutlet weak var activityContainerView : UIView!
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialUISetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialUISetUp()
    }
    
    // MARK: - LifeCycle Methods
    override func draw(_ rect: CGRect) {
        view.frame = bounds
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = UIColor.clear
        activityContainerView.layer.cornerRadius = 5
    }
    
    // MARK: - Instance Methods
    
    /// It brings the loader view on the provided view.
    ///
    /// - Parameter view: View
    func show (inView view : UIView) {
        
        if retainCountValue == 0 {
            activity.startAnimating()
            
            let leadingConstraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
            let topConstraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
            let trailingConstraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
            let bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
            view.addSubview(self)
            view.addConstraints([leadingConstraint, topConstraint, trailingConstraint,bottomConstraint])
        }
        DispatchQueue.main.async {
            view.bringSubviewToFront(self)
        }
        retainCountValue += 1
    }
    
    /// Decrease retain count by 1, and hide if retain count reaches 0
    func hide() {
        if retainCountValue > 0 {
            retainCountValue -=  1
            if retainCountValue == 0 {
                activity.startAnimating()
                removeFromSuperview()
            }
        }
    }
}

//// MARK: - LoaderView
extension LoaderView {
    
    func initialUISetUp() {
        
        Bundle.main.loadNibNamed("LoaderView", owner: self, options: nil)
        guard let content = view else { return }
        translatesAutoresizingMaskIntoConstraints = false
        
        content.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = NSLayoutConstraint(item: content, attribute: .leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: content, attribute: .top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: content, attribute: .trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: content, attribute: .bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        addSubview(content)
        addConstraints([leadingConstraint, topConstraint, trailingConstraint,bottomConstraint])
    }
}
