//
//  ViewController.swift
//  DictionaryServiceClient
//
//  Created by Milena Korusiewicz on 02/06/2023.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var srcLangPicked: String?
    var dstLangPicked: String?
    let baseURL: String = "https://nlp-translation.p.rapidapi.com/v1/translate"
    
    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var resultTextField: UITextField!
    @IBOutlet var translateButton: UIButton!
    
    @IBAction func onButtonTap(_ sender: Any) {
        guard let from = srcLanguagesDict[srcLangPicked!],
              let to = dstLanguagesDict[dstLangPicked!],
              let text = inputTextField.text else {
            return
        }
        translateEndpoint(from: from, to: to, text: text)
    }
    
    
    func translateEndpoint(from: String, to: String, text: String) {
        var request = URLRequest(url: URL(string: baseURL + "?text=\(text)&to=\(to)&from=\(from)")!)
        request.httpMethod = "GET"
        request.addValue("API_KEY", forHTTPHeaderField: "X-RapidAPI-Key")
        request.addValue("nlp-translation.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               response != nil,
               error == nil,
               let translateResponse = try? JSONDecoder().decode(TranslateResponse.self, from: data) {
                let translatedText = translateResponse.translatedText
                var translated: String?
                switch self.dstLangPicked {
                case "Spanish":
                    translated = translatedText.es
                case "Lamnso":
                    translated = translatedText.nso
                case "isiZulu":
                    translated = translatedText.zu
                case "Malay":
                    translated = translatedText.ms
                case "Indonesian":
                    translated = translatedText.id
                case "Setswana":
                    translated = translatedText.tn
                case "Romanian":
                    translated = translatedText.ro
                case "German":
                    translated = translatedText.de
                case "Portugese":
                    translated = translatedText.pt
                default:
                    translated = ""
                }

                    DispatchQueue.main.async {
                        self.resultTextField.text = translated
                    }

                
            } else {
                print(error)
            }
        }
        .resume()
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == srcLanguage {
            return srcLanguageNames.count
        } else {
            return dstLanguageNames.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == srcLanguage {
            srcLangPicked = srcLanguageNames[row]
            return srcLangPicked
        } else {
            dstLangPicked = dstLanguageNames[row]
            return dstLangPicked
        }
    }
    

    @IBOutlet var srcLanguage: UIPickerView!
    
    @IBOutlet var dstLanguage: UIPickerView!
    
    
    let srcLanguagesDict: [String: String] = [
    "English": "en",
    "Spanish": "es",
    "Lamnso": "nso",
    "isiZulu": "zu",
    "Urdu": "ur",
    "German": "de",
    "Portuguese": "pt"
    ]
    
    let dstLanguagesDict: [String: String] = [
    
    "Spanish": "es",
    "Lamnso": "nso",
    "isiZulu": "zu",
    "Malay": "ms",
    "Indonesian": "id",
    "Setswana": "tn",
    "Romanian": "ro",
    "German": "de",
    "Portuguese": "pt"
    ]
    
    
    var srcLanguageNames: Array<String> = Array<String>()
    var dstLanguageNames: Array<String> = Array<String>()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.srcLanguage.delegate = self
        self.srcLanguage.dataSource = self
        
        self.dstLanguage.delegate = self
        self.dstLanguage.dataSource = self
        
        srcLanguagesDict.keys.sorted(by: {$0.localizedStandardCompare($1) == .orderedAscending})
        dstLanguagesDict.keys.sorted(by: {$0.localizedStandardCompare($1) == .orderedAscending})
        
        
        
        srcLanguageNames = Array<String>(srcLanguagesDict.keys).sorted()
        dstLanguageNames = Array<String>(dstLanguagesDict.keys).sorted()
    }


}
