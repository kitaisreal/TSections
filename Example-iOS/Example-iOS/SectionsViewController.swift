//
//  SectionsViewController.swift
//  Example-iOS
//
//  Created by Kita, Maksim on 1/14/20.
//  Copyright © 2020 Kita, Maksim. All rights reserved.
//

import UIKit
import TSections

enum DemoSections {
    case headerSection
    case subheaderSection(SectionsArray<String>)
    case mainSection
    case footerSection
}

enum DemoItem {
    case valueCell(String)
    case collectionCell(SectionsArray<String>)

    var reuseIdentifier: String {
        let result: String

        switch self {

        case .valueCell:
            result = "ValueCell"
        case .collectionCell:
            result = "CollectionCell"
        }

        return result
    }
}

class SectionsViewController: UIViewController {

    private lazy var sections: Sections<DemoSections, DemoItem> = [
        Section(value: .headerSection, items: [.valueCell("Header Section")]),
        Section(value: .subheaderSection(["Subheader First Header",
                                          "Subheader Second Header"]), items: [.valueCell("Subheader Section")]),
        Section(value: .mainSection, items: [.valueCell("Main Section Begin"),
                                             .collectionCell(["First main section item",
                                                              "Second main section item",
                                                              "Third main section item"]),
                                             .valueCell("Main Section End")]),
        Section(value: .footerSection, items: [.valueCell("Footer Section")])
    ]

    private let tableView: UITableView = UITableView()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private struct Constants {
        static let sectionHeaderReuseIdentifier: String = "sectionHeaderReuseIdentifier"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }

}

private extension SectionsViewController {

    func initialization() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])


        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SectionItemTableViewCell.self, forCellReuseIdentifier: DemoItem.valueCell("").reuseIdentifier)
        tableView.register(SectionItemTableViewCell.self, forCellReuseIdentifier: DemoItem.collectionCell([]).reuseIdentifier)
        tableView.register(SectionItemTableHeaderView.self, forHeaderFooterViewReuseIdentifier: Constants.sectionHeaderReuseIdentifier)
    }
}

extension SectionsViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.section(at: section).count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = sections[indexPath].item

        let resultCell: UITableViewCell
        switch item {

        case .valueCell(let value):
            let cell: SectionItemTableViewCell! = tableView.dequeueReusableCell(withIdentifier: item.reuseIdentifier) as? SectionItemTableViewCell
            cell.updateWith(text: value)
            resultCell = cell
        case .collectionCell(let sectionsArray):
            let cell: SectionItemTableViewCell! = tableView.dequeueReusableCell(withIdentifier: item.reuseIdentifier) as? SectionItemTableViewCell
            let itemInDataSource = sectionsArray.item
            cell.updateWith(text: itemInDataSource)
            resultCell = cell
        }

        return resultCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let itemInSection = sections.itemInSection(at: indexPath)
        let section = itemInSection.section.value
        let item = itemInSection.item

        let resultHeight: CGFloat

        switch (section, item) {

        case (.headerSection, _):
            resultHeight = 120.0
        case (.mainSection, .valueCell):
            resultHeight = 140.0
        case (.mainSection, .collectionCell):
            resultHeight = 48.0
        case (.subheaderSection, _):
            resultHeight = 84.0
        case (.footerSection, _):
            resultHeight = 64.0
        }

        return resultHeight
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = sections[section]

        let resultView: UIView?

        if case .subheaderSection(let value) = section.value {
            let headerFooter: SectionItemTableHeaderView! = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.sectionHeaderReuseIdentifier) as? SectionItemTableHeaderView
            headerFooter.updateWithText(text: value.item)
            resultView = headerFooter
        } else {
            resultView = nil
        }

        return resultView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section]

        let resultHeight: CGFloat

        if case .subheaderSection = section.value {
            resultHeight = 48.0
        } else {
            resultHeight = 0.0
        }

        return resultHeight
    }

}
