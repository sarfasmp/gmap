import 'package:flutter/material.dart';
import 'package:gmapapp/presentation/controller/home_screen_provider.dart';
import 'package:gmapapp/presentation/view/map_screen.dart';
import 'package:gmapapp/presentation/widget/refactor_widget_of_home_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homePro.onFetchLocationList();
    });
  }

  late HomeScreenProvider homePro;

  @override
  Widget build(BuildContext context) {
    homePro = Provider.of<HomeScreenProvider>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Location List"),
        ),
        body: Stack(
          children: [
            ListView.separated(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              itemCount: homePro.locationList.length,
              itemBuilder: (context, index) {
                return HomeScreenTile(
                  locationModel: homePro.locationList[index],
                  onTap: () {
                    if (homePro.currentLocation?.longitude != null &&
                        homePro.locationList[index].latitude != null) {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MapScreen(
                              polyLineLatAndLang: [
                                LatLng((homePro.currentLocation?.latitude ?? 0.0),
                                    (homePro.currentLocation?.longitude ?? 0.0)),
                                LatLng((homePro.locationList[index].latitude ?? 0.0),
                                    (homePro.locationList[index].longitude ?? 0.0))
                              ],
                            )),
                      );


                    }


                  },
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
            ),
            if (homePro.isFetchLocationLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ));
  }
}
