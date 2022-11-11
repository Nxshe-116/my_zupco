class Quote {
  String text;
  String author;
  String image;

  Quote({required this.text, required this.author, required this.image});
}



/*   


   Text(" Taxi details",
                        style: GoogleFonts.lato(
                            color: altPrimaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 25)),

SafeArea(
                    child: StreamBuilder<List<TransportDetailsModel>>(
                      stream: getTransport(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const Center(
                                child: CircularProgressIndicator());
                          default:
                            if (snapshot.hasError) {
                              if (kDebugMode) {
                                print(snapshot.error);
                              }
                              return const Text(
                                  'Something Went Wrong Try later');
                            } else {
                              final users = snapshot.data;
                              if (users!.isEmpty) {
                                return const Text(
                                    'No Taxis Are Boarding At The Moment');
                              } else {
                                return Column(
                                  children: [
                                    ChatHeaderWidget(taxi: users),
                                  ],
                                );
                              }
                            }
                        }
                      },
                    ),
                  ), */