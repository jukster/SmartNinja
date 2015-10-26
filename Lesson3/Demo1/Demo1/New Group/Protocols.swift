//
//  Protocols.swift
//  Demo1
//
//  Created by Marko Jukic on 22/10/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import Foundation

struct Kvader: Geometrija {
	var x: Double
	var y: Double
	var širina : Double
	var višina : Double
	
	func ploščina() -> Double {
		return širina * višina
	}
	
	mutating func povečaj(faktor: Double) {
		širina = širina * faktor
		višina = višina * faktor
	}
}

protocol Geometrija {
	func ploščina () -> Double

	mutating func povečaj(faktor: Double)
}

func printKvader() {
	let kvader1 = Kvader(x: 1.0, y: 2.0, širina: 5.0, višina: 4.0)
	
	let kvader2 = Kvader(x: 3.0, y: 5.0, širina: 50.0, višina: 40.0)
	
	print("Ploščina 1: \(kvader1.ploščina())")
	print("Ploščina 2: \(kvader2.ploščina())")
}