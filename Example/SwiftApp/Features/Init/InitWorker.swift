//
//  InitWorker.swift
//  SwiftApp
//
//  Created by Jose Julio Junior on 15/09/26.
//

import Foundation

protocol InitWorkerLogic {
    func fetchInitData(params: InitRequest, completion: @escaping (Result<InitResponse, Error>) -> Void)
}

final class InitWorker: InitWorkerLogic {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchInitData(params: InitRequest, completion: @escaping (Result<InitResponse, Error>) -> Void) {
        // TODO: substituir pela URL real do endpoint de Init.
        guard let url = URL(string: "https://example.com/TODO-init-endpoint") else {
            preconditionFailure("Configure a URL real do endpoint de Init")
        }

        let task = session.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            do {
                let response = try JSONDecoder().decode(InitResponse.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
