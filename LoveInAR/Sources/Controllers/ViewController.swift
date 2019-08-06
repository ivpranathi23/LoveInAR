//
//  ViewController.swift
//  Hello-AR
//
//  Created by Mohammad Azam on 6/18/17.
//  Copyright © 2017 Mohammad Azam. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    var imageName: String?
    var pickedImage: UIImage?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Launch the Rocket of Love"
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.showsStatistics = true
        
        let missleScene = SCNScene(named: "missile-1.scn")
        
        let missile = Missile(scene: missleScene!)
        missile.name = "Missile"
        missile.position = SCNVector3(0,0,-4)
        
        let scene = SCNScene()
        scene.rootNode.addChildNode(missile)
        
        sceneView.scene = scene
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    
    @IBAction func launchRocket(_ sender: UIButton) {
    
        guard let missileNode = self.sceneView.scene.rootNode.childNode(withName: "Missile", recursively: true)
            else {
                fatalError("Missile not found")
        }

        
        missileNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        missileNode.physicsBody?.isAffectedByGravity = false
        missileNode.physicsBody?.damping = 0.0
        
        missileNode.physicsBody?.applyForce(SCNVector3(0,300,0), asImpulse: false)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.addStartsInTheSky(missileNode: missileNode)
        })
        
    }
    
    func addStartsInTheSky(missileNode: SCNNode) {
        
        let starNode = SCNNode()
        starNode.position = SCNVector3(0, 5, -3)
        let stars = SCNParticleSystem(named: "Crackers.scnp", inDirectory: nil)
        if self.imageName != nil {
            stars?.particleImage = UIImage(named: self.imageName!)
            
        }
        starNode.addParticleSystem(stars!)
        self.sceneView.scene.rootNode.addChildNode(starNode)
        self.addCubeNode()
       
    }

    
    func addCubeNode() {
        
        let sphere = SCNBox(width: 2.0, height: 3.0, length: 2.0, chamferRadius: 0)
        let material1 = SCNMaterial()
        material1.diffuse.contents = self.pickedImage!
        sphere.materials = [material1]
        
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = SCNVector3(-2, 0, -7)
        
        let box = SCNBox(width: 2.0, height: 3.0, length: 2.0, chamferRadius: 0)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: self.imageName! + "1")
        box.materials = [material]
        
        let boxNode = SCNNode(geometry: box)
        boxNode.position = SCNVector3(0, -3, -7)
        
        
        let rotateOne = SCNAction.rotateBy(x: 0, y: CGFloat(Float.pi), z: 0, duration: 5.0)
//        let repeatForever = SCNAction.repeatForever(rotateOne)
//        boxNode.runAction(repeatForever)
        
//        sphereNode.runAction(rotateOne)
        self.sceneView.scene.rootNode.addChildNode(boxNode)
        self.sceneView.scene.rootNode.addChildNode(sphereNode)

    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        let alert = UIAlertController(title: "Alert", message: "This app do not have permission to use the camera. Enable it in settings.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
}



