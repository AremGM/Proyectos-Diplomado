//
//  TabsTableViewCell.swift
//  App Examen-iOS
//
//  Created by Emiliano Gil  on 15/04/25.
//


import UIKit

protocol TabsTableViewCellDelegate: AnyObject {
    func didSelectTab(category: String)
}

class TabsTableViewCell: UITableViewCell {
    static let identifier = "TabsTableViewCell"
    weak var delegate: TabsTableViewCellDelegate?

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let tabs = ["Recommend", "Recent", "Popular"]

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(stackView)
        setupTabs()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTabs() {
        tabs.forEach { title in
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
            button.setTitleColor(title == "Popular" ? .label : .secondaryLabel, for: .normal)
            button.layer.cornerRadius = 10
            button.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }

    @objc private func tabButtonTapped(_ sender: UIButton) {
        // Reset all buttons to default color and font weight
        stackView.arrangedSubviews.forEach { view in
            if let button = view as? UIButton {
                button.setTitleColor(.secondaryLabel, for: .normal)
            }
        }

        // Change the color and font weight of the selected button
        sender.setTitleColor(.label, for: .normal)

        guard let title = sender.title(for: .normal) else { return }
        let category: String
        switch title {
        case "Recommend":
            category = "top_rated"
        case "Recent":
            category = "now_playing"
        case "Popular":
            category = "popular"
        default:
            return
        }
        
        delegate?.didSelectTab(category: category)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}
