import 'package:chat/const/languages.dart';
import 'package:chat/model/language.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class LanguageDropdown extends StatelessWidget {
  final Language selectedLanguage;
  final ValueChanged<Language?>? onChanged;

  const LanguageDropdown(
      {super.key, required this.selectedLanguage, this.onChanged});

  Widget _languageItemBuilder(
      BuildContext context, Language item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
            ),
      child: ListTile(
        title: Text(item.name),
        selected: item.code == selectedLanguage.code,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Language>(
      filterFn: (language, filter) {
        return language.code.toLowerCase().contains(filter.toLowerCase()) ||
            language.name.toLowerCase().contains(filter.toLowerCase());
      },
      itemAsString: (language) => language.name,
      compareFn: (l1, l2) => l1.code == l2.code,
      popupProps: PopupProps.menu(
        showSearchBox: true,
        showSelectedItems: true,
        itemBuilder: _languageItemBuilder,
        searchDelay: const Duration(milliseconds: 50)
      ),
      items: languages.toList(growable: false),
      onChanged: onChanged,
      selectedItem: selectedLanguage,
    );
  }
}
