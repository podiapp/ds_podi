import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:ds_podi/ds_podi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DropzoneWidget extends StatefulWidget {
  final String title;
  final double height;
  final double width;

  /// File:
  /// - file.name;
  /// - file.mime;
  /// - file.bytes;
  /// - file.url;
  final void Function(DroppedFile file) onDroppedItem;
  final void Function(int index) onRemove;
  final String text;
  final List<String>? imageList;
  final bool hasHeader, hasButton, hasTitle, busy;
  final bool isSingleImage;
  final bool isCsv;
  final bool isPdf;
  final String? image;
  const DropzoneWidget({
    Key? key,
    this.title = "Fotos",
    this.text = "Clique ou arraste um arquivo",
    this.height = 160.0,
    this.width = double.infinity,
    this.hasHeader = true,
    this.hasButton = true,
    this.hasTitle = true,
    this.isSingleImage = false,
    this.busy = false,
    this.isCsv = false,
    this.isPdf = false,
    this.imageList,
    this.image,
    required this.onDroppedItem,
    required this.onRemove,
  }) : super(key: key);

  @override
  _DropzoneWidgetState createState() => _DropzoneWidgetState();
}

class _DropzoneWidgetState extends State<DropzoneWidget> {
  late DropzoneViewController controller;
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Widget stackChild = Stack(
      children: widget.busy
          ? [
              Center(
                child: Container(
                  height: 48,
                  width: 48,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(PodiColors.green),
                    strokeWidth: 3,
                  ),
                ),
              ),
            ]
          : [
              DropzoneView(
                onCreated: (controller) => this.controller = controller,
                onDrop: uploadImage,
              ),
              if (widget.isSingleImage) ...[
                InkWell(
                  onTap: pickFiles,
                  child: (isNull(widget.image))
                      ? SizedBox(
                          width: widget.width,
                          height: widget.height,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  PodiIcons.upload,
                                  height: 24,
                                  width: 24,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  widget.text,
                                  style: PodiTexts.caption
                                      .copyWith(fontSize: 13, height: 1.5),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Stack(
                          children: [
                            SizedBox(
                              width: widget.width,
                              height: widget.height,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.network(
                                  widget.image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: GestureDetector(
                                onTap: () => widget.onRemove(0),
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                      PodiColors.danger, BlendMode.srcIn),
                                  child: SvgPicture.asset(
                                    PodiIcons.trash,
                                    height: 16,
                                    width: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ] else ...[
                InkWell(
                  onTap: pickFiles,
                  child: ((widget.imageList?.isEmpty ?? true))
                      ? SizedBox(
                          width: widget.width,
                          height: widget.height,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  PodiIcons.upload,
                                  height: 24,
                                  width: 24,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  widget.text,
                                  style: PodiTexts.caption
                                      .copyWith(fontSize: 13, height: 1.5),
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView.separated(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Container(
                            child: Stack(
                              children: [
                                Container(
                                  height: 120,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Image.network(
                                      widget.imageList?[index] ?? "",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: GestureDetector(
                                      onTap: () => widget.onRemove(index),
                                      child: SvgPicture.asset(
                                        PodiIcons.trash,
                                        height: 16,
                                        width: 16,
                                        color: PodiColors.danger,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 16),
                          itemCount: widget.imageList?.length ?? 0,
                        ),
                ),
              ],
            ],
    );
    return Column(
      children: [
        if (widget.hasHeader) ...[
          SizedBox(
            width: widget.width,
            child: Row(
              mainAxisAlignment: (!widget.hasTitle || !widget.hasButton)
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.spaceBetween,
              children: [
                if (widget.hasTitle)
                  Text(
                    widget.title,
                    style: PodiTexts.body1.weightMedium.heightRegular,
                  ),
                if (widget.hasButton)
                  InkWell(
                    onTap: () async {
                      pickFiles();
                    },
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      width: 120,
                      padding: EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: PodiColors.dark[100]!),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add),
                          SizedBox(width: 4),
                          Text("Adicionar",
                              style: PodiTexts.button1
                                  .size(13)
                                  .weightBold
                                  .heightCenter),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
        DottedBorder(
          borderType: BorderType.RRect,
          dashPattern: [3, 6],
          color: PodiColors.dark[300]!,
          radius: Radius.circular(8),
          child: Container(
            width: widget.width,
            height: widget.height,
            padding: (!widget.isSingleImage)
                ? (widget.imageList?.isEmpty ?? true)
                    ? EdgeInsets.symmetric(vertical: 54)
                    : EdgeInsets.all(24)
                : EdgeInsets.all(8),
            child: (widget.isSingleImage)
                ? stackChild
                : RawScrollbar(
                    thumbVisibility: true,
                    controller: _scrollController,
                    thumbColor: PodiColors.green,
                    radius: Radius.circular(8),
                    thickness: 5,
                    child: stackChild,
                  ),
          ),
        ),
      ],
    );
  }

  Future uploadImage(dynamic event) async {
    final supportedMimeFiles = widget.isCsv
        ? ["application/vnd.ms-excel"]
        : widget.isPdf
            ? ["application/pdf"]
            : ["image/jpeg", "image/png"];
    final name = event.name;
    final mime = await controller.getFileMIME(event);
    final bytes = await controller.getFileSize(event);
    final url = await controller.createFileUrl(event);
    final data = await controller.getFileData(event);
    if (supportedMimeFiles.contains(mime)) {
      final droppedFile = DroppedFile(
        url: url,
        name: name,
        mime: mime,
        bytes: bytes,
        data: data,
      );
      widget.onDroppedItem(droppedFile);
    }
  }

  Future pickFiles() async {
    final supportedMimeFiles = widget.isCsv
        ? ["application/vnd.ms-excel"]
        : widget.isPdf
            ? ["application/pdf"]
            : ["image/jpeg", "image/png"];
    final events =
        await controller.pickFiles(multiple: true, mime: supportedMimeFiles);
    if (events.isEmpty) return;
    uploadImage(events.first);
  }
}
