//
//  TH2OTimerPickerView.swift
//  TimerH2O
//
//  Created by Alessio Roberto on 31/10/16.
//  Copyright © 2016 Alessio Roberto. All rights reserved.
//

import UIKit

class TH2OTimerPickerView: UIView {
    @IBOutlet weak var pickerTitleLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    typealias DoneListener = (Date) -> ()
    var doneListener: DoneListener?
    private var selectedDate: Date?
    private var parentView: UIView?
    
    @IBAction func doneButtonPressed(_ sender: AnyObject) {
        guard let selectedDate = selectedDate else {
            return
        }
        
        doneListener?(selectedDate)
    }
    
    @IBAction func valueChanged(_ sender: AnyObject) {
        selectedDate = datePicker.date
    }
    
    func loadDatePickerView() -> TH2OTimerPickerView? {
        guard let view = R.nib.tH2OTimePickerView.firstView(owner: self) else {
            return nil
        }
        view.frame.origin.y = UIScreen.main.bounds.height
        view.frame.size.width = UIScreen.main.bounds.width
        return view
    }
    
    
    func configure(onView:UIView, withCallback: @escaping DoneListener) {
        doneListener = withCallback
        parentView = onView
        self.frame.origin.y = onView.frame.size.height
        datePicker.maximumDate = Date()
        
        UIApplication.shared.keyWindow?.addSubview(self)
    }
    
    func isTo(show: Bool) {
        UIView.animate(withDuration:0.3,
                       animations: {
                        if show {
                            self.frame.origin.y = self.parentView!.center.y
                        } else {
                            self.frame.origin.y = self.parentView!.frame.size.height
                        }
            },completion: nil)
    }
}
