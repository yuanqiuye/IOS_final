//
//  GameOverView.swift
//  LoveLetter
//
//  Created by qiuye on 2023/6/15.
//

import SwiftUI

struct GameOverView: View {
    @EnvironmentObject var GameModel: GameViewModel
    @Binding var control: Bool
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .fill(.gray)
                .opacity(0.7)
                .frame(width: 350, height: 150)
            
            HStack{
                if GameModel.isWin {
                    Text("你贏了")
                }else{
                    Text("你輸了")
                }
                
                Button("Back"){
                    control = true
                }
                .ButtonStyle()

            }
        }
        
    }
}
