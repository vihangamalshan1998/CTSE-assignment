import 'package:flutter/material.dart';
import 'package:frontend_mobile/providers/fertilizer_provider.dart';
import 'package:frontend_mobile/screens/Fertilizer/Widgets/snack_bar.dart';
import 'package:provider/provider.dart';

class EditFertilizerScreen extends StatefulWidget {
  const EditFertilizerScreen({Key? key}) : super(key: key);
  @override
  State<EditFertilizerScreen> createState() => _EditFertilizerScreenState();
}

class _EditFertilizerScreenState extends State<EditFertilizerScreen> {
  final _formKey = GlobalKey<FormState>();
  late FocusScopeNode node;

  TextEditingController fertilizerName = TextEditingController();
  TextEditingController fertilizerCode = TextEditingController();
  TextEditingController fertilizerWeight = TextEditingController();
  TextEditingController fertilizerDescription = TextEditingController();
  late String fertilizerId;
  late bool create;
  @override
  void initState() {
    create = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Fertilizer fertilizer = Provider.of<Fertilizers>(context).getFertilizer();
    fertilizer.id != '' ? create = false : create = true;
    fertilizerName.text = fertilizer.name;
    fertilizerCode.text = fertilizer.code;
    fertilizerWeight.text = fertilizer.weight;
    fertilizerDescription.text = fertilizer.description;
    fertilizerId = fertilizer.id;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Update Fertilizer',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                fertilizerNameField(),
                fertilizerCodeField(),
                fertilizerWeightField(),
                fertilizerDescriptionField(),
                const SizedBox(height: 50),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ButtonTheme(
                    minWidth: double.infinity,
                    child: MaterialButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        updateFertilizer();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Update",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget fertilizerNameField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: TextFormField(
        keyboardType: TextInputType.text,
        validator: (value) {},
        controller: fertilizerName,
        textInputAction: TextInputAction.next,
        onEditingComplete: () => node.nextFocus(),
        decoration: const InputDecoration(
          labelText: "Name",
          hintText: "Name",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
    );
  }

  Widget fertilizerCodeField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: TextFormField(
        keyboardType: TextInputType.text,
        validator: (value) {},
        controller: fertilizerCode,
        textInputAction: TextInputAction.next,
        onEditingComplete: () => node.nextFocus(),
        decoration: const InputDecoration(
          labelText: "Code",
          hintText: "Code",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
    );
  }

  Widget fertilizerWeightField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: TextFormField(
        keyboardType: TextInputType.number,
        validator: (value) {},
        controller: fertilizerWeight,
        textInputAction: TextInputAction.next,
        onEditingComplete: () => node.nextFocus(),
        decoration: const InputDecoration(
          labelText: "Weight",
          hintText: "Weight",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
    );
  }

  Widget fertilizerDescriptionField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: TextFormField(
        keyboardType: TextInputType.text,
        validator: (value) {},
        controller: fertilizerDescription,
        textInputAction: TextInputAction.next,
        onEditingComplete: () => node.nextFocus(),
        decoration: const InputDecoration(
          labelText: "Description",
          hintText: "Description",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
    );
  }

  updateFertilizer() async {
    await Provider.of<Fertilizers>(context, listen: false)
        .updateFertilizer(
      fertilizerId,
      fertilizerName.text,
      fertilizerCode.text,
      fertilizerWeight.text,
      fertilizerDescription.text,
    )
        .then(
      (result) {
        Navigator.pop(context);
        if (result is String) {
          ScaffoldMessenger.of(context).showSnackBar(successSnackBar(result));
        } else {
          Navigator.pop(context);
        }
      },
      onError: (message) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(message));
      },
    );
  }
}
