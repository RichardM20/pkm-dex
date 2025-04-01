import 'package:poke_api/src/views/exports.dart';

class PokeImage extends StatelessWidget {
  const PokeImage({
    super.key,
    required this.source,
    this.isLocal = false,
    this.width,
    this.height,
    this.opacity = 1.0,
  });

  final String? source;
  final bool isLocal;
  final double? width;
  final double? height;
  final double opacity;

  static const double _height = 100;
  static const double _size = 80;
  static const String _pokeballAsset = 'assets/pokeball.gif';
  static const String _errorAsset = 'assets/pikachu_no_load_img.gif';

  Widget _buildPlaceholder() {
    return _buildImageAsset(_pokeballAsset);
  }

  Widget _buildErrorImage() {
    return _buildImageAsset(_errorAsset);
  }

  Widget _buildImageAsset(String assetPath) {
    return SizedBox(
      height: height ?? _size,
      width: width ?? _size,
      child: Opacity(
        opacity: opacity,
        child: Image.asset(assetPath, fit: BoxFit.contain),
      ),
    );
  }

  Widget _buildSvgImage(String imageSource) {
    return SvgPicture.network(
      imageSource,
      fit: BoxFit.cover,
      height: height ?? _height,
      width: width,
      placeholderBuilder: (_) => _buildPlaceholder(),
      errorBuilder: (_, __, ___) => _buildErrorImage(),
    );
  }

  Widget _buildNetworkImage(String imageSource) {
    return FadeInImage.assetNetwork(
      placeholder: _pokeballAsset,
      image: imageSource,
      fit: BoxFit.cover,
      height: height ?? _height,
      width: width,
      imageErrorBuilder: (_, __, ___) => _buildErrorImage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageSource = source;
    if (imageSource == null || imageSource.trim().isEmpty) {
      return _buildErrorImage();
    }

    if (isLocal || imageSource.startsWith('assets/')) {
      return _buildImageAsset(imageSource);
    }

    final uri = Uri.tryParse(imageSource);
    if (uri == null || !uri.hasAbsolutePath) {
      return _buildErrorImage();
    }

    return imageSource.endsWith('.svg')
        ? _buildSvgImage(imageSource)
        : _buildNetworkImage(imageSource);
  }
}
