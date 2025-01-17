//
//  Router.swift
//  AnxietyNotesApp
//
//  Created by Anggara Satya Wimala Nelwan on 12/07/24.
//

import Foundation
import SwiftUI

final class Router: ObservableObject {
    
    public enum Destination: Codable, Hashable {
        case homeView
        case noteView(noteID: UUID?)
        case saveNoteView(feeling: String?)
    }
    
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
