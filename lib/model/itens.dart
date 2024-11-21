class Itens {
  final String cod;
  final String foto;

  Itens(
    this.cod, 
    this.foto,
  );

  static List<Itens> gerarDados() {
    return [
      Itens('1','lib/images/bruschetta.jpg'),
      Itens('2','lib/images/dadinhodelegumes.jpg'),
      Itens('3','lib/images/bolinhodebacalhau.jpg'),
      Itens('4','lib/images/fileaparmegiana.jpg'),
      Itens('5','lib/images/risotodecamarao.jpg'),
      Itens('6','lib/images/lasanhabolonhesa.jpg'),
      Itens('7','lib/images/petitgateau.jpg'),
      Itens('8','lib/images/cheesecakefrutasvermelhas.jpg'),
      Itens('9','lib/images/pudimdeleite.jpg'),
    ];
  }
}