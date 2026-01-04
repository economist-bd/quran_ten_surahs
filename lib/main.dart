import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'surah_data.dart'; // আমাদের তৈরি করা ডেটা ফাইল ইম্পোর্ট

void main() {
  runApp(const QuranApp());
}

// ==============================
// অ্যাপের প্রধান থিম কনফিগারেশন
// ==============================
class QuranApp extends StatelessWidget {
  const QuranApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '১০টি ছোট সূরা',
      theme: ThemeData(
        // একটি শান্ত ইসলামিক কালার থিম
        scaffoldBackgroundColor: const Color(0xFFFFFBE6), // হালকা ক্রিম কালার ব্যাকগ্রাউন্ড
        primaryColor: const Color(0xFF006400), // গাঢ় সবুজ
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF006400),
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        // ডিফল্ট বাংলা ফন্ট
        textTheme: GoogleFonts.tiroBanglaTextTheme(),
        useMaterial3: true,
      ),
      home: const CoverPage(),
    );
  }
}

// ==============================
// পেইজ ১: কভার পেইজ (Cover Page)
// ==============================
class CoverPage extends StatelessWidget {
  const CoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // ব্যাকগ্রাউন্ডে একটি হালকা প্যাটার্ন বা গ্রেডিয়েন্ট
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF006400), Color(0xFF004D00)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                // ক্যালিগ্রাফি স্টাইলে শিরোনাম
                Text(
                  "القرآن الكريم",
                  style: GoogleFonts.amiri(
                    fontSize: 60,
                    color: const Color(0xFFFFD700), // সোনালী কালার
                    fontWeight: FontWeight.bold,
                    shadows: [const Shadow(blurRadius: 10, color: Colors.black45, offset: Offset(2,2))]
                  ),
                ),
                 const SizedBox(height: 20),
                Text(
                  "পবিত্র কোরআনের\n১০টি ছোট সূরা",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.tiroBangla(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 50),
                // শুরু করার বাটন
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const IndexPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD700), // সোনালী বাটন
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  icon: const Icon(Icons.menu_book_rounded),
                  label: const Text("পাঠ শুরু করুন", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                const Spacer(),
                // ডেভেলপারের নাম
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    "Developer: Your Name/Studio", // এখানে আপনার নাম দিন
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==============================
// পেইজ ২: ইনডেক্স পেইজ (Index Page)
// ==============================
class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("সূরা সূচি"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: tenSurahsData.length,
          itemBuilder: (context, index) {
            final surah = tenSurahsData[index];
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text("${index + 1}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                title: Text(
                  surah.nameBangla,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(surah.nameArabic, style: GoogleFonts.amiri(fontSize: 16, color: Colors.grey[700])),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFF006400)),
                onTap: () {
                  // ডিটেইলস পেজে নেভিগেট করা এবং সিলেক্ট করা সূরা ও তার ইনডেক্স পাঠানো
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SurahDetailPage(surahIndex: index)));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

// ==============================
// পেইজ ৩: বিস্তারিত সূরা পেইজ (Surah Detail Page)
// ==============================
class SurahDetailPage extends StatelessWidget {
  final int surahIndex;

  const SurahDetailPage({super.key, required this.surahIndex});

  @override
  Widget build(BuildContext context) {
    final surah = tenSurahsData[surahIndex];
    final isLastSurah = surahIndex == tenSurahsData.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text(surah.nameBangla),
        actions: [
          // হোম বাটন
          IconButton(
            icon: const Icon(Icons.home_rounded),
            tooltip: 'Home',
            onPressed: () {
               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const IndexPage()), (route) => false);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // আরবি টেক্সট সেকশন
            _buildContentCard(
              context,
              title: surah.nameArabic,
              content: surah.arabicText,
              isArabic: true,
              headerColor: const Color(0xFF006400),
            ),
            const SizedBox(height: 20),

            // বাংলা উচ্চারণ সেকশন
            _buildContentCard(
              context,
              title: "বাংলা উচ্চারণ",
              content: surah.pronunciation,
              headerColor: Colors.teal[700]!,
            ),
            const SizedBox(height: 20),

            // বাংলা অনুবাদ সেকশন
            _buildContentCard(
              context,
              title: "বাংলা অনুবাদ",
              content: surah.translation,
              headerColor: Colors.indigo[700]!,
            ),
             const SizedBox(height: 20),

            // তাফসির সেকশন
            _buildContentCard(
              context,
              title: "সংক্ষিপ্ত তাফসির",
              content: surah.tafsir,
              headerColor: Colors.brown[700]!,
              bgColor: const Color(0xFFF5F5DC) // একটু ভিন্ন ব্যাকগ্রাউন্ড
            ),
          ],
        ),
      ),
      // নেভিগেশন বাটন (নেক্সট)
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: isLastSurah
              ? const SizedBox.shrink() // শেষ সূরা হলে বাটন দেখাবে না
              : ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  ),
                  onPressed: () {
                    // পরের সূরায় যাওয়া
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SurahDetailPage(surahIndex: surahIndex + 1)));
                  },
                  icon: const Icon(Icons.skip_next_rounded),
                  label: const Text("পরবর্তী সূরা", style: TextStyle(fontSize: 18)),
                ),
        ),
      ),
    );
  }

  // কনটেন্ট দেখানোর জন্য একটি হেল্পার উইজেট (Card Design)
  Widget _buildContentCard(BuildContext context, {required String title, required String content, required Color headerColor, bool isArabic = false, Color bgColor = Colors.white}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          // কার্ডের হেডার
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              color: headerColor,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: isArabic
                ? GoogleFonts.amiri(fontSize: 24, color: const Color(0xFFFFD700), fontWeight: FontWeight.bold)
                : const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          // কার্ডের বডি (টেক্সট)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: bgColor,
               borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
            ),
            child: Text(
              content,
              textAlign: isArabic ? TextAlign.center : TextAlign.justify,
              style: isArabic
                  ? GoogleFonts.amiri(fontSize: 28, height: 1.8, color: Colors.black87) // আরবি ফন্ট ও স্টাইল
                  : GoogleFonts.tiroBangla(fontSize: 17, height: 1.6, color: Colors.black87), // বাংলা ফন্ট ও স্টাইল
            ),
          ),
        ],
      ),
    );
  }
}