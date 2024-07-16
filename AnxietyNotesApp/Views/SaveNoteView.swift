//
//  SaveNoteView.swift
//  AnxietyNotesApp
//
//  Created by Ages on 15/07/24.
//

import SwiftUI

struct SaveNoteView: View {
    @State private var navigateToHome = false
    
    var body: some View {
        ZStack{
            Image("SaveNoteImage")
                .resizable()
                .scaledToFit()

            VStack {
                Spacer()
                
                Button(action: {
                    navigateToHome = true
                }, label: {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color(red: 0.05, green: 0.05, blue: 0.05).opacity(0.44))
                        .fill(.ultraThinMaterial)
                        .stroke(Color(red: 0.78, green: 0.78, blue: 0.78), lineWidth: 1)
                        
                        .overlay{
                            Text("Save Note")
                                .font(.system(size: 16))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)

                                
                        }
                        
                })
                .buttonStyle(PlainButtonStyle())
                .frame(width: 300, height: 56, alignment: .center)
            }.padding(.bottom, 80)
            
            NavigationLink(
                destination: HomeView(),
                isActive: $navigateToHome,
                label: {
                    EmptyView()
                })
                
        }.ignoresSafeArea(.all)
    }
}

#Preview {
    SaveNoteView()
}