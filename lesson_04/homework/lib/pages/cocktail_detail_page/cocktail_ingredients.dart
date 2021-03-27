import 'package:flutter/material.dart';
import 'package:homework/style/app-colors.dart';
import 'package:homework/style/app-text-style.dart';
import 'package:homework/models/models.dart';

class CocktailIngredients extends StatelessWidget {
  final String ingredientTitle = 'Ингредиенты:';
  final List<IngredientDefinition> ingredients;
  const CocktailIngredients({Key key, this.ingredients}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> ingredientsWidgets = ingredients
        .map((ingraient) => _buildIngredient(
              context,
              name: ingraient.ingredientName,
              measure: ingraient.measure,
            ))
        .toList();

    return Container(
      color: AppColors.surface,
      padding: EdgeInsets.only(
        top: 24,
        right: 36,
        bottom: 24,
        left: 36,
      ),
      child: Column(
        children: [
          Container(
            child: Text(
              ingredientTitle,
              style: AppTextStyle.secondaryTitle,
            ),
            padding: EdgeInsets.only(
              bottom: 24,
            ),
          ),
          ...ingredientsWidgets,
        ],
      ),
    );
  }

  Widget _buildIngredient(BuildContext context, {name, measure}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: AppTextStyle.primaryText.copyWith(
            height: 2,
            decoration: TextDecoration.underline,
          ),
        ),
        Text(
          measure,
          style: AppTextStyle.primaryText.copyWith(
            height: 2,
          ),
        ),
      ],
    );
  }
}