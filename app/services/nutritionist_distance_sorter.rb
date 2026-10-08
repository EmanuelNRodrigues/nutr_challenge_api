class NutritionistDistanceSorter
  def initialize(nutritionists, coordinates)
    @nutritionists = nutritionists
    @coordinates = coordinates
  end

  def call(limit: 50)
    @nutritionists.to_a.sort_by { |nutritionist| closest_distance(nutritionist) }.first(limit)
  end

  private

  def closest_distance(nutritionist)
    nutritionist.nutritionist_services
                 .filter_map do |nutritionist_service|
                   nutritionist_service.location.distance_from(@coordinates)
                 end.min || Float::INFINITY
  end
end