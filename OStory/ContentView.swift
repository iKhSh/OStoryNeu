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
                    HStack {
                        Image(systemName: "person")
                            .foregroundColor(.gray)
                        Text("Username")
                            .font(.headline)
                    }

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

                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.gray)
                        Text("Password")
                            .font(.headline)
                    }

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
                        .frame(width: 120, height: 120)
                        .background(Color(UIColor(red: 0.96, green: 0.90, blue: 0.55, alpha: 1.00))) // Off-white gold color
                        .cornerRadius(75)
                }
                .padding()
                Text("Don't have an account?")
                    .foregroundColor(.gray)
                Button("Signup") {

                }

                Spacer()

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
                                        .frame(width: 140, height: 140)
                                        .background(Color(UIColor(red: 0.96, green: 0.90, blue: 0.55, alpha: 1.00))) // Off-white gold color
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
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color(UIColor(red: 0.96, green: 0.90, blue: 0.55, alpha: 1.00))) // Off-white gold color
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
            buttons.append(["Circel"])
        } else {
            if buttons.isEmpty {
                buttons.append(["Circel"])
            } else {
                buttons[buttons.count - 1].append("Circel")
            }
        }
    }
}

struct ButtonPage: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var options: [String] = []
    var button: String

    var body: some View {
        VStack {
            Text(button)
                .font(.headline)

            Spacer()

            ForEach(options, id: \.self) { option in
                Button(action: {
                    // Handle option selection
                }) {
                    Image(option)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .padding()
                        .background(Color(UIColor(red: 0.96, green: 0.90, blue: 0.55, alpha: 1.00))) // Off-white gold color
                        .cornerRadius(75)
                }
            }

            Button(action: {
                generateOptions()
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color(UIColor(red: 0.96, green: 0.90, blue: 0.55, alpha: 1.00))) // Off-white gold color
                    .padding()
            }
            .frame(maxWidth: .infinity)

            backButton
        }
        .padding()
        .navigationBarTitle("OStory")
        .navigationBarItems(trailing: HStack {
            shareButton
            filterButton
        })
    }

    var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("")
        }
        .padding(.top, 10)
    }

    var shareButton: some View {
        Button(action: {
            // Handle share action
        }) {
            Image(systemName: "square.and.arrow.up")
        }
    }

    var filterButton: some View {
        Button(action: {
            // Handle filter action
        }) {
            Image(systemName: "slider.horizontal.3")
        }
    }

    func generateOptions() {
        options.append(contentsOf: ["message_icon", "voice_note_icon", "choose_photo_icon"])
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
