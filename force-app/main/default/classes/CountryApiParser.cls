/**
 * @Author       : Mohammad Arafat Ali
 * @Description  : Wrapper parser for FetchCountryInformation class
 * @Date         : 05-18-2025
**/

public class CountryApiParser {
        public String name;
        public String alpha2Code;
        public String alpha3Code;
        public String capital;
        public String region;
        public List<RegionalBloc> regionalBlocs;
    

    public class RegionalBloc {
        public String acronym;
    }

    public static List<CountryApiParser> parse(String json) {
		return (List<CountryApiParser>) System.JSON.deserialize(json, List<CountryApiParser>.class);
	}
}