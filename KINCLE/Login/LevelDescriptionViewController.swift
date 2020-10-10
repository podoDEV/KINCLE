//
//  LevelDescriptionViewController.swift
//  KINCLE
//
//  Created by Zedd on 2020/10/10.
//  Copyright © 2020 Zedd. All rights reserved.
//

import UIKit

class LevelDescriptionViewController: UIViewController {

    static func create() -> LevelDescriptionViewController {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "LevelDescriptionViewController") as! LevelDescriptionViewController

        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: false, completion: nil)
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
