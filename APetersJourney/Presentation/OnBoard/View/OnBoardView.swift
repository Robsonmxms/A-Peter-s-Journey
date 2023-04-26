//
//  OnBoardView.swift
//  APetersJourney
//
//  Created by Marcelo De Araújo on 26/04/23.
//

import SwiftUI

struct OnboardingView: View {
    @State var destination: Bool = false

    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    VStack {
                        Text("Bem vindo ao A Peter's Journey!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.vertical, 5)
                        Text("Capture a boneca com o menino, mas cuidado para mamãe não te pegar 😅")
                            .font(.title2)
                            .padding(.horizontal, 5)
                    }
                    .padding(.vertical, 5)

                    OnBoardImage(
                        image: "boy",
                        title: "Peter",
                        text: "Um menino que gosta de brincar com bonecas"
                    )
                    OnBoardImage(
                        image: "doll",
                        title: "Doll",
                        text: "O brinquedo preferido de Peter"
                    )
                    OnBoardImage(
                        image: "mom",
                        title: "Mom",
                        text: "Ela não quer ver Peter brincando com boneca"
                    )

                }
                .padding(.horizontal, 5)

                Button(action: {
                    destination.toggle()
                }) {
                    Text("Continue")
                        .frame(
                            minWidth: 100,
                            idealWidth: 1200,
                            maxWidth: .infinity,
                            minHeight: 50,
                            idealHeight: 50,
                            maxHeight: 50,
                            alignment: .center
                        )
                        .font(.system(size: 40, weight: .regular))
                }
                .buttonStyle(.borderedProminent)
                .contentShape(Rectangle())
                .navigationDestination(isPresented: $destination) {
                    MenuView()
                        .navigationBarBackButtonHidden()
                }
                .padding()
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
