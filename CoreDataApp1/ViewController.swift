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
    @IBOutlet private weak var txtTen: UITextField!
    @IBOutlet private weak var txtQue: UITextField!
    @IBOutlet private weak var lblInfo: UILabel!
    
    private func getManagedObjectContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        return appDelegate.persistentContainer.viewContext
    }
    
    //  Tạo Kho chứa các đối tượng
    var context: NSManagedObjectContext? {
        get {
            return getManagedObjectContext()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //  ------------------      Core Data       ------------------
    
    struct const {
        func NguoiSetValueForTenQue(Nguoi: NSManagedObject,Ten: String, Que: String){
            Nguoi.setValue(Ten, forKey: "ten")
            Nguoi.setValue(Que, forKey: "que")
        }
    }
    
    @IBAction func handleAddButtonClick(_ sender: Any) {
        //  Tạo entity của đối tượng
        guard let context = context, let personEntity = NSEntityDescription.entity(forEntityName: "Nguoi", in: context) else { return }
        let Nguoi = NSManagedObject.init(entity: personEntity, insertInto: context)
        //  Add thông tin vào thuộc tính
        let constSetValue = const()
        constSetValue.NguoiSetValueForTenQue(Nguoi: Nguoi, Ten: txtTen.text ?? "", Que: txtQue.text ?? "")
        //  Save data
        do {
            try context.save()
        } catch {
            print("Error Save")
        }
    }
    
    @IBAction func handleSearchButtonClick(_ sender: Any) {
        //  Tạo request truy vấn dữ liệu
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Nguoi")
        //  Tạo mảng chứa dữ liệu
        do {
            let result = try context?.fetch(fetchRequest) as! [NSManagedObject]
            //  In ra các thông tin
            for item in result {
                print(item.value(forKey: "ten") ?? "", item.value(forKey: "que") ?? "")
            }
        } catch {
            print("Error result")
        }
    }
}

