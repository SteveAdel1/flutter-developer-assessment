import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/banner/banner_cubit.dart';
import '../cubit/room/room_cubit.dart';
import '../cubit/room/room_states.dart';
import '../widgets/chat_list_widget.dart';
import '../widgets/room_banner_widget.dart';
import '../widgets/seat_grid_widget.dart';

class RoomScreenMini extends StatefulWidget {
  final int roomId;
  final bool isLocked;
  const RoomScreenMini(
      {required this.roomId, this.isLocked = false, super.key});

  @override
  State<RoomScreenMini> createState() => _RoomScreenMiniState();
}

class _RoomScreenMiniState extends State<RoomScreenMini>
    with WidgetsBindingObserver {
  final RoomCubit _roomCubit = RoomCubit();
  final BannerCubit _bannerCubit = BannerCubit();
  final ScrollController _chatScrollController = ScrollController();
  final List<StreamSubscription?> _subscriptions = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    //  الاشتراك في ستريم الرسائل دلوقتي فعلي وبيضيف رسائل
    _subscriptions.add(
      Stream.periodic(const Duration(seconds: 3), (i) => 'Hello $i')
          .listen((msg) => _roomCubit.addMessage(msg)),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // الغينا كل الاشتراكات لتجنب تسريبات الذاكرة

    for (final sub in _subscriptions) {
      sub?.cancel();
    }
    _chatScrollController.dispose();
    _roomCubit.close();
    _bannerCubit.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // إصلاح الـ async/void bug بدون مشاكل
    if (state == AppLifecycleState.paused) {
      Future.delayed(const Duration(milliseconds: 100),
          () => debugPrint('Camera stopped'));
    } else if (state == AppLifecycleState.resumed) {
      Future.delayed(const Duration(milliseconds: 100),
          () => debugPrint('Camera resumed'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Room'),
              background: Container(color: Colors.purple.shade900),
            ),
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<RoomCubit, RoomState>(
              bloc: _roomCubit,
              buildWhen: (prev, curr) => prev != curr,
              builder: (context, state) {
                if (state is RoomLoaded) {
                  return Container(
                    height: 60,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Colors.amber, Colors.orange]),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        state.roomMode == 'locked'
                            ? 'Comments Locked'
                            : 'Normal Mode',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          BlocBuilder<RoomCubit, RoomState>(
            bloc: _roomCubit,
            buildWhen: (prev, curr) => prev != curr,
            builder: (context, state) {
              if (state is RoomLoaded)
                return SeatGrid(seatCount: state.seatCount);
              return const SliverToBoxAdapter(child: SizedBox(height: 50));
            },
          ),
          BlocBuilder<RoomCubit, RoomState>(
            bloc: _roomCubit,
            buildWhen: (prev, curr) => prev != curr,
            builder: (context, state) {
              if (state is RoomLoaded) {
                return ChatList(
                    messages: state.messages,
                    scrollController: _chatScrollController);
              }
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),
        ],
      ),
    );
  }
}
