import Routing
import Vapor

/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)
public func routes(_ router: Router) throws {
    //When someone makes a GET request to the /hello endpoint, return Hello World
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    router.post("users", use: createUser)
    
}

func createUser(_ req: Request) throws -> Future<String>  {
    
   let user = try req.content.decode(User.self)
    
  return user.flatMap { (unwrapUser) -> Future<String> in
    return req.future("Created user for \(unwrapUser.name)")
    }
    
}


struct User: Content {
    let name: String
    let email: String
}
 
