//
//  MainCollectionViewController.swift
//  USCitizenshipTestApp
//
//  Created by Dongwoo Pae on 9/7/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit
import CoreData
import SAConfettiView

class MainCollectionViewController: UICollectionViewController, SectionHeaderDelegate, NSFetchedResultsControllerDelegate {
    
    
    //MARK: FetchedResultController
    lazy var fetchedResultsController: NSFetchedResultsController<Question> = {
        let fetchRequest: NSFetchRequest<Question> = Question.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "questionPhoto", ascending: true)]
        let moc = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        try! frc.performFetch()
        return frc
    }()
    
    
    //MARK: ModelViewController instance
    let modelViewController = ModelViewController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.observeShouldReloadData()
        self.updateNavBarTheme()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionHeadersPinToVisibleBounds = true
    }
    
    
    //MARK: Observer for updated datas
    func observeShouldReloadData() {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshViews(notification:)), name: .needtoReloadData, object: nil)
    }
    @objc func refreshViews(notification: Notification) {
        self.collectionView.reloadData()
    }
    
    
    //MARK: Upate navigation bar theme
    private func updateNavBarTheme() {
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: .shouldShowWhiteTheme) == true {
            //updateNavBar
            let mainColorBlue = #colorLiteral(red: 0.1578108668, green: 0.298258096, blue: 0.4726179838, alpha: 1)
            let textAttributes = [NSAttributedString.Key.foregroundColor: mainColorBlue]
            self.navigationController?.navigationBar.titleTextAttributes = textAttributes
            self.navigationController?.navigationBar.barTintColor = .white
            
        } else {
            let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            self.navigationController?.navigationBar.titleTextAttributes = textAttributes
            self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1578108668, green: 0.298258096, blue: 0.4726179838, alpha: 1)
        }
    }
    
    // MARK: - Navigation - Prepare segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            guard let destVC = segue.destination as? DetailViewController,
                let selectedItem = collectionView.indexPathsForSelectedItems?.first else {return}
            destVC.question = self.fetchedResultsController.object(at: selectedItem)
            destVC.modelViewController = modelViewController
        }
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MainCollectionViewCell
        let question = self.fetchedResultsController.object(at: indexPath)
        cell.question = question
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! SectionHeader
        view.questions = self.fetchedResultsController.fetchedObjects
        //delegate being assigned here for mainCollectionViewController to show alert based on datas from sectionHeader
        view.delegate = self
        return view
    }
    
    
    //MARK: Required methods for SectionHeaderDelegate
    //confetti view method
    func showConfettiAnimation() {
        
        let confettiView = SAConfettiView(frame: self.view.bounds)
        self.view.addSubview(confettiView)
        confettiView.type = .Star
        confettiView.intensity = 0.75
        confettiView.startConfetti()
        
        //UIAlerts - Okay and Reset
        let alert = UIAlertController(title: "Congratulations!", message: "You studied all civics questions", preferredStyle: .actionSheet)
        
        let okayAction = UIAlertAction(title: "Okay, I am ready for the test", style: .default) { (_) in
    
            confettiView.stopConfetti()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                confettiView.removeFromSuperview()
            })
        }
        let resetAction = UIAlertAction(title: "Reset", style: .default) { (_) in
        
            confettiView.stopConfetti()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                confettiView.removeFromSuperview()
    
                self.reset()
            })
        }
        
        alert.addAction(okayAction)
        alert.addAction(resetAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //private method for reset()
    private func reset() {
        //objects from fetchedResultsController
        let objects: [Question] = self.fetchedResultsController.fetchedObjects!
        let completedQuestions = objects.filter{$0.isCompleted == true}
        for i in completedQuestions {
            i.isCompleted = false
        }
        self.modelViewController.saveToPersistentStore()
        self.collectionView.reloadData()
    }
    
    
    //UIAlerts for progress check
    func showAlertTwentyFive() {
        let alert = UIAlertController(title: "25% Done", message: "Studied 25 out of 100", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Keep it up! You can do this!", style: .default, handler: nil)
        alert.addAction(okayAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertFifty() {
        let alert = UIAlertController(title: "50% Done", message: "Studied 50 out of 100", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Keep it up!", style: .default, handler: nil)
        alert.addAction(okayAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertSeventyFive() {
        let alert = UIAlertController(title: "75% Done", message: "Studied 75 out of 100", preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "Almost there!", style: .default, handler: nil)
        alert.addAction(okayButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    //Extra - resetting the datas based on datas being fetched through NSPredicate
    /*
     //using NSPredicate to show isCompleted true value objects but it seems like NSPredicate is only for unique values??
     private func resetThroughNSPredicate() {
     let backgroundContext = CoreDataStack.shared.container.newBackgroundContext()
     backgroundContext.performAndWait {
     //getting the specific object from persistentStore - CoreData
     if let objects = self.modelViewController.fetchTrueQuestionsFromPersistentStore(for: true, context: backgroundContext) {
     for i in objects {
     i.isCompleted = false
     }
     } else {
     print("there is an error in updating question object from persistent store")
     }
     
     do {
     try backgroundContext.save()
     } catch {
     NSLog("there is an error in saving the data as backgroundContext")
     }
     }
     }
     */
}
