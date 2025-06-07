# Servicio para consultar la API de RAWG y obtener información de un videojuego por nombre
require 'net/http'
require 'json'

class RawgApiService
  BASE_URL = 'https://api.rawg.io/api/games'

  def initialize(api_key)
    @api_key = api_key
  end

  # Busca un juego por nombre y retorna los datos principales
  def search_game(game_name)
    encoded_name = URI.encode_www_form_component(game_name)
    url = URI("#{BASE_URL}?search=#{encoded_name}&key=#{@api_key}")
    response = Net::HTTP.get(url)
    data = JSON.parse(response)
    return nil if data['results'].blank?
    game = data['results'].first
    {
      slug: game['slug'],
      name: game['name'],
      released: game['released'],
      rating: game['rating'],
      ratings_count: game['ratings_count'],
      background_image: game['background_image'],
      description: fetch_game_description(game['id'])
    }
  end

  private

  # Obtiene la descripción completa del juego por ID
  def fetch_game_description(game_id)
    url = URI("#{BASE_URL}/#{game_id}?key=#{@api_key}")
    response = Net::HTTP.get_response(url)
    if response.is_a?(Net::HTTPSuccess)
      data = JSON.parse(response.body)
      data['description_raw'] || ''
    else
      Rails.logger.warn "RAWG API error: \\#{response.code} \\#{response.message} - \\#{response.body.truncate(200)}"
      ''
    end
  rescue JSON::ParserError => e
    Rails.logger.error "RAWG API JSON parse error: \\#{e.message} - Body: \\#{response&.body&.truncate(200)}"
    ''
  end
end
