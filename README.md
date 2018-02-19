# DARCoachMarks

Coach marks library extracted from DAR Applications.

## Quick Start

First you have to create a view controller by extending `DARCoachMarksViewController`. In this controller you need to override some methods to make it work 🙌

```Swift
class CatalogViewController: DARCoachMarksViewController {

	// Number of coaching steps for this controller
	override func numberOfSteps() -> Int {
    	...	
    }
    
    // Coach mark configuration for certain step
    override func stepAt(index: Int) -> DARCoachMarkConfig {
    	...
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