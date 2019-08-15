class Converter {
  static String doubleToEuro(double value) {
    String euros = value.toString();
    List<String> result = euros.split(".");
    if (result[0].length > 3) {
      result[0] = result[0].substring(0, result[0].length - 3) +
          "." +
          result[0].substring(result[0].length - 3, result[0].length);
    }
    euros = result[0] + "," + result[1];
    if (result[1].length == 1) {
      euros += "0";
    }

    euros += " €";
    return euros;
  }
}
