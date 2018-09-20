namespace :bus_lines do
  desc "fetch operations"
  task fetch_operations: :environment do
    client = Savon.client(wsdl: 'http://clswbsas.smartmovepro.net/ModuloParadas/SWParadas.asmx?WSDL')

    pp client.operations
  end
  
  desc "fetch entities"
  task fetch_entities: :environment do
    client = Savon.client(wsdl: 'http://clswbsas.smartmovepro.net/ModuloParadas/SWParadas.asmx?WSDL')

    (0..10).each do |code|
      response = client.call(:recuperar_linea_por_entidad, message: {
        usuario: 'WEB.UPLATENSE',
        clave: 'PAR.SW.UPLATENSE',
        codigoEntidadSMP: code,
        isSublinea: false
      })

      data = response.body.dig(:recuperar_linea_por_entidad_response, :recuperar_linea_por_entidad_result)

      json = JSON.parse(data)

      if (json['CodigoEstado'] >= 0)
        pp json
      end

    end
  end
  
  desc "fetch bus lines"
  task fetch: :environment do
    client = Savon.client(wsdl: 'http://clswbsas.smartmovepro.net/ModuloParadas/SWParadas.asmx?WSDL')  
  
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
          description = street['Descripcion'].match /\A(.+) - (.+)\z/

          main_street = MainStreet.find_or_create_by! code: street['Codigo'], name: description[1], city: description[2]

          bus_line.main_streets << main_street
        end
      end
    end
  end

end
