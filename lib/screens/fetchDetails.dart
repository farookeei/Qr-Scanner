import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_user/core/provider/authProvider.dart';

class FetchDetails extends StatefulWidget {
  static const routeName = "/fetchDetals";

  @override
  _FetchDetailsState createState() => _FetchDetailsState();
}

bool isLoading = false;

class _FetchDetailsState extends State<FetchDetails> {
  Future<void> fetchInfo() async {
    setState(() => isLoading = true);
    await Provider.of<AuthProvider>(context, listen: false).acessData();
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    fetchInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UserDetails"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Consumer<AuthProvider>(
          builder: (ctx, _providerData, _) {
            return isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _providerData.userFetchedData.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        dense: true,
                        leading: Text(
                          "${i + 1}) ${_providerData.userFetchedData[i]["name"]}",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        title: Text(
                          _providerData.userFetchedData[i]["address"],
                          style: Theme.of(context).primaryTextTheme.bodyText1,
                        ),
                        trailing: Text(
                            _providerData.userFetchedData[i]["phoneNumber"]),
                      );
                    });
          },
        ),
      ),
    );
  }
}
