import 'dart:convert' as convert;
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../models.dart';

class AsyncCocktailRepository {
  static const String _apiKey =
      'e5b7f97a78msh3b1ba27c40d8ccdp105034jsn34e2da32d50b';

  static const Map<String, String> _headers = const {
    'x-rapidapi-key': _apiKey,
  };

  Future<Cocktail> fetchCocktailDetails(String id) async {
    Cocktail? result;

    var client = http.Client();
    try {
      final url =
          Uri.parse('https://the-cocktail-db.p.rapidapi.com/lookup.php?i=$id');
      var response = await http.get(url, headers: _headers);
      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);
        var drinks = jsonResponse['drinks'] as Iterable<dynamic>;

        final dtos = drinks
            .cast<Map<String, dynamic>>()
            .map((json) => CocktailDto.fromJson(json));
        if (dtos.length > 0) {
          result = _createCocktailFromDto(dtos.first);
        }
      } else {
        throw HttpException(
            'Request failed with status: ${response.statusCode}');
      }
    } finally {
      client.close();
    }

    return result!;
  }

  Future<Iterable<CocktailDefinition>> fetchCocktailsByCocktailCategory(
      CocktailCategory category) async {
    var result = <CocktailDefinition>[];

    var client = http.Client();
    try {
      final url = Uri.parse(
          'https://the-cocktail-db.p.rapidapi.com/filter.php?c=${category.value}');
      var response = await http.get(
        url,
        headers: {
          'x-rapidapi-key':
              'e5b7f97a78msh3b1ba27c40d8ccdp105034jsn34e2da32d50b',
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);
        var drinks = jsonResponse['drinks'] as Iterable<dynamic>;

        final dtos = drinks
            .cast<Map<String, dynamic>>()
            .map((json) => CocktailDefinitionDto.fromJson(json));

        for (final dto in dtos) {
          result.add(CocktailDefinition(
            id: dto.idDrink,
            isFavourite: false,
            name: dto.strDrink,
            drinkThumbUrl: dto.strDrinkThumb,
          ));
        }
      } else {
        throw HttpException(
            'Request failed with status: ${response.statusCode}');
      }
    } finally {
      client.close();
    }

    return result;
  }

  Future<Iterable<CocktailDefinition>> fetchCocktailsByCocktailType(
      CocktailType cocktailType) async {
    var result = <CocktailDefinition>[];

    var client = http.Client();
    try {
      final url = Uri.parse(
          'https://the-cocktail-db.p.rapidapi.com/filter.php?a=${cocktailType.value}');
      var response = await http.get(
        url,
        headers: {
          'x-rapidapi-key':
              'e5b7f97a78msh3b1ba27c40d8ccdp105034jsn34e2da32d50b',
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);
        var drinks = jsonResponse['drinks'] as Iterable<dynamic>;

        final dtos = drinks
            .cast<Map<String, dynamic>>()
            .map((json) => CocktailDefinitionDto.fromJson(json));

        for (final dto in dtos) {
          result.add(CocktailDefinition(
            id: dto.idDrink,
            isFavourite: false,
            name: dto.strDrink,
            drinkThumbUrl: dto.strDrinkThumb,
          ));
        }
      } else {
        throw HttpException(
            'Request failed with status: ${response.statusCode}');
      }
    } finally {
      client.close();
    }

    return result;
  }

  Future<Iterable<Cocktail>> fetchPopularCocktails() async {
    var result = <Cocktail>[];

    var client = http.Client();
    try {
      final url =
          Uri.parse('https://the-cocktail-db.p.rapidapi.com/popular.php');
      var response = await http.get(
        url,
        headers: {
          'x-rapidapi-key':
              'e5b7f97a78msh3b1ba27c40d8ccdp105034jsn34e2da32d50b',
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);
        var drinks = jsonResponse['drinks'] as Iterable<dynamic>;

        final dtos = drinks
            .cast<Map<String, dynamic>>()
            .map((json) => CocktailDto.fromJson(json));

        for (final dto in dtos) {
          final cocktail = _createCocktailFromDto(dto);
          result.add(cocktail);
        }
      } else {
        throw HttpException(
            'Request failed with status: ${response.statusCode}');
      }
    } finally {
      client.close();
    }

    return result;
  }

  Future<Cocktail> getRandomCocktail() async {
    Cocktail? result;

    var client = http.Client();
    try {
      final url =
          Uri.parse('https://the-cocktail-db.p.rapidapi.com/random.php');
      var response = await http.get(url, headers: _headers);
      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);
        var drinks = jsonResponse['drinks'] as Iterable<dynamic>;

        final dtos = drinks
            .cast<Map<String, dynamic>>()
            .map((json) => CocktailDto.fromJson(json));
        if (dtos.length > 0) {
          result = _createCocktailFromDto(dtos.first);
        }
      } else {
        throw HttpException(
            'Request failed with status: ${response.statusCode}');
      }
    } finally {
      client.close();
    }

    return result!;
  }

  Future<Ingredient?> lookupIngredientById() async {
    return null;
  }

  Cocktail _createCocktailFromDto(CocktailDto dto) {
    final glass = GlassType.parse(dto.strGlass);
    final cocktailType = CocktailType.parse(dto.strAlcoholic);
    final category = CocktailCategory.parse(dto.strCategory);

    var ingredients = <IngredientDefinition>[];

    _getIngredients(dto).forEach((key, value) {
      if (key != null && value != null) {
        ingredients.add(IngredientDefinition(key, value));
      }
    });

    return Cocktail(
      id: dto.idDrink,
      category: category,
      cocktailType: cocktailType,
      glassType: glass,
      instruction: dto.strInstructions ?? '',
      isFavourite: false,
      name: dto.strDrink,
      ingredients: ingredients,
      drinkThumbUrl: dto.strDrinkThumb ?? '',
    );
  }

  Map<String?, String?> _getIngredients(CocktailDto dto) {
    return <String?, String?>{
      dto.strIngredient1: dto.strMeasure1,
      dto.strIngredient2: dto.strMeasure2,
      dto.strIngredient3: dto.strMeasure3,
      dto.strIngredient4: dto.strMeasure4,
      dto.strIngredient5: dto.strMeasure5,
      dto.strIngredient6: dto.strMeasure6,
      dto.strIngredient7: dto.strMeasure7,
      dto.strIngredient8: dto.strMeasure8,
      dto.strIngredient9: dto.strMeasure9,
      dto.strIngredient10: dto.strMeasure10,
      dto.strIngredient11: dto.strMeasure11,
      dto.strIngredient12: dto.strMeasure12,
      dto.strIngredient13: dto.strMeasure13,
      dto.strIngredient14: dto.strMeasure14,
      dto.strIngredient15: dto.strMeasure15,
    };
  }
}
