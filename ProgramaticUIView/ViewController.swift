//
//  ViewController.swift
//  ProgramaticUIView
//
//  Created by Gokul Murugan on 27/03/24.
//

import UIKit


enum ActivityType{
    case Accuracy, Calories, Reps, Timer
}

class ViewController: UIViewController {
    
    var isRepBased:Bool = true
    
    public func makeStackView(withOrientation axis: NSLayoutConstraint.Axis,
                              alignment: UIStackView.Alignment = .center,
                              distribution: UIStackView.Distribution = .fill,
                              spacing: CGFloat? = nil) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.distribution = distribution
        stackView.alignment = alignment
        stackView.spacing = spacing ?? 0.0
        stackView.backgroundColor = .gray.withAlphaComponent(0.3)
        stackView.layer.cornerRadius = 10

        return stackView
    }
    
    public func makeImageView(withImageName name: String,
                              width: CGFloat,
                              height: CGFloat) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName:name)
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: height).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }
    
    
    private func returnUIlabel(title:String, fontSize:CGFloat, color:UIColor = .darkGray ) -> UIView{
        let valueLabel = UILabel()
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.text = title
        valueLabel.font = UIFont.systemFont(ofSize: fontSize, weight: .semibold)
        valueLabel.textColor = color
        valueLabel.textAlignment = .center
        return valueLabel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = .systemRed
//        if isRepBased {
//            setupExerciseData(repBased:isRepBased)
//            //setupNameOfTheExerciseView()
//            setupTimerView(repBased: isRepBased)
//        } else {
//            setupExerciseData(repBased:isRepBased)
//            setupTimerView(repBased: isRepBased)
//        }
        
        timerArrangedView()
    }
    
    
    func timerArrangedView() {
        let wrapperView = makeStackView(withOrientation: .vertical)
        
        let progressView = CircularProgressView(frame: CGRect(x: 0, y: 0, width: 85, height: 85), lineWidth: 10, rounded: true)
        progressView.progressColor = .white
        progressView.trackColor = .gray.withAlphaComponent(0.4)
        progressView.progress = 0.6
        progressView.backgroundColor = .clear
        
        let label = returnUIlabel(title: "30", fontSize: 30, color: .black)
        
        wrapperView.addArrangedSubview(progressView)
        wrapperView.addArrangedSubview(label)
        
        view.addSubview(wrapperView)
        
        NSLayoutConstraint.activate([
            wrapperView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150),
            wrapperView.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            wrapperView.widthAnchor.constraint(equalToConstant: 85), // Assuming a fixed width for wrapperView
            wrapperView.heightAnchor.constraint(equalToConstant: 170), // Assuming the total height of progressView and label
            progressView.widthAnchor.constraint(equalToConstant: 85), // Assuming a fixed width for progressView
            progressView.heightAnchor.constraint(equalToConstant: 85), // Assuming a fixed height for progressView
            label.centerXAnchor.constraint(equalTo: progressView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: progressView.centerYAnchor), // Assuming a fixed height for label
        ])
    }

    
    func setupTimerView(repBased:Bool){
        let wrapperView = UIView()
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        wrapperView.layer.cornerRadius = 10
        wrapperView.backgroundColor = .black.withAlphaComponent(0.4)
        
        let stack = makeStackView(withOrientation: .vertical, distribution: .fill)
        let timerView = exerciseDataView(for: .Timer, mainValueToDisplay: "30", addedValue: nil)
        stack.backgroundColor = .clear
        // Create circular progress view
        let progressView = CircularProgressView(frame: CGRect(x: -42.5, y: -25, width: 85, height: 85), lineWidth: 10, rounded: true)
        progressView.progressColor = .white
        progressView.trackColor = .gray.withAlphaComponent(0.4)
        progressView.progress = 0.6
        
        // Add progress view as subview of timer view
        timerView.addSubview(progressView)
        
        // Center the progress view within the timer view
        progressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressView.centerXAnchor.constraint(equalTo: timerView.centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: timerView.centerYAnchor)
        ])

        stack.addArrangedSubview(timerView)
        wrapperView.addSubview(stack)
        self.view.addSubview(wrapperView)

            NSLayoutConstraint.activate([
                // Constrain the stack view to the wrapper view with padding
                stack.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 10),
                stack.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -10),
                stack.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 10),
                stack.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -10),
                
                // Constrain the wrapper view to the safe area layout guide
                wrapperView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
                wrapperView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                wrapperView.heightAnchor.constraint(equalToConstant: 150)
            ])
       
    }

    
    
    func setupNameOfTheExerciseView(){
        let wrapperView = UIView()
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        wrapperView.layer.cornerRadius = 10
        wrapperView.backgroundColor = .black.withAlphaComponent(0.4)
        
        let stack = makeStackView(withOrientation: .vertical, distribution: .fill)
        let exercise = returnUIlabel(title: "Curl", fontSize: 20, color: .white)
        stack.backgroundColor = .clear
        stack.addArrangedSubview(exercise)
        
        wrapperView.addSubview(stack)
        view.addSubview(wrapperView)
        // Constraints
           NSLayoutConstraint.activate([
            // Constrain the stack view to the wrapper view with padding
            stack.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -10),
            stack.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -10),
            
            // Constrain the wrapper view to the safe area layout guide
            wrapperView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            wrapperView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            wrapperView.heightAnchor.constraint(equalToConstant: 45)
           ])
        view.bringSubviewToFront(stack)
        
        
    }
    
    func setupExerciseData(repBased:Bool){
        // Create a wrapper view for the stack view
        let wrapperView = UIView()
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        wrapperView.layer.cornerRadius = 10
        wrapperView.backgroundColor = .black.withAlphaComponent(0.4) // Set the background color of the wrapper view
        
        // Add the stack view to the wrapper view
        let stack = makeStackView(withOrientation: .vertical, distribution: .fill, spacing: 5)
        stack.backgroundColor = .clear
        // Add the views inside the stack view
        if repBased{
            let repCounter = exerciseDataView(for: .Reps, mainValueToDisplay: "12", addedValue: "/ 15")
            let accuracy = exerciseDataView(for: .Accuracy, mainValueToDisplay: "20", addedValue: "%")
            let calories = exerciseDataView(for: .Calories, mainValueToDisplay: "88", addedValue: "cal")
            stack.addArrangedSubview(repCounter)
            stack.addArrangedSubview(accuracy)
            stack.addArrangedSubview(calories)
            
            wrapperView.addSubview(stack)
            
            // Add the wrapper view to the main view
            self.view.addSubview(wrapperView)
        } else {
            let accuracy = exerciseDataView(for: .Accuracy, mainValueToDisplay: "20", addedValue: "%")
            stack.addArrangedSubview(accuracy)
            self.view.addSubview(stack)
        }
        
        // Add the stack view inside wrapper view to add padding
        
        if repBased{
            //COnstrains
            NSLayoutConstraint.activate([
                // Constrain the stack view to the wrapper view with padding
                stack.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 10),
                stack.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -10),
                stack.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 10),
                stack.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -10),
                
                // Constrain the wrapper view to the safe area layout guide
                wrapperView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
                wrapperView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
            ])
            
            // Bring the wrapper view to the front
            view.bringSubviewToFront(wrapperView)
        } else {
            // Constraints
            NSLayoutConstraint.activate([
                stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
                stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
            
            
            ])
        }
        
        
    }


    func exerciseDataView(for Activity:ActivityType, mainValueToDisplay:String, addedValue:String?) -> UIStackView{
        
        let stack = makeStackView(withOrientation: .vertical)
        let horizontalStack1 = makeStackView(withOrientation: .horizontal, spacing: 2)
        let horizontalStack2 = makeStackView(withOrientation: .horizontal, spacing: 2)
        stack.heightAnchor.constraint(equalToConstant: 90).isActive = true
        stack.widthAnchor.constraint(equalToConstant: 100).isActive = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        switch Activity{
            
        case .Accuracy:
            addAllViewsTogether(mainStach: stack, horizontalStack1: horizontalStack1, horizontalStack2: horizontalStack2, mainValue: mainValueToDisplay, subValue: addedValue, iconName: "scope", iconTitle: "Accuracy", colorforText: .white)
            if Int(mainValueToDisplay)! > 0 && Int(mainValueToDisplay)! <= 40{
                stack.backgroundColor = UIColor(red: 166/255, green: 69/255, blue: 69/255, alpha: 1)
            } else if Int(mainValueToDisplay)! > 40 && Int(mainValueToDisplay)! < 75{
                stack.backgroundColor = UIColor(red: 201/255, green: 147/255, blue: 65/255, alpha: 1)
            } else {
                stack.backgroundColor = UIColor(red: 91/255, green: 142/255, blue: 120/255, alpha: 1)
            }
            
        case .Calories:
            addAllViewsTogether(mainStach: stack, horizontalStack1: horizontalStack1, horizontalStack2: horizontalStack2, mainValue: mainValueToDisplay, subValue: addedValue, iconName: "flame", iconTitle: "Calories Burn", colorforText: .darkGray)
            stack.backgroundColor = .white
            
        case .Reps:
            addAllViewsTogether(mainStach: stack, horizontalStack1: horizontalStack1, horizontalStack2: horizontalStack2, mainValue: mainValueToDisplay, subValue: addedValue, iconName: "arrow.circlepath", iconTitle: "Rep Count", colorforText: .white, subFontSize: 18)
            stack.backgroundColor = .none
            
        case .Timer:
            addAllViewsTogether(mainStach: stack, horizontalStack1: horizontalStack1, horizontalStack2: horizontalStack2, mainValue: mainValueToDisplay, subValue: addedValue, iconName: "clock.arrow.circlepath", iconTitle: "Timer", colorforText: .white, subFontSize: 18)
            stack.backgroundColor = .none
            
        }
        return stack
    }
    
    
    func addAllViewsTogether(mainStach:UIStackView, horizontalStack1:UIStackView, horizontalStack2:UIStackView, mainValue:String, subValue:String?, iconName:String, iconTitle:String, colorforText:UIColor, subFontSize: CGFloat = 10){
        let icon = makeImageView(withImageName: iconName, width: 15, height: 15)
        icon.tintColor = colorforText
        let view1 = returnUIlabel(title: iconTitle,fontSize: 10, color: colorforText)
        
        horizontalStack1.addArrangedSubview(icon)
        horizontalStack1.addArrangedSubview(view1)
        horizontalStack1.backgroundColor = .none
        let horizontalStack2 = makeStackView(withOrientation: .horizontal,alignment: .fill, spacing: 2)
        let view2 = returnUIlabel(title: mainValue,fontSize: 36, color: colorforText)
        horizontalStack2.addArrangedSubview(view2)
        if let subFont = subValue{
            let view3 = returnUIlabel(title: subFont,fontSize: subFontSize, color: colorforText)
            horizontalStack2.addArrangedSubview(view3)
        } else{
            horizontalStack2.heightAnchor.constraint(equalToConstant: 100).isActive = true
        }
        horizontalStack2.backgroundColor = .none
        mainStach.addArrangedSubview(horizontalStack1)
        mainStach.addArrangedSubview(horizontalStack2)
    }
    

}

