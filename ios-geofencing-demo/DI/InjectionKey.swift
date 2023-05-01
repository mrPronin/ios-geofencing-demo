//
//  InjectionKey.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 01.05.23.
//

import Foundation

public protocol InjectionKey {
    associatedtype Value
    
    // Default valut for the DI key
    static var currentValue: Self.Value { get set }
}
