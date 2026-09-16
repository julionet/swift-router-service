//
//  InfoView.swift
//  SwiftApp
//
//  Created by Jose Julio Junior on 15/09/26.
//

import UIKit

protocol InfoViewDelegate: AnyObject {
    // TODO: declare aqui as ações que a view repassa para o ViewController
}

final class InfoView: UIView {

    weak var delegate: InfoViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCode()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViewCode()
    }

    func setup(model: InfoModel.SceneModel) {
        // TODO: aplicar os dados do sceneModel nos componentes da tela
    }
}

private extension InfoView {

    func setupViewCode() {
        setupViews()
        addViews()
        addConstraints()
    }

    func setupViews() {
        backgroundColor = .white
    }

    func addViews() {
        // TODO: adicione as subviews com addSubview(_:)
    }

    func addConstraints() {
        // TODO: adicione as constraints (NSLayoutConstraint) das subviews
    }
}
