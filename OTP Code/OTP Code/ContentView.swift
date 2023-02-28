//
//  ContentView.swift
//  OTP Code
//
//  Created by Elaidzha Shchukin on 28.02.2023.
//  Done

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
    
    var body: some View{
        
        ZStack{
            
            if unLocked {
                
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
    
    @State var password = ""
    @AppStorage("lock_Password") var key = "2023"
    @Binding var unLocked : Bool
    @State var wrongPassword = false
    let height = UIScreen.main.bounds.width
    
    var body: some View{
        
        VStack {
            HStack {
                
                Spacer(minLength: 0)
                
                Menu(content: {
                    
                    Label(
                        title: { Text("") },
                        icon: { Image(systemName: "info.circle.fill") })
                        .onTapGesture(perform: {
                        
                        })
                    
                    Label(
                        title: { Text("Reset Password") },
                        icon: { Image(systemName: "key.fill") })
                        .onTapGesture(perform: {
                            
                        })
                    
                }) {
                    
                    Image("menubar")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.orange)
                        .padding()
                }
            }
            .padding(.leading)
            
            Image("logo")
                .resizable()
                .cornerRadius(12)
                .frame(width: 95, height: 95)
                .padding(.top, 20)
            
            Text("Enter Pin to Unlock")
                .foregroundColor(.orange)
                .font(.title2)
                .fontWeight(.heavy)
                .padding(.top, 20)
            
            HStack(spacing: 22) {
                
                ForEach(0..<4, id: \.self) {index in
                    
                    PasswordView(index: index, password: $password)
                }
            }
    
            .padding(.top,height < 750 ? 20 : 30)
            
            Spacer(minLength: 0)
            
            Text(wrongPassword ? "Incorrect Pin" : "")
                .foregroundColor(.red)
                .fontWeight(.heavy)
            
            Spacer(minLength: 0)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: height < 750 ? 5 : 15) {
                
                ForEach(1...9, id: \.self) {value in
                    
                    PasswordButton(value: "\(value)",password: $password, key: $key, unlocked: $unLocked, wrongPass: $wrongPassword)
                }
                
                PasswordButton(value: "delete.fill",password: $password, key: $key, unlocked: $unLocked, wrongPass: $wrongPassword)
                
                PasswordButton(value: "0", password: $password, key: $key, unlocked: $unLocked, wrongPass: $wrongPassword)
            }
            .padding(.bottom)

        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct PasswordView : View {
    
    var index : Int
    @Binding var password : String
    
    var body: some View{
        
        ZStack{
            
            Circle()
                .stroke(Color.orange, lineWidth: 2)
                .frame(width: 15, height: 15)
            
            if password.count > index{
                
                Circle()
                    .fill(Color.orange)
                    .frame(width: 15, height: 15)
            }
        }
    }
}

struct PasswordButton : View {
    
    var value : String
    @Binding var password : String
    @Binding var key : String
    @Binding var unlocked : Bool
    @Binding var wrongPass : Bool
    
    var body: some View{
        
        Button(action: setPassword, label: {
            
            VStack{
                
                if value.count > 1 {
                    
                    Image(systemName: "delete.left")
                        .font(.system(size: 24))
                        .foregroundColor(.orange)
                    
                } else {
                    
                    Text(value)
                        .font(.title)
                        .foregroundColor(.orange)
                }
            }
            .padding()
        })
    }
    
    func setPassword() {
        
        withAnimation {
            
            if value.count > 1 {
                
                if password.count != 0 {
                    
                    password.removeLast()
                }
                
            } else {
                
                if password.count != 4{
                    
                    password.append(value)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        
                        withAnimation{
                            
                            if password.count == 4 {
                                
                                if password == key {
                                    
                                    unlocked = true
                                    
                                } else {
                                    
                                    wrongPass = true
                                    password.removeAll()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
