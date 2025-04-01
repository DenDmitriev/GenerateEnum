import XCTest
import GenerateEnum
import ObjCClasses

@GenerateEnum(base: Flow1ComponentChild, name: "Flow1Enum")
enum Flow1ComponentChildEnum {}

final class GenerateEnumTests: XCTestCase {
    
    func testEnumInitialization() {
        let screenA = Flow1ComponentChild.Screen1A()
        let screenB = Flow1ComponentChild.Screen1B()
        let screenC = Flow1ComponentChild.Screen1C()

        let enumA = Flow1ComponentChildEnum(shared: screenA)
        let enumB = Flow1ComponentChildEnum(shared: screenB)
        let enumC = Flow1ComponentChildEnum(shared: screenC)

        XCTAssertNotNil(enumA)
        XCTAssertNotNil(enumB)
        XCTAssertNotNil(enumC)
    }
}
