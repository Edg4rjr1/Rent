class TestPdfController < ApplicationController
    def gerar_pdf
      pdf = Prawn::Document.new
      data = [["Nome", "Idade"], ["João", "30"], ["Maria", "25"]]
      
      # Gerando a tabela
      pdf.table(data, header: true) do
        row(0).font_style = :bold
        columns(0..1).align = :center
      end
      
      send_data pdf.render, filename: "test_pdf.pdf", type: "application/pdf", disposition: "inline"
    end
  end