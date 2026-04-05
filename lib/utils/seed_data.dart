import '../models/food_item.dart';
import '../models/recipe.dart';
import '../models/diet_plan.dart';
import '../models/reminder_model.dart';

class SeedData {
  static List<FoodItem> getFoodItems() {
    return [
      // Fruits
      FoodItem(id: 'f1', name: 'Apple', caloriesPer100g: 52, proteinPer100g: 0.3, carbsPer100g: 14, fatPer100g: 0.2, category: 'Fruits', servingUnit: 'piece', servingSize: 182),
      FoodItem(id: 'f2', name: 'Banana', caloriesPer100g: 89, proteinPer100g: 1.1, carbsPer100g: 23, fatPer100g: 0.3, category: 'Fruits', servingUnit: 'piece', servingSize: 118),
      FoodItem(id: 'f3', name: 'Orange', caloriesPer100g: 47, proteinPer100g: 0.9, carbsPer100g: 12, fatPer100g: 0.1, category: 'Fruits', servingUnit: 'piece', servingSize: 131),
      FoodItem(id: 'f4', name: 'Mango', caloriesPer100g: 60, proteinPer100g: 0.8, carbsPer100g: 15, fatPer100g: 0.4, category: 'Fruits', servingUnit: 'piece', servingSize: 336),
      FoodItem(id: 'f5', name: 'Watermelon', caloriesPer100g: 30, proteinPer100g: 0.6, carbsPer100g: 8, fatPer100g: 0.2, category: 'Fruits', servingUnit: 'cup', servingSize: 152),

      // Vegetables
      FoodItem(id: 'v1', name: 'Salad (Mixed)', caloriesPer100g: 20, proteinPer100g: 1.5, carbsPer100g: 3.5, fatPer100g: 0.2, category: 'Vegetables', servingUnit: 'bowl', servingSize: 150),
      FoodItem(id: 'v2', name: 'Broccoli', caloriesPer100g: 55, proteinPer100g: 3.7, carbsPer100g: 11, fatPer100g: 0.6, category: 'Vegetables', servingUnit: 'cup', servingSize: 91),
      FoodItem(id: 'v3', name: 'Carrot', caloriesPer100g: 41, proteinPer100g: 0.9, carbsPer100g: 10, fatPer100g: 0.2, category: 'Vegetables', servingUnit: 'piece', servingSize: 72),
      FoodItem(id: 'v4', name: 'Spinach', caloriesPer100g: 23, proteinPer100g: 2.9, carbsPer100g: 3.6, fatPer100g: 0.4, category: 'Vegetables', servingUnit: 'cup', servingSize: 30),
      FoodItem(id: 'v5', name: 'Potato (Boiled)', caloriesPer100g: 87, proteinPer100g: 1.9, carbsPer100g: 20, fatPer100g: 0.1, category: 'Vegetables', servingUnit: 'piece', servingSize: 150),

      // Proteins
      FoodItem(id: 'p1', name: 'Chicken Breast', caloriesPer100g: 165, proteinPer100g: 31, carbsPer100g: 0, fatPer100g: 3.6, category: 'Protein', servingUnit: 'piece', servingSize: 120),
      FoodItem(id: 'p2', name: 'Egg (Boiled)', caloriesPer100g: 155, proteinPer100g: 13, carbsPer100g: 1.1, fatPer100g: 11, category: 'Protein', servingUnit: 'piece', servingSize: 50),
      FoodItem(id: 'p3', name: 'Fish (Grilled)', caloriesPer100g: 206, proteinPer100g: 22, carbsPer100g: 0, fatPer100g: 12, category: 'Protein', servingUnit: 'piece', servingSize: 150),
      FoodItem(id: 'p4', name: 'Lentils (Daal)', caloriesPer100g: 116, proteinPer100g: 9, carbsPer100g: 20, fatPer100g: 0.4, category: 'Protein', servingUnit: 'bowl', servingSize: 200),
      FoodItem(id: 'p5', name: 'Chickpeas', caloriesPer100g: 164, proteinPer100g: 8.9, carbsPer100g: 27, fatPer100g: 2.6, category: 'Protein', servingUnit: 'cup', servingSize: 164),
      FoodItem(id: 'p6', name: 'Beef (Lean)', caloriesPer100g: 250, proteinPer100g: 26, carbsPer100g: 0, fatPer100g: 15, category: 'Protein', servingUnit: 'piece', servingSize: 120),

      // Grains
      FoodItem(id: 'g1', name: 'Rice (White)', caloriesPer100g: 130, proteinPer100g: 2.7, carbsPer100g: 28, fatPer100g: 0.3, category: 'Grains', servingUnit: 'cup', servingSize: 158),
      FoodItem(id: 'g2', name: 'Roti (Chapati)', caloriesPer100g: 297, proteinPer100g: 8.7, carbsPer100g: 50, fatPer100g: 7.5, category: 'Grains', servingUnit: 'piece', servingSize: 40),
      FoodItem(id: 'g3', name: 'Bread (Whole Wheat)', caloriesPer100g: 247, proteinPer100g: 13, carbsPer100g: 41, fatPer100g: 3.4, category: 'Grains', servingUnit: 'slice', servingSize: 32),
      FoodItem(id: 'g4', name: 'Oats', caloriesPer100g: 389, proteinPer100g: 17, carbsPer100g: 66, fatPer100g: 7, category: 'Grains', servingUnit: 'cup', servingSize: 40),
      FoodItem(id: 'g5', name: 'Paratha', caloriesPer100g: 326, proteinPer100g: 7, carbsPer100g: 45, fatPer100g: 13, category: 'Grains', servingUnit: 'piece', servingSize: 80),

      // Dairy
      FoodItem(id: 'd1', name: 'Milk (Full Cream)', caloriesPer100g: 61, proteinPer100g: 3.2, carbsPer100g: 4.8, fatPer100g: 3.3, category: 'Dairy', servingUnit: 'glass', servingSize: 244),
      FoodItem(id: 'd2', name: 'Yogurt', caloriesPer100g: 59, proteinPer100g: 10, carbsPer100g: 3.6, fatPer100g: 0.4, category: 'Dairy', servingUnit: 'cup', servingSize: 170),
      FoodItem(id: 'd3', name: 'Cheese Slice', caloriesPer100g: 402, proteinPer100g: 25, carbsPer100g: 1.3, fatPer100g: 33, category: 'Dairy', servingUnit: 'slice', servingSize: 28),
      FoodItem(id: 'd4', name: 'Lassi', caloriesPer100g: 60, proteinPer100g: 2.5, carbsPer100g: 9, fatPer100g: 1.5, category: 'Dairy', servingUnit: 'glass', servingSize: 250),

      // Desi Food
      FoodItem(id: 'ds1', name: 'Biryani', caloriesPer100g: 140, proteinPer100g: 5, carbsPer100g: 16, fatPer100g: 6, category: 'Desi Food', servingUnit: 'plate', servingSize: 250),
      FoodItem(id: 'ds2', name: 'Nihari', caloriesPer100g: 150, proteinPer100g: 12, carbsPer100g: 5, fatPer100g: 9, category: 'Desi Food', servingUnit: 'bowl', servingSize: 300),
      FoodItem(id: 'ds3', name: 'Chicken Karahi', caloriesPer100g: 180, proteinPer100g: 15, carbsPer100g: 4, fatPer100g: 12, category: 'Desi Food', servingUnit: 'bowl', servingSize: 200),
      FoodItem(id: 'ds4', name: 'Haleem', caloriesPer100g: 120, proteinPer100g: 8, carbsPer100g: 14, fatPer100g: 4, category: 'Desi Food', servingUnit: 'bowl', servingSize: 250),
      FoodItem(id: 'ds5', name: 'Aloo Gosht', caloriesPer100g: 130, proteinPer100g: 10, carbsPer100g: 8, fatPer100g: 7, category: 'Desi Food', servingUnit: 'bowl', servingSize: 250),
      FoodItem(id: 'ds6', name: 'Samosa', caloriesPer100g: 262, proteinPer100g: 5, carbsPer100g: 25, fatPer100g: 16, category: 'Desi Food', servingUnit: 'piece', servingSize: 100),

      // Fast Food
      FoodItem(id: 'ff1', name: 'Burger', caloriesPer100g: 295, proteinPer100g: 17, carbsPer100g: 24, fatPer100g: 14, category: 'Fast Food', servingUnit: 'piece', servingSize: 120),
      FoodItem(id: 'ff2', name: 'Pizza Slice', caloriesPer100g: 266, proteinPer100g: 11, carbsPer100g: 33, fatPer100g: 10, category: 'Fast Food', servingUnit: 'slice', servingSize: 107),
      FoodItem(id: 'ff3', name: 'French Fries', caloriesPer100g: 312, proteinPer100g: 3.4, carbsPer100g: 41, fatPer100g: 15, category: 'Fast Food', servingUnit: 'serving', servingSize: 117),
      FoodItem(id: 'ff4', name: 'Shawarma', caloriesPer100g: 200, proteinPer100g: 14, carbsPer100g: 18, fatPer100g: 8, category: 'Fast Food', servingUnit: 'piece', servingSize: 200),

      // Drinks
      FoodItem(id: 'dr1', name: 'Green Tea', caloriesPer100g: 1, proteinPer100g: 0, carbsPer100g: 0, fatPer100g: 0, category: 'Drinks', servingUnit: 'cup', servingSize: 240),
      FoodItem(id: 'dr2', name: 'Orange Juice', caloriesPer100g: 45, proteinPer100g: 0.7, carbsPer100g: 10, fatPer100g: 0.2, category: 'Drinks', servingUnit: 'glass', servingSize: 248),
      FoodItem(id: 'dr3', name: 'Cola', caloriesPer100g: 42, proteinPer100g: 0, carbsPer100g: 11, fatPer100g: 0, category: 'Drinks', servingUnit: 'can', servingSize: 330),
      FoodItem(id: 'dr4', name: 'Chai (Tea)', caloriesPer100g: 30, proteinPer100g: 1, carbsPer100g: 4, fatPer100g: 1, category: 'Drinks', servingUnit: 'cup', servingSize: 200),

      // Snacks
      FoodItem(id: 's1', name: 'Almonds', caloriesPer100g: 579, proteinPer100g: 21, carbsPer100g: 22, fatPer100g: 50, category: 'Snacks', servingUnit: '10 pcs', servingSize: 14),
      FoodItem(id: 's2', name: 'Biscuit', caloriesPer100g: 480, proteinPer100g: 6, carbsPer100g: 65, fatPer100g: 22, category: 'Snacks', servingUnit: 'piece', servingSize: 8),
      FoodItem(id: 's3', name: 'Dates', caloriesPer100g: 277, proteinPer100g: 1.8, carbsPer100g: 75, fatPer100g: 0.2, category: 'Snacks', servingUnit: 'piece', servingSize: 24),
      FoodItem(id: 's4', name: 'Peanuts', caloriesPer100g: 567, proteinPer100g: 26, carbsPer100g: 16, fatPer100g: 49, category: 'Snacks', servingUnit: 'handful', servingSize: 28),
    ];
  }

  static List<Recipe> getRecipes() {
    return [
      Recipe(
        id: 'r1', name: 'Oatmeal Bowl', cuisine: 'Continental', dietType: 'veg', mealType: 'breakfast',
        prepTimeMinutes: 5, cookTimeMinutes: 10, servings: 1,
        ingredients: ['1/2 cup Oats', '1 cup Milk', '1 tbsp Honey', '1 Banana (sliced)', 'Handful of Almonds'],
        steps: ['Boil milk in a pan.', 'Add oats and stir for 3-4 minutes.', 'Pour into bowl, add honey.', 'Top with banana slices and almonds.'],
        caloriesPerServing: 350, proteinPerServing: 12, carbsPerServing: 55, fatPerServing: 10,
      ),
      Recipe(
        id: 'r2', name: 'Egg Omelette', cuisine: 'Continental', dietType: 'non-veg', mealType: 'breakfast',
        prepTimeMinutes: 5, cookTimeMinutes: 5, servings: 1,
        ingredients: ['2 Eggs', '1/4 Onion (chopped)', '1 Tomato (chopped)', 'Salt & Pepper', '1 tsp Oil'],
        steps: ['Beat eggs with salt and pepper.', 'Heat oil in pan.', 'Add onion and tomato, saute 1 min.', 'Pour egg mixture, cook until set.', 'Fold and serve.'],
        caloriesPerServing: 220, proteinPerServing: 14, carbsPerServing: 4, fatPerServing: 16,
      ),
      Recipe(
        id: 'r3', name: 'Paratha with Yogurt', cuisine: 'Pakistani', dietType: 'veg', mealType: 'breakfast',
        prepTimeMinutes: 15, cookTimeMinutes: 15, servings: 2,
        ingredients: ['2 cups Wheat Flour', 'Water', 'Salt', '2 tbsp Oil/Ghee', '1 cup Yogurt'],
        steps: ['Knead dough with flour, water and salt.', 'Divide into balls, roll out each one.', 'Apply oil, fold and roll again.', 'Cook on tawa with oil until golden on both sides.', 'Serve hot with yogurt.'],
        caloriesPerServing: 380, proteinPerServing: 10, carbsPerServing: 52, fatPerServing: 14,
      ),
      Recipe(
        id: 'r4', name: 'Fruit Smoothie', cuisine: 'Continental', dietType: 'veg', mealType: 'breakfast',
        prepTimeMinutes: 5, cookTimeMinutes: 0, servings: 1,
        ingredients: ['1 Banana', '1/2 cup Strawberries', '1 cup Milk', '1 tbsp Honey', 'Ice cubes'],
        steps: ['Add all ingredients to blender.', 'Blend until smooth.', 'Pour into glass and serve.'],
        caloriesPerServing: 250, proteinPerServing: 8, carbsPerServing: 48, fatPerServing: 4,
      ),
      Recipe(
        id: 'r5', name: 'Grilled Chicken Salad', cuisine: 'Continental', dietType: 'non-veg', mealType: 'lunch',
        prepTimeMinutes: 10, cookTimeMinutes: 15, servings: 1,
        ingredients: ['150g Chicken Breast', 'Mixed Salad Leaves', '1 Tomato', '1/2 Cucumber', '1 tbsp Olive Oil', 'Lemon juice', 'Salt & Pepper'],
        steps: ['Season chicken with salt, pepper and lemon.', 'Grill chicken for 6-7 min each side.', 'Chop vegetables and arrange on plate.', 'Slice chicken and place on top.', 'Drizzle olive oil and lemon juice.'],
        caloriesPerServing: 320, proteinPerServing: 35, carbsPerServing: 10, fatPerServing: 15,
      ),
      Recipe(
        id: 'r6', name: 'Daal Chawal', cuisine: 'Pakistani', dietType: 'veg', mealType: 'lunch',
        prepTimeMinutes: 10, cookTimeMinutes: 30, servings: 2,
        ingredients: ['1 cup Masoor Daal', '1 cup Rice', '1 Onion', '2 Tomatoes', 'Turmeric, Salt, Chili', '2 tbsp Oil', 'Coriander leaves'],
        steps: ['Wash and soak daal for 15 min.', 'Boil daal with turmeric and salt until soft.', 'Heat oil, add onion and fry until golden.', 'Add tomatoes and spices, cook 5 min.', 'Add boiled daal, simmer 10 min.', 'Cook rice separately. Serve together.'],
        caloriesPerServing: 420, proteinPerServing: 18, carbsPerServing: 65, fatPerServing: 10,
      ),
      Recipe(
        id: 'r7', name: 'Chicken Biryani', cuisine: 'Pakistani', dietType: 'non-veg', mealType: 'lunch',
        prepTimeMinutes: 30, cookTimeMinutes: 45, servings: 4,
        ingredients: ['500g Chicken', '2 cups Basmati Rice', '2 Onions', '1 cup Yogurt', 'Biryani Masala', 'Oil, Salt', 'Saffron in milk', 'Coriander & Mint'],
        steps: ['Marinate chicken with yogurt and spices for 30 min.', 'Soak rice for 20 min, then parboil.', 'Fry onions until golden brown.', 'Layer: chicken, then rice, then fried onions.', 'Add saffron milk on top.', 'Cover and cook on low flame for 25 min.'],
        caloriesPerServing: 450, proteinPerServing: 28, carbsPerServing: 50, fatPerServing: 15,
      ),
      Recipe(
        id: 'r8', name: 'Vegetable Stir Fry', cuisine: 'Chinese', dietType: 'veg', mealType: 'lunch',
        prepTimeMinutes: 10, cookTimeMinutes: 10, servings: 2,
        ingredients: ['1 cup Broccoli', '1 Carrot', '1 Capsicum', '1/2 cup Mushrooms', '2 tbsp Soy Sauce', '1 tbsp Oil', 'Garlic, Ginger'],
        steps: ['Chop all vegetables.', 'Heat oil in wok, add garlic and ginger.', 'Add vegetables, stir fry on high heat 5 min.', 'Add soy sauce, toss well.', 'Serve hot with rice.'],
        caloriesPerServing: 150, proteinPerServing: 5, carbsPerServing: 18, fatPerServing: 7,
      ),
      Recipe(
        id: 'r9', name: 'Grilled Fish', cuisine: 'Continental', dietType: 'non-veg', mealType: 'dinner',
        prepTimeMinutes: 10, cookTimeMinutes: 15, servings: 1,
        ingredients: ['150g Fish Fillet', 'Lemon juice', 'Garlic powder', 'Salt & Pepper', '1 tbsp Olive Oil', 'Herbs (optional)'],
        steps: ['Marinate fish with lemon, garlic, salt and pepper.', 'Heat oil in pan or grill.', 'Cook fish 5-6 min each side.', 'Serve with lemon wedge and salad.'],
        caloriesPerServing: 280, proteinPerServing: 32, carbsPerServing: 2, fatPerServing: 14,
      ),
      Recipe(
        id: 'r10', name: 'Chicken Karahi', cuisine: 'Pakistani', dietType: 'non-veg', mealType: 'dinner',
        prepTimeMinutes: 15, cookTimeMinutes: 30, servings: 3,
        ingredients: ['500g Chicken', '3 Tomatoes', '2 Green Chilies', 'Ginger, Garlic paste', 'Salt, Red Chili, Coriander powder', '3 tbsp Oil', 'Fresh Coriander'],
        steps: ['Heat oil in karahi/wok.', 'Add chicken, fry on high heat 5 min.', 'Add ginger garlic paste.', 'Add chopped tomatoes and all spices.', 'Cook on medium heat until chicken is tender.', 'Garnish with green chilies and coriander.'],
        caloriesPerServing: 350, proteinPerServing: 30, carbsPerServing: 8, fatPerServing: 22,
      ),
      Recipe(
        id: 'r11', name: 'Lentil Soup', cuisine: 'Continental', dietType: 'veg', mealType: 'dinner',
        prepTimeMinutes: 10, cookTimeMinutes: 25, servings: 2,
        ingredients: ['1 cup Red Lentils', '1 Onion', '1 Carrot', '2 cloves Garlic', '4 cups Water', 'Cumin, Salt, Pepper', '1 tbsp Olive Oil'],
        steps: ['Heat oil, saute onion and garlic.', 'Add chopped carrot, cook 2 min.', 'Add lentils, water and spices.', 'Bring to boil, then simmer 20 min.', 'Blend partially for creamy texture.'],
        caloriesPerServing: 280, proteinPerServing: 18, carbsPerServing: 42, fatPerServing: 5,
      ),
      Recipe(
        id: 'r12', name: 'Vegetable Curry with Roti', cuisine: 'Pakistani', dietType: 'veg', mealType: 'dinner',
        prepTimeMinutes: 15, cookTimeMinutes: 20, servings: 2,
        ingredients: ['1 Potato', '1 cup Peas', '1 Carrot', '1 Onion', '2 Tomatoes', 'Curry powder, Salt', '2 tbsp Oil', '4 Rotis'],
        steps: ['Chop all vegetables.', 'Heat oil, fry onion until golden.', 'Add tomatoes and spices, cook 3 min.', 'Add potato and carrot with water.', 'Cover and cook until tender.', 'Add peas, cook 5 more min. Serve with roti.'],
        caloriesPerServing: 400, proteinPerServing: 12, carbsPerServing: 62, fatPerServing: 12,
      ),
      Recipe(
        id: 'r13', name: 'Greek Yogurt Parfait', cuisine: 'Continental', dietType: 'veg', mealType: 'snack',
        prepTimeMinutes: 5, cookTimeMinutes: 0, servings: 1,
        ingredients: ['1 cup Yogurt', '1/4 cup Granola', 'Handful of Berries', '1 tbsp Honey'],
        steps: ['Layer yogurt in a glass.', 'Add granola layer.', 'Add berries on top.', 'Drizzle honey. Serve chilled.'],
        caloriesPerServing: 220, proteinPerServing: 15, carbsPerServing: 30, fatPerServing: 5,
      ),
      Recipe(
        id: 'r14', name: 'Fruit Salad', cuisine: 'Continental', dietType: 'veg', mealType: 'snack',
        prepTimeMinutes: 10, cookTimeMinutes: 0, servings: 2,
        ingredients: ['1 Apple', '1 Banana', '1 Orange', '10 Grapes', '1 tbsp Lemon juice', 'Pinch of Chaat Masala'],
        steps: ['Wash and chop all fruits.', 'Mix in a bowl.', 'Add lemon juice and chaat masala.', 'Toss gently and serve.'],
        caloriesPerServing: 150, proteinPerServing: 2, carbsPerServing: 38, fatPerServing: 0.5,
      ),
      Recipe(
        id: 'r15', name: 'Protein Shake', cuisine: 'Continental', dietType: 'veg', mealType: 'snack',
        prepTimeMinutes: 5, cookTimeMinutes: 0, servings: 1,
        ingredients: ['1 cup Milk', '1 Banana', '2 tbsp Peanut Butter', '1 tbsp Honey', 'Ice cubes'],
        steps: ['Add all ingredients to blender.', 'Blend until smooth and creamy.', 'Pour into glass and serve.'],
        caloriesPerServing: 380, proteinPerServing: 16, carbsPerServing: 45, fatPerServing: 18,
      ),
      Recipe(
        id: 'r16', name: 'Avocado Toast', cuisine: 'Continental', dietType: 'veg', mealType: 'breakfast',
        prepTimeMinutes: 5, cookTimeMinutes: 3, servings: 1,
        ingredients: ['2 slices Whole Wheat Bread', '1 Avocado', 'Lemon juice', 'Salt & Pepper', 'Red Chili Flakes'],
        steps: ['Toast the bread slices.', 'Mash avocado with lemon, salt and pepper.', 'Spread on toast.', 'Sprinkle chili flakes on top.'],
        caloriesPerServing: 320, proteinPerServing: 8, carbsPerServing: 35, fatPerServing: 18,
      ),
      Recipe(
        id: 'r17', name: 'Daal Mash', cuisine: 'Pakistani', dietType: 'veg', mealType: 'dinner',
        prepTimeMinutes: 10, cookTimeMinutes: 30, servings: 3,
        ingredients: ['1 cup Mash Daal', '1 Onion', '2 Tomatoes', 'Green Chilies', 'Turmeric, Salt, Red Chili', '2 tbsp Ghee', 'Cumin seeds'],
        steps: ['Wash daal and boil until soft.', 'Heat ghee, add cumin seeds.', 'Add onion, fry golden.', 'Add tomatoes, chilies and spices.', 'Add boiled daal, mash and mix well.', 'Simmer 10 min. Garnish with coriander.'],
        caloriesPerServing: 300, proteinPerServing: 16, carbsPerServing: 40, fatPerServing: 8,
      ),
      Recipe(
        id: 'r18', name: 'Chapli Kebab', cuisine: 'Pakistani', dietType: 'non-veg', mealType: 'dinner',
        prepTimeMinutes: 20, cookTimeMinutes: 15, servings: 4,
        ingredients: ['500g Minced Beef', '1 Onion (chopped)', '2 Tomatoes (chopped)', 'Green Chilies', 'Coriander, Cumin, Salt', '1 Egg', 'Oil for frying'],
        steps: ['Mix mince with all ingredients and egg.', 'Make flat round patties.', 'Heat oil in pan.', 'Shallow fry kebabs 3-4 min each side.', 'Serve hot with naan and chutney.'],
        caloriesPerServing: 320, proteinPerServing: 25, carbsPerServing: 8, fatPerServing: 20,
      ),
      Recipe(
        id: 'r19', name: 'Hummus with Veggies', cuisine: 'Middle Eastern', dietType: 'veg', mealType: 'snack',
        prepTimeMinutes: 10, cookTimeMinutes: 0, servings: 2,
        ingredients: ['1 can Chickpeas', '2 tbsp Tahini', '1 clove Garlic', 'Lemon juice', 'Olive Oil', 'Carrot & Cucumber sticks'],
        steps: ['Blend chickpeas, tahini, garlic and lemon.', 'Add olive oil while blending until smooth.', 'Transfer to bowl.', 'Serve with veggie sticks.'],
        caloriesPerServing: 200, proteinPerServing: 8, carbsPerServing: 22, fatPerServing: 10,
      ),
      Recipe(
        id: 'r20', name: 'Banana Berry Smoothie', cuisine: 'Continental', dietType: 'veg', mealType: 'snack',
        prepTimeMinutes: 5, cookTimeMinutes: 0, servings: 1,
        ingredients: ['1 Banana', '1/2 cup Mixed Berries', '1 cup Yogurt', '1 tbsp Honey'],
        steps: ['Add all ingredients to blender.', 'Blend until smooth.', 'Pour and serve chilled.'],
        caloriesPerServing: 230, proteinPerServing: 10, carbsPerServing: 45, fatPerServing: 2,
      ),
    ];
  }

  static List<DietPlan> getDietPlans() {
    return [
      DietPlan(
        id: 'plan1', planName: 'Balanced', description: 'A well-rounded plan with all food groups for steady energy and health.',
        days: _generateBalancedPlan(),
      ),
      DietPlan(
        id: 'plan2', planName: 'High Protein', description: 'Focus on protein-rich foods for muscle building and recovery.',
        days: _generateHighProteinPlan(),
      ),
      DietPlan(
        id: 'plan3', planName: 'Low Carb', description: 'Reduced carbohydrate intake for effective weight management.',
        days: _generateLowCarbPlan(),
      ),
      DietPlan(
        id: 'plan4', planName: 'Vegetarian', description: 'Plant-based meals with dairy for complete nutrition without meat.',
        days: _generateVegetarianPlan(),
      ),
      DietPlan(
        id: 'plan5', planName: 'Desi Healthy', description: 'Traditional Pakistani meals made healthier with balanced portions.',
        days: _generateDesiPlan(),
      ),
    ];
  }

  static List<DayPlan> _generateBalancedPlan() {
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    final breakfasts = [
      PlanMeal(mealType: 'breakfast', recipeName: 'Oatmeal Bowl', calories: 350, protein: 12, carbs: 55, fat: 10),
      PlanMeal(mealType: 'breakfast', recipeName: 'Egg Omelette', calories: 220, protein: 14, carbs: 4, fat: 16),
      PlanMeal(mealType: 'breakfast', recipeName: 'Avocado Toast', calories: 320, protein: 8, carbs: 35, fat: 18),
      PlanMeal(mealType: 'breakfast', recipeName: 'Paratha with Yogurt', calories: 380, protein: 10, carbs: 52, fat: 14),
      PlanMeal(mealType: 'breakfast', recipeName: 'Fruit Smoothie', calories: 250, protein: 8, carbs: 48, fat: 4),
      PlanMeal(mealType: 'breakfast', recipeName: 'Oatmeal Bowl', calories: 350, protein: 12, carbs: 55, fat: 10),
      PlanMeal(mealType: 'breakfast', recipeName: 'Egg Omelette', calories: 220, protein: 14, carbs: 4, fat: 16),
    ];
    final lunches = [
      PlanMeal(mealType: 'lunch', recipeName: 'Grilled Chicken Salad', calories: 320, protein: 35, carbs: 10, fat: 15),
      PlanMeal(mealType: 'lunch', recipeName: 'Daal Chawal', calories: 420, protein: 18, carbs: 65, fat: 10),
      PlanMeal(mealType: 'lunch', recipeName: 'Vegetable Stir Fry', calories: 150, protein: 5, carbs: 18, fat: 7),
      PlanMeal(mealType: 'lunch', recipeName: 'Chicken Biryani', calories: 450, protein: 28, carbs: 50, fat: 15),
      PlanMeal(mealType: 'lunch', recipeName: 'Grilled Chicken Salad', calories: 320, protein: 35, carbs: 10, fat: 15),
      PlanMeal(mealType: 'lunch', recipeName: 'Daal Chawal', calories: 420, protein: 18, carbs: 65, fat: 10),
      PlanMeal(mealType: 'lunch', recipeName: 'Vegetable Stir Fry', calories: 150, protein: 5, carbs: 18, fat: 7),
    ];
    final dinners = [
      PlanMeal(mealType: 'dinner', recipeName: 'Grilled Fish', calories: 280, protein: 32, carbs: 2, fat: 14),
      PlanMeal(mealType: 'dinner', recipeName: 'Chicken Karahi', calories: 350, protein: 30, carbs: 8, fat: 22),
      PlanMeal(mealType: 'dinner', recipeName: 'Lentil Soup', calories: 280, protein: 18, carbs: 42, fat: 5),
      PlanMeal(mealType: 'dinner', recipeName: 'Vegetable Curry with Roti', calories: 400, protein: 12, carbs: 62, fat: 12),
      PlanMeal(mealType: 'dinner', recipeName: 'Grilled Fish', calories: 280, protein: 32, carbs: 2, fat: 14),
      PlanMeal(mealType: 'dinner', recipeName: 'Daal Mash', calories: 300, protein: 16, carbs: 40, fat: 8),
      PlanMeal(mealType: 'dinner', recipeName: 'Chicken Karahi', calories: 350, protein: 30, carbs: 8, fat: 22),
    ];
    final snacks = [
      PlanMeal(mealType: 'snack', recipeName: 'Greek Yogurt Parfait', calories: 220, protein: 15, carbs: 30, fat: 5),
      PlanMeal(mealType: 'snack', recipeName: 'Fruit Salad', calories: 150, protein: 2, carbs: 38, fat: 0.5),
      PlanMeal(mealType: 'snack', recipeName: 'Protein Shake', calories: 380, protein: 16, carbs: 45, fat: 18),
      PlanMeal(mealType: 'snack', recipeName: 'Fruit Salad', calories: 150, protein: 2, carbs: 38, fat: 0.5),
      PlanMeal(mealType: 'snack', recipeName: 'Greek Yogurt Parfait', calories: 220, protein: 15, carbs: 30, fat: 5),
      PlanMeal(mealType: 'snack', recipeName: 'Banana Berry Smoothie', calories: 230, protein: 10, carbs: 45, fat: 2),
      PlanMeal(mealType: 'snack', recipeName: 'Hummus with Veggies', calories: 200, protein: 8, carbs: 22, fat: 10),
    ];

    return List.generate(7, (i) => DayPlan(
      dayName: days[i],
      meals: [breakfasts[i], lunches[i], dinners[i], snacks[i]],
    ));
  }

  static List<DayPlan> _generateHighProteinPlan() {
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return List.generate(7, (i) => DayPlan(dayName: days[i], meals: [
      PlanMeal(mealType: 'breakfast', recipeName: 'Egg Omelette', calories: 220, protein: 14, carbs: 4, fat: 16),
      PlanMeal(mealType: 'lunch', recipeName: 'Grilled Chicken Salad', calories: 320, protein: 35, carbs: 10, fat: 15),
      PlanMeal(mealType: 'dinner', recipeName: 'Grilled Fish', calories: 280, protein: 32, carbs: 2, fat: 14),
      PlanMeal(mealType: 'snack', recipeName: 'Protein Shake', calories: 380, protein: 16, carbs: 45, fat: 18),
    ]));
  }

  static List<DayPlan> _generateLowCarbPlan() {
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return List.generate(7, (i) => DayPlan(dayName: days[i], meals: [
      PlanMeal(mealType: 'breakfast', recipeName: 'Egg Omelette', calories: 220, protein: 14, carbs: 4, fat: 16),
      PlanMeal(mealType: 'lunch', recipeName: 'Grilled Chicken Salad', calories: 320, protein: 35, carbs: 10, fat: 15),
      PlanMeal(mealType: 'dinner', recipeName: 'Chicken Karahi', calories: 350, protein: 30, carbs: 8, fat: 22),
      PlanMeal(mealType: 'snack', recipeName: 'Hummus with Veggies', calories: 200, protein: 8, carbs: 22, fat: 10),
    ]));
  }

  static List<DayPlan> _generateVegetarianPlan() {
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return List.generate(7, (i) => DayPlan(dayName: days[i], meals: [
      PlanMeal(mealType: 'breakfast', recipeName: 'Oatmeal Bowl', calories: 350, protein: 12, carbs: 55, fat: 10),
      PlanMeal(mealType: 'lunch', recipeName: 'Daal Chawal', calories: 420, protein: 18, carbs: 65, fat: 10),
      PlanMeal(mealType: 'dinner', recipeName: 'Vegetable Curry with Roti', calories: 400, protein: 12, carbs: 62, fat: 12),
      PlanMeal(mealType: 'snack', recipeName: 'Fruit Salad', calories: 150, protein: 2, carbs: 38, fat: 0.5),
    ]));
  }

  static List<DayPlan> _generateDesiPlan() {
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return List.generate(7, (i) => DayPlan(dayName: days[i], meals: [
      PlanMeal(mealType: 'breakfast', recipeName: 'Paratha with Yogurt', calories: 380, protein: 10, carbs: 52, fat: 14),
      PlanMeal(mealType: 'lunch', recipeName: 'Chicken Biryani', calories: 450, protein: 28, carbs: 50, fat: 15),
      PlanMeal(mealType: 'dinner', recipeName: 'Daal Mash', calories: 300, protein: 16, carbs: 40, fat: 8),
      PlanMeal(mealType: 'snack', recipeName: 'Banana Berry Smoothie', calories: 230, protein: 10, carbs: 45, fat: 2),
    ]));
  }

  static List<ReminderModel> getDefaultReminders() {
    return [
      ReminderModel(id: 'rem1', title: 'Breakfast Time', type: 'meal', hour: 8, minute: 0, repeatDays: [1,2,3,4,5,6,7]),
      ReminderModel(id: 'rem2', title: 'Lunch Time', type: 'meal', hour: 13, minute: 0, repeatDays: [1,2,3,4,5,6,7]),
      ReminderModel(id: 'rem3', title: 'Dinner Time', type: 'meal', hour: 19, minute: 0, repeatDays: [1,2,3,4,5,6,7]),
      ReminderModel(id: 'rem4', title: 'Drink Water', type: 'water', hour: 10, minute: 0, repeatDays: [1,2,3,4,5,6,7]),
      ReminderModel(id: 'rem5', title: 'Weekly Weigh-in', type: 'weigh_in', hour: 7, minute: 0, repeatDays: [1]),
    ];
  }
}
