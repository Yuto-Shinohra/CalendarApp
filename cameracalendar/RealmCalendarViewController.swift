//
//  ViewController.swift
//  Diary
//
//  Created by 髙津悠樹 on 2022/09/10.
//

import UIKit
import FSCalendar
import CalculateCalendarLogic
import RealmSwift

let width = UIScreen.main.bounds.size.width
let height = UIScreen.main.bounds.size.height

class ViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    let dateView = FSCalendar(frame: CGRect(x: 0, y: 30, width: width, height: 400))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //カレンダーの設定
        self.dateView.dataSource = self
        self.dateView.delegate = self
        self.dateView.today = nil
        
        view.addSubview(dateView)
    }
    
    //祝日判定を行なって結果を返すメソッド
    func judgeHoliday(_ date : Date) -> Bool {
        //祝日判定用のカレンダークラスのインスタンス
        let tmpCalendar = Calendar(identifier: .gregorian)
        
        //祝日判定を行う日にちの年・月・日を取得する
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        
        let holiday = CalculateCalendarLogic()
        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
        
    }
    
    //曜日の判定をする
    func getWeekIdx(_ date : Date) -> Int {
        let tmpCalendar = Calendar(identifier: .gregorian)
        return tmpCalendar.component(.weekday, from: date)
    }
    
    //土日祝日の色を変える
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        
        //祝日判定をする
        if self.judgeHoliday(date) {
            return UIColor.red
        }
        
        //土日の判定
        let weekday = self.getWeekIdx(date)
        if weekday == 1{
            return UIColor.red
        }
        else if weekday == 7 {
            return UIColor.blue
        }
        return nil
        
    }
    

}

