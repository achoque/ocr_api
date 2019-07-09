require 'ocr_space/file_post'
module OcrSpace
    module Convert
        def convert(apikey: @api_key, language: 'eng', isOverlayRequired: false, file: nil, url: nil, endpoint: nil, extra_params: {})
          if file
            @files = File.new(file)
            @data = OcrSpace::FilePost.post('/parse/image',
                                            body: { apikey: apikey,
                                                    language: language,
                                                    isOverlayRequired: isOverlayRequired,
                                                    file: @files }.merge(extra_params))
            @data = @data.parsed_response['ParsedResults']
          elsif url
            endpoint = endpoint || "https://api.ocr.space/parse/image"
            @data = HTTParty.post(endpoint,
                                  body: { apikey: apikey,
                                          language: language,
                                          isOverlayRequired: isOverlayRequired,
                                          url: url }.merge(extra_params))
            @data = @data.parsed_response['ParsedResults']
          else
            "You need to Pass either file or url."
          end
        end

        def clean_convert(apikey: @api_key, language: 'eng', isOverlayRequired: false, file: nil, url: nil, endpoint: nil, extra_params: {})
          if file
            @files = File.new(file)
            @data = OcrSpace::FilePost.post('/parse/image',
                                            body: { apikey: apikey,
                                                    language: language,
                                                    isOverlayRequired: isOverlayRequired,
                                                    file: @files }.merge(extra_params))
            @data = @data.parsed_response['ParsedResults'][0]["ParsedText"].gsub(/\r|\n/, "")
          elsif url
            endpoint = endpoint || "https://api.ocr.space/parse/image"
            @data = HTTParty.post(endpoint,
                                  body: { apikey: apikey,
                                          language: language,
                                          isOverlayRequired: isOverlayRequired,
                                          url: url }.merge(extra_params))
            @data = @data.parsed_response['ParsedResults'][0]["ParsedText"].gsub(/\r|\n/, "")
          else
            "You need to Pass either file or url."
          end
        end
    end
end
