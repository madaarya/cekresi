module Cekresi
  class Parser
    def self.parse(container_result)
      expedition_name = container_result.find(".top_title").text
      tracking_number_info = container_result.all(".table-responsive")
      delivery_info = tracking_number_info[0]

      delivery_status_data, delivery_info_data = {}, {}
      delivery_info.all("tr").each do |item|
        hash_el = item.text.split(" : ")
        key_name = parse_info_attribute(hash_el)
        delivery_info_data[key_name.to_sym] = hash_el.last
      end

      tracking_number_info.each_with_index do |tracking_number, index|
        unless index.zero?
          key_name = tracking_number.find("b").text.tr(" ","_").downcase
          tracking_data = []
          tracking_number.all('tr').each_with_index do |list, tracking_number_index|
            unless tracking_number_index.zero?
              tracking_list_data = list.all('td')
              tracking_data << {shipment_date: tracking_list_data[0].text, shipment_location: tracking_list_data[1].text, shipment_status: tracking_list_data[2].text}
            end
          end
          delivery_status_data[key_name.to_sym] = tracking_data
        end
      end

      return {status: :ok, expedition_name: expedition_name, delivery_info: delivery_info_data, delivery_status: delivery_status_data}
    end

    
    def self.parse_info_attribute(info)
      new_key = info.first.tr(" ","_").downcase
      case new_key
      when "no_resi"
        new_key = 'tracking_number'
      when 'dikirim_tanggal'
        new_key = 'sent_time'
      when 'dikirim_oleh'
        new_key = 'sender'
      when 'dikirim_ke'
        new_key = 'receiver'
      end
      new_key
    end 

  end
end