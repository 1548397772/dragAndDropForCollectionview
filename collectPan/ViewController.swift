//
//  ViewController.swift
//  collectPan
//
//  Created by yhc on 2020/8/7.
//  Copyright © 2020 hongcy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 400, height: 50)
        self.navigationController?.pushViewController(ColViewController(collectionViewLayout: layout), animated: true)
    }

}

