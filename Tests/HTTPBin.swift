import Spectre
import RequestSession
import Foundation

func describeGet() {
  describe("Can perform GET requests") {
    $0.it("httpbin.org") {
      let sessionConfiguration = HTTPSessionConfiguration.defaultSessionConfiguration()
      sessionConfiguration.HTTPAdditionalHeaders = [ "YOLO": "yes" ]
      let session = HTTPSession(configuration: sessionConfiguration)

      var httpBody: NSString?
      var httpError: NSError?
      var httpResponse: NSHTTPURLResponse?

      let expectation = Expectation()
      let url = NSURL(string: "http://httpbin.org/headers")!
      let task = session.dataTaskWithURL(url) { (data, response, error) in
        httpBody = NSString(data: data!, encoding: NSUTF8StringEncoding)
        httpBody = httpBody?.stringByReplacingOccurrencesOfString(" ", withString: "")
        httpBody = httpBody?.stringByReplacingOccurrencesOfString("\n", withString: "")

        httpResponse = response as? NSHTTPURLResponse
        httpError = error

        expectation.fulfil()
      }
      task.resume()

      try expectation.wait()

      try expect(httpBody) == "{\"headers\":{\"Host\":\"httpbin.org\",\"Yolo\":\"yes\"}}"
      try expect(httpResponse?.statusCode) == 200
      try expect(httpError == nil) == true
    }
  }
}
