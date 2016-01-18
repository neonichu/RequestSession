#if os(Linux)
import Glibc

func async(block: (Void) -> Void) {
  block()
}

extension String {
  func dataUsingEncoding(encoding: UInt) -> NSData? {
    self.withCString { (bytes) in
      return NSData(bytes: bytes, length: Int(strlen(bytes)))
    }
    return nil
  }
}
#else
import Dispatch

func async(block: (Void) -> Void) {
  dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), block)
}
#endif

