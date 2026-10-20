import 'package:flutter/widgets.dart';

/// Pengaturan ukuran responsif untuk seluruh aplikasi.
///
/// Semua ukuran (font, jarak, ikon, radius) dikalikan dengan faktor skala
/// yang dihitung dari sisi terpendek layar, sehingga:
///  - HP kecil  -> sedikit lebih kecil,
///  - HP biasa  -> ukuran dasar (desain 360 dp),
///  - tablet / web -> lebih besar, tetapi dibatasi agar tidak berlebihan.
class Responsive {
  Responsive._();

  /// Lebar maksimum konten. Di layar yang lebih lebar (tablet / web),
  /// konten tetap berada di tengah dan tidak melebar penuh.
  static const double maxContentWidth = 600;

  static const double _designWidth = 360;
  static const double _minScale = 0.85;
  static const double _maxScale = 1.3;

  static double scaleOf(BuildContext context) {
    final shortest = MediaQuery.sizeOf(context).shortestSide;
    return (shortest / _designWidth).clamp(_minScale, _maxScale).toDouble();
  }
}

extension ResponsiveContext on BuildContext {
  /// Ukuran font yang sudah diskalakan.
  double sp(double size) => size * Responsive.scaleOf(this);

  /// Ukuran umum (jarak, padding, radius, ikon) yang sudah diskalakan.
  double sz(double size) => size * Responsive.scaleOf(this);

  double get screenWidth => MediaQuery.sizeOf(this).width;
}
