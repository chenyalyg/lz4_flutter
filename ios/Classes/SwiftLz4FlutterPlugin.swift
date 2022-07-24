import Flutter
import UIKit
import Compression


public class SwiftLz4FlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "lz4_flutter", binaryMessenger: registrar.messenger())
    let instance = SwiftLz4FlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      if (call.method == "lz4_encode") {
        let arg=call.arguments as? Dictionary<String,Any>
        let src=arg?["src"] as! FlutterStandardTypedData;
        let _bytes=[UInt8](src.data)
        
        
        let destinationBufferSize=compression_encode_scratch_buffer_size(COMPRESSION_LZ4_RAW);
        let destinationBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity:destinationBufferSize);
        //let destinationBuffer=[UInt8](repeating:0,count: _bytes.count)
        
        
        let size=compression_encode_buffer(destinationBuffer,destinationBufferSize,_bytes,_bytes.count,nil,COMPRESSION_LZ4_RAW)
        //let dataAfterCompress = [Data dataWithBytes:destinationBuffer length:size];
      
        let _dst=Data(bytes: destinationBuffer, count: size)
        let dst=FlutterStandardTypedData(bytes:_dst)
        result(dst)
      }else if(call.method == "lz4_decode"){
        let arg=call.arguments as? Dictionary<String,Any>
        let src=arg?["src"] as! FlutterStandardTypedData;
        let src_bytes=[UInt8](src.data)
        //let dst=FlutterStandardTypedData(bytes:Data( _bytes))
        let dst_len=arg?["dst_len"] as! Int;
       
        let destinationBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: dst_len)
        
        let size=compression_decode_buffer(destinationBuffer,dst_len,src_bytes,src_bytes.count,nil,COMPRESSION_LZ4_RAW)
        
        
        let _dst=Data(bytes: destinationBuffer, count: size)
        let dst=FlutterStandardTypedData(bytes:_dst)
        result(dst)
      }

  }
}
