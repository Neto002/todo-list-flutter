import 'package:flutter/material.dart';
import 'package:todo_list/pages/todo_list_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usuarioController = TextEditingController();

  final TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Login Todo Neto",
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: TextField(
                      controller: usuarioController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Usuário",
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextField(
                    controller: senhaController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Senha",
                    ),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    onLogin(usuarioController.text, senhaController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Entrar",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onLogin(String usuario, String senha) {
    if (usuario == "Neto" && senha == "123") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TodoListPage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Login Inválido"),
          content: const Text("Usuário e/ou Senha incorreto(s)"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "OK",
                style: TextStyle(
                  color: Colors.purple,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
