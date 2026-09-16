//
//  InfoWorker.swift
//  SwiftApp
//
//  Created by Jose Julio Junior on 15/09/26.
//

import Foundation

protocol InfoWorkerLogic {
    func fetchInfoData(params: InfoRequest, completion: @escaping (Result<InfoResponse, Error>) -> Void)
}

final class InfoWorker: InfoWorkerLogic {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchInfoData(params: InfoRequest, completion: @escaping (Result<InfoResponse, Error>) -> Void) {
        // TODO: substituir pela URL real do endpoint de Info.
        guard let url = URL(string: "https://example.com/TODO-info-endpoint") else {
            preconditionFailure("Configure a URL real do endpoint de Info")
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
                let response = try JSONDecoder().decode(InfoResponse.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
