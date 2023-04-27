//
//  OnBoardImage.swift
//  APetersJourney
//
//  Created by Marcelo De Araújo on 26/04/23.
//

import SwiftUI

struct OnBoardImage: View {

    let image: String
    let title: String
    let text: String

    var body: some View {
        HStack {
            Image(image)
                .frame(width: 75)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(text)
                    .foregroundColor(.white)
            }
            Spacer(minLength: 5)
        }
    }
}
