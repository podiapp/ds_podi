import '../../utils.dart';

enum SocialNetwork { Facebook, Instagram, Twitter, Youtube }

const Map<SocialNetwork, String> kSocialNetworkToIcon = {
  SocialNetwork.Facebook: PodiIcons.logoFacebookSquare,
  SocialNetwork.Twitter: PodiIcons.logoTwitter,
  SocialNetwork.Instagram: PodiIcons.logoInstagram,
  SocialNetwork.Youtube: PodiIcons.logoYoutube
};

const Map<SocialNetwork, String> kSocialNetworkToString = {
  SocialNetwork.Facebook: "Facebook",
  SocialNetwork.Twitter: "Twitter",
  SocialNetwork.Instagram: "Instagram",
  SocialNetwork.Youtube: "Youtube"
};
