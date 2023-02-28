//
//  ContentView.swift
//  OTP Code
//
//  Created by Elaidzha Shchukin on 28.02.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
     
        NavigationView {
            
            OTPCODE()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct OTPCODE : View {
    
    @State var unLocked = false
    
    var body: some View {
        
        
        ZStack{
            
            if unLocked{
                
                Text("App Unlocked")
                    .font(.title2)
                    .fontWeight(.heavy)
                
            } else {
                
                LockScreen(unLocked: $unLocked)
            }
        }
        .preferredColorScheme(unLocked ? .light : .dark)
    }
}

struct LockScreen : View {
    
    var body: some View {
        
        
    }
}
