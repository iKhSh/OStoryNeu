import SwiftUI

struct ContentView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var showSecondPage = false
    @State private var buttons: [[String]] = []
    
    var body: some View {
        NavigationView {
            VStack {
                Image("OStory")
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Username")
                        .font(.headline)
                    
                    TextField("", text: $username)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 1, x: 0, y: 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.bottom, 10)
                    
                    Text("Password")
                        .font(.headline)
                    
                    SecureField("", text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 1, x: 0, y: 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                .padding(.horizontal)
                
                NavigationLink(destination: SecondPage(buttons: $buttons)) {
                    Text("Anmelden")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 150, height: 150)
                        .background(Color.yellow)
                        .cornerRadius(75)
                }
                .padding()
                
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}

struct SecondPage: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var buttons: [[String]]
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(buttons.indices, id: \.self) { rowIndex in
                        HStack(spacing: 10) {
                            ForEach(buttons[rowIndex].indices, id: \.self) { columnIndex in
                                NavigationLink(destination: ButtonPage(button: buttons[rowIndex][columnIndex])) {
                                    Text(buttons[rowIndex][columnIndex])
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(width: 110, height: 110)
                                        .background(Color.yellow)
                                        .cornerRadius(75)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            
            Spacer()
            
            Button(action: {
                generateButton()
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.yellow)
                    .padding()
            }
            .frame(maxWidth: .infinity)
        }
        .navigationBarTitle("OStory")
        .navigationBarItems(trailing: logoutButton)
        .navigationBarBackButtonHidden(true)
    }
    
    var logoutButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Logout")
        }
    }
    
    func generateButton() {
        if buttons.last?.count == 2 {
            if buttons.count >= 10 {
                return
            }
            buttons.append(["Button"])
        } else {
            if buttons.isEmpty {
                buttons.append(["Button"])
            } else {
                buttons[buttons.count - 1].append("Button")
            }
        }
    }
}

struct ButtonPage: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var buttons: [[String]] = []
    var button: String
    
    var body: some View {
        VStack {
            Text(button)
                .font(.headline)
            
            Spacer()
            
            Button(action: {
                generateButton()
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.yellow)
                    .padding()
            }
            .frame(maxWidth: .infinity)
        }
        .navigationBarTitle(button)
        .navigationBarItems(trailing: closeButton)
    }
    
    var closeButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Close")
        }
    }
    
    func generateButton() {
        if buttons.last?.count == 2 {
            if buttons.count >= 10 {
                return
            }
            buttons.append(["Button"])
        } else {
            if buttons.isEmpty {
                buttons.append(["Button"])
            } else {
                buttons[buttons.count - 1].append("Button")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
