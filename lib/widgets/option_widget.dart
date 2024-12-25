import 'package:flutter/material.dart';

class OptionWidget extends StatelessWidget {
  final String imagePath;
  final String optionTitle;
  final String optionDescription;
  final Widget targetPage;

  const OptionWidget({
    super.key,
    required this.imagePath,
    required this.optionTitle,
    required this.optionDescription,
    required this.targetPage
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width - 10,
          height: MediaQuery.sizeOf(context).height / 3,
          child: Material(
            elevation: 3,
            color: isDarkMode ? Color(0xFF1E1E1E) : Color.fromARGB(255, 0, 255, 255),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => targetPage,
                  )
                );
              },
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: SizedBox(
                          width: 120,
                          height: 100,
                          // decoration: BoxDecoration(
                          //   color: Colors.red
                          // ),
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    )
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)
                        ),
                        color: isDarkMode ? Colors.black : Color(0xFF0EB1D2)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                optionTitle,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.white
                                ),
                              ),
                              Text(
                                optionDescription,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}