//
//  NetworkService.swift
//  FearlessDateAI
//
//  Created by Денис Сторожик on 14.05.2023.
//

import Foundation

final class NetworkService<Endpoint: EndpointProtocol>: NSObject, URLSessionTaskDelegate {
    
    // MARK: - Typealiases
    
    typealias Percentage = Double
    typealias ProgressHandler = (Percentage) -> Void
    
    
    // MARK: - Properties
    
    private lazy var sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = ServiceConstants.requestTimeout
        sessionConfiguration.timeoutIntervalForResource = ServiceConstants.resourceTimeout
        
        return sessionConfiguration
    }()
    
    private lazy var urlSession: URLSession = {
        let session = URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: .main)
        return session
    }()
    
    private var decoder: JSONDecoder
    private var progressHandlersByTaskID = [Int : ProgressHandler]()
    
    
    // MARK: - Init
    
    override init() {
        decoder = JSONDecoder()
        decoder.dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.millisecondsSince1970
        super.init()
    }
    
    
    // MARK: - JSON request .put, .post, .delete.
    
    func jsonRequest<Response>(
        endpoint: Endpoint,
        completion: @escaping (NetworkResult<Response>) -> Void) where Response: Decodable {
        
        decoder.keyDecodingStrategy = endpoint.keyDecodingStrategy
        
        let url = URL(string: APIURL.develop.rawValue + endpoint.path)!
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        let jsonData = try? JSONSerialization.data(withJSONObject: endpoint.parameters, options: [])
        request.httpBody = jsonData
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlSession.dataTask(with: request) { data, response, error in
            
            let result: NetworkResult<Response>
            
            guard response != nil else {
                result = NetworkResult.failure(APIError.noNetwork)
                return
            }
            
            guard let data = data else { return }
            
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            do {
                let object = try self.decoder.decode(Response.self, from: data)
                result = NetworkResult.success(object)
                print(object)
            } catch (let error) {
                NSLog("CheckError \(error)")
                result = NetworkResult.failure(.decodingError)
            }
            
        }.resume()
    }
    
    
    // MARK: - Multi-part request
    
    @discardableResult func mpRequest<Response>(
        attachmentFiles: [(String, URL)],
        endpoint: Endpoint,
        progressHandler: @escaping ProgressHandler,
        completion: @escaping (NetworkResult<Response>) -> Void) -> Int? where Response: Decodable {
            
            decoder.keyDecodingStrategy = endpoint.keyDecodingStrategy
            
            var url = URLComponents(string: APIURL.develop.rawValue + endpoint.path)
            
            endpoint.queryParams?.forEach {
                url?.queryItems = [
                    URLQueryItem(name: $0, value: $1)
                ]
            }
            
            guard let resultURL = url?.url else { return nil }
            
            var request = URLRequest(url: resultURL)
            request.httpMethod = endpoint.method.rawValue
            
            let boundary = BodyAdapter.generateBoundaryString()
            guard let body = try? BodyAdapter.createBody(with: endpoint.parameters,
                                                         files: attachmentFiles,
                                                         boundary: boundary) else { return nil }
            
            request.addValue("ru", forHTTPHeaderField: "Accept-Language")
            request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.httpBody = body
            
            let task = urlSession.dataTask(
                with: request,
                completionHandler: { data, response, error in
                    
                    let result: NetworkResult<Response>
                    
                    guard response != nil else {
                        result = NetworkResult.failure(APIError.noNetwork)
                        return
                    }
                    
                    guard let data = data else {
                        return
                    }
                    
                    defer {
                        DispatchQueue.main.async {
                            completion(result)
                        }
                    }
                    
                    do {
                        let object = try self.decoder.decode(Response.self, from: data)
                        result = NetworkResult.success(object)
                        print(object)
                    } catch (let error) {
                        NSLog("CheckError \(error)")
                        result = NetworkResult.failure(.decodingError)
                    }
                    
                }
            )
            
            progressHandlersByTaskID[task.taskIdentifier] = progressHandler
            task.resume()
            return task.taskIdentifier
        }
    
    func cancel(taskID: Int) {
        Task {
            await urlSession.allTasks.filter({ $0.taskIdentifier == taskID }).first?.cancel()
        }
    }
    
    func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        didSendBodyData bytesSent: Int64,
        totalBytesSent: Int64,
        totalBytesExpectedToSend: Int64
    ) {
        let progress = Double(totalBytesSent) / Double(totalBytesExpectedToSend)
        let handler = progressHandlersByTaskID[task.taskIdentifier]
        print(progress)
        handler?(progress)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        progressHandlersByTaskID.removeValue(forKey: task.taskIdentifier)
    }
}
