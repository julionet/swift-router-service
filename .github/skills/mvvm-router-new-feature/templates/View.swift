//
//  {Feature}View.swift
//  PanPaymentGateway
//
//  Created by {Author} on {Date}.
//

import UIKit

protocol {Feature}ViewDelegate: AnyObject {
    // TODO: declare aqui as ações que a view repassa para o ViewController
}

final class {Feature}View: UIView {

    weak var delegate: {Feature}ViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCode()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViewCode()
    }

    func setup(model: {Feature}Model.SceneModel) {
        // TODO: aplicar os dados do sceneModel nos componentes da tela
    }
}

private extension {Feature}View {

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
        // TODO: adicione as constraints (SnapKit) das subviews
    }
}
