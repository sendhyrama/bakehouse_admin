import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/users_provider.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/search_bar.dart';
import '../../widgets/user_card.dart';

class UserPage extends ConsumerStatefulWidget {
  const UserPage({super.key});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends ConsumerState<UserPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          title: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              'Pengguna',
              style: TextStyles.h2.copyWith(color: Colors.white),
            ),
          ),
          backgroundColor: PrimaryColor.c8,
          automaticallyImplyLeading: false,
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              labelColor: PrimaryColor.c8,
              labelStyle: TextStyles.b1.copyWith(color: PrimaryColor.c8, fontWeight: FontWeight.bold),
              unselectedLabelColor: Colors.grey,
              unselectedLabelStyle: TextStyles.b1.copyWith(color: Colors.grey),
              controller: _tabController,
              indicatorColor: PrimaryColor.c8,
              tabs: const [
                Tab(text: 'Pelanggan'),
                Tab(text: 'UMKM'),
              ],
            ),
          ),
          SearchBarr(
            controller: _searchController,
            onSearch: (query) {
              setState(() {
                _searchQuery = query;
              });
            },
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Customer Tab
                _UserList(role: 'customer', searchQuery: _searchQuery),
                // UMKM Tab
                _UserList(role: 'merchant', searchQuery: _searchQuery),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UserList extends ConsumerWidget {
  final String role;
  final String searchQuery;

  const _UserList({
    required this.role,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(usersByRoleProvider(role));

    return users.when(
      data: (userList) {
        // Filter the list of users based on the role and search query
        final filteredList = userList.where((user) {
          final lowerCaseQuery = searchQuery.toLowerCase();
          if (role == 'customer') {
            return user.fullname?.toLowerCase().contains(lowerCaseQuery) ??
                false;
          } else if (role == 'merchant') {
            return user.businessName?.toLowerCase().contains(lowerCaseQuery) ??
                false;
          }
          return false;
        }).toList();

        if (filteredList.isEmpty) {
          return const Center(child: Text('No users found.'));
        }

        return ListView.builder(
          itemCount: filteredList.length,
          itemBuilder: (context, index) {
            final user = filteredList[index];
            return UserCard(user: user);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
