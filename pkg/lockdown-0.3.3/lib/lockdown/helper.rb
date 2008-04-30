module Lockdown
  module Helper
    def syms_from_names(ary)
      rvalue = []
      ary.each{|ar| rvalue << symbolize(ar.name)}
      rvalue
    end

    #
    # If str_sym is a Symbol (:users), give me back "Users"
    # If str_sym is a String ("Users"), give me back :users
    #
    # Was :to_title_sym for String and :to_title_str for Symbol
    #
    def convert_reference_name(str_sym)
      if str_sym.is_a?(Symbol)
        titleize(str_sym)
      else
        underscore(str_sym).tr(' ','_').to_sym
      end
    end

		def string_name(str_sym)
			str_sym.is_a?(Symbol) ? convert_reference_name(str_sym) : str_sym
		end

		def symbol_name(str_sym)
			str_sym.is_a?(String) ? convert_reference_name(str_sym) : str_sym
		end

    def symbolize(str)
      str.downcase.gsub("admin ","admin__").gsub(" ","_").to_sym
    end

    def camelize(str)
      str.to_s.gsub(/\/(.?)/) { "::" + $1.upcase }.gsub(/(^|_)(.)/) { $2.upcase }
    end

    def random_string(len = 10)
      chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
      Array.new(len){||chars[rand(chars.size)]}.join
    end

		def administrator_group_string
			string_name(:administrators)
    end

		def administrator_group_symbol
			:administrators
    end

    private

    def titleize(str)
      humanize(underscore(str)).gsub(/\b([a-z])/) { $1.capitalize }
    end
    
    def humanize(str)
      str.to_s.gsub(/_id$/, "").gsub(/_/, " ").capitalize
    end

    def underscore(str)
      str.to_s.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").downcase
    end
  end
end