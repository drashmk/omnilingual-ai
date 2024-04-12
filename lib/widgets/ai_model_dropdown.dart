import 'package:chat/const/ai_models.dart';
import 'package:chat/model/ai_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class AiModelDropdown extends StatelessWidget {
  final AiModel selectedValue;
  final ValueChanged<AiModel?>? onChanged;

  const AiModelDropdown(
      {super.key, required this.selectedValue, this.onChanged});

  Widget _itemBuilder(BuildContext context, AiModel item, bool isSelected) {
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
        selected: item.code == selectedValue.code,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<AiModel>(
      filterFn: (aiModel, filter) {
        return aiModel.code.toLowerCase().contains(filter.toLowerCase());
      },
      itemAsString: (language) => language.name,
      compareFn: (l1, l2) => l1.code == l2.code,
      popupProps: PopupProps.menu(
          showSearchBox: true,
          showSelectedItems: true,
          itemBuilder: _itemBuilder,
          searchDelay: const Duration(milliseconds: 50)),
      items: aiModels.toList(growable: false),
      onChanged: onChanged,
      selectedItem: selectedValue,
    );
  }
}
