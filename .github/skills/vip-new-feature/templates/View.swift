//
//  {Feature}View.swift
//  App
//
//  Created by {Author} on {Date}.
//

import UIKit

protocol {Feature}Delegate: AnyObject {
    // TODO: declare aqui as ações que a view repassa para o ViewController
}

final class {Feature}View: UIView {
    
    weak var delegate: {Feature}Delegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViewCode()
    }
    
    func setup(model: {Feature}.Model.ViewModel) {
        // TODO: aplicar os dados do ViewModel nos componentes da tela
    }
}

extension {Feature}View: ViewCodeProtocol {
    
    func addViews() {
        // TODO: adicione as subviews com addSubview(_:)
    }
    
    func addConstraints() {
        // TODO: adicione as constraints (SnapKit)
    }
    
    func setupAccessibility() {}
    
    func setupViews() {
        backgroundColor = PanColor.neutral800
    }
}
