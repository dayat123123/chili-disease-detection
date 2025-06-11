import 'package:chili_disease_detection/core/tensorflow/tensorflow.dart';
import 'package:chili_disease_detection/shared/extensions/context_extension.dart';
import 'package:chili_disease_detection/shared/misc/file_paths.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Formatters {
  static String formatDateOnly(DateTime dateTime) {
    return DateFormat('dd MMMM yyyy', 'id').format(dateTime);
  }

  static String formatTimeOnly(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  static String formatAccuracy(double value) {
    return "${(value * 100).toStringAsFixed(2)}%";
  }

  static String formatSelectedResultName(ClassesResult selected) {
    return switch (selected) {
      ClassesResult.healthy => "Healthy",
      ClassesResult.leafCurling => "Leaf Curling",
      ClassesResult.leafSpot => "Leaf Spot",
      ClassesResult.leafYellowing => "Leaf Yellowing",
    };
  }

  static String formatSelectedResulTranslateName(ClassesResult selected) {
    return switch (selected) {
      ClassesResult.healthy => "Daun Sehat",
      ClassesResult.leafCurling => "Daun Keriting",
      ClassesResult.leafSpot => "Daun Berlubang",
      ClassesResult.leafYellowing => "Daun Kekuningan",
    };
  }

  static String getImagePath(ClassesResult result) {
    return switch (result) {
      ClassesResult.healthy => FilePaths.healthy,
      ClassesResult.leafCurling => FilePaths.curly,
      ClassesResult.leafSpot => FilePaths.spot,
      ClassesResult.leafYellowing => FilePaths.yellow,
    };
  }

  static Color colorAccuracy(BuildContext context, double acc) {
    acc *= 100;
    if (acc > 75) {
      return (context.themeColors.success);
    } else if (acc < 75 && acc > 50) {
      return (context.themeColors.warning);
    } else {
      return (context.themeColors.failed);
    }
  }

  static String getCiriCiri(ClassesResult result) {
    return switch (result) {
      ClassesResult.healthy => "Daun tampak hijau",
      ClassesResult.leafCurling =>
        "Daun menggulung ke atas atau bawah, Tekstur daun mengeras atau tampak tebal,warna daun bisa tetap hijau atau menguning",
      ClassesResult.leafSpot =>
        "Muncul bercak cokelat, abu-abu, kehitaman, atau kuning pada daun, ukuran bercak bervariasi, bisa menyebar dan menyatu, tepi bercak kadang tampak melingkar atau tidak beraturan,daun bisa menguning, mengering, dan rontok jika parah",
      ClassesResult.leafYellowing =>
        "Warna daun berubah dari hijau menjadi kuning pucat hingga kuning terang",
    };
  }

  static List<String> getDampak(ClassesResult result) {
    return switch (result) {
      ClassesResult.healthy => [],
      ClassesResult.leafCurling => [
        "Tanaman sulit tumbuh normal",
        "Fotosintesis terganggu",
        "Produksi dan kualitas buah menurun drastis",
        "Risiko gagal panen jika tidak segera ditangani",
      ],
      ClassesResult.leafSpot => [
        "Menurunnya fotosintesis akibat daun rusak",
        "Daun rontok → tanaman lemah",
        "Buah jadi kecil atau busuk jika infeksi menyebar",
        "Potensi penurunan hasil panen secara signifikan",
      ],
      ClassesResult.leafYellowing => [
        "Fotosintesis terganggu",
        "Pertumbuhan lambat",
        "Produksi dan kualitas buah menurun",
        "Tanaman bisa mati jika tidak ditangani",
      ],
    };
  }

  static List<String> getPenyebabUmum(ClassesResult result) {
    return switch (result) {
      ClassesResult.healthy => [],
      ClassesResult.leafCurling => [
        "Kutu daun dan thrips menghisap cairan daun → menyebabkan daun keriting dan rusak",
        "Infeksi Virus: Virus gemini menyebabkan daun keriting parah, mengecil, pertumbuhan terhambat",
        "Kekurangan kalsium (Ca), boron (B), dan kalium (K) → jaringan daun tidak berkembang normal",
        "Cuaca panas berlebih, angin kencang, atau tanah terlalu kering/basah",
      ],
      ClassesResult.leafSpot => [
        "Penyakit Jamur: Cercospora capsici (bercak daun cercospora),Alternaria solani (bercak daun alternaria),Umumnya muncul saat cuaca lembap dan hujan",
        "Penyakit Bakteri: Xanthomonas campestris → bercak daun bakteri (bercak gelap, berminyak)",
        "Daun basah terus-menerus → kondisi ideal bagi jamur dan bakteri berkembang",
        "Tanaman terlalu rapat → udara terjebak dan memperparah infeksi",
      ],
      ClassesResult.leafYellowing => [
        "Hama: Kutu daun & kutu kebul menghisap cairan dan membawa virus",
        "Kekurangan Nutrisi: Terutama nitrogen dan magnesium",
        "Lingkungan Buruk: Tanah becek, pH tidak sesuai, atau penyiraman berlebihan",
      ],
    };
  }

  static List<String> getPenanganan(ClassesResult result) {
    return switch (result) {
      ClassesResult.healthy => [],
      ClassesResult.leafCurling => [
        "Gunakan insektisida yang tepat (misal: abamektin, imidakloprid, spinosad)",
        "Gunakan insektisida nabati (contoh: ekstrak daun mimba, bawang putih)",
        "Cabut dan bakar tanaman yang sudah parah agar tidak menular ke tanaman sehat.",
        "Jaga kelembaban tanah, hindari genangan, dan beri naungan saat cuaca ekstrem",
      ],
      ClassesResult.leafSpot => [
        "Buang dan musnahkan daun yang terkena bercak agar tidak menyebar",
        "Semprot fungisida berbahan aktif seperti: Mancozeb, Klorotalonil Difenokonazol",
        "Jarak tanam yang cukup dan rajin menyiangi gulma",
      ],
      ClassesResult.leafYellowing => [
        "Semprot Intektisida nabati,jaga kelembaban tanah, Cabut tanaman terinfeksi virus,Beri pupuk seimbang (N, Mg, unsur mikro) dan  Gunakan benih tahan penyakit dan jaga kebersihan lahan",
      ],
    };
  }
}
