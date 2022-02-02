
import Foundation

class Persons {
    var personID:Int?
    var personName:String?
    var personAge:Int?
    
    init(){
        
    }
    
    init(personID:Int,personName:String,personAge:Int){
        
        self.personID = personID
        self.personName = personName
        self.personAge = personAge
        
    }
}
