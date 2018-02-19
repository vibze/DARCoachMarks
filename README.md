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

After than instantiate your coaching view controller and call `present` or `presenOnce` method passing it a view that you want to display coach marks on. `presentOnce` method writes a flag in user defaults and doesnt display this particular CoachMarksViewController in future.

```Swift
...
let cmvc = ExampleCoachMarksViewController()

override func viewDidLoad() {
    super.viewDidLoad()
    ...
    cmvc.present(on: self.view)
}
```

If you want to get notified when user completed the coaching course you can provide a `DARCoachingMarksViewControllerDelegate` to the controller.
