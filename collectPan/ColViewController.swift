//
//  ColViewController.swift
//  collectPan
//
//  Created by yhc on 2020/8/7.
//  Copyright © 2020 hongcy. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ColViewController: UICollectionViewController , UICollectionViewDragDelegate , UICollectionViewDropDelegate{
    var dataSourceY = ["01,","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19"]
    var currentIndex: IndexPath? = nil
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 375, height: 50)
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.collectionView.dragDelegate = self
        self.collectionView.dragInteractionEnabled = true
        self.collectionView.dropDelegate = self
        self.collectionView.reorderingCadence = .immediate
        self.collectionView.isSpringLoaded = true
        
        
        self.collectionView.register(UINib(nibName: "CollectionViewCellCubic", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.backgroundColor = .white
        // Do any additional setup after loading the view.
    }


    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(dataSourceY)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return dataSourceY.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : CollectionViewCellCubic = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCellCubic
        // Configure the cell
        cell.labTitle.text = dataSourceY[indexPath.row]
        return cell
    }

    
    //drag
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        currentIndex = indexPath
        let itemProvider = NSItemProvider(object: dataSourceY[indexPath.row] as NSItemProviderWriting)
        let item = UIDragItem(itemProvider: itemProvider)
        return [item]
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        let itemProvider = NSItemProvider(object: dataSourceY[indexPath.row] as NSItemProviderWriting)
        let item = UIDragItem(itemProvider: itemProvider)
        return [item]
    }

    func collectionView(_ collectionView: UICollectionView, dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        let preview = UIDragPreviewParameters()
        preview.visiblePath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 370, height: 50), cornerRadius: 10)
        preview.backgroundColor = .yellow
        return preview
    }
    
    //drop

    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
//        coordinator.session.progressIndicatorStyle = UIDropSessionProgressIndicatorStyle.none
        let destinationIndexPath = coordinator.destinationIndexPath
        let dragItem: UIDragItem = coordinator.items.first!.dragItem
        let currentTitleString = self.dataSourceY[currentIndex!.row]
        
        if dragItem.itemProvider.canLoadObject(ofClass: UIImage.self) {
            dragItem.itemProvider.loadObject(ofClass: UIImage.self) { (object, error) in
                
            }
        }
        
        if currentIndex!.section == destinationIndexPath!.section && currentIndex!.row == destinationIndexPath!.row{
            return
        }
        collectionView.performBatchUpdates({
            self.dataSourceY.remove(at: currentIndex!.item)
            self.dataSourceY.insert(currentTitleString, at: destinationIndexPath!.item)
            collectionView.moveItem(at: currentIndex!, to: destinationIndexPath!)
        }) { (finish) in
            
        }
        coordinator.drop(dragItem, toItemAt: destinationIndexPath!)
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
//        session.progressIndicatorStyle = UIDropSessionProgressIndicatorStyle.none
        var dropProposal : UICollectionViewDropProposal? = nil
        if session.localDragSession != nil {
          dropProposal = UICollectionViewDropProposal(operation: UIDropOperation.move, intent: UICollectionViewDropProposal.Intent.insertAtDestinationIndexPath)
        } else {
            dropProposal = UICollectionViewDropProposal(operation: UIDropOperation.move, intent: UICollectionViewDropProposal.Intent.insertAtDestinationIndexPath)
        }
        return dropProposal!
    }
    
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        if session.localDragSession == nil {
            return false
        } else {
            return true
        }
    }
}

