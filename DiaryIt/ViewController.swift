//
//  ViewController.swift
//  DiaryIt
//
//  Created by Rinni Swift on 10/16/18.
//  Copyright © 2018 Rinni Swift. All rights reserved.
//

import UIKit
import JTAppleCalendar

class ViewController: UIViewController {
    
    let formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Calendar.current.locale
        dateFormatter.dateFormat = "yyyy MM dd"
        return dateFormatter
    }()
    
    let outsideMonthColor = UIColor.darkWhiteText
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var month: UILabel!
    
    @IBAction func unwindToCalendar(_ sender: UIStoryboardSegue) {
        // for the unwind segue in DiaryMain storyboard
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set backround color
        view.setGradientBackground(colorOne: .lightPinkMainColor, colorTwo: .lightPurpleMainColor)
        
        // set calendar with numbers that are in the month
        setUpCalendarView()
        
        // set calender to initially be in this month and set it to be initially in the page of this date
        calendarView.scrollToDate(Date(), animateScroll: false)
        
//        set it to the diary page of the day when opened
//        calendarView.selectDates([Date()])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func setUpCalendarView() {
        
        // makes the whole cell the outer most part of the cell
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        
        // set up calendar labels to the correct month and year
        calendarView.visibleDates { (visibleDates) in
            self.setUpViewsOfCalendar(visibleDates: visibleDates)
            
        }
    }
    
    func setUpViewsOfCalendar(visibleDates: DateSegmentInfo) {
        guard let date = visibleDates.monthDates.first?.date else { return }
        
        formatter.dateFormat = "   yyyy"
        year.text = formatter.string(from: date)
        
        formatter.dateFormat = " MMMM"
        month.text = formatter.string(from: date)
    }
    
    func handleCellTextColor(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CustomCell else { return }
        if cellState.dateBelongsTo == .thisMonth {
            validCell.dateLabel.textColor = UIColor.brightWhite
        } else {
            validCell.dateLabel.textColor = UIColor.darkWhiteText
        }
    }
    
    // *** make circle show under date
    func handleCellSelection(cell: CustomCell, cellState: CellState) {
        
        if cell.dateLabel.textColor == UIColor.brightWhite {
            cell.circleUnderDate.isHidden = false
            cell.circleUnderDate.backgroundColor = UIColor.white
        } else {
            cell.circleUnderDate.isHidden = true
        }
    }
    
}

extension ViewController: JTAppleCalendarViewDataSource {
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        return
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        formatter.dateFormat =  "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2018 01 01")!
        let parameters = ConfigurationParameters(startDate: startDate, endDate: Date())
        
        return parameters
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // pass information to the DiaryMain storyboard
        switch segue.identifier {
        case "toDiaryMain":
            let date = sender as? Date
            let destination = segue.destination as! DiaryMain
            destination.date = date
        default: break
        }
    }
}

extension ViewController: JTAppleCalendarViewDelegate {
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "customCell", for: indexPath) as! CustomCell
        
        // sets date label to the correct number
        cell.dateLabel.text = cellState.text
        
        handleCellTextColor(view: cell, cellState: cellState)
        
        
        // * tracks the current date by tracking with a circle around it.
        let todaysDate = Date()
        
        formatter.dateFormat = "yyyy MM dd"
        
        let todaysDateString = formatter.string(from: todaysDate)
        let monthDateString = formatter.string(from: cellState.date)
        
        
        
        if monthDateString == todaysDateString {
            handleCellSelection(cell: cell, cellState: cellState)
        } else {
            cell.circleUnderDate.isHidden = true
        }
        // * end: tracks the current date by tracking with a circle around it
        
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        
        setUpViewsOfCalendar(visibleDates: visibleDates)
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        // perform segue once tapped on cell
        performSegue(withIdentifier: "toDiaryMain", sender: date)

    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        return
        
    }
    
}

