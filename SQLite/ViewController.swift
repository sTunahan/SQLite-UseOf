

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        databaseCopy()
        
        
        let p = PersonsDao()
        //print(p.databaseRecordControl(personName: "mehmet"))
        //p.databaseAddData(personName: "selma", personAge: 45)
        //p.databaseDeleteData(personID: 1)
        //p.databaseUpdateData(personID: 4, personName: "mehmet", personAge: 65)
        let incommingList = p.databaseTakeAllDb()
        //let incommingList2 = p.databaseSearchExecute(personName: "e")
        
        p.databaseTakeOneData(personID: 2)
        
        for i in incommingList{
            print("personID:\(i.personID!) \n personName:\(i.personName!) \n personAge:\(i.personAge!)")
            
        }
    }

    
    
    func databaseCopy(){
        print("Worked databaseCopy")
        //Where we specify where the file is
        let bundlePath = Bundle.main.path(forResource: "personsloggin", ofType: ".sqlite.db")
    
        let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        //file manager , handles the file operation
        
        let fileManager = FileManager.default
        
        // We tell where and in which name it should be copied.
        let placeToCopy = URL(fileURLWithPath: targetPath).appendingPathComponent("personsloggin.sqlite")
        
    
        if fileManager.fileExists(atPath: placeToCopy.path){
            print("data available")
        }else{
            
            do{
                try fileManager.copyItem(atPath: bundlePath!, toPath:placeToCopy.path)
            }catch{
                print(error.localizedDescription)
            }
        }
        
    
    }
}

