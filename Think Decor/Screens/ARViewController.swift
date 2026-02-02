import UIKit
import ARKit
import SceneKit

class ARViewController: UIViewController, ARSCNViewDelegate {

    private var sceneView: ARSCNView!

    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView = ARSCNView(frame: view.bounds)
        sceneView.delegate = self
        sceneView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(sceneView)

        sceneView.autoenablesDefaultLighting = true
        
        let pan = UIPanGestureRecognizer(target: self,
                                         action: #selector(handlePan(_:)))
//        sceneView.addGestureRecognizer(pan)

        let rotationGesture = UIRotationGestureRecognizer(
                    target: self,
                    action: #selector(handleRotation(_:))
                )
                sceneView.addGestureRecognizer(rotationGesture)
    }

    
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]

        sceneView.session.run(config)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    // MARK: - Drag to move

        @objc
    private func handlePan(_ gesture: UIPanGestureRecognizer) {
        
        guard let node = placedNode else { return }
        
        let location = gesture.location(in: sceneView)
        
        let query = sceneView.raycastQuery(
            from: location,
            allowing: .estimatedPlane,
            alignment: .horizontal
        )
        
        guard let raycastQuery = query else { return }
        
        let results = sceneView.session.raycast(raycastQuery)
        
        guard let result = results.first else { return }
        
        let transform = result.worldTransform
        
        let position = SCNVector3(
            transform.columns.3.x,
            transform.columns.3.y,
            transform.columns.3.z
        )
        
        node.position = position
    }
    
    // MARK: - Rotate object

    @objc
    private func handleRotation(_ gesture: UIRotationGestureRecognizer) {

        guard let node = placedNode else { return }

        if gesture.state == .changed {

            // rotate around Y axis
            node.eulerAngles.y -= Float(gesture.rotation)

            gesture.rotation = 0
        }
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        guard let touch = touches.first else { return }

        let location = touch.location(in: sceneView)

        let query = sceneView.raycastQuery(
            from: location,
            allowing: .estimatedPlane,
            alignment: .horizontal
        )

        guard let raycastQuery = query else { return }

        let results = sceneView.session.raycast(raycastQuery)

        guard let result = results.first else { return }

        placeObject(result: result)
    }
    
    private var placedNode: SCNNode?


    private func placeObject(result: ARRaycastResult) {

        let transform = result.worldTransform

        let position = SCNVector3(
            transform.columns.3.x,
            transform.columns.3.y,
            transform.columns.3.z
        )

        // If already created → just move it
        if let node = placedNode {
            node.position = position
            return
        }

        // Otherwise create it
        guard let scene = SCNScene(named: "wooden_chair.usdz") else {
            print("chair.usdz not found in bundle")
            return
        }

        guard let node = scene.rootNode.childNodes.first else { return }

        
        node.position = position

        // ✅ Reduce object size here
        node.scale = SCNVector3(0.01, 0.01, 0.01)   // try 0.1 or 0.15 if still big

        sceneView.scene.rootNode.addChildNode(node)

        placedNode = node
    }

}
