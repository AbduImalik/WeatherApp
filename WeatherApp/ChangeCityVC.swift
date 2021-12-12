//
//  ChangeCityVC.swift
//  WeatherApp
//
//  Created by Abdulmalik on 05/05/1443 AH.
//

import UIKit

class ChangeCityVC: UIViewController {
    
    var citieArray = [
        
        City(name: "الرياض",cityID: "108410"),
        City(name: "الدمام", cityID: "110336"),
        City(name: "جده", cityID: "105343"),
        City(name: "مكة", cityID: "104514"),
        

    ]
    var selectedCity : City?
    @IBOutlet weak var changeCityPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        changeCityPicker.delegate = self
        changeCityPicker.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonChangeAction(_ sender: Any) {
        if let city = selectedCity {
            NotificationCenter.default.post(name: NSNotification.Name("CityValueChanges"), object: nil, userInfo: ["city" : city])
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    

}
extension ChangeCityVC : UIPickerViewDataSource,UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return citieArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return citieArray[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCity = citieArray[row]
    }
    
}
