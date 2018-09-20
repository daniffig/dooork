namespace :bus_lines do
  desc "fetch bus lines"
  task fetch: :environment do
    client = Savon.client(wsdl: 'http://clswbsas.smartmovepro.net/ModuloParadas/SWParadas.asmx?WSDL')
  
    # pp client.operations
  
    (1000..2000).each do |code|
      response = client.call(:recuperar_calles_principal_por_linea, message: {
        usuario: 'WEB.UPLATENSE',
        clave: 'PAR.SW.UPLATENSE',
        codigoLineaParada: code,
        isSubLinea: false
      })
    
      data = response.body.dig(:recuperar_calles_principal_por_linea_response, :recuperar_calles_principal_por_linea_result)
  
      json = JSON.parse(data)

      BusLine.create(code: code) if (json['CodigoEstado'] >= 0)
    end
  end

  desc "fetch bus lines main streets"
  task fetch_main_streets: :environment do
    client = Savon.client(wsdl: 'http://clswbsas.smartmovepro.net/ModuloParadas/SWParadas.asmx?WSDL')

    count = 0

    BusLine.all.each do |bus_line|
      response = client.call(:recuperar_calles_principal_por_linea, message: {
        usuario: 'WEB.UPLATENSE',
        clave: 'PAR.SW.UPLATENSE',
        codigoLineaParada: bus_line.code,
        isSubLinea: false
      })

      data = response.body.dig(:recuperar_calles_principal_por_linea_response, :recuperar_calles_principal_por_linea_result)
  
      json = JSON.parse(data)

      if (json['CodigoEstado'] >= 0)
        json.dig('calles').each do |street|
          count = count + 1

          description = street['Descripcion'].match /\A(.+) - (.+)\z/

          MainStreet.create code: street['Codigo'], name: description[1], city: description[2]
        end
      end
    end

    p count
    p MainStreet.count
  end

end