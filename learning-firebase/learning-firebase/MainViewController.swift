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
        
        // Use setData to set the data of a document, add merge to avoid overwriting previous contents
        // db.collection("cities").document("BJ").setData([ "capital": true ], merge: true)
        // set requires you provide a id for the document
        // use add to have Firebase auto-generate a UID
        
//        db.collection("users").addDocument(data: ["autoGenDoc" : 1234])
        
        // Create (POST)
        // document("name").setData([data]) -> creates new doc or overwrites old one
        // addDocument(data: [data]) -> creates new doc with auto-generated UID
        // ------------------------------------------------------
        // Read (GET)
        // document("name).getDocument { (document, error) in
        //   if let document = document, document.exisit {
        //     print(document.data())
        //   } else {
        //     print("Error =>",error)
        //   }
        // }
        // Get multiple or all documents:
        // use a query to get specific docs:
        // db.collection("cities").whereField("capital", isEqualTo: true).getDocuments()
        // Omit queries to get all documents in that collection:
        // db.collection("users").getDocuments() { (QuerySnapshot, err) in
        //     if let error = err {
        //         print("Error =>", error)
        //     } else {
        //         for document in QuerySnapshot!.documents {
        //             print(document.documentID,"=>",document.data())
        //         }
        //     }
        // }
        // ------------------------------------------------------
        // Update (PUT)
        // updateData(["alreadyExists": "newValue"])
        // ------------------------------------------------------
        // Delete (DELETE)
        //
        // Notes:
        // Add a server timestamp: ["lastUpdated": FieldValue.serverTimestamp()]
        // Increment or decrement a value: "population": FieldValue.increment(Int64(50)) -> if no value, + by 1
        // Increments are useful but keep in mind that you can only update a document once per second
        // Queries:
        // create a query:
        // let capitalCities = db.collection("cities").whereField("capital", isEqualTo: true)
        // Execute the query by calling get():
        // capitalCities.getDocuments()
        // Check an array of values -> .whereField("regions", arrayContains: "west_coast")
        // Combine up to ten equality (==) clauses, and an OR option:
        // .whereField("country", in: ["USA", "Japan"])
        // This checkes => country == "USA" || "country" == "Japan"
        // Array contains any = matches if the array contains any of up to 10 values
        // .whereField("regions", arrayContainsAny: ["west_coast", "east_coast"])
        // You can't combine arrayContainsAny and in, in the same query
        // Compound query:
        // citiesRef
        //  .whereField("state", isEqualTo: "CO")
        //  .whereField("name", isEqualTo: "Denver")
        // This means => cityRef where state == "CO" && name == "Denver"
        // Query Notes:
        // Queries with range filters on different fields are not supported.
        // No support for !=, instead => where("age", "<", "30").where("age", ">", "30")
        
        
        
        // Tutorial code:
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
        
//        db.collection("users").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
//                }
//            }
//        }
    }

}
