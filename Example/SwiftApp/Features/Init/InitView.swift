//
//  InitView.swift
//  SwiftApp
//
//  Created by Jose Julio Junior on 15/09/26.
//

import UIKit

protocol InitViewDelegate: AnyObject {
    func didTapButton()
}

final class InitView: UIView {

    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.textColor = .black
        button.addTarget(self, action: #selector(didTapButttonAction), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: InitViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCode()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViewCode()
    }

    func setup(model: InitModel.SceneModel) {
        button.setTitle(model.buttonText, for: .normal)
    }
    
    @objc private func didTapButttonAction() {
        delegate?.didTapButton()
    }
}

private extension InitView {

    func setupViewCode() {
        setupViews()
        addViews()
        addConstraints()
    }

    func setupViews() {
        backgroundColor = .white
    }

    func addViews() {
        addSubview(button)
    }

    func addConstraints() {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
