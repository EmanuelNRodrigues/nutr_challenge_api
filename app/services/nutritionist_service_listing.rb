class NutritionistServiceListing
  BRAGA_COORDINATES = [41.5510583, -8.4280045].freeze
  DEFAULT_LIMIT = 50

  def initialize(query: nil, location_address: nil, limit: DEFAULT_LIMIT)
    @query = query
    @location_address = location_address.to_s.strip
    @limit = limit
  end

  def call
    coordinates = Geocoder.coordinates(@location_address) || BRAGA_COORDINATES
    services_by_nutritionist = ordered_nutritionist_services(coordinates)
                                 .group_by(&:nutritionist_id)
                                 .values
                                 .first(@limit)

    nutritionist_ids = services_by_nutritionist.map do |nutritionist_services|
      nutritionist_services.first.nutritionist_id
    end

    filled_slots_by_nutritionist = FilledSlotsFinder.new(nutritionist_ids).call

    services_by_nutritionist.map do |nutritionist_services|
      nutritionist = nutritionist_services.first.nutritionist

      {
        nutritionist: nutritionist,
        nutritionist_services: nutritionist_services,
        filled_slots: filled_slots_by_nutritionist.fetch(
          nutritionist.id, []
        )
      }
    end
  end

  private

  def ordered_nutritionist_services(coordinates)
    NutritionistServiceDistanceSorter
      .new(matching_nutritionist_services, coordinates)
      .call
  end

  def matching_nutritionist_services
    NutritionistServiceSearch.new(query: @query).call
  end
end