//
//  ViewController.swift
//  face-tracker
//
//  Created by takaya kusanagi on 2018/03/29.
//  Copyright © 2018年 takaya kusanagi. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var parameterText: UILabel!
    @IBOutlet weak var ipAddressField: UITextField!
    @IBOutlet weak var portField: UITextField!
    @IBOutlet weak var udpStatusLabel: UILabel!
    private var udp: MyUDPClient?
    
    @IBAction func startButtonTapped() {
        self.ipAddressField.endEditing(true)
        self.portField.endEditing(true)
        if let ip = self.ipAddressField.text, let port = self.portField.text {
            if let port = Int32(port) {
                self.udpStatusLabel.text = ""
                self.udp = MyUDPClient(address: ip, port: port)
            }else{
                self.udpStatusLabel.text = "not correct port number"
            }
        }else{
                self.udpStatusLabel.text = "Please ip address and port"
        }
    }
    
    @IBAction func refreshButtonTapped() {
        guard ARFaceTrackingConfiguration.isSupported else { return }
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    private var parameters: Dictionary<String, Float> = Dictionary(uniqueKeysWithValues: [
        ("anchorTransform1x1", 0), ("anchorTransform1x2", 0), ("anchorTransform1x3", 0), ("anchorTransform1x4", 0),
        ("anchorTransform2x1", 0), ("anchorTransform2x2", 0), ("anchorTransform2x3", 0), ("anchorTransform2x4", 0),
        ("anchorTransform3x1", 0), ("anchorTransform3x2", 0), ("anchorTransform3x3", 0), ("anchorTransform3x4", 0),
        ("anchorTransform4x1", 0), ("anchorTransform4x2", 0), ("anchorTransform4x3", 0), ("anchorTransform4x4", 0),
        ("browDownLeft", 0), ("browDownRight", 0), ("browInnerUp", 0), ("browOuterUpLeft", 0),
        ("browOuterUpRight", 0), ("cheekPuff", 0), ("cheekSquintLeft", 0), ("cheekSquintRight", 0),
        ("eyeBlinkLeft", 0), ("eyeBlinkRight", 0), ("eyeLookDownLeft", 0), ("eyeLookDownRight", 0),
        ("eyeLookInLeft", 0), ("eyeLookInRight", 0), ("eyeLookOutLeft", 0), ("eyeLookOutRight", 0),
        ("eyeLookUpLeft", 0), ("eyeLookUpRight", 0), ("eyeSquintLeft", 0), ("eyeSquintRight", 0),
        ("eyeWideLeft", 0), ("eyeWideRight", 0), ("jawForward", 0), ("jawLeft", 0),
        ("jawOpen", 0), ("jawRight", 0), ("mouthClose", 0), ("mouthDimpleLeft", 0),
        ("mouthDimpleRight", 0), ("mouthFrownLeft", 0), ("mouthFrownRight", 0), ("mouthFunnel", 0),
        ("mouthLowerDownLeft", 0), ("mouthLowerDownRight", 0), ("mouthPressLeft", 0), ("mouthPressRight", 0),
        ("mouthPucker", 0), ("mouthRight", 0), ("mouthRollLower", 0), ("mouthRollUpper", 0),
        ("mouthShrugLower", 0), ("mouthShrugUpper", 0), ("mouthSmileLeft", 0), ("mouthSmileRight", 0),
        ("mouthStretchLeft", 0), ("mouthStretchRight", 0), ("mouthUpperUpLeft", 0), ("mouthUpperUpRight", 0),
        ("noseSneerLeft", 0), ("noseSneerRight", 0)
        ])
    
    var session: ARSession {
        return self.sceneView.session
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.delegate = self
        sceneView.session.delegate = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.udpClose),
            name: NSNotification.Name.UIApplicationDidEnterBackground,
            object: nil
        )
    }
    
    @objc private func udpClose() {
        self.udp?.close()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startSession()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // session stop
        self.session.pause()
    }

    func startSession() {
        print("STARTING A NEW SESSION")
        // Is ARFaceTracking support?
        if !ARFaceTrackingConfiguration.isSupported {
            return
        }

        // setting for face tracking
        let configuration = ARFaceTrackingConfiguration()
        self.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }

}

extension ViewController: ARSessionDelegate {
    // error
    func session(_ session: ARSession, didFailWithError error: Error) {
        guard error is ARError else { return }
        print("SESSION ERROR")
    }

    // stop session
    func sessionWasInterrupted(_ session: ARSession) {
        print("SESSION INTERRUPTED")
    }

    // restart session
    func sessionInterruptionEnded(_ session: ARSession) {
        DispatchQueue.main.async {
            self.startSession()
        }
    }
}

extension ViewController: ARSCNViewDelegate {
    // new ARAnchor
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
    }

    // update ARAnchor
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if let faceAnchor = anchor as? ARFaceAnchor {
            if let t = faceAnchor.blendShapes[.browDownLeft]        as? Float { self.parameters["browDownLeft"]        = t }
            if let t = faceAnchor.blendShapes[.browDownRight]       as? Float { self.parameters["browDownRight"]       = t}
            if let t = faceAnchor.blendShapes[.browInnerUp]         as? Float { self.parameters["browInnerUp"]         = t}
            if let t = faceAnchor.blendShapes[.browOuterUpLeft]     as? Float { self.parameters["browOuterUpLeft"]     = t}
            if let t = faceAnchor.blendShapes[.browOuterUpRight]    as? Float { self.parameters["browOuterUpRight"]    = t}
            if let t = faceAnchor.blendShapes[.cheekPuff]           as? Float { self.parameters["cheekPuff"]           = t}
            if let t = faceAnchor.blendShapes[.cheekSquintLeft]     as? Float { self.parameters["cheekSquintLeft"]     = t}
            if let t = faceAnchor.blendShapes[.cheekSquintRight]    as? Float { self.parameters["cheekSquintRight"]    = t}
            if let t = faceAnchor.blendShapes[.eyeBlinkLeft]        as? Float { self.parameters["eyeBlinkLeft"]        = t}
            if let t = faceAnchor.blendShapes[.eyeBlinkRight]       as? Float { self.parameters["eyeBlinkRight"]       = t}
            if let t = faceAnchor.blendShapes[.eyeLookDownLeft]     as? Float { self.parameters["eyeLookDownLeft"]     = t}
            if let t = faceAnchor.blendShapes[.eyeLookDownRight]    as? Float { self.parameters["eyeLookDownRight"]    = t}
            if let t = faceAnchor.blendShapes[.eyeLookInLeft]       as? Float { self.parameters["eyeLookInLeft"]       = t}
            if let t = faceAnchor.blendShapes[.eyeLookInRight]      as? Float { self.parameters["eyeLookInRight"]      = t}
            if let t = faceAnchor.blendShapes[.eyeLookOutLeft]      as? Float { self.parameters["eyeLookOutLeft"]      = t}
            if let t = faceAnchor.blendShapes[.eyeLookOutRight]     as? Float { self.parameters["eyeLookOutRight"]     = t}
            if let t = faceAnchor.blendShapes[.eyeLookUpLeft]       as? Float { self.parameters["eyeLookUpLeft"]       = t}
            if let t = faceAnchor.blendShapes[.eyeLookUpRight]      as? Float { self.parameters["eyeLookUpRight"]      = t}
            if let t = faceAnchor.blendShapes[.eyeSquintLeft]       as? Float { self.parameters["eyeSquintLeft"]       = t}
            if let t = faceAnchor.blendShapes[.eyeSquintRight]      as? Float { self.parameters["eyeSquintRight"]      = t}
            if let t = faceAnchor.blendShapes[.eyeWideLeft]         as? Float { self.parameters["eyeWideLeft"]         = t}
            if let t = faceAnchor.blendShapes[.eyeWideRight]        as? Float { self.parameters["eyeWideRight"]        = t}
            if let t = faceAnchor.blendShapes[.jawForward]          as? Float { self.parameters["jawForward"]          = t}
            if let t = faceAnchor.blendShapes[.jawLeft]             as? Float { self.parameters["jawLeft"]             = t}
            if let t = faceAnchor.blendShapes[.jawOpen]             as? Float { self.parameters["jawOpen"]             = t}
            if let t = faceAnchor.blendShapes[.jawRight]            as? Float { self.parameters["jawRight"]            = t}
            if let t = faceAnchor.blendShapes[.mouthClose]          as? Float { self.parameters["mouthClose"]          = t}
            if let t = faceAnchor.blendShapes[.mouthDimpleLeft]     as? Float { self.parameters["mouthDimpleLeft"]     = t}
            if let t = faceAnchor.blendShapes[.mouthDimpleRight]    as? Float { self.parameters["mouthDimpleRight"]    = t}
            if let t = faceAnchor.blendShapes[.mouthFrownLeft]      as? Float { self.parameters["mouthFrownLeft"]      = t}
            if let t = faceAnchor.blendShapes[.mouthFrownRight]     as? Float { self.parameters["mouthFrownRight"]     = t}
            if let t = faceAnchor.blendShapes[.mouthFunnel]         as? Float { self.parameters["mouthFunnel"]         = t}
            if let t = faceAnchor.blendShapes[.mouthLowerDownLeft]  as? Float { self.parameters["mouthLowerDownLeft"]  = t}
            if let t = faceAnchor.blendShapes[.mouthLowerDownRight] as? Float { self.parameters["mouthLowerDownRight"] = t}
            if let t = faceAnchor.blendShapes[.mouthPressLeft]      as? Float { self.parameters["mouthPressLeft"]      = t}
            if let t = faceAnchor.blendShapes[.mouthPressRight]     as? Float { self.parameters["mouthPressRight"]     = t}
            if let t = faceAnchor.blendShapes[.mouthPucker]         as? Float { self.parameters["mouthPucker"]         = t}
            if let t = faceAnchor.blendShapes[.mouthRight]          as? Float { self.parameters["mouthRight"]          = t}
            if let t = faceAnchor.blendShapes[.mouthRollLower]      as? Float { self.parameters["mouthRollLower"]      = t}
            if let t = faceAnchor.blendShapes[.mouthRollUpper]      as? Float { self.parameters["mouthRollUpper"]      = t}
            if let t = faceAnchor.blendShapes[.mouthShrugLower]     as? Float { self.parameters["mouthShrugLower"]     = t}
            if let t = faceAnchor.blendShapes[.mouthShrugUpper]     as? Float { self.parameters["mouthShrugUpper"]     = t}
            if let t = faceAnchor.blendShapes[.mouthSmileLeft]      as? Float { self.parameters["mouthSmileLeft"]      = t}
            if let t = faceAnchor.blendShapes[.mouthSmileRight]     as? Float { self.parameters["mouthSmileRight"]     = t}
            if let t = faceAnchor.blendShapes[.mouthStretchLeft]    as? Float { self.parameters["mouthStretchLeft"]    = t}
            if let t = faceAnchor.blendShapes[.mouthStretchRight]   as? Float { self.parameters["mouthStretchRight"]   = t}
            if let t = faceAnchor.blendShapes[.mouthUpperUpLeft]    as? Float { self.parameters["mouthUpperUpLeft"]    = t}
            if let t = faceAnchor.blendShapes[.mouthUpperUpRight]   as? Float { self.parameters["mouthUpperUpRight"]   = t}
            if let t = faceAnchor.blendShapes[.noseSneerLeft]       as? Float { self.parameters["noseSneerLeft"]       = t}
            if let t = faceAnchor.blendShapes[.noseSneerRight]      as? Float { self.parameters["noseSneerRight"]      = t}
            self.parameters["anchorTransform1x1"] = anchor.transform.columns.0.x
            self.parameters["anchorTransform1x2"] = anchor.transform.columns.0.y
            self.parameters["anchorTransform1x3"] = anchor.transform.columns.0.z
            self.parameters["anchorTransform1x4"] = anchor.transform.columns.0.w
            self.parameters["anchorTransform2x1"] = anchor.transform.columns.1.x
            self.parameters["anchorTransform2x2"] = anchor.transform.columns.1.y
            self.parameters["anchorTransform2x3"] = anchor.transform.columns.1.z
            self.parameters["anchorTransform2x4"] = anchor.transform.columns.1.w
            self.parameters["anchorTransform3x1"] = anchor.transform.columns.2.x
            self.parameters["anchorTransform3x2"] = anchor.transform.columns.2.y
            self.parameters["anchorTransform3x3"] = anchor.transform.columns.2.z
            self.parameters["anchorTransform3x4"] = anchor.transform.columns.2.w
            self.parameters["anchorTransform4x1"] = anchor.transform.columns.3.x
            self.parameters["anchorTransform4x2"] = anchor.transform.columns.3.y
            self.parameters["anchorTransform4x3"] = anchor.transform.columns.3.z
            self.parameters["anchorTransform4x4"] = anchor.transform.columns.3.w
        }
        
        var text = ""
        var sendText = ""
        for (key, value) in self.parameters {
            text += key + ":" + String(value) + "\n"
            sendText += key + "=" + String(value) + "&"
        }
        DispatchQueue.main.async {
            self.parameterText.text = text
        }
        
        if let udp = self.udp {
            if udp.send(data: sendText) {
                DispatchQueue.main.async { self.udpStatusLabel.text = "Connect" }
            }else{
                DispatchQueue.main.async { self.udpStatusLabel.text = "Not Connect" }
            }
        }else{
            DispatchQueue.main.async { self.udpStatusLabel.text = "Not Connect" }
        }
    }
}

