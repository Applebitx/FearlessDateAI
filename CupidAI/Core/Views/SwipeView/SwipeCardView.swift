//
//  SwipeCardView.swift
//  CupidAI
//
//  Created by Шарап Бамматов on 14.05.2023.
//

import SwiftUI

struct SwipeCardView: View {
    @EnvironmentObject var vm: SwipeViewModel
    var user: User
    
    //MARK: Gesture properties
    @State var offset: CGFloat = 0
    @GestureState var isDragging: Bool = false
    @State var endSwipe: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let index = CGFloat(vm.getIndex(user: user))
            let topOffset = (index <= 2 ? index : 2) * 15
            
            ZStack {
                Image(user.profilePicture ?? "girl1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width - topOffset, height: size.height)
                    .cornerRadius(15)
                    .offset(y: -topOffset)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .offset(x: offset)
        .rotationEffect(.init(degrees: getRotation(angle: 8)))
        .contentShape(Rectangle().trim(from: 0, to: endSwipe ? 0 : 1))
        .gesture(
            DragGesture()
                .updating($isDragging, body: { value, out, _ in
                    out = true
                })
                .onChanged({ value in
                    let translation = value.translation.width
                    offset = (isDragging ? translation : .zero)
                })
                .onEnded({ value in
                    let width = getRect().width - 50
                    let translation = value.translation.width
                    
                    let checkingStatus = (translation > 0 ? translation : -translation)
                    
                    withAnimation {
                        if checkingStatus > (width / 2) {
                            offset = (translation > 0 ? width : -width) * 2
                            
                            endSwipeAction()
                            
                            if translation > 0 {
                                vm.rightSwipe()
                            } else {
                                vm.leftSwipe()
                            }
                        } else {
                            offset = .zero
                        }
                    }
                })
        )
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("ACTIONFROMBUTTON"), object: nil)) { data in
            guard let info = data.userInfo else {
                return
            }
            
            let id = info["id"] as? String ?? ""
            let rightSwipe = info["rightSwipe"] as? Bool ?? false
            let width = getRect().width - 50
            
            if user.id == id {
                offset = (rightSwipe ? width : -width) * 2
                
                endSwipeAction()
                
                if rightSwipe {
                    vm.rightSwipe()
                } else {
                    vm.leftSwipe()
                }
            }
        }
    }
}

struct SwipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(Store())
    }
}

//MARK: PRIVATE FUNC
extension SwipeCardView {
    private func endSwipeAction() {
        withAnimation(.none) {endSwipe = true}
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let _ = vm.displayingUsers?.first {
                let _ = withAnimation {
                    vm.displayingUsers?.removeFirst()
                }
            }
        }
    }
    
    private func getRotation(angle: Double) -> Double {
        return (offset / (getRect().width - 50)) * angle
    }
}
