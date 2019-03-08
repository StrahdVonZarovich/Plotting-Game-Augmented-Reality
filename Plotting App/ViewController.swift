//
//  ViewController.swift
//  Plotting App
//
//  Created by Fatih Canbekli on 8.03.2019.
//  Copyright © 2019 wealight. All rights reserved.
//

import UIKit
import ARKit
class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var RedButton: UIButton!
    @IBOutlet weak var YellowButton: UIButton!
    @IBOutlet weak var GreenButton: UIButton!
    @IBOutlet weak var sceneView: ARSCNView!
    var pointerColorIndex : Int = 0
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.showsStatistics = true
        self.sceneView.delegate = self
        self.sceneView.session.run(configuration)
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval){
        guard let pointOfView = sceneView.pointOfView else { return }
        let transform = pointOfView.transform
        let orientation = SCNVector3(-transform.m31, -transform.m32, -transform.m33)
        let location = SCNVector3(transform.m41, transform.m42, transform.m43)
        let currentPositionOfCamera = orientation + location
        print(orientation.x, orientation.y, orientation.z)
        if self.RedButton.isHighlighted {
            pointerColorIndex = 0
            let sphereNode = SCNNode(geometry: SCNSphere(radius: 0.02))
            sphereNode.position = currentPositionOfCamera
            self.sceneView.scene.rootNode.addChildNode(sphereNode)
            sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        }else if self.YellowButton.isHighlighted{
            pointerColorIndex = 1
            let sphereNode = SCNNode(geometry: SCNSphere(radius: 0.02))
            sphereNode.position = currentPositionOfCamera
            self.sceneView.scene.rootNode.addChildNode(sphereNode)
            sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
        }else if self.GreenButton.isHighlighted{
            pointerColorIndex = 2
            let sphereNode = SCNNode(geometry: SCNSphere(radius: 0.02))
            sphereNode.position = currentPositionOfCamera
            self.sceneView.scene.rootNode.addChildNode(sphereNode)
            sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.green
        }else{
            let pointer = SCNNode(geometry: SCNSphere(radius: 0.01))
            pointer.name = "Pointer"
            pointer.position = currentPositionOfCamera
            
            self.sceneView.scene.rootNode.enumerateChildNodes({ (node, _) in
                if node.name == "Pointer"{
                    node.removeFromParentNode()
                }
            })
            
            self.sceneView.scene.rootNode.addChildNode(pointer)
            if(pointerColorIndex == 0){
                pointer.geometry?.firstMaterial?.diffuse.contents = UIColor.red
            }else if(pointerColorIndex == 1){
                pointer.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
            }else if(pointerColorIndex == 2){
                pointer.geometry?.firstMaterial?.diffuse.contents = UIColor.green
            }
            
            
        }
    }


}
func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3Make(left.x + right.x, left.y + right.y , left.z + right.z)
}

