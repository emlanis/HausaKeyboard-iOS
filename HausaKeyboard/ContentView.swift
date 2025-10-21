//
//  ContentView.swift
//  HausaKeyboard
//
//  Created by emlanis on 20/10/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // App Icon/Logo Area
                VStack(spacing: 15) {
                    Image(systemName: "keyboard.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.white)
                    
                    Text("Hausa Keyboard")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Mai Sauƙi · ɓ ɗ ƙ ƴ ʼy")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white.opacity(0.9))
                }
                .padding(.top, 60)
                
                Spacer()
                
                // Instructions Card
                VStack(alignment: .leading, spacing: 20) {
                    Text("How to Enable")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.primary)
                    
                    InstructionStep(
                        number: "1",
                        text: "Open Settings on your iPhone"
                    )
                    
                    InstructionStep(
                        number: "2",
                        text: "Go to General → Keyboard → Keyboards"
                    )
                    
                    InstructionStep(
                        number: "3",
                        text: "Tap 'Add New Keyboard'"
                    )
                    
                    InstructionStep(
                        number: "4",
                        text: "Select 'HausaKeyboard' from the list"
                    )
                    
                    InstructionStep(
                        number: "5",
                        text: "Switch keyboards by tapping 🌐 globe icon"
                    )
                    
                    Divider()
                        .padding(.vertical, 5)
                    
                    Text("Special Characters Available:")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.secondary)
                    
                    Text("ɓ  ɗ  ƙ  ƴ  ʼy")
                        .font(.system(size: 28, weight: .medium))
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 10)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                }
                .padding(25)
                .background(Color(.systemBackground))
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                .padding(.horizontal, 20)
                
                Spacer()
                
                // Footer
                Text("Made with ❤️ for Hausa speakers")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.bottom, 30)
            }
        }
    }
}

struct InstructionStep: View {
    let number: String
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Text(number)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 32, height: 32)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.blue, Color.purple]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(16)
            
            Text(text)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
