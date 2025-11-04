import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isAutoModeEnabled = false;

  void _logout() {
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tableau de Bord'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Déconnexion',
            onPressed: _logout,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          _buildBalanceCard('1,250.75 €'),
          const SizedBox(height: 16),
          _buildAutomationControlCard(),
          const SizedBox(height: 16),
          _buildInfoCard(
            title: 'Historique des Paris',
            icon: Icons.history,
            content: const ListTile(
              leading: Icon(Icons.receipt_long),
              title: Text('Gain: Pari Double'),
              subtitle: Text('Hier, 20:45 - Cote: 2.15'),
              trailing: Text('+ 125.07 €', style: TextStyle(color: Colors.green)),
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoCard(
            title: 'Logs de Décision IA',
            icon: Icons.psychology,
            content: const ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('Pari Placé: Match A + Match B'),
              subtitle: Text('p_comb: 0.82 > 0.80. Mise: 125.07 € (10% du solde)'),
            ),
          ),
           const SizedBox(height: 24),
          _buildLegalWarning(),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(String balance) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SOLDE ACTIF',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  balance,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Icon(Icons.account_balance_wallet, size: 32, color: Colors.deepPurple),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAutomationControlCard() {
    return Card(
      elevation: 4,
      child: SwitchListTile(
        title: const Text('Mode Automatique'),
        subtitle: Text(_isAutoModeEnabled ? 'Activé: Les paris sont placés automatiquement.' : 'Désactivé: Validation manuelle requise.'),
        value: _isAutoModeEnabled,
        onChanged: (bool value) {
          setState(() {
            _isAutoModeEnabled = value;
          });
        },
        secondary: Icon(
          _isAutoModeEnabled ? Icons.smart_toy : Icons.touch_app,
          color: Colors.deepPurple,
        ),
      ),
    );
  }

  Widget _buildInfoCard({required String title, required IconData icon, required Widget content}) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Icon(icon, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: content,
          ),
        ],
      ),
    );
  }

    Widget _buildLegalWarning() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        'Avertissement: Les paris sportifs comportent des risques. Ne misez que de l\'argent que vous pouvez vous permettre de perdre. Jouez de manière responsable.',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
      ),
    );
  }
}
