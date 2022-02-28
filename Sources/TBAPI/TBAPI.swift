import Foundation

public class TBAPI {
    
    public var encoder = JSONEncoder()
    public var decoder = JSONDecoder()
    public var successResponseCode: Int? = 200
    
    private let session = URLSession.shared
    
    public enum Method: String {
        case get = "GET"
        case post = "POST"
    }
    
    
    public func request(_ method: Method = .get, url: String, headers: [String:String]? = nil, bodyData: Data? = nil, query: [URLQueryItem]? = nil) async throws -> (Data, URLResponse) {
        guard var url = URL(string: url) else {
            throw Error.invalidURL(url)
        }
        
        url = try url.append(queryItems: query)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.set(headers: headers)
        request.httpBody = bodyData
        return try await session.data(for: request)
    }
    
    
    public func request(_ method: Method = .get, url: String, headers: [String:String]? = nil, bodyData: Data? = nil, query: [URLQueryItem]? = nil) async throws -> Data {
        let (data, response) = try await request(method, url: url, headers: headers, bodyData: bodyData, query: query)
        
        if let successResponseCode = successResponseCode {
            guard let httpResponse = response as? HTTPURLResponse else {
                throw Error.noResponseCode
            }
            guard httpResponse.statusCode == successResponseCode else {
                throw Error.responseCode(httpResponse.statusCode)
            }
        }
        return data
    }
    
    
    public func request<B:Encodable,R:Decodable>(_ method: Method = .get, url: String, headers: [String:String]? = nil, body: B? = nil, query: [URLQueryItem]? = nil) async throws -> R {
    
        var bodyData: Data?
        if let body = body {
            bodyData = try encoder.encode(body)
        }
        
        let data: Data = try await request(method, url: url, headers: headers, bodyData: bodyData, query: query)
        return try decoder.decode(R.self, from: data)
    }
    
}
