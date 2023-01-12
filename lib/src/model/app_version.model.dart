class AppVersion {
  late String version;
  AppVersion? subversion;

  AppVersion(String value) {
    final parts = value.split(".");
    if (parts.length <= 1) {
      version = value;
    } else {
      version = parts[0];
      subversion = AppVersion(parts.sublist(1).join("."));
    }
  }

  @override
  String toString() {
    if (subversion == null) return version;
    return "$version.${subversion.toString()}";
  }

  bool operator >(AppVersion other) {
    final c = version.compareTo(other.version);
    if (c > 0) {
      return true;
    } else if (c < 0) {
      return false;
    } else {
      if (other.subversion == null) {
        if (subversion == null) return false;
        return true;
      }
      if (subversion == null) return false;
      return subversion! > other.subversion!;
    }
  }

  bool operator <(AppVersion other) {
    final c = version.compareTo(other.version);
    if (c > 0) {
      return false;
    } else if (c < 0) {
      return true;
    } else {
      if (subversion == null) {
        if (other.subversion == null) return false;
        return true;
      }
      if (other.subversion == null) return false;
      return subversion! < other.subversion!;
    }
  }
}
