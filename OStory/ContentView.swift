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
    @State private var showFilterPage = false
    @State private var showProfilePage = false
    @State private var profileImage: UIImage? = nil
    @State private var profileName: String = ""

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

            backButton
        }
        .navigationBarTitle("OStory")
        .navigationBarItems(leading: profileButton, trailing: logoutButton)
        .navigationBarBackButtonHidden(true)
        .background(
            NavigationLink(destination: FilterPage(), isActive: $showFilterPage) {
                EmptyView()
            }
        )
        .sheet(isPresented: $showProfilePage) {
            ProfilePage(profileImage: $profileImage, profileName: $profileName)
        }
    }

    var logoutButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Logout")
        }
    }

    var profileButton: some View {
        Button(action: {
            showProfilePage = true
        }) {
            Image(systemName: "person.crop.circle")
        }
    }

    var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("")
        }
        .padding(.top, 10)
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

struct ProfilePage: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var profileImage: UIImage?
    @Binding var profileName: String

    var body: some View {
        VStack {
            Button(action: {
                // Handle profile image selection
            }) {
                Circle()
                    .frame(width: 150, height: 150)
                    .overlay(Text("Select Profile Photo").foregroundColor(.white))
                    .foregroundColor(Color(UIColor(red: 0.96, green: 0.90, blue: 0.55, alpha: 1.00)))
            }

            TextField("Enter your name", text: $profileName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                // Handle save button action
                saveProfile()
            }) {
                Text("Save")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
    func saveProfile() {
           // Perform profile saving logic

           // Dismiss the profile page
           presentationMode.wrappedValue.dismiss()
       }
   }


struct ButtonPage: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var options: [String] = []
    var button: String
    @State private var showFilterPage = false

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
        .background(
            NavigationLink(destination: FilterPage(), isActive: $showFilterPage) {
                EmptyView()
            }
        )
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
            // Display the share sheet
            let shareText = "Sharing from OStory"
            let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
        }) {
            Image(systemName: "square.and.arrow.up")
        }
    }

    var filterButton: some View {
        Button(action: {
            showFilterPage = true
        }) {
            Image(systemName: "square.grid.2x2.fill")
        }
    }

    func generateOptions() {
        guard options.isEmpty else {
            return  // Options already generated, so exit the function
        }
        
        options.append(contentsOf: ["message_icon", "voice_note_icon", "choose_photo_icon"])
    }

}

struct FilterPage: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedFilters: [String] = []
    @State private var circles: [CGPoint] = []
    let maxCircles = 25

    var body: some View {
        VStack {
                 VStack {
                     
                     Button(action: {}) {
                                         Text("Filter")
                           
                         
                                             .font(.title)
                                             .padding()
                                             .frame(width: 100, height: 100)
                                             .background(Color(UIColor(red: 0.96, green: 0.90, blue: 0.55, alpha: 1.00))) // Off-white gold color
                                             .cornerRadius(75)
                                             .foregroundColor(.white)
                                             .padding(.top, 20)
                     }
                     Spacer()
                     
                     ForEach(selectedFilters, id: \.self) { filter in
                         Text(filter)
                     }
                 }
                
                Spacer()
                
                VStack {
                    ForEach(circles.indices, id: \.self) { index in
                        Circle()
                            .foregroundColor(.yellow)
                            .foregroundColor(.blue)
                            .frame(width: 100, height: 100)
                            .position(circles[index])
                            .gesture(DragGesture().onChanged { value in
                                // Update circle position based on drag gesture
                                self.circles[index] = value.location
                            })
                    }
                    
                    Button(action: {
                        addCircle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .padding()
                            .background(Color(UIColor(red: 0.96, green: 0.90, blue: 0.55, alpha: 1.00))) // Off-white gold color
                            .foregroundColor(.white)
                            .cornerRadius(75)
                            .frame(width: 100, height: 100)
                    }
                    .padding()
                }
            }
            .padding()
            .navigationBarItems(trailing: HStack {
                      playButton
                      resetButton
                  })
        }
    var playButton: some View {
         Button(action: {
             // Perform play action
         }) {
             Image(systemName: "play.circle.fill")
         }
     }
        
        var resetButton: some View {
            Button(action: {
                selectedFilters.removeAll()
                circles.removeAll()
            }) {
                Text("Reset")
            }
        }
        
        func addCircle() {
            if circles.count < maxCircles {
              
                circles.append(CGPoint(x: 50, y: 50))  // Set initial position of the circle
               
            }
        }
    }







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
