class ItemCompra {
  String nomeItem;
  bool concluido;
  int quantidade;

  ItemCompra({
    required this.nomeItem,
    this.concluido = false,
    required this.quantidade,
  });
}
