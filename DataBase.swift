//
//  DataBase.swift
//  FINAL_SMTH
//
//  Created by Алина Ненашева on 10/5/20.
//  Copyright © 2020 Алина Ненашева. All rights reserved.
//

import Foundation
import SQLite
class DataBase {
     
    var database: Connection!
    
    static let shared = DataBase()
    
    private let workersTable = Table("workers")
    private let idWorker = Expression<Int>("id")
    private let workerName = Expression<String>("worker full name")
    private let age = Expression<Int>("age")
    private let riskCategory = Expression<String>("risk category")
    
    private let agentsTable = Table("agents")
    private let idAgent = Expression<Int>("id")
    private let agentName = Expression<String>("agent full name")
    private let passport = Expression<String>("passport")
    private let phone = Expression<String>("phone number")
    
    private init(){
        do {
                   let documentDirectroy = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                   let fileURL = documentDirectroy.appendingPathComponent("lab2").appendingPathExtension("sqlite3")
                   let database = try Connection(fileURL.path)
                   self.database = database
               } catch {
                   print(error)
               }
    }
    
    func createWorkerTable(){
          let createTable = self.workersTable.create { (table) in
              table.column(self.idWorker, primaryKey: true)
              table.column(self.workerName)
              table.column(self.age)
              table.column(self.riskCategory)
          }
          do {
              try self.database.run(createTable)
              print("CREATED WORKER TABLE")
          } catch {
              print(error)
          }
      }
    
    func createAgentTable(){
          let createTable = self.agentsTable.create { (table) in
              table.column(self.idAgent, primaryKey: true)
              table.column(self.agentName)
              table.column(self.passport)
              table.column(self.phone)
          }
          do {
              try self.database.run(createTable)
              print("CREATED AGENT TABLE")
          } catch {
              print(error)
          }
      }
    
    func addWorker(worker: Worker){
        let insertWorker = self.workersTable.insert(self.workerName <- worker.name, self.age <- worker.age)
        do {
            try self.database.run(insertWorker)
            print("WORKER INSERTED")
        } catch {
            print(error)
        }
    }
        
    func addAgent(agent: Agent){
        let insertAgent = self.agentsTable.insert(self.agentName <- agent.name, self.phone <- agent.phone, self.passport <- agent.passport)
        do {
            try self.database.run(insertAgent)
            print("AGENT INSERTED")
        } catch {
            print(error)
        }
    }

    func deleteWorker(workerID: Int){
        let worker = self.workersTable.filter(self.idWorker == workerID)
        let deleteWorker = worker.delete()
        do {
            try self.database.run(deleteWorker)
            print("WORKER DELETED")
        } catch {
            print(error)
        }
    }
    
    func deleteAgent(agentID: Int){
        let agent = self.agentsTable.filter(self.idAgent == agentID)
        let deleteAgent = agent.delete()
        do {
            try self.database.run(deleteAgent)
            print("AGENT DELETED")
        } catch {
            print(error)
        }
    }
    
    func editWorker(workerID: Int, name: String?, age: String?, riskCategory: String?){
        let worker = self.workersTable.filter(self.idWorker == workerID)
        if let unwrappedName = name {
            let updateWorkerName = worker.update(self.workerName <- unwrappedName)
            do {
                try self.database.run(updateWorkerName)
                print("WORKER NAME EDITED")
            } catch {
                print(error)
            }
        }
        if let unwrappedAgeString = age {
            if let unwrappedAge = Int(unwrappedAgeString) {
            let updateWorkerAge = worker.update(self.age <- unwrappedAge)
            do {
                try self.database.run(updateWorkerAge)
                print("WORKER AGE EDITED")
            } catch {
                print(error)
            }
            }
            
        }
        if let unwrappedRiskCategory = riskCategory {
            let updateWorkerRiskCategory = worker.update(self.riskCategory <- unwrappedRiskCategory)
            do {
                try self.database.run(updateWorkerRiskCategory)
                print("WORKER RISK EDITED")
            } catch {
                print(error)
            }
        }
    }
    
//    func editAgent(agentID: Int, name: String?, phone: String?, passport: String?){
//           let agent = self.workersTable.filter(self.idWorker == workerID)
//           if let unwrappedName = name {
//               let updateWorkerName = worker.update(self.workerName <- unwrappedName)
//               do {
//                   try self.database.run(updateWorkerName)
//                   print("WORKER NAME EDITED")
//               } catch {
//                   print(error)
//               }
//           }
//           if let unwrappedAgeString = age {
//               if let unwrappedAge = Int(unwrappedAgeString) {
//               let updateWorkerAge = worker.update(self.age <- unwrappedAge)
//               do {
//                   try self.database.run(updateWorkerAge)
//                   print("WORKER AGE EDITED")
//               } catch {
//                   print(error)
//               }
//               }
//               
//           }
//           if let unwrappedRiskCategory = riskCategory {
//               let updateWorkerRiskCategory = worker.update(self.riskCategory <- unwrappedRiskCategory)
//               do {
//                   try self.database.run(updateWorkerRiskCategory)
//                   print("WORKER RISK EDITED")
//               } catch {
//                   print(error)
//               }
//           }
//       }
}

