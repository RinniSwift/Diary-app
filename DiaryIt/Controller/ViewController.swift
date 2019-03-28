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
    
    // MARK: - Variables
    var delegate: CalendarControllerDelegate?
    
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

    @IBAction func viewAlertViewControllerButton(_ sender: UIButton) {
        delegate?.handleSideToggle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set backround color
        view.setGradientBackground(colorOne: .lightPinkMainColor, colorTwo: .lightPurpleMainColor)
        
        // set calendar with numbers that are in the month
        setUpCalendarView()
        
        // set calender to initially be in this month and set it to be initially in the page of this date
        calendarView.scrollToDate(Date(), animateScroll: true)
        
//        set it to the diary page of the day when opened
//        calendarView.selectDates([Date()])
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    
    func handleCellSelection(cell: CustomCell, cellState: CellState) {
        // sets circle around date
        if cell.dateLabel.textColor == UIColor.brightWhite {
            cell.circleAroundDate.isHidden = false
            cell.circleAroundDate.backgroundColor = UIColor.darkWhiteText
        } else {
            cell.circleAroundDate.isHidden = true
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
        
        let startDate = formatter.date(from: "2019 01 01")! // TODO: set to current date from Date() downloaded.
        let parameters = ConfigurationParameters(startDate: startDate, endDate: Date())
        
        return parameters
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
            cell.circleAroundDate.isHidden = true
        }
        
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        
        setUpViewsOfCalendar(visibleDates: visibleDates)
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {

        let diaryMainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "diaryMain") as! DiaryMain
        diaryMainViewController.date = date
        self.navigationController?.pushViewController(diaryMainViewController, animated: true)
        

    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        return
        
    }
    
}

