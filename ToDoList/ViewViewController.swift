//
//  ViewViewController.swift
//  ToDoList
//
//  Created by Hossam Elshewikh on 5/12/21.
//
import RealmSwift
import UIKit

class ViewViewController: UIViewController {

    
    public var item: ToDoListItem?
    
    
    public var deletionHandler: (() -> Void)?
    
    @IBOutlet var itemLable: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    private let realm = try! Realm()
    

    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        itemLable.text = item?.item
        dateLabel.text = Self.dateFormatter.string(from: item!.date)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))
        // Do any additional setup after loading the view.
    }
    
    
    @objc private func didTapDelete(){
        guard let myItem = self.item else {
            return
        }
        
        realm.beginWrite()
        realm.delete(myItem)
        try! realm.commitWrite()
        
        deletionHandler?()
        navigationController?.popToRootViewController(animated: true)
        
    }

}
