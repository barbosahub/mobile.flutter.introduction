import 'package:flutter/material.dart';

class Quotation extends StatefulWidget {
  @override
  _QuotationState createState() => _QuotationState();
}

class _QuotationState extends State<Quotation> {
  final TextEditingController _reais = TextEditingController();
  final TextEditingController _dolar = TextEditingController();
  final key = GlobalKey<ScaffoldState>();
  var _resultado = '';

  _onItemTapped(int index) {
    if (index == 0) {
      _reais.clear();
      _dolar.clear();
      setState(() {
        _resultado= '';
      });

    } else if (_reais.text.isEmpty || _dolar.text.isEmpty) {
      key.currentState.showSnackBar(SnackBar(
          content: Text("Campos obrigatórios!")
      ));
    } else {
      var reais = double.parse(_reais.text);
      var dolar = double.parse(_dolar.text);
      var resultado = reais / dolar;
      setState(() {
        _resultado = 'Com ${_reais.text} reais é possível comprar ${resultado.toStringAsFixed(2)} dólares a ${_dolar.text} cada';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text("Cotação do dólar"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
            children: [
            Image.asset('assets/images/icon.png', width: 120),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TextField(
            controller: _reais,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
                hintText: 'Valor em Reais',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                icon: Icon(Icons.account_balance_wallet)),
          ),
        ),
        TextField(
          controller: _dolar,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
              hintText: 'Cotação do Dólar',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              icon: Icon(Icons.attach_money)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text('$_resultado', style: TextStyle(fontSize: 16)),
        )
        ],
    ),
      ),

    bottomNavigationBar: BottomNavigationBar(
    backgroundColor: Colors.blue,
    onTap: _onItemTapped,
    items: [
    BottomNavigationBarItem(
    icon: Icon(Icons.clear, color: Colors.white), title: Text("Limpar",style: TextStyle(color: Colors.white),)),
    BottomNavigationBarItem(
    icon: Icon(Icons.check, color: Colors.white), title: Text("Calcular",style: TextStyle(color: Colors.white),))
    ],
    ),
    );
  }
}
