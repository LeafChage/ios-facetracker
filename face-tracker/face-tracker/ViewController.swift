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
    class Parameters {
        public static let ANCHOR_TRANSFORM_1X1 = "anchorTransform1x1"
        public static let ANCHOR_TRANSFORM_1X2 = "anchorTransform1x2"
        public static let ANCHOR_TRANSFORM_1X3 = "anchorTransform1x3"
        public static let ANCHOR_TRANSFORM_1X4 = "anchorTransform1x4"
        public static let ANCHOR_TRANSFORM_2X1 = "anchorTransform2x1"
        public static let ANCHOR_TRANSFORM_2X2 = "anchorTransform2x2"
        public static let ANCHOR_TRANSFORM_2X3 = "anchorTransform2x3"
        public static let ANCHOR_TRANSFORM_2X4 = "anchorTransform2x4"
        public static let ANCHOR_TRANSFORM_3X1 = "anchorTransform3x1"
        public static let ANCHOR_TRANSFORM_3X2 = "anchorTransform3x2"
        public static let ANCHOR_TRANSFORM_3X3 = "anchorTransform3x3"
        public static let ANCHOR_TRANSFORM_3X4 = "anchorTransform3x4"
        public static let ANCHOR_TRANSFORM_4X1 = "anchorTransform4x1"
        public static let ANCHOR_TRANSFORM_4X2 = "anchorTransform4x2"
        public static let ANCHOR_TRANSFORM_4X3 = "anchorTransform4x3"
        public static let ANCHOR_TRANSFORM_4X4 = "anchorTransform4x4"
        public static let BROW_OUTER_UP_LEFT = "browOuterUp_L";     // 左眉の外側の上方向への動き
        public static let BROW_OUTER_UP_RIGHT = "browOuterUp_R";    // 右眉の外側の上方向への動き
        public static let BROW_DOWN_LEFT = "browDown_L";        // 左眉の外側の下方向への動き
        public static let BROW_DOWN_RIGHT = "browDown_R";       // 右眉の外側の下方向への動き
        public static let BROW_INNER_UP = "browInnerUp";         //両眉の内側部分の上方向への動き
        public static let EYE_WIDE_RIGHT = "eyeWide_R";        // 右の瞼の広がり→右目の開き具合
        public static let EYE_WIDE_LEFT = "eyeWide_L";         // 左の瞼の広がり→左眼の開き具合
        public static let EYE_LOOK_UP_LEFT = "eyeLookUp_L";       // 左目の上方向への視線
        public static let EYE_LOOK_UP_RIGHT = "eyeLookUp_R";      // 右目の上方向への視線
        public static let EYE_LOOK_DOWN_RIGHT = "eyeLookDown_R";    // 右目の下方向への視線
        public static let EYE_LOOK_DOWN_LEFT = "eyeLookDown_L";     // 左目の下方向への視線
        public static let EYE_LOOK_IN_LEFT = "eyeLookIn_L";       // 左目の右方向への視線
        public static let EYE_LOOK_IN_RIGHT = "eyeLookIn_R";      // 右目の左方向への視線
        public static let EYE_LOOK_OUT_LEFT = "eyeLookOut_L";      // 左目の左方向への視線
        public static let EYE_LOOK_OUT_RIGHT = "eyeLookOut_R";     // 右目の右方向への視線:
        public static let EYE_BLINK_LEFT = "eyeBlink_L";        // 左目瞬き
        public static let EYE_BLINK_RIGHT = "eyeBlink_R";       // 右目瞬き
        public static let EYE_SQUINT_LEFT = "eyeSquint_L";       // 左目周辺の顔の収縮具合
        public static let EYE_SQUINT_RIGHT = "eyeSquint_R";      // 右目周辺の顔の収縮具合
        public static let NOSE_SNEER_LEFT = "noseSneer_L";       // 左の鼻孔周辺の上方向への移動
        public static let NOSE_SNEER_RIGHT = "noseSneer_R";      // 右の鼻孔周辺の上方向への移動
        public static let CHEEK_SQUINT_LEFT = "cheekSquint_L";     //左頬の周辺の上方向への移動
        public static let CHEEK_SQUINT_RIGHT = "cheekSquint_R";    // 右頬の周辺の上方向への移動
        public static let CHEEK_PUFF = "cheekPuff";           // 両頬の外側への動き
        public static let MOUTH_LOWER_DOWN_LEFT = "mouthLowerDown_L";  // 左側の下唇の下方向への動き
        public static let MOUTH_LOWER_DOWN_RIGHT = "mouthLowerDown_R"; // 左側の下唇の下方向への動き
        public static let MOUTH_ROLL_UPPER = "mouthRollUpper";      // 上唇の口内への動き
        public static let MOUTH_ROLL_LOWER = "mouthRollLower";      // 下唇の口内への動き
        public static let MOUTH_UPPER_UP_LEFT = "mouthUpperUp_L";    // 左側の上唇の上方向への動き
        public static let MOUTH_UPPER_UP_RIGHT = "mouthUpperUp_R";   //左側の上唇の上方向への動き
        public static let MOUTH_SMILE_RIGHT = "mouthSmile_R";     // 口の最右端の上方向への動き
        public static let MOUTH_SMILE_LEFT = "mouthSmile_L";      // 口の最左端の上方向への動き
        public static let MOUTH_DIMPLE_RIGHT = "mouthDimple_R";    // 口の最右端の後方への移動
        public static let MOUTH_DIMPLE_LEFT = "mouthDimple_L";     //口の最左端の後方への移動
        public static let MOUTH_PRESS_RIGHT = "mouthPress_R";     // 右側の下唇の上方向への収縮(移動)
        public static let MOUTH_PRESS_LEFT = "mouthPress_L";      // 左側の下唇の上方向への収縮(移動)
        public static let MOUTH_STRETCH_RIGHT = "mouthStretch_R";   // 口の最右端の右方向への動き
        public static let MOUTH_STRETCH_LEFT = "mouthStretch_L";    // 口の最左端の左方向への動き
        public static let MOUTH_SHRUG_LOWER = "mouthShrugLower";     // 下唇の外側への動き
        public static let MOUTH_SHRUG_UPPER = "mouthShrugUpper";     // 上唇の外側への動き
        public static let MOUTH_FROWN_RIGHT = "mouthFrown_R";     // 口の最右端の下方向への動き
        public static let MOUTH_FROWN_LEFT = "mouthFrown_L";      // 口の最左端の下方向への動き
        public static let MOUTH_RIGHT = "mouthRight";          // 唇の右方向への動き
        public static let MOUTH_LEFT = "mouthLeft";           // 唇の左方向への動き
        public static let MOUTH_FUNNEL = "mouthFunnel";         // 開いた口の収縮
        public static let MOUTH_CLOSE = "mouthClose";          // 唇の開閉（顎の位置に依存しない）
        public static let MOUTH_PUCKER = "mouthPucker";         // 唇の収縮
        public static let JAW_OPEN = "jawOpen";                // 下顎の開閉
        public static let JAW_FORWARD = "jawForward";          // 下顎の前方向への動き
        public static let JAW_RIGHT = "jawRight";            // 下顎の右方向への動き
        public static let JAW_LEFT = "jawLeft";             // 下顎の左方向への動き
    }


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

    private var parameters: Dictionary<String, Float> = [
        Parameters.ANCHOR_TRANSFORM_1X1: 0,
        Parameters.ANCHOR_TRANSFORM_1X2: 0,
        Parameters.ANCHOR_TRANSFORM_1X3: 0,
        Parameters.ANCHOR_TRANSFORM_1X4: 0,
        Parameters.ANCHOR_TRANSFORM_2X1: 0,
        Parameters.ANCHOR_TRANSFORM_2X2: 0,
        Parameters.ANCHOR_TRANSFORM_2X3: 0,
        Parameters.ANCHOR_TRANSFORM_2X4: 0,
        Parameters.ANCHOR_TRANSFORM_3X1: 0,
        Parameters.ANCHOR_TRANSFORM_3X2: 0,
        Parameters.ANCHOR_TRANSFORM_3X3: 0,
        Parameters.ANCHOR_TRANSFORM_3X4: 0,
        Parameters.ANCHOR_TRANSFORM_4X1: 0,
        Parameters.ANCHOR_TRANSFORM_4X2: 0,
        Parameters.ANCHOR_TRANSFORM_4X3: 0,
        Parameters.ANCHOR_TRANSFORM_4X4: 0,
        Parameters.BROW_OUTER_UP_LEFT     : 0,
        Parameters.BROW_OUTER_UP_RIGHT    : 0,
        Parameters.BROW_DOWN_LEFT         : 0,
        Parameters.BROW_DOWN_RIGHT        : 0,
        Parameters.BROW_INNER_UP          : 0,
        Parameters.EYE_WIDE_RIGHT         : 0,
        Parameters.EYE_WIDE_LEFT          : 0,
        Parameters.EYE_LOOK_UP_LEFT       : 0,
        Parameters.EYE_LOOK_UP_RIGHT      : 0,
        Parameters.EYE_LOOK_DOWN_RIGHT    : 0,
        Parameters.EYE_LOOK_DOWN_LEFT     : 0,
        Parameters.EYE_LOOK_IN_LEFT       : 0,
        Parameters.EYE_LOOK_IN_RIGHT      : 0,
        Parameters.EYE_LOOK_OUT_LEFT      : 0,
        Parameters.EYE_LOOK_OUT_RIGHT     : 0,
        Parameters.EYE_BLINK_LEFT         : 0,
        Parameters.EYE_BLINK_RIGHT        : 0,
        Parameters.EYE_SQUINT_LEFT        : 0,
        Parameters.EYE_SQUINT_RIGHT       : 0,
        Parameters.NOSE_SNEER_LEFT        : 0,
        Parameters.NOSE_SNEER_RIGHT       : 0,
        Parameters.CHEEK_SQUINT_LEFT      : 0,
        Parameters.CHEEK_SQUINT_RIGHT     : 0,
        Parameters.CHEEK_PUFF             : 0,
        Parameters.MOUTH_LOWER_DOWN_LEFT  : 0,
        Parameters.MOUTH_LOWER_DOWN_RIGHT : 0,
        Parameters.MOUTH_ROLL_UPPER       : 0,
        Parameters.MOUTH_ROLL_LOWER       : 0,
        Parameters.MOUTH_UPPER_UP_LEFT    : 0,
        Parameters.MOUTH_UPPER_UP_RIGHT   : 0,
        Parameters.MOUTH_SMILE_RIGHT      : 0,
        Parameters.MOUTH_SMILE_LEFT       : 0,
        Parameters.MOUTH_DIMPLE_RIGHT     : 0,
        Parameters.MOUTH_DIMPLE_LEFT      : 0,
        Parameters.MOUTH_PRESS_RIGHT      : 0,
        Parameters.MOUTH_PRESS_LEFT       : 0,
        Parameters.MOUTH_STRETCH_RIGHT    : 0,
        Parameters.MOUTH_STRETCH_LEFT     : 0,
        Parameters.MOUTH_SHRUG_LOWER      : 0,
        Parameters.MOUTH_SHRUG_UPPER      : 0,
        Parameters.MOUTH_FROWN_RIGHT      : 0,
        Parameters.MOUTH_FROWN_LEFT       : 0,
        Parameters.MOUTH_RIGHT            : 0,
        Parameters.MOUTH_LEFT             : 0,
        Parameters.MOUTH_FUNNEL           : 0,
        Parameters.MOUTH_CLOSE            : 0,
        Parameters.MOUTH_PUCKER           : 0,
        Parameters.JAW_OPEN               : 0,
        Parameters.JAW_FORWARD            : 0,
        Parameters.JAW_RIGHT              : 0,
        Parameters.JAW_LEFT               : 0,
    ]

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
            if let t = faceAnchor.blendShapes[.browDownLeft]        as? Float { self.parameters[Parameters.BROW_DOWN_LEFT]         = t }
            if let t = faceAnchor.blendShapes[.browDownRight]       as? Float { self.parameters[Parameters.BROW_DOWN_RIGHT]        = t }
            if let t = faceAnchor.blendShapes[.browInnerUp]         as? Float { self.parameters[Parameters.BROW_INNER_UP]          = t }
            if let t = faceAnchor.blendShapes[.browOuterUpLeft]     as? Float { self.parameters[Parameters.BROW_OUTER_UP_LEFT]     = t }
            if let t = faceAnchor.blendShapes[.browOuterUpRight]    as? Float { self.parameters[Parameters.BROW_OUTER_UP_RIGHT]    = t }
            if let t = faceAnchor.blendShapes[.cheekPuff]           as? Float { self.parameters[Parameters.CHEEK_PUFF]             = t }
            if let t = faceAnchor.blendShapes[.cheekSquintLeft]     as? Float { self.parameters[Parameters.CHEEK_SQUINT_LEFT]      = t }
            if let t = faceAnchor.blendShapes[.cheekSquintRight]    as? Float { self.parameters[Parameters.CHEEK_SQUINT_RIGHT]     = t }
            if let t = faceAnchor.blendShapes[.eyeBlinkLeft]        as? Float { self.parameters[Parameters.EYE_BLINK_LEFT]         = t }
            if let t = faceAnchor.blendShapes[.eyeBlinkRight]       as? Float { self.parameters[Parameters.EYE_BLINK_RIGHT]        = t }
            if let t = faceAnchor.blendShapes[.eyeLookDownLeft]     as? Float { self.parameters[Parameters.EYE_LOOK_DOWN_LEFT]     = t }
            if let t = faceAnchor.blendShapes[.eyeLookDownRight]    as? Float { self.parameters[Parameters.EYE_LOOK_DOWN_RIGHT]    = t }
            if let t = faceAnchor.blendShapes[.eyeLookInLeft]       as? Float { self.parameters[Parameters.EYE_LOOK_IN_LEFT]       = t }
            if let t = faceAnchor.blendShapes[.eyeLookInRight]      as? Float { self.parameters[Parameters.EYE_LOOK_IN_RIGHT]      = t }
            if let t = faceAnchor.blendShapes[.eyeLookOutLeft]      as? Float { self.parameters[Parameters.EYE_LOOK_OUT_LEFT]      = t }
            if let t = faceAnchor.blendShapes[.eyeLookOutRight]     as? Float { self.parameters[Parameters.EYE_LOOK_OUT_RIGHT]     = t }
            if let t = faceAnchor.blendShapes[.eyeLookUpLeft]       as? Float { self.parameters[Parameters.EYE_LOOK_UP_LEFT]       = t }
            if let t = faceAnchor.blendShapes[.eyeLookUpRight]      as? Float { self.parameters[Parameters.EYE_LOOK_UP_RIGHT]      = t }
            if let t = faceAnchor.blendShapes[.eyeSquintLeft]       as? Float { self.parameters[Parameters.EYE_SQUINT_LEFT]        = t }
            if let t = faceAnchor.blendShapes[.eyeSquintRight]      as? Float { self.parameters[Parameters.EYE_SQUINT_RIGHT]       = t }
            if let t = faceAnchor.blendShapes[.eyeWideLeft]         as? Float { self.parameters[Parameters.EYE_WIDE_LEFT]          = t }
            if let t = faceAnchor.blendShapes[.eyeWideRight]        as? Float { self.parameters[Parameters.EYE_WIDE_RIGHT]         = t }
            if let t = faceAnchor.blendShapes[.jawForward]          as? Float { self.parameters[Parameters.JAW_FORWARD]            = t }
            if let t = faceAnchor.blendShapes[.jawLeft]             as? Float { self.parameters[Parameters.JAW_LEFT]               = t }
            if let t = faceAnchor.blendShapes[.jawOpen]             as? Float { self.parameters[Parameters.JAW_OPEN]               = t }
            if let t = faceAnchor.blendShapes[.jawRight]            as? Float { self.parameters[Parameters.JAW_RIGHT]              = t }
            if let t = faceAnchor.blendShapes[.mouthClose]          as? Float { self.parameters[Parameters.MOUTH_CLOSE]            = t }
            if let t = faceAnchor.blendShapes[.mouthDimpleLeft]     as? Float { self.parameters[Parameters.MOUTH_DIMPLE_LEFT]      = t }
            if let t = faceAnchor.blendShapes[.mouthDimpleRight]    as? Float { self.parameters[Parameters.MOUTH_DIMPLE_RIGHT]     = t }
            if let t = faceAnchor.blendShapes[.mouthFrownLeft]      as? Float { self.parameters[Parameters.MOUTH_FROWN_LEFT]       = t }
            if let t = faceAnchor.blendShapes[.mouthFrownRight]     as? Float { self.parameters[Parameters.MOUTH_FROWN_RIGHT]      = t }
            if let t = faceAnchor.blendShapes[.mouthFunnel]         as? Float { self.parameters[Parameters.MOUTH_FUNNEL]           = t }
            if let t = faceAnchor.blendShapes[.mouthLowerDownLeft]  as? Float { self.parameters[Parameters.MOUTH_LOWER_DOWN_LEFT]  = t }
            if let t = faceAnchor.blendShapes[.mouthLowerDownRight] as? Float { self.parameters[Parameters.MOUTH_LOWER_DOWN_RIGHT] = t }
            if let t = faceAnchor.blendShapes[.mouthPressLeft]      as? Float { self.parameters[Parameters.MOUTH_PRESS_LEFT]       = t }
            if let t = faceAnchor.blendShapes[.mouthPressRight]     as? Float { self.parameters[Parameters.MOUTH_PRESS_RIGHT]      = t }
            if let t = faceAnchor.blendShapes[.mouthPucker]         as? Float { self.parameters[Parameters.MOUTH_PUCKER]           = t }
            if let t = faceAnchor.blendShapes[.mouthRight]          as? Float { self.parameters[Parameters.MOUTH_RIGHT]            = t }
            if let t = faceAnchor.blendShapes[.mouthRollLower]      as? Float { self.parameters[Parameters.MOUTH_ROLL_LOWER]       = t }
            if let t = faceAnchor.blendShapes[.mouthRollUpper]      as? Float { self.parameters[Parameters.MOUTH_ROLL_UPPER]       = t }
            if let t = faceAnchor.blendShapes[.mouthShrugLower]     as? Float { self.parameters[Parameters.MOUTH_SHRUG_LOWER]      = t }
            if let t = faceAnchor.blendShapes[.mouthShrugUpper]     as? Float { self.parameters[Parameters.MOUTH_SHRUG_UPPER]      = t }
            if let t = faceAnchor.blendShapes[.mouthSmileLeft]      as? Float { self.parameters[Parameters.MOUTH_SMILE_LEFT]       = t }
            if let t = faceAnchor.blendShapes[.mouthSmileRight]     as? Float { self.parameters[Parameters.MOUTH_SMILE_RIGHT]      = t }
            if let t = faceAnchor.blendShapes[.mouthStretchLeft]    as? Float { self.parameters[Parameters.MOUTH_STRETCH_LEFT]     = t }
            if let t = faceAnchor.blendShapes[.mouthStretchRight]   as? Float { self.parameters[Parameters.MOUTH_STRETCH_RIGHT]    = t }
            if let t = faceAnchor.blendShapes[.mouthUpperUpLeft]    as? Float { self.parameters[Parameters.MOUTH_UPPER_UP_LEFT]    = t }
            if let t = faceAnchor.blendShapes[.mouthUpperUpRight]   as? Float { self.parameters[Parameters.MOUTH_UPPER_UP_RIGHT]   = t }
            if let t = faceAnchor.blendShapes[.noseSneerLeft]       as? Float { self.parameters[Parameters.NOSE_SNEER_LEFT]        = t }
            if let t = faceAnchor.blendShapes[.noseSneerRight]      as? Float { self.parameters[Parameters.NOSE_SNEER_RIGHT]       = t }
            self.parameters[Parameters.ANCHOR_TRANSFORM_1X1] = anchor.transform.columns.0.x
            self.parameters[Parameters.ANCHOR_TRANSFORM_1X2] = anchor.transform.columns.0.y
            self.parameters[Parameters.ANCHOR_TRANSFORM_1X3] = anchor.transform.columns.0.z
            self.parameters[Parameters.ANCHOR_TRANSFORM_1X4] = anchor.transform.columns.0.w
            self.parameters[Parameters.ANCHOR_TRANSFORM_2X1] = anchor.transform.columns.1.x
            self.parameters[Parameters.ANCHOR_TRANSFORM_2X2] = anchor.transform.columns.1.y
            self.parameters[Parameters.ANCHOR_TRANSFORM_2X3] = anchor.transform.columns.1.z
            self.parameters[Parameters.ANCHOR_TRANSFORM_2X4] = anchor.transform.columns.1.w
            self.parameters[Parameters.ANCHOR_TRANSFORM_3X1] = anchor.transform.columns.2.x
            self.parameters[Parameters.ANCHOR_TRANSFORM_3X2] = anchor.transform.columns.2.y
            self.parameters[Parameters.ANCHOR_TRANSFORM_3X3] = anchor.transform.columns.2.z
            self.parameters[Parameters.ANCHOR_TRANSFORM_3X4] = anchor.transform.columns.2.w
            self.parameters[Parameters.ANCHOR_TRANSFORM_4X1] = anchor.transform.columns.3.x
            self.parameters[Parameters.ANCHOR_TRANSFORM_4X2] = anchor.transform.columns.3.y
            self.parameters[Parameters.ANCHOR_TRANSFORM_4X3] = anchor.transform.columns.3.z
            self.parameters[Parameters.ANCHOR_TRANSFORM_4X4] = anchor.transform.columns.3.w
        }

        var text = ""
        var sendText = ""
        for (key, value) in self.parameters.sorted(by: <) {
            text += key + ":" + String(value) + "\n"
            sendText += key + "=" + String(value) + "&"
        }

        DispatchQueue.main.async { self.parameterText.text = text }

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

