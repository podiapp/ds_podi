enum DeviceType { Desktop, Tablet, Mobile }

extension DeviceTypeExtension on DeviceType {
  bool get isMobile => this == DeviceType.Mobile || this == DeviceType.Tablet;
}
