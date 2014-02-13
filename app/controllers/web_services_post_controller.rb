require 'net/http'
require 'rexml/text'
require "rexml/document"
require 'pg'
require 'rest-client'
require 'nokogiri'
include REXML

class WebServicesPostController < ApplicationController

    def web_post
      id_P = params[:idP]
      at_descricao = params[:desc]
      at_data = params[:data]
      at_tipo = params[:tipo]
      at_existe = params[:existe]
      param1 = "NOT OK"
      param2 = "NOT OK"
      param3 = "NOT OK"
      param4 = "NOT OK"
      param5 = "NOT OK"

      if params[:idP]
        predio = Building.where(:idAtlas => id_P).first
        if predio
          predio_Id = predio[:id]
          param1= "OK"
          @vr = "ID do predio: " + predio_Id.to_s
        else
          @vr= "Erro - ID passado do Predio nao existe"
        end
      else
        @vr= "Erro - Nao foi passado o parametro 'idP' - ID do Predio"
      end

      if params[:desc]
        @vr2 = "Descricao: " + at_descricao
        param2= "OK"
      else
        @vr2 = "Erro - Nao foi passado o parametro 'desc' - Descricao do equipamento"
      end

      if params[:data]
        @vr3 = at_data
        if at_data.size!=19
            @vr3 = "Erro - Tamanho incorreto - Formato: dd-mm-aaaa hh-mm-ss"
        else
          if at_data[2] == "-" && at_data[5] == "-" && at_data[13] == "-" && at_data[16] == "-"
            dia = at_data[0,2].to_i
            mes = at_data[3,2].to_i
            ano = at_data[6,4].to_i
            hora = at_data[11,2].to_i
            minuto = at_data[14,2].to_i
            segundo = at_data[17,2].to_i
            if dia > 0 && dia < 32
              if mes > 0 && mes < 13
                if ano < 1700
                  @vr3 = "Erro - Ano incorreto - Formato: dd-mm-aaaa"
                else
                  #at_data = aux[0,2] + "/" + aux[3,2] + "/" + aux[6,4]
                  if hora > 24 || hora < 0
                    @vr3 = "Erro - Hora incorreta"
                  else
                    if minuto < 0 || minuto > 59
                      @vr3 = "Erro - Minuto incorreto"
                    else
                      if segundo < 0 || segundo > 59
                        @vr3 = "Erro - Segundos incorreto"
                      else
                        data_aux = DateTime.new(ano,mes,dia,hora,minuto,segundo)
                        at_datetime = data_aux.to_s(:db)
                        @vr3 = data_aux
                        param3 = "OK"
                      end
                    end
                  end
                end
              else
                @vr3 = "Erro - Mes incorreto - Formato: dd-mm-aaaa hh-mm-ss"
              end
            else
              @vr3 ="Erro - Valor do dia incorreto - Formato: dd-mm-aaaa hh-mm-ss"
            end
          else
            @vr3 = "Erro - Espacamento incorreto, era para usar - - Formato: dd-mm-aaaa hh-mm-ss"
          end
        end
     else
       @vr3 = "Erro - Nao foi passado o parametro 'data' - Data de inspecao - Formato: dd-mm-aaaa hh-mm-ss"
     end

      if params[:tipo]
        equipTipo = EquipType.where(:id => at_tipo).first
        if equipTipo
          nomeEquip = equipTipo[:kind]
          @vr4 = "Tipo: " + at_tipo + " - "+ nomeEquip
          param4 = "OK"
        else
          @vr4= "Erro - Tipo de equipamento passado nao existe"
        end
      else
        @vr4= "Erro - Nao foi passado o parametro 'tipo' - Tipo do equipamento"
      end


      if params[:existe]
        if at_existe == "0"  || at_existe == "1"
          @vr5 = "Existe? " + at_existe
          param5 = "OK"
        else
          @vr5 = "Erro - Parametro 'existe' diferente de 0 e/ou 1"
        end
      else
        @vr5 = "Erro - Nao foi passado o parametro 'existe' - Existencia do equipamento"
      end

      if param1 == "OK" && param4 == "OK" && ((param3 == "OK" && param5 == "OK" && at_existe == "1")||(param5 == "OK" && at_existe == "0"))
        @vr6 = "Cadastrado"
        if at_existe == "1"
          equip = Equipment.new(building_id:predio_Id, name: at_descricao , creation_date: at_datetime , equip_type_id: at_tipo , is_there: at_existe )
        else
          equip = Equipment.new(building_id:predio_Id, name: at_descricao , equip_type_id: at_tipo , is_there: at_existe )
        end


        if Equipment.where("equip_type_id = ? AND building_id = ? AND name = ? AND is_there = ?",at_tipo.to_i, predio_Id,at_descricao, at_existe).length >= 1
          @vr6 = "Erro - Esse equipamento ja foi cadastrado"
        else
          equip.save
        end

        if(at_existe == "1")
        result = Equipment.last.creation_date - Equipment.last.created_at

        if(result > 0)
          Equipment.last.delete
          @vr6 = "Erro - Conflito nos horarios"
        end
      end
      # (result < 0) indica que date1 < date2
      # (result == 0) indica que date1 = date2
      # (result > 0) indica que date1 > date2
      else
        @vr6 = "Corrija os erros"
      end
    end


end