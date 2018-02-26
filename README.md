# DARCoachMarks

Coach marks library extracted from DAR Applications.

![demo](https://thumbs.gfycat.com/BestExcitableClumber-size_restricted.gif)

## Quick Start

First you have to create a view controller by extending `DARCoachMarksViewController`. In this controller you need to override some methods to make it work 🙌

```Swift
class CatalogViewController: DARCoachMarksViewController {

    // Number of coaching steps for this controller
    override func numberOfSteps() -> Int {
	return 1
    }
    
    // Coach mark configuration for certain step
    override func stepAt(index: Int) -> DARCoachMarkConfig {
    	let step = DARCoachMarkConfig()
        step.text = "..."  // Text of this mark
        step.highlightFrame = CGRect(...)  // Frame of highlight window in dimmer
        step.highlightCornerRadius = 15  // Corner radius of the highlight window
        step.hintBottom = 100  // Bottom offset for coach mark content (text and buttons)
        step.arrowStartPoint = CGPoint(...)  // Point where the arrrow should start
        step.arrowControlPoint = CGPoint(...)  // Point of control (it uses quad curve path)
        step.arrowEndPoint = CGPoint(...)  // Where the arrow should point
        return step
    }
    
    // Customization overrides:
    // Dimmer background gradient colors
    override var gradientColors: [CGColor] {
    	...
    }
    
    // Accent color
    override var accentColor: UIColor {
    	...
    }
}
```

After than instantiate your coaching view controller and call `present` passing it a view that you want to display coach marks on. This method also has an optional steps parameter which is an integer array for steps you'd like to show on this particular call.

Steps that have been displayed will not be displayed again. So for example you have displayed 0 step of a coach marks controller. And on another screen you want to present 0, 1 and 2 steps. Since 0 step has been shown already the coach marking will start from step 1.

If you want to reset shown steps status, you can call `resetPresentedStatus` method on an instance of your coach marks controller.

```Swift
...
let cmvc = ExampleCoachMarksViewController()

override func viewDidLoad() {
    super.viewDidLoad()
    ...
    cmvc.present(on: self.view, steps: [0, 1])
    cmvc.resetPresentedStatus()
}
```

If you want to get notified when user completed the coaching course you can provide a `DARCoachingMarksViewControllerDelegate` to the controller.
