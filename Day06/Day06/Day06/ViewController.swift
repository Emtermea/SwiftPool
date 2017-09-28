//
//  ViewController.swift
//  Day06
//
//  Created by Emmanuelle TERMEAU on 6/20/17.
//  Copyright © 2017 Emmanuelle TERMEAU. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIApplicationDelegate {
    
    var animator: UIDynamicAnimator!
    var collision: UICollisionBehavior!
    var gravity: UIGravityBehavior!
    var itemBehaviour : UIDynamicItemBehavior! //elasticity
    var attachment: UIAttachmentBehavior! //interaction between form
    var statusOK : Bool! = false

    
    func PanGesture(_ gesture: UIPanGestureRecognizer) {
        print("Pan Gesture")
        switch gesture.state {
        case .began:
            gravity.removeItem(gesture.view!)
            attachment = UIAttachmentBehavior(item:gesture.view!, attachedToAnchor: CGPoint(x: gesture.view!.center.x, y: gesture.view!.center.y))
            animator.addBehavior(attachment)
        case .changed:
            attachment.damping = 100
            attachment.length = 0
            attachment.anchorPoint = gesture.location(in: view)
        case .ended:
            animator.removeBehavior(attachment)
            gravity.addItem(gesture.view!)
            statusOK = true
        default:
            animator.removeBehavior(attachment)
        }
    }
    
    func RotationGesture(_ gesture: UIRotationGestureRecognizer) {
        print("Rotation gesture")
        switch gesture.state {
        case .began:
            gravity.removeItem(gesture.view!)
            collision.removeItem(gesture.view!)
            itemBehaviour.removeItem(gesture.view!)
        case .changed:
            gesture.view?.transform = CGAffineTransform(rotationAngle: gesture.rotation);
        case .ended:
            gravity.addItem(gesture.view!)
            collision.addItem(gesture.view!)
            itemBehaviour.addItem(gesture.view!)
            statusOK = true
        default:
            gravity.addItem(gesture.view!)
            collision.addItem(gesture.view!)
            itemBehaviour.addItem(gesture.view!)
        }
    }
    
    func tapOnObj(_ gesture : UITapGestureRecognizer) {
        print("TapOn Obj gesture")
        if gesture.state == .ended {
//            gesture.view?.removeFromSuperview()
            if statusOK == true {
//                gravity.removeItem((gesture.view)!)
                itemBehaviour.removeItem((gesture.view)!)
                statusOK = false
            } else {
                gravity.addItem(gesture.view!)
                itemBehaviour.removeItem((gesture.view)!)
            }
        }
    }
    
    
    func PinchGesture(_ gesture: UIPinchGestureRecognizer) {
        switch gesture.state {
        case .began:
            gravity.removeItem(gesture.view!)
            collision.removeItem(gesture.view!)
            itemBehaviour.removeItem(gesture.view!)
            
        case .changed:
            let scale = gesture.scale
            print(scale)

            var nW = (gesture.view?.frame.width)! * (scale)

            if nW < CGFloat(20) {
                nW = CGFloat(20)
            }
            let nH = nW
            let x = gesture.location(in: view).x - nW / 2

            let y = gesture.location(in: view).y - nH / 2
            gesture.view?.frame = CGRect(x: x, y: y, width: nW, height: nH)
            if let obj =  gesture.view as? object {
                if obj.design == "circle" {
                    gesture.view?.layer.cornerRadius = (gesture.view?.frame.width)! / 2
                }
            }
        case .ended:
            gravity.addItem(gesture.view!)
            collision.addItem(gesture.view!)
            itemBehaviour.addItem(gesture.view!)
            statusOK = true
            
        default:
            gravity.addItem(gesture.view!)
            collision.addItem(gesture.view!)
            itemBehaviour.addItem(gesture.view!)
        }
        gesture.scale = 1
    }
    
    func TapGesture(_ gesture: UITapGestureRecognizer) {
        print("first Tap Gesture")
        if gesture.state == .ended {

            let obj = object(x: gesture.location(in: view).x ,y: gesture.location(in: view).y)
            
            let deplace = UIPanGestureRecognizer(target: self, action: #selector(PanGesture(_:)))
            let rotate = UIRotationGestureRecognizer(target: self, action: #selector(RotationGesture(_:)))
            let tapOn = UITapGestureRecognizer(target:self, action: #selector(tapOnObj(_:)))
            let pinch = UIPinchGestureRecognizer(target: self, action: #selector(PinchGesture(_:)))
            
            obj.addGestureRecognizer(deplace)
            obj.addGestureRecognizer(rotate)
            obj.addGestureRecognizer(tapOn)
            obj.addGestureRecognizer(pinch)
            
            print("design obj \(obj.design)")
            animator.addBehavior(collision)
            animator.addBehavior(gravity)

            view.addSubview(obj)
            gravity.addItem(obj)
            collision.addItem(obj)
            itemBehaviour.addItem(obj)
            



        }
    }
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TapGesture(_:)))
            
            animator = UIDynamicAnimator(referenceView: self.view)
            gravity = UIGravityBehavior()
            gravity.magnitude = 1.1
            animator.addBehavior(gravity)
            itemBehaviour = UIDynamicItemBehavior()
            collision = UICollisionBehavior()
            itemBehaviour.elasticity = 0.8
            collision.translatesReferenceBoundsIntoBoundary = true
            animator.addBehavior(itemBehaviour)
            animator.addBehavior(collision)
            
            view.addGestureRecognizer(tapGesture)
            // Do any additional setup after loading the view, typically from a nib.
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

