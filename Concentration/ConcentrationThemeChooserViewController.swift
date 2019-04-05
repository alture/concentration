//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Redemax on 3/12/19.
//  Copyright © 2019 Alisher Altore. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {
    
    private typealias Theme = (emojies: [String], bgColor: UIColor, cardFrontColor: UIColor, cardBackColor: UIColor)
    
    private let themes: [String:Theme] = [
        "Halloween":(emojies: ["👻", "🎃", "🧟‍♀️", "👺", "🍭", "🍬", "🦇"], bgColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cardFrontColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), cardBackColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
        "Building":(emojies: ["🚜", "🚧", "🏗", "🔧", "👷🏻‍♂️", "🔩", "👷🏻‍♀️"], bgColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cardFrontColor: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), cardBackColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
        "Winter":(emojies: ["🥶", "🎅🏻", "🧣", "❄️", "☃️", "🌨", "🌬"], bgColor: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), cardFrontColor: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), cardBackColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
        ]
    
    
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitDetailConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
        } else if let cvc = lastSequedToConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        } else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
        
    }
    
    override func awakeFromNib() {
         splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
    private var splitDetailConcentrationViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    private var lastSequedToConcentrationViewController: ConcentrationViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName]{
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                    lastSequedToConcentrationViewController = cvc
                }
            }
        }
    }
}
