class NutritionistServiceSearch
  def initialize(query: nil)
    @query = query.to_s.strip
  end

  def call
    nutritionist_services = NutritionistService.includes(:nutritionist, :service, :location)

    return nutritionist_services if @query.blank?

    nutritionist_services.where(nutritionist_id: matching_nutritionist_ids)
  end

  private

  def matching_nutritionist_ids
    search_pattern = "%#{ActiveRecord::Base.sanitize_sql_like(@query)}%"

    Nutritionist.joins(nutritionist_services: :service)
                .where( "nutritionists.name ILIKE :query OR services.name ILIKE :query",
                        query: search_pattern )
                .distinct
                .pluck(:id)
  end
end