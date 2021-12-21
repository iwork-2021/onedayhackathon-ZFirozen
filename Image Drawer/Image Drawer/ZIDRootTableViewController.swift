//
//  ZIDRootTableViewController.swift
//  Image Drawer
//
//  Created by ZFirozen on 2021/12/21.
//

import UIKit
import CoreML
import Vision
import CoreMedia

class ZIDRootTableViewController: UITableViewController {

    @IBOutlet weak var cameraButton: UITableViewCell!
    @IBOutlet weak var photoLibraryButton: UITableViewCell!
    var imageSets: [UIImage] = []
    var drawers: [String: ZImageSets] = [:]
    var allImages: ZImageSets = ZImageSets()
    var lastResult: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        drawers["apple"] = ZImageSets()
        drawers["banana"] = ZImageSets()
        drawers["cake"] = ZImageSets()
        drawers["candy"] = ZImageSets()
        drawers["carrot"] = ZImageSets()
        drawers["cookie"] = ZImageSets()
        drawers["doughnut"] = ZImageSets()
        drawers["grape"] = ZImageSets()
        drawers["hot dog"] = ZImageSets()
        drawers["ice cream"] = ZImageSets()
        drawers["juice"] = ZImageSets()
        drawers["muffin"] = ZImageSets()
        drawers["orange"] = ZImageSets()
        drawers["pineapple"] = ZImageSets()
        drawers["popcorn"] = ZImageSets()
        drawers["pretzel"] = ZImageSets()
        drawers["salad"] = ZImageSets()
        drawers["strawberry"] = ZImageSets()
        drawers["waffle"] = ZImageSets()
        drawers["watermelon"] = ZImageSets()
        drawers["others"] = ZImageSets()
    }
    
    lazy var classificationRequest: VNCoreMLRequest = {
        do{
            let classifier = try snacks(configuration: MLModelConfiguration())
            
            let model = try VNCoreMLModel(for: classifier.model)
            let request = VNCoreMLRequest(model: model, completionHandler: {
                [weak self] request,error in
                self?.processObservations(for: request, error: error)
            })
            request.imageCropAndScaleOption = .centerCrop
            return request
            
            
        } catch {
            fatalError("Failed to create request")
        }
    }()

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "select" {
            let pickerViewController = segue.destination as! ZPickerViewController
            pickerViewController.pickerType = .photoLibrary
            pickerViewController.imagePickerDelegate = self
        } else if segue.identifier == "new" {
            let pickerViewController = segue.destination as! ZPickerViewController
            pickerViewController.pickerType = .camera
            pickerViewController.imagePickerDelegate = self
        } else if segue.identifier == "all" {
            let collectionViewController = segue.destination as! ZCollectionViewController
            collectionViewController.imageSets = allImages
            collectionViewController.imagePerformDelegate = self
            collectionViewController.navigationItem.title = "All Images"
        } else if segue.identifier == "list" {
            let drawerViewController = segue.destination as! ZDrawerViewController
            drawerViewController.drawerPerformDelegate = self
            drawerViewController.imagePerformDelegate = self
            drawerViewController.navigationItem.title = "Drawers"
        }
    }
    
    func classify(image: UIImage) {
        if let cgImage = image.cgImage {
            let handler = VNImageRequestHandler(cgImage: cgImage)
            do {
                try handler.perform([self.classificationRequest])
            } catch {
                print("Failed to perform classification: \(error)")
            }
        } else {
            print("Failed to get CGImage")
        }
    }
}

extension ZIDRootTableViewController: ImagePickerDelegate {
    func imageSelected(newImage: UIImage) {
        classify(image: newImage)
        if lastResult != nil {
            let index = self.imageSets.endIndex
            self.imageSets.append(newImage)
            self.drawers[lastResult!]?.sets.append(index)
            self.allImages.sets.append(index)
        }
    }
}

extension ZIDRootTableViewController: ImagePerformDelegate {
    func imagePerform(index: Int) -> UIImage {
        return imageSets[index]
    }
}

extension ZIDRootTableViewController: DrawerPerformDelegate {
    func drawerPerform(_ index: Int) -> (String, ZImageSets) {
        var drawerString: String = ""
        switch (index) {
        case 0: drawerString = "apple"
        case 1: drawerString = "banana"
        case 2: drawerString = "cake"
        case 3: drawerString = "candy"
        case 4: drawerString = "carrot"
        case 5: drawerString = "cookie"
        case 6: drawerString = "doughnut"
        case 7: drawerString = "grape"
        case 8: drawerString = "hot dog"
        case 9: drawerString = "ice cream"
        case 10: drawerString = "juice"
        case 11: drawerString = "muffin"
        case 12: drawerString = "orange"
        case 13: drawerString = "pineapple"
        case 14: drawerString = "popcorn"
        case 15: drawerString = "pretzel"
        case 16: drawerString = "salad"
        case 17: drawerString = "strawberry"
        case 18: drawerString = "waffle"
        case 19: drawerString = "watermelon"
        default:
            drawerString = "others"
        }
        return (drawerString, self.drawers[drawerString]!)
    }
}

extension ZIDRootTableViewController {
    func processObservations(for request: VNRequest, error: Error?) {
        if let results = request.results as? [VNClassificationObservation] {
            if results.isEmpty {
                lastResult = "others"
                return
            } else {
                let result = results[0].identifier
                let confidence = results[0].confidence
                print(result)
                print(confidence)
                if confidence < 0.6 {
                    lastResult = "others"
                } else {
                    lastResult = result
                }
                return
            }
        } else if let error = error {
            let alert = UIAlertController(
                title: "Unable to Identify Image",
                message: "Error: \(error.localizedDescription)",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(
                                title: "OK",
                                style: .default,
                                handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(
                title: "Unable to Identify Image",
                message: "Error: failed due to unknown reason",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(
                                title: "OK",
                                style: .default,
                                handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        lastResult = nil
        return
    }
}
