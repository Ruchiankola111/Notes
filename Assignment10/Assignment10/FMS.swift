import Foundation
class FMS {
    static func getDocDir() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print("Doc Dir: \(paths[0])")
        return paths[0]
    }
    
    static func getfile() -> [String] {
        var FileList = [String]()
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].path
        do{
            FileList = try FileManager.default.contentsOfDirectory(atPath: paths)
            return FileList
        } catch {
            print("Could not search : \(error)")
        }
        return FileList
    }
}
