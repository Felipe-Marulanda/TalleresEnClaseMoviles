class Meal {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;

  const Meal({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
  });
}

const sampleMeals = <Meal>[
  Meal(
    id: 'feijoada',
    title: 'Feijoada',
    description: 'Guiso tradicional con frijoles negros, cerdo y arroz blanco.',
    imageUrl: 'https://images.unsplash.com/photo-1612874472201-5627b07472b7',
    ingredients: [
      '500 g de frijoles negros',
      '300 g de costilla de cerdo',
      '200 g de chorizo ahumado',
      '2 hojas de laurel',
      'Cebolla, ajo y sal al gusto',
    ],
    steps: [
      'Remoja los frijoles toda la noche.',
      'Cocina los frijoles con las hojas de laurel.',
      'Dora las carnes y agrégalas a la olla.',
      'Hierve a fuego lento por 2 horas y rectifica sal.',
      'Sirve con arroz blanco y naranjas.',
    ],
  ),
  Meal(
    id: 'moqueca',
    title: 'Moqueca Baiana',
    description: 'Caldo de pescado con leche de coco, pimientos y dendê.',
    imageUrl: 'https://images.unsplash.com/photo-1496417263034-38ec4f0b665a',
    ingredients: [
      '600 g de filete de pescado blanco',
      '1 cebolla morada',
      '1 pimiento rojo y 1 amarillo',
      '200 ml de leche de coco',
      '2 cucharadas de aceite de dendê',
      'Cilantro fresco, ajo y sal al gusto',
    ],
    steps: [
      'Sazona el pescado con ajo, limón y sal.',
      'Saltea cebolla y pimientos en aceite.',
      'Agrega el pescado y cocina 5 minutos.',
      'Vierte la leche de coco y el aceite de dendê.',
      'Cocina a fuego lento 10 minutos y decora con cilantro.',
    ],
  ),
  Meal(
    id: 'brigadeiro',
    title: 'Brigadeiro',
    description: 'Dulce clásico de chocolate con leche condensada.',
    imageUrl: 'https://images.unsplash.com/photo-1515003197210-e0cd71810b5f',
    ingredients: [
      '1 lata de leche condensada',
      '3 cucharadas de cacao en polvo',
      '2 cucharadas de mantequilla',
      'Grageas de chocolate para decorar',
    ],
    steps: [
      'Calienta la leche condensada con cacao y mantequilla.',
      'Remueve sin parar hasta que espese.',
      'Deja templar y forma bolitas.',
      'Reboza en grageas y refrigera 30 minutos.',
    ],
  ),
];
