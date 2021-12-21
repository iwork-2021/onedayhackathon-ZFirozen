//
//  ZCollectionViewController.swift
//  Image Drawer
//
//  Created by ZFirozen on 2021/12/21.
//

import UIKit

private let reuseIdentifier = "Cell"

protocol ImagePerformDelegate {
    func imagePerform(index: Int) -> UIImage
}

class ZCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    weak var imageSets: ZImageSets?
    var imagePerformDelegate: ImagePerformDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(ZCollectionViewCell.self, forCellWithReuseIdentifier: "reuseIdentifier")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.imageSets!.sets.endIndex
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseIdentifier", for: indexPath) as! ZCollectionViewCell
    
        // Configure the cell
        cell.image = imagePerformDelegate?.imagePerform(index: indexPath.row)
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 414, height: (cell.image?.size.height)! / (cell.image?.size.width)! * 414))
    print((cell.image?.size.height)! / (cell.image?.size.width)! * 414)
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        imageView.image = cell.image!
        cell.autoresizesSubviews = true
        cell.contentView.autoresizingMask = UIView.AutoresizingMask.flexibleWidth;
        cell.addSubview(imageView)
        cell.subviews[0].layoutSubviews()
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "show" {
            let imageViewController = segue.destination as! ZImageViewController
            let cell = sender as! ZCollectionViewCell
            imageViewController.image = cell.image
        }
    }
}
