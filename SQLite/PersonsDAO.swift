

import Foundation

class PersonsDao{
    
    //NOTE: db!.executeUpdate is used if any action is to be taken on the data.When we want to access data, we use db!.executeQuery
    
    
    
    // I created my database object
    let db:FMDatabase?
    
    
    init(){
        let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let placeToCopy = URL(fileURLWithPath: targetPath).appendingPathComponent("personsloggin.sqflite")
        
        db = FMDatabase(path: placeToCopy.path)
    }
    
    /// ** Data Add
    
    func databaseAddData(personName:String,personAge:Int){
        
        db?.open()
        
        do{
            try db!.executeUpdate("INSERT INTO Persons(personName,personAge) VALUES (?,?)", values:[personName,personAge])
        }catch{
            print(error.localizedDescription)
        }
        db!.close()
    }
    
    
    ///**  Data read
    
    func databaseTakeAllDb() ->[Persons]{
        
        
        
        var receivedPersonList = [Persons]()
        
        db?.open()
        
        do{
            // resultSet : our query to database

            let resultSet = try  db!.executeQuery("SELECT * FROM Persons", values: nil) // we got all the data
            
          
            //NOT: We assigned the data in the db to the array variable
            while resultSet.next() {
                let person = Persons(personID: Int(resultSet.string(forColumn: "personID"))!
                                     ,personName: resultSet.string(forColumn: "personName")!
                                     ,personAge: Int(resultSet.string(forColumn: "personAge"))!)
                
                receivedPersonList.append(person)
            }
             
        }catch{
            print(error.localizedDescription)
        }
        
        db!.close()
        
        return receivedPersonList
    }
    
    ///**  Data Delete
    func databaseDeleteData(personID:Int){
        
        db?.open()
        
        do{
            try db!.executeUpdate("DELETE FROM Persons WHERE personID = ?", values:[personID])
        }catch{
            print(error.localizedDescription)
        }
        db!.close()
    }
    ///**  Data Update
    
    func databaseUpdateData(personID:Int,personName:String,personAge:Int){
        db?.open()
        
        do{
            try db!.executeUpdate("UPDATE Persons SET personName = ? , personAge = ? WHERE personID = ? ", values:[personName,personAge,personID])
        }catch{
            print(error.localizedDescription)
        }
        db!.close()
    }
    
    ///**  Record Control
    
    func databaseRecordControl(personName:String) -> Int {
        
        var resultValue = 0
        
        db?.open()
        
        do{
            
            let resultSet = try  db!.executeQuery("SELECT count(*) as result  FROM Persons WHERE personName = ?", values: [personName])
            
            while resultSet.next() {
                
                resultValue = Int(resultSet.string(forColumn: "result"))!
            }
             
        }catch{
            print(error.localizedDescription)
        }
        
        db!.close()
        
        return resultValue
    }
    ///** To pull the desired information from the database
    func databaseSearchExecute(personName:String) ->[Persons]{
        
        var receivedPersonList = [Persons]()
        
        db?.open()
        
        do{
            
           
            let resultSet = try  db!.executeQuery("SELECT * FROM Persons WHERE personName like '%\(personName)%'", values: nil)
            
            while resultSet.next() {
                let person = Persons(personID: Int(resultSet.string(forColumn: "personID"))!
                                     ,personName: resultSet.string(forColumn: "personName")!
                                     ,personAge: Int(resultSet.string(forColumn: "personAge"))!)
                
                receivedPersonList.append(person)
            }
             
        }catch{
            print(error.localizedDescription)
        }
        
        db!.close()
        
        return receivedPersonList
    }
    
    ///** if we want to get single data
    
    func databaseTakeOneData(personID:Int) -> Persons{
        
        var receivedPerson = Persons()
        
        db?.open()
        
        do{
            
            
            let resultSet = try  db!.executeQuery("SELECT * FROM Persons WHERE personID = ?", values: [personID])
            
            while resultSet.next() {
                receivedPerson = Persons(personID: Int(resultSet.string(forColumn: "personID"))!
                                     ,personName: resultSet.string(forColumn: "personName")!
                                     ,personAge: Int(resultSet.string(forColumn: "personAge"))!)
            }
             
        }catch{
            print(error.localizedDescription)
        }
        
        db!.close()
        
        return receivedPerson
    }
    
    ///** limited data retrieval
    func databaseLimitedData() ->[Persons]{
        
        var receivedPersonList = [Persons]()
        
        db?.open()
        
        do{
            
            let resultSet = try  db!.executeQuery("SELECT * FROM Persons LIMIT 2 ", values: nil) //
            while resultSet.next() {
                let person = Persons(personID: Int(resultSet.string(forColumn: "personID"))!
                                     ,personName: resultSet.string(forColumn: "personName")!
                                     ,personAge: Int(resultSet.string(forColumn: "personAge"))!)
                
                receivedPersonList.append(person)
            }
             
        }catch{
            print(error.localizedDescription)
        }
        
        db!.close()
        
        return receivedPersonList
    }
    
    ///** get random data
    
    func databaseRandomData() ->[Persons]{
        
        var receivedPersonList = [Persons]()
        
        db?.open()
        
        do{
            
            let resultSet = try  db!.executeQuery("SELECT * FROM Persons ORDER BY RANDOM() LIMIT 2 ", values: nil)
            
            
            while resultSet.next() {
                let person = Persons(personID: Int(resultSet.string(forColumn: "personID"))!
                                     ,personName: resultSet.string(forColumn: "personName")!
                                     ,personAge: Int(resultSet.string(forColumn: "personAge"))!)
                
                receivedPersonList.append(person)
            }
             
        }catch{
            print(error.localizedDescription)
        }
        
        db!.close()
        
        return receivedPersonList
    }
    
}
