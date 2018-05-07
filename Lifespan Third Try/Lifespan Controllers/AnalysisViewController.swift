//
//  AnalysisViewController.swift
//  Lifespan Third Try
//
//  Created by jpavley12 on 3/25/18.
//  Copyright © 2018 jpavley12. All rights reserved.
//

import UIKit

class AnalysisViewController: UIViewController {
    
    @IBOutlet weak var analysisText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func updateView() {
        
        let tb = self.tabBarController as! TabViewController
        tb.updateLifeClock()
        
        guard let lifeSpan = tb.lifeSpan else {
            return
        }
        
        analysisText.attributedText = generateAnalysis(lifeSpan: lifeSpan)

    }
        
    // MARK: - Navigation
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        analysisText.setContentOffset(CGPoint.zero, animated: true)
    }
    
    fileprivate func levelToText(level: CGFloat,
                                 words: [String] = ["low", "moderate", "high", "unknown"]) -> String {
        
        enum Levels: Int {
            // map the index of the words to their place in the array
            case low = 0, moderate = 1, high = 2, unknown = 3
        }
        
        // round that float to a neo-Int	
        let level = level.rounded(.down)
        
        switch UInt(level) {
        case 0...4:
            return words[Levels.low.rawValue]
        case 5:
            return words[Levels.moderate.rawValue]
        case 6...:
            return words[Levels.high.rawValue]
        default:
            return words[Levels.unknown.rawValue]
        }
    }
    
    struct ParagraphOneData {
        let name: String
        let age: Int
        let birthYear: Int
        let modifiedLifeExpectancy: Int
        let lifeExpectancy: Int
        let possesser: String
        let object: String
        let subject: String
        let missingYears: Int
        let modifiedYearsLeft: Int
        let modifiedDeathYear: Int
        let stressLevel: String
        let activityLevel: String
        let riskLevel: String
        let geneticsLevel: String
    }
    
    fileprivate func generateParagraphOneSentanceOne(with d: ParagraphOneData) -> NSMutableAttributedString {
        
        let resultString = NSMutableAttributedString(string: "", attributes: [:])
        
        let stringsS1 = [
            "\(d.name)",       // 0
            " was born ",      // 1
            " \(d.age)",       // 2
            " years ago in ",  // 3
            "\(d.birthYear)",  // 4
            ". ",              // 5
            "\(d.possesser.capitalized)",        // 6
            " life expectancy of ",              // 7
            "\(d.lifeExpectancy)",               // 8
            " years is influenced by a ",        // 9
            "\(d.activityLevel)",                // 10
            " level of physical activity, a ",   // 11
            "\(d.stressLevel)",                  // 12
            " level of mental stress, a ",       // 13
            "\(d.riskLevel) ",                   // 14
            "level of risky behavior, and an ",  // 15
            "\(d.geneticsLevel)",      // 16
            " genetic history.",       // 17
            "\n\n"                     // 18
        ]
        
        let boldIndexesS1 = [0, 2, 4, 8, 10, 12, 14, 16]
        
        let tf = TextFormatter()
        let attributedS1 = tf.createStringWithBoldParts(with: stringsS1, boldedIndexes: boldIndexesS1)
        resultString.append(attributedS1)
        return resultString
    }
    
    fileprivate func generateParagraphOne(with d: ParagraphOneData) -> NSMutableAttributedString {
        
        let resultString = NSMutableAttributedString(string: "", attributes: [:])

        
//        let s1 = "\(d.name) was born \(d.age) years ago in \(d.birthYear). \(d.possesser.capitalized) life expectancy of \(d.lifeExpectancy) years is influenced by a \(d.activityLevel) level of physical activity, a \(d.stressLevel) level of mental stress, a \(d.riskLevel) level of risky behavior, and an \(d.geneticsLevel) genetic history."
        
        let s1 = generateParagraphOneSentanceOne(with: d)
        
        var s2 = ""
        var s3 = ""

        
        if d.modifiedLifeExpectancy < d.lifeExpectancy {
            
            // negative
            
            s2 = "\(d.possesser.capitalized) life expectancy is therefore reduced to \(d.modifiedLifeExpectancy) years, robbing \(d.object) of \(d.missingYears) years."
            
            s3 = "If \(d.subject) doesn’t improve \(d.possesser) life style \(d.subject) could die in \(d.modifiedYearsLeft) years from today, in the year \(d.modifiedDeathYear)."
            
        } else if d.modifiedLifeExpectancy == d.lifeExpectancy {
            
            // neutral
            
            s2 = "\(d.possesser.capitalized) life expectancy is therefore unchanged with no missing or extra years."
            
            s3 = "If \(d.subject) is able to maintain \(d.possesser) current life style \(d.subject) could die in \(d.modifiedYearsLeft) years from today, in the year \(d.modifiedDeathYear)."
            
        } else if d.modifiedLifeExpectancy > d.lifeExpectancy {
            
            // positive
            
            s2 = "\(d.possesser.capitalized) life expectancy is therefore increased to \(d.modifiedLifeExpectancy) years, gifting \(d.object) another \(d.missingYears) years."
            
            s3 = "If \(d.subject) is able to maintain \(d.possesser) current life style \(d.subject) could live for another \(d.modifiedYearsLeft) years from today, and delay \(d.possesser) death until the year \(d.modifiedDeathYear)."
        }
        
        resultString.append(s1)
        return resultString

//        return "\(s1) \(s2) \(s3)"
        
    }
    
    fileprivate func generateParagraphZero(with d: ParagraphOneData) -> NSMutableAttributedString {
        
        let resultString = NSMutableAttributedString(string: "", attributes: [:])
        
        let tb = self.tabBarController as! TabViewController
        guard let lifeSpan = tb.lifeSpan else {
            return resultString
        }
        
        let cal = CalendarUtilities.utcCal()
        let now = Date()
        let thisWeekDay = cal.weekdaySymbols[cal.component(.weekday, from: now)-1]
        let thisDay = cal.component(.day, from: now)
        let thisMonth = cal.monthSymbols[cal.component(.month, from: now)-1]
        let thisYear = cal.component(.year, from: now)

        //        let p0 = "Today is \(thisWeekDay), \(thisMonth) \(thisDay), \(thisYear). \(name) has spent \(lifeSpan.clockDescriptionSpent) in \(possesser) life to date. At this point in time \(subject) could live for another \(lifeSpan.clockDescriptionRemaining)."
        
        let stringsParagraph0Part1 = [
            "Today is ",       // 0
            "\(thisWeekDay)",  // 1
            ", ",              // 2
            "\(thisMonth)",    // 3
            " ",               // 4
            "\(thisDay)",      // 5
            ", ",              // 6
            "\(thisYear)",     // 7
            ". ",              // 8
            "\n\n",           // 9
            "\(d.name)",         // 10
            " has spent "      // 11
        ]
        
        let boldIndexesParagraph0Part1 = [1, 3, 5, 7, 10]
        
        let tf = TextFormatter()
        let attributedParagraph0Part1 = tf.createStringWithBoldParts(with: stringsParagraph0Part1, boldedIndexes: boldIndexesParagraph0Part1)
        resultString.append(attributedParagraph0Part1)
        
        //    "\(lifeSpan.clockDescriptionSpent)",     // 12
        
        let clockDescriptionSpentList = lifeSpan.clockDescriptionSpent.components(separatedBy: " ")
        let clockDescriptionSpentListWithSpaces = clockDescriptionSpentList.map({ $0 + " "})
        let boldIndexesSpentList = [0, 2, 4]
        
        let attributedParagraphSpent = tf.createStringWithBoldParts(with: clockDescriptionSpentListWithSpaces, boldedIndexes: boldIndexesSpentList)
        resultString.append(attributedParagraphSpent)
        
        let stringsParagraph0Part2 = [
            " in ",            // 0
            "\(d.possesser)",    // 1
            " life to date. At this point in time ", // 2
            "\(d.subject)",      // 3
            " could live for another "               // 4
        ]
        
        let boldIndexesParagraph0Part2 = [Int]()
        
        let attributedParagraph0Part2 = tf.createStringWithBoldParts(with: stringsParagraph0Part2, boldedIndexes: boldIndexesParagraph0Part2)
        resultString.append(attributedParagraph0Part2)
        
        //    "\(lifeSpan.clockDescriptionRemaining)", // 18
        
        let clockDescriptionRemainingList = lifeSpan.clockDescriptionRemaining.components(separatedBy: " ")
        let clockDescriptionRemainingListWithSpaces = clockDescriptionRemainingList.map({ $0 + " "})

        let boldInedxesRemainingList = [0, 2, 4]
        
        let attributedParagraphRemaining = tf.createStringWithBoldParts(with: clockDescriptionRemainingListWithSpaces, boldedIndexes: boldInedxesRemainingList)
        resultString.append(attributedParagraphRemaining)
        
        let stringsParagraph0Part3 = [
            "." ,               // 0
            "\n\n"              // 1
        ]
        
        let boldIndexesParagraph0Part3 = [Int]()
        
        let attributedParagraph0Part3 = tf.createStringWithBoldParts(with: stringsParagraph0Part3, boldedIndexes: boldIndexesParagraph0Part3)
        resultString.append(attributedParagraph0Part3)
        
        return resultString
    }
    
    func generateAnalysis(lifeSpan: Lifespan) -> NSMutableAttributedString {
        
        let resultString = NSMutableAttributedString(string: "", attributes: [:])

        let tb = self.tabBarController as! TabViewController
        guard let userProfile = tb.userProfile, let lifeSpan = tb.lifeSpan else {
            return resultString
        }
        
        let name = userProfile.name
        let subject = userProfile.pronouns.subjective
        let object = userProfile.pronouns.objective
        let possesser = userProfile.pronouns.possessive
        
        
        let us = userProfile.calcUserStats(from: lifeSpan)
        let cal = CalendarUtilities.utcCal()
        let now = Date()
        let thisYear = cal.component(.year, from: now)
        let modifiedYearsLeft = us.modifiedDeathYear - thisYear
        let stressLevel = levelToText(level: userProfile.stress)
        let activityLevel = levelToText(level: userProfile.activity)
        let riskLevel = levelToText(level: userProfile.risk)
        let geneticsLevel = levelToText(level: userProfile.genetics, words: ["unfortunate", "average", "excellent", "unknown"])
        
        let paragraphData = ParagraphOneData(name: name,
                                             age: us.age,
                                             birthYear: us.birthYear,
                                             modifiedLifeExpectancy: us.modifiedLifeExpectancy,
                                             lifeExpectancy: us.lifeExpectancy,
                                             possesser: possesser,
                                             object: object,
                                             subject: subject,
                                             missingYears: us.missingYears,
                                             modifiedYearsLeft: modifiedYearsLeft,
                                             modifiedDeathYear: us.modifiedDeathYear,
                                             stressLevel: stressLevel,
                                             activityLevel: activityLevel,
                                             riskLevel: riskLevel,
                                             geneticsLevel: geneticsLevel)
        
        resultString.append(generateParagraphZero(with: paragraphData))
        
        let attributedParagraph1 = generateParagraphOne(with: paragraphData)
        
        resultString.append(attributedParagraph1)

        // Universal
//        let p2 = "If \(name) lives beyond \(us.modifiedDeathYear) and the age of \(us.modifiedLifeExpectancy), \(subject) will be living on borrowed time."
        
        let stringsParagraph2 = [
            "If ",              // 0
            "\(name)",          // 1
            " lives beyond ",   // 2
            "\(us.modifiedDeathYear)",          // 3
            " and the age of ", // 4
            "\(us.modifiedLifeExpectancy)",     // 5
            ", ",               // 6
            "\(subject)",       // 7
            " will be living on borrowed time." // 8
        ]
        
        let boldInexesParagraph2 = [1, 3, 5]
        
        let tf = TextFormatter()
        let attributedParagraph2 = tf.createStringWithBoldParts(with: stringsParagraph2, boldedIndexes: boldInexesParagraph2)
        
        resultString.append(attributedParagraph2)
        
        // return "\(p0)\(cr)\(p1)\(cr)\(p2)"
        return resultString
    }
    
}

