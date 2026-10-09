
class NutritionistServiceDistanceSorter
  def initialize(nutritionist_services, coordinates)
    @nutritionist_services = nutritionist_services
    @coordinates = coordinates
    @distance_by_location_id = {}
  end

  # Returns all NutritionistService records ordered from nearest to farthest.
  def call
    @nutritionist_services.to_a.sort_by do |nutritionist_service|
      [
        distance_for(nutritionist_service),
        nutritionist_service.id
      ]
    end
  end

  private

  def distance_for(nutritionist_service)
    location = nutritionist_service.location

    @distance_by_location_id[location.id] ||= begin
                                                if location.latitude && location.longitude
                                                  location.distance_from(@coordinates) || Float::INFINITY
                                                else
                                                  Float::INFINITY
                                                end
                                              end
  end
end