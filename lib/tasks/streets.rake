namespace :streets do
  desc "fetch streets"
  task fetch: :environment do
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

          main_street = Street.create(code: street['Codigo'], name: description[1], city: description[2])
        end
      end
    end
  end

  desc "fetch main streets"
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
          bus_line.streets << Street.find_by!(code: street['Codigo'])
        end
      end
    end

  end

end
