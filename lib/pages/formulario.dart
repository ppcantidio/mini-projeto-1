import 'package:flutter/material.dart';

class FormAtv extends StatelessWidget {
  const FormAtv({super.key});

  Widget _buildTextField(String labelText, {String? helperText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: labelText,
            ),
          ),
          if (helperText != null)
            const SizedBox(height: 8),
          if (helperText != null)
            Text(
              helperText,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildListTile(String title) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
      ),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    const title = 'Aplication';
    return MaterialApp(
      title: title,
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black54,
            title: const Text(title, style: TextStyle(color: Colors.white)),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert_sharp, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          body: ListView(children: [
            _buildListTile('Personal info'),
            _buildTextField('Firstname'),
            _buildTextField('Lastname'),
            Row(
              children: [
                Expanded(child: _buildTextField('Birthday', helperText: 'MM/DD/AAAA')),
                Expanded(child: _buildTextField('Social Security', helperText: '###-##-###')),
              ],
            ),
            _buildListTile('Residence address'),
            _buildTextField('Address'),
            Row(
              children: [
                Expanded(child: _buildTextField('City')),
                Expanded(child: _buildTextField('State')),
              ],
            ),
            Row(
              children: [
                Expanded(child: _buildTextField('ZIP Code')),
                Expanded(child: _buildTextField('Country')),
              ],
            ),
          ])),
    );
  }
}