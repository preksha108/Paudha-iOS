import SwiftUI
import FirebaseAuth
import Firebase

struct LoginView: View {
    @State private var isLogged = false // Add a state variable for navigation
    @State private var email = ""
    @State private var password = ""
    @State private var firstName = ""

    var content: some View {
        NavigationView {
            ZStack {
                Color(red: 244/255, green: 241/255, blue: 222/255)
                    .ignoresSafeArea()
                Image("plantHang")
                    .offset(x: 200, y: -150)

                Image("groundPlant")
                    .resizable()
                    .scaledToFit()
                    .offset(x: -120, y: 250)

                VStack {
                    Spacer()

                    VStack(spacing: 20) {
                        Text("Login")
                            .font(.title)
                            .foregroundColor(.black.opacity(0.7))

                        TextField("Email", text: $email)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(200.0)

                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(200.0)

                        Button(action: {
                            // Add your login authentication logic here
                            // For demonstration purposes, set isLogged to true
                            login()
                           
                        }) {
                            Text("Login")
                                .font(.headline)
                                .foregroundColor(.black)
                                .padding()
                                .frame(width: 220, height: 50)
                                .background(Color(red: 250/255, green: 243/255, blue: 221/255))
                                .cornerRadius(10.0)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10.0)
                                        .stroke(Color( red: 0.2, green: 0.2, blue: 0.2).opacity(0.4), lineWidth: 2)
                                )
                        }



                        HStack(spacing: 0) {
                            Text("Don't have an account? ")
                                .foregroundColor(.blue)
                                .font(.body)

                            NavigationLink(destination: SignupView()) {
                                Text("Sign up")
                                    .underline()  // Add underline to the text
                                    .foregroundColor(.blue)
                                    .font(.body)
                            }
                        }
                    }
                    .padding()
                    .background(Color(red: 202/255,green:255/255,blue:150/255.0).opacity(0.7))
                    .cornerRadius(30.0)
                    .padding()
                    .frame(width: 400, height: 750)
                    .shadow(color: Color.brown.opacity(0.3), radius: 10, x: 0, y: 5)
                }
                Spacer()
            }
            
            .background(NavigationLink(destination: PaudhaTabView(), isActive: $isLogged) {
                EmptyView()
            })
        }.navigationBarBackButtonHidden(true)
    }
    
    var body: some View{
        if isLogged {
            //go to home page
            PaudhaTabView()
        }
        else {
            content
        }
    }
    
    func login(){
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error logging in: \(error.localizedDescription)")
            } else {
                // Successfully logged in
                isLogged = true // Set isLogged to true to trigger navigation
                print("User successfully logged in!")
            }
        }
    }

    
}

struct SignupView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var firstName = ""
  

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 244/255, green: 241/255, blue: 222/255)
                    .ignoresSafeArea()
                Image("plantHang")
                    .offset(x: 200, y: -150)

                Image("groundPlant")
                    .resizable()
                    .scaledToFit()
                    .offset(x: -120, y: 250)

                VStack {
                    Spacer()

                    VStack(spacing: 20) {
                        Text("Signup") // Changed to Signup
                            .font(.title)
                            .foregroundColor(.black.opacity(0.7))
                        TextField("First Name", text: $firstName) // Changed from email to firstName
                            .padding()
                            .background(Color.white)
                            .cornerRadius(200.0) 
                        TextField("Email", text: $email)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(200.0)

                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(200.0)

                        Button(action: {
                            // Add your signup authentication logic here
                            register()
                        }) {
                            Text("Signup") // Changed from "Login" to "Signup"
                                .font(.headline)
                                .foregroundColor(.black)
                                .padding()
                                .frame(width: 220, height: 50)
                                .background(Color(red: 250/255, green: 243/255, blue: 221/255))
                                .cornerRadius(10.0)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10.0)
                                        .stroke(Color( red: 0.2, green: 0.2, blue: 0.2).opacity(0.4), lineWidth: 2)
                                )
                        }
                    }
                    .padding()
                    .background(Color(red: 202/255,green:255/255,blue:150/255.0).opacity(0.7))
                    .cornerRadius(60.0)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .shadow(color: Color.brown.opacity(0.3), radius: 10, x: 0, y: 5)
                }
                Spacer()
            }
        }
    }
    
    func register(){
        Auth.auth().createUser(withEmail: email, password: password){ result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
}
struct LogoButton: View {
    var imageName: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(imageName)
                .resizable()
                .frame(width: 40, height: 40)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

func openURL(_ urlString: String) {
    if let url = URL(string: urlString) {
        UIApplication.shared.open(url)
    }
}

