import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skincare_logger/src/core/common/themes/constants.dart';
import 'package:skincare_logger/src/features/streaktraker/presentation/cubit/getstreakdata_cubit.dart';

class StreakTrackerPage extends StatefulWidget {
  const StreakTrackerPage({super.key});

  @override
  State<StreakTrackerPage> createState() => _StreakTrackerPageState();
}

class _StreakTrackerPageState extends State<StreakTrackerPage> {
  @override
  void initState() {
    super.initState();
    context.read<GetstreakdataCubit>().getstreakdata(noOfDays: 30);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 247, 250),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Streaks',
          style: textStyle.copyWith(fontSize: 22),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Today's Goal : 3 Streak Days",
              style: textStyle.copyWith(fontSize: 22),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color.fromARGB(255, 224, 208, 218),
              ),
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Streak Days',
                      style: textStyle.copyWith(fontSize: 22),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '2',
                      style: textStyle.copyWith(fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daily Streak',
                      style: textStyle.copyWith(fontSize: 22),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '2',
                      style: textStyle.copyWith(fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 200,
                width: double.maxFinite,
                child: BlocBuilder<GetstreakdataCubit, GetstreakdataState>(
                  builder: (context, state) {
                    if (state is GetstreakdataComplete) {
                      final streakData = state.streakdata;
                      final spots = streakData.asMap().entries.map((entry) {
                        final index = entry.key;
                        final value = entry.value;
                        return FlSpot(index.toDouble(), value.toDouble());
                      }).toList();
                      return LineChart(
                        LineChartData(
                          backgroundColor: const Color.fromARGB(
                            255,
                            224,
                            208,
                            218,
                          ), // Adjust opacity as needed
                          borderData:
                              FlBorderData(border: Border.all(), show: false),
                          titlesData: const FlTitlesData(
                              show: false,
                              rightTitles: AxisTitles(),
                              topTitles: AxisTitles(),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: true),
                              ),
                              leftTitles: AxisTitles()),
                          gridData: const FlGridData(
                            show: false,
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              dotData: const FlDotData(show: false),
                              spots: spots,
                              isCurved: true, // Adjust line style as needed
                              color: const Color.fromARGB(255, 150, 79, 101),
                              barWidth: 2, // Adjust line width
                              belowBarData: BarAreaData(show: false),
                            ),
                          ],
                        ),
                      );
                    }
                    if (state is GetstreakdataLoading) {
                      // return const SizedBox(
                      //   height: 100,
                      //   width: 100,
                      //   child: CircularProgressIndicator.adaptive(),
                      // );
                    }
                    return const Center(child: Text('No Data Available'));
                  },
                ),
              ),
            ),
            
            const Text(
              'Keep it up!, You are on roll.',
              style: textStyle,
            )
          ],
        ),
      ),
    );
  }
}
