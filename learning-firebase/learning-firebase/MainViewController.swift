//
//  MainViewController.swift
//  
//
//  Created by Robbie Gay on 2/15/20.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift

class MainViewController: UIViewController {
    
    /*
     - Create (POST)
     - Read (GET)
     - Update/Replace (PUT)
     - Delete (DELETE)
     */
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var ref: DocumentReference? = nil
        
        // Add a new document with a generated ID
//        ref = db.collection("users").addDocument(data: [
//            "first": "Ada",
//            "last": "Lovelace",
//            "born": 1815
//        ]) { err in
//            if let err = err {
//                print("Error adding document: \(err)")
//            } else {
//                print("Document added with ID: \(ref!.documentID)")
//            }
//        }
        
        // Add a second document with a generated ID.
//        ref = db.collection("users").addDocument(data: [
//            "first": "Alan",
//            "middle": "Mathison",
//            "last": "Turing",
//            "born": 1912
//        ]) { err in
//            if let err = err {
//                print("Error adding document: \(err)")
//            } else {
//                print("Document added with ID: \(ref!.documentID)")
//            }
//        }
        
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }

        view.backgroundColor = .blue
    }

}
