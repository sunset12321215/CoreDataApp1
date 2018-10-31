//
//  ViewController.swift
//  CoreDataApp1
//
//  Created by mac on 10/31/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    //  Ánh xạ
    @IBOutlet weak var txt_Ten: UITextField!
    @IBOutlet weak var txt_Que: UITextField!
    @IBOutlet weak var lbl_Info: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //  ------------------      Core Data       ------------------
    
        //  Tạo Kho chứa các đối tượng
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    @IBAction func btn_Them(_ sender: Any) {
        //  Tạo entity của đối tượng
        let entity_Nguoi = NSEntityDescription.entity(forEntityName: "Nguoi", in: context)
        let Nguoi = NSManagedObject.init(entity: entity_Nguoi!, insertInto: context)
        //  Add thông tin vào thuộc tính
        Nguoi.setValue(txt_Ten.text, forKey: "ten")
        Nguoi.setValue(txt_Que.text, forKey: "que")
        //  Save data
        try! context.save()
    }
    
    @IBAction func btn_Tim(_ sender: Any) {
        //  Tạo request truy vấn dữ liệu
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Nguoi")
        //  Tạo mảng chứa dữ liệu
        let result = try! context.fetch(fetchRequest) as! [NSManagedObject]
        //  In ra các thông tin
        for item in result
        {
            print(item.value(forKey: "ten") as! String, item.value(forKey: "que") as! String)
        }
    }
    
}

