//
//  ContentView.swift
//  GestureDemo
//
//  Created by 박민주 on 2022/11/01.
//

import SwiftUI
import Combine

struct ContentView: View {
    // 숫자 카운트
    @State private var count: Int = 0
    
    //롱프레스 제스처 상태
    @GestureState var longPressState: Bool = false
    
    // 타이머 선언
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()

    var body: some View {
        // 탭 재스처
        let tap = TapGesture()
            .onEnded { _ in
                count += 1
            }

        // 드래그 재스처
        let drag = DragGesture()
            .onEnded { _ in
                if count > 0 { count -= 1 }
            }
        
        // 롱 프레스 재스처
        let longPress = LongPressGesture(minimumDuration: Double.greatestFiniteMagnitude)
            .updating($longPressState) { currentState, gestureState, _ in
                gestureState = currentState
            }

        
        VStack {
            Spacer()
            
            if count % 10 == 0 && count != 0 {
                Text("\(count)")
                    .font(.system(size: 100, weight: .heavy))
                    .foregroundColor(.yellow)
                    .padding()
            } else {
                Text("\(count)")
                    .font(.system(size: 100, weight: .heavy))
                    .foregroundColor(.white)
                    .padding()
            }
            
            Button("RESET") {
                count = 0
            }
            .foregroundColor(.white)
            .font(.system(size: 20))
            
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color("navy"))
        
        // 타이머 받기
        .onReceive(timer) { _ in
            if longPressState { // 길게 눌렀을 경우
                count += 1
            }
        }
        .gesture(tap)
        .gesture(longPress)
        .gesture(drag)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
