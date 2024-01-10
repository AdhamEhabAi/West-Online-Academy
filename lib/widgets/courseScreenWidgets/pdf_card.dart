import 'package:elmanasa/constants.dart';
import 'package:elmanasa/models/all_pdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class PdfCard extends StatelessWidget {
  final AllPdf pdf;

  const PdfCard({
    Key? key,
    required this.pdf,
  }) : super(key: key);

  Future<void> _downloadPdf() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final directory = await getExternalStorageDirectory();
      final taskId = await FlutterDownloader.enqueue(
        url:  'https://beta.aminyoussef.com/upload/pdf/${pdf.url}',
        savedDir: directory!.path,
        fileName: pdf.url,
        showNotification: true,
        openFileFromNotification: true,
      );
    } else {

    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: kSecondaryColor,
      onTap: _downloadPdf,
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            Image.asset(
              'assets/icons/pdf.png',
              height: 45,
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    pdf.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.download_for_offline,
              color: kSecondaryColor,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }
}
