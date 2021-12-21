//
//  ZImageViewController.swift
//  Image Drawer
//
//  Created by ZFirozen on 2021/12/21.
//

import UIKit

class ZImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    weak var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.imageView.image = image
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
