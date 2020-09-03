//
//  MenuProtocolDelegate.swift
//  ivanov.igor.gb.architecture.millonare
//
//  Created by Igor Ivanov on 03.09.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation

protocol MenuProtocolDelegate: AnyObject {
    func didViewAppear()
    func didPressGameStart()
    func didPressResults()
}
