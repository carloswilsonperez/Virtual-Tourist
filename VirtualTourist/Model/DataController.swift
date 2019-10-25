//
//  DataController.swift
//  Mooskine
//
//  Created by 강선미 on 07/10/2019.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation
import CoreData

class DataController {
    let persistentContainer:NSPersistentContainer
    
    var viewContext:NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var backgroundContext:NSManagedObjectContext!
    
    // Using context on the wrong queue won't always crash app
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func configureContexts() {
        
        // instantiate the background context
        backgroundContext = persistentContainer.newBackgroundContext()
        viewContext.automaticallyMergesChangesFromParent = true
        backgroundContext.automaticallyMergesChangesFromParent = true
        
        // background thread 권한 부여
        backgroundContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
    }
    
    func load(completion: (() -> Void)? = nil) {
           persistentContainer.loadPersistentStores { storeDescription, error in
               guard error == nil else {
                   fatalError(error!.localizedDescription)
               }
            self.autoSaveViewContext()
            self.configureContexts()
            completion?()
           }
       }
}

extension DataController {
    
    // save data for 30 sec
    func autoSaveViewContext(interval:TimeInterval = 30) {
        print("autosaving!!")
        guard interval > 0 else {
            print("cannot set negative autosave interval")
            return
        }
        
        if viewContext.hasChanges {
            try? viewContext.save()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            self.autoSaveViewContext(interval: interval)
        }
    }
}
