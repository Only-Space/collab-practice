class ConversionResult {
  final bool success;
  final String? pdfFilePath;
  final String? errorMessage;

  ConversionResult({
    required this.success,
    this.pdfFilePath,
    this.errorMessage,
  });
}