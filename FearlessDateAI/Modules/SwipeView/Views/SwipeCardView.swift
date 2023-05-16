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
            let topOffset = (index <= 3 ? index : 3) * 15
            
            ZStack {
                likeAndDisLikeView
                
                Image(user.profilePicture ?? "girl1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width - topOffset, height: size.height)
                    .cornerRadius(15)
                    .offset(y: -topOffset)
                    .overlay(alignment: .bottom) {
                            VStack(alignment: .leading, spacing: 6) {
                                Group {
                                    HStack {
                                        Text("\(user.firstName ?? "") ," )
                                            .font(.title)
                                            .foregroundColor(.white)
                                            .bold()
                                        
                                        Text(user.birthday ?? "")
                                            .font(.title)
                                            .foregroundColor(.white)
                                            .bold()
                                    }
                                    
                                    Text(user.lastName ?? "")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                }
                                .offset(y: -5)
                                
                                Spacer()
                            }
                            .frame(maxHeight: vm.fullDetailInfo ? .infinity : 80)
                            .padding([.leading, .top], 20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                BlurView(style: .systemChromeMaterialDark).opacity(0.9).cornerRadius(15)
                            )
                            .animation(.interactiveSpring(response: 0.7, dampingFraction: 0.7, blendDuration: 0.7), value: vm.fullDetailInfo)
                            .onTapGesture {
                                withAnimation() {
                                    vm.fullDetailInfo = !vm.fullDetailInfo
                                }
                            }
                        
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .offset(x: offset)
        .rotationEffect(.init(degrees: getRotation(angle: 8)))
        .contentShape(Rectangle().trim(from: 0, to: endSwipe ? 0 : 1))
        .shadow(color: Color.black.opacity(0.4), radius: 10, x: 0, y: 5)
        .gesture(
            dragGesture
        )
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("ACTIONFROMBUTTON"), object: nil)) { data in
            monitoringSwipes(data: data)
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
    
    private func monitoringSwipes(data: Notification) {
        guard let info = data.userInfo else { return }
        
        let id = info["id"] as? String ?? ""
        let rightSwipe = info["rightSwipe"] as? Bool ?? false
        let width = getRect().width - 50
        
        if user.id == id {
            offset = (rightSwipe ? width : -width) * 2
            
            endSwipeAction()
            
            rightSwipe ? vm.rightSwipe() : vm.leftSwipe()
        }
    }
}

//MARK: GESTURE
extension SwipeCardView {
    private var dragGesture: some Gesture {
        DragGesture()
            .updating($isDragging, body: { value, out, _ in
                out = true
            })
            .onChanged({ value in
                let translation = value.translation.width
                withAnimation {
                    offset = (isDragging ? translation : .zero)
                }
            })
            .onEnded({ value in
                let width = getRect().width - 50
                let translation = value.translation.width
                let checkingStatus = (translation > 0 ? translation : -translation)
                
                withAnimation {
                    if checkingStatus > (width / 2) {
                        offset = (translation > 0 ? width : -width) * 2
                        
                        endSwipeAction()
                        
                        translation > 0 ? vm.rightSwipe() : vm.leftSwipe()
                    } else {
                        offset = .zero
                    }
                }
            })
    }
}

//MARK: Components
extension SwipeCardView {
    private var likeAndDisLikeView: some View {
        Image(systemName: offset > 0 ? "heart.fill" : "xmark")
            .resizable()
            .fontWeight(.bold)
            .aspectRatio(contentMode: .fill)
            .frame(width: 35, height: 35)
            .foregroundColor(.red)
            .zIndex(1)
            .background(
                Circle()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.white)
            )
            .opacity(offset > 60 || offset < -60 ? 1 : 0)
            .scaleEffect(offset > 60 || offset < -60 ? 1 : 0.001)
    }
}
