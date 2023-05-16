//
//  MatchesView.swift
//  FearlessDateAI
//
//  Created by Шарап Бамматов on 14.05.2023.
//

import SwiftUI

struct MatchesView: View {
    var users: [User] = User.fetchMocks
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        VStack {
            header
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(users) { user in
                        MatchesCardView(user: user)
                    }
                }
                .padding()
            }
            
        }
    }
}

struct MatchesView_Previews: PreviewProvider {
    static var previews: some View {
        MatchesView()
    }
}

extension MatchesView {
    private var header: some View {
        VStack(alignment: .leading, spacing: 9) {
            Text("Matches")
                .font(.system(size: 40))
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("This is a list of people who have liked you and your matches")
                .font(.system(size: 16))
                .fontWeight(.regular)
            
            HStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 0.5)
                
                Text("today")
                    .font(.subheadline)
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 0.5)
            }
            .foregroundColor(.redColor)
        }
        .padding(.horizontal)
    }
}
