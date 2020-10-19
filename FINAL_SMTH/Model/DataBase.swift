import Foundation
import SQLite
class DataBase {
     
    var database: Connection!
    
    static let shared = DataBase()
    
    private let workersTable = Table("workers")
    private let idWorker = Expression<Int>("idWorker")
    private let workerName = Expression<String>("workerName")
    private let age = Expression<Int>("age")
    private let riskCategory = Expression<String>("riskCategory")
    private let companyCode = Expression<String>("companyCode")
    
    private let agentsTable = Table("agents")
    private let idAgent = Expression<Int>("idAgent")
    private let agentName = Expression<String>("agentName")
    private let passport = Expression<String>("passport")
    private let phone = Expression<String>("phone")
    private let insuranceCompany = Expression<String>("insuranceCompany")
    
    private let companiesTable = Table("companies")
    private let idCompany = Expression<Int>("idCompany")
    private let code = Expression<String>("code")
    private let fullName = Expression<String>("fullName")
    private let shortName = Expression<String>("shortName")
    private let address = Expression<String>("address")
    private let bankID = Expression<Int>("bankID")
    private let specialization = Expression<String>("specialization")

    
    private let contractsTable = Table("contracts")
    private let idContract = Expression<Int>("idContract")
    private let dateOfSigning = Expression<String>("dateOfSigning")
    private let dateOfExpiring = Expression<String>("dateOfExpiring")
    private let insuranceSum = Expression<Int>("insuranceSum")
    private let contractCompanyCode = Expression<String>("contractCompanyCode")
    private let contractAgentID = Expression<Int>("contractAgentID")
    
    private let paymentsTable = Table("payments")
    private let sumOfPayments = Expression<Int>("sumOfPayments")
    private let workerCategory = Expression<String>("workerCategory")
    private let contractID = Expression<Int>("contractID")
    
    private init() {
        do {
            let databaseFileName = "lab_2.sqlite3"
            let databaseFilePath = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\(databaseFileName)"
            let db = try Connection(databaseFilePath)
            self.database = db
            createWorkerTable()
            createAgentTable()
            createCompanyTable()
            createPaymentTable()
            createContractTable()
            try database.execute("PRAGMA foreign_keys = ON;")
        } catch {
            print(error)
        }
    }
    
    func createWorkerTable(){
        try! database!.run(workersTable.create(ifNotExists: true) { table in
            table.column(idWorker, primaryKey: .autoincrement)
            table.column(workerName)
            table.column(age)
            table.column(riskCategory)
            table.column(companyCode)
            table.foreignKey(companyCode, references: companiesTable, code, delete: .cascade)
        })
    }
    
    func createAgentTable(){
        try! database!.run(agentsTable.create(ifNotExists: true) { table in
            table.column(idAgent, primaryKey: .autoincrement)
            table.column(agentName)
            table.column(passport)
            table.column(phone)
            table.column(insuranceCompany)
        })
    }
    
    func createCompanyTable(){
        try! database!.run(companiesTable.create(ifNotExists: true) { table in
            table.column(code, primaryKey: true)
            table.column(fullName)
            table.column(shortName)
            table.column(address)
            table.column(bankID)
            table.column(specialization)
        })
    }
    
    func createContractTable(){
        try! database!.run(contractsTable.create(ifNotExists: true) { table in
            table.column(idContract, primaryKey: .autoincrement)
            table.column(dateOfSigning)
            table.column(dateOfExpiring)
            table.column(insuranceSum)
            table.column(contractCompanyCode)
            table.column(contractAgentID)
            table.foreignKey(contractCompanyCode, references: companiesTable, code, delete: .cascade)
            table.foreignKey(contractAgentID, references: agentsTable, idAgent, delete: .cascade)
        })
    }
    
    func createPaymentTable(){
        try! database!.run(paymentsTable.create(ifNotExists: true) { table in
            table.column(workerCategory)
            table.column(sumOfPayments)
            table.column(contractID)
            table.foreignKey(contractID, references: contractsTable, idContract, delete: .cascade)
        })
    }
    
    func showAgentsList(companyCode: String, currentDate: String) -> [(currentDate: String, agentName: String, phone: String, insuranceCompany: String)]{
        typealias PickedAgent = (currentDate: String, agentName: String, phone: String, insuranceCompany: String)
        var pickedAgents = [PickedAgent]()
            let result = try? database.prepare("""
                SELECT agentName, phone, insuranceCompany FROM agents JOIN contracts ON agents.idAgent = contracts.contractAgentID WHERE "\(currentDate)" >= contracts.dateOfSigning AND "\(currentDate))" <= contracts.dateOfExpiring AND contracts.contractCompanyCode = "\(companyCode)"
                """)
            result?.forEach({ (row) in
                    let pickedAgent: PickedAgent
                    pickedAgent.0 = currentDate
                    pickedAgent.1 = "\(row[0]!)"
                    pickedAgent.2 = "\(row[1]!)"
                    pickedAgent.3 = "\(row[2]!)"
                    pickedAgents.append(pickedAgent)
            })
        return pickedAgents
    }
    
    func showPaymentsList(currentDate: String) -> [(currentDate: String, contractID: String, workerCategory: String, sumOfPayments: String)]{
        typealias PickedPayment = (currentDate: String, contractID: String, workerCategory: String, sumOfPayments: String)
        var pickedPayments = [PickedPayment]()
        do {
            let result = try? database.prepare("""
                SELECT contractID, workerCategory, sumOfPayments FROM payments JOIN contracts ON contracts.idContract = payments.contractID WHERE  "\(currentDate)" >= contracts.dateOfSigning AND "\(currentDate)" <= contracts.dateOfExpiring
                """)
            result?.forEach({ (row) in
                    let pickedPayment: PickedPayment
                    pickedPayment.0 = currentDate
                    pickedPayment.1 = "\(row[0]!)"
                    pickedPayment.2 = "\(row[1]!)"
                    pickedPayment.3 = "\(row[2]!)"
                    pickedPayments.append(pickedPayment)
            })
        return pickedPayments
        }
    }
    
    func showCompaniesList(companyCode: String, currentDate: String) -> [(companyName: String, address: String, currentDate: String, idContract: String, dateOfSigning: String, dateOfExpiring: String)]{
        typealias PickedCompany = (companyName: String, address: String, currentDate: String, idContract: String, dateOfSigning: String, dateOfExpiring: String)
        var pickedCompanies = [PickedCompany]()
            let result = try? database.prepare("""
                SELECT fullName, address, contracts.idContract, contracts.dateOfSigning, contracts.dateOfExpiring FROM companies JOIN contracts ON contracts.contractCompanyCode = companies.code WHERE "\(currentDate)" >= contracts.dateOfSigning AND "\(currentDate)" <= contracts.dateOfExpiring AND contracts.contractCompanyCode = "\(companyCode)"
                """)
            result?.forEach({ (row) in
                    let pickedCompany: PickedCompany
                    pickedCompany.0 = "\(row[0]!)"
                    pickedCompany.1 = "\(row[1]!)"
                    pickedCompany.2 = currentDate
                    pickedCompany.3 = "\(row[2]!)"
                    pickedCompany.4 = "\(row[3]!)"
                    pickedCompany.5 = "\(row[4]!)"
                    pickedCompanies.append(pickedCompany)
            })
        return pickedCompanies
    }
    
    func addWorker(worker: Worker){
        let insertWorker = self.workersTable.insert(self.workerName <- worker.name!, self.age <- worker.age!, self.riskCategory <- worker.riskCategory!, self.companyCode <- worker.companyCode!)
        do {
            try self.database.run(insertWorker)
        } catch {
            print(error)
        }
    }
        
    func addAgent(agent: Agent){
        let insertAgent = self.agentsTable.insert(self.agentName <- agent.name!, self.phone <- agent.phone!, self.passport <- agent.passport!, self.insuranceCompany <- agent.insuranceCompany!)
        do {
            try self.database.run(insertAgent)
        } catch {
            print(error)
        }
    }

    func addCompany(company: Company){
        let insertCompany = self.companiesTable.insert(self.code <- company.code!, self.fullName <- company.name!, self.shortName <- company.abbreviation!, self.address <- company.address! , self.bankID <- company.bankID!, self.specialization <- company.specialization!)
        do {
            try self.database.run(insertCompany)
        } catch {
            print(error)
        }
    }

    func deleteWorker(workerID: Int){
        let worker = self.workersTable.filter(self.idWorker == workerID)
        let deleteWorker = worker.delete()
        do {
            try self.database.run(deleteWorker)
        } catch {
            print(error)
        }
    }
    
    func deleteAgent(agentID: Int){
        let agent = self.agentsTable.filter(self.idAgent == agentID)
        let deleteAgent = agent.delete()
        do {
            try self.database.run(deleteAgent)
        } catch {
            print(error)
        }
    }
    
    func deleteCompany(companyCode: String){
        let company = self.companiesTable.filter(self.code == companyCode)
        let deleteCompany = company.delete()
        do {
            try self.database.run(deleteCompany)
        } catch {
            print(error)
        }
    }
    
    func editWorker(workerID: Int, name: String?, age: String?, riskCategory: String?){
        let worker = self.workersTable.filter(self.idWorker == workerID)
        if name != "" {
            let updateWorkerName = worker.update(self.workerName <- name!)
            do {
                try self.database.run(updateWorkerName)
            } catch {
                print(error)
            }
        }
        if let age = age, let unwrappedAge = Int(age) {
            let updateWorkerAge = worker.update(self.age <- unwrappedAge)
            do {
                try self.database.run(updateWorkerAge)
            } catch {
                print(error)
            }
        }
        if riskCategory != "" {
            let updateWorkerRiskCategory = worker.update(self.riskCategory <- riskCategory!)
            do {
                try self.database.run(updateWorkerRiskCategory)
            } catch {
                print(error)
            }
        }
    }
    
    func editAgent(agentID: Int, name: String?, passport: String?, phone: String?, insuranceCompany: String?){
        let agent = self.agentsTable.filter(self.idAgent == agentID)
        if name != "" {
            let updateAgentName = agent.update(self.agentName <- name!)
            do {
                try self.database.run(updateAgentName)
            } catch {
                print(error)
            }
        }
        if passport != "" {
            let updateAgentPassport = agent.update(self.passport <- passport!)
            do {
                try self.database.run(updateAgentPassport)
            } catch {
                print(error)
            }
        }
        if phone != "" {
            let updateAgentPhone = agent.update(self.phone <- phone!)
            do {
                try self.database.run(updateAgentPhone)
            } catch {
                print(error)
            }
        }
        if insuranceCompany != "" {
            let updateAgentInsuranceCompany = agent.update(self.phone <- insuranceCompany!)
            do {
                try self.database.run(updateAgentInsuranceCompany)
            } catch {
                print(error)
            }
        }
    }
    
    func editCompany(companyCode: String, fullName: String?, shortName: String?, bankID: String?, address: String?, specialization: String?){
        let company = self.companiesTable.filter(self.code == companyCode)
        if fullName != "" {
            let updateCompanyFullName = company.update(self.fullName <- fullName!)
            do {
                try self.database.run(updateCompanyFullName)
            } catch {
                print(error)
            }
        }
        if shortName != "" {
            let updateCompanyShortName = company.update(self.shortName <- shortName!)
            do {
                try self.database.run(updateCompanyShortName)
            } catch {
                print(error)
            }
        }
        if let bankID = bankID, let unwrappedBankID = Int(bankID) {
            let updateCompanyBankID = company.update(self.bankID <- unwrappedBankID)
            do {
                try self.database.run(updateCompanyBankID)
            } catch {
                print(error)
            }
        }
        if address != "" {
            let updateCompanyAddress = company.update(self.address <- address!)
            do {
                try self.database.run(updateCompanyAddress)
            } catch {
                print(error)
            }
        }
        if specialization != "" {
            let updateCompanySpecialization = company.update(self.specialization <- specialization!)
            do {
                try self.database.run(updateCompanySpecialization)
            } catch {
                print(error)
            }
        }
    }
    
    func getListOfWorkers() -> [Worker]{
        var workers = [Worker]()
        let result = try? database.prepare(workersTable)
         result?.forEach({ (row) in
            do{
                let worker: Worker = Worker()
                worker.workerID = try row.get(idWorker)
                worker.name = try row.get(workerName)
                worker.age = try row.get(age)
                worker.riskCategory = try row.get(riskCategory)
                worker.companyCode = try row.get(companyCode)
                workers.append(worker)
            }catch{
                print(error)
            }
         })
        return workers
    }
    
    func getListOfCompanies() -> [Company] {
        var companies = [Company]()
        let result = try? database.prepare(companiesTable)
         result?.forEach({ (row) in
            do{
                let company = Company()
                company.code = try row.get(code)
                company.name = try row.get(fullName)
                company.abbreviation = try row.get(shortName)
                company.address = try row.get(address)
                company.bankID = try row.get(bankID)
                company.specialization = try row.get(specialization)
                companies.append(company)
            }catch{
                print(error)
            }
         })
        return companies
    }
    
    func getListOfAgents() -> [Agent]{
        var agents = [Agent]()
            let result = try? database.prepare(agentsTable)
        result?.forEach({ (row) in
            do{
                let agent = Agent()
                agent.agentID = try row.get(idAgent)
                agent.name = try row.get(agentName)
                agent.passport = try row.get(passport)
                agent.phone = try row.get(phone)
                agent.insuranceCompany = try row.get(insuranceCompany)
                agents.append(agent)
            }catch{
                print(error)
            }
        })
        return agents
    }
    
    func getListOfContracts() -> [Contract]{
        var contracts = [Contract]()
            let result = try? database.prepare(contractsTable)
        result?.forEach({ (row) in
            do{
                let contract = Contract()
                contract.dateOfSigning = try row.get(dateOfSigning)
                contract.dateOfExpiring = try row.get(dateOfExpiring)
                contract.sumOfInsurance = try row.get(insuranceSum)
                contract.contractCompanyCode = try row.get(contractCompanyCode)
                contract.contractAgentID = try row.get(contractAgentID)
                contracts.append(contract)
            }catch{
                print(error)
            }
        })
        return contracts
    }
    
    func getListOfPayments() -> [Payment]{
        var payments = [Payment]()
            let result = try? database.prepare(paymentsTable)
        result?.forEach({ (row) in
            do{
                let payment = Payment()
                payment.sumOfPayment = try row.get(sumOfPayments)
                payment.workerCategory = try row.get(workerCategory)
                payment.contractID = try row.get(contractID)
                payments.append(payment)
            }catch{
                print(error)
            }
        })
        return payments
    }
}



