Return-Path: <netdev+bounces-237697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD8BC4F0C4
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 17:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3653B54BF
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 16:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9843C36CE0F;
	Tue, 11 Nov 2025 16:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QOcb8ABJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A656D2080C1;
	Tue, 11 Nov 2025 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762878841; cv=none; b=WoNyBKZiajaEUF0fUx4ruRa4siLnnZ9d8otaKAYgb21im8QmIlgMc/eWOFdfoKJT9Mq6maRMf/XdO/2+NTUd2+3+oZk/2b9r1Csqwx1yOGoUvVKQrx88LcIuoBfDaZiDyrI+dF+A/ivEQN7oIuGWQJ3bJ7l+JN66NAqTMx7tbUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762878841; c=relaxed/simple;
	bh=BquNmvx4M6cuYvQd6HB1gkhisvb6QI+XwiX16wONre8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKSF/gvZrMwsHIi5NCBuJdFdOf8JTMudXQvmkTbrnkEPIqB9uJBDUtSmW2M6RhUgnK1b0g/SBSMlBORnqKCBg52ieqSIeCgVZH0ybO9SSo3htuad+yIqRGhb7C51HvCZwAr2uTrWmp4heeLYh9yuerP74HQ+Nh7YI1A4rDCAPHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QOcb8ABJ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762878840; x=1794414840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BquNmvx4M6cuYvQd6HB1gkhisvb6QI+XwiX16wONre8=;
  b=QOcb8ABJ/991zYPVPv+LjupeVRyJAz8FlUcWd75nzf0Q9GU5CTQGjrEM
   zOiiOzX3WeYTTr887wxsxuzqGUZ+rB9609X7H3CefUhOawz/cEOxdHY2K
   GuKBqvqFkTuB1naTGgeohc0ZdpV01wh2YUfWfuf/HKBmudEE89SaotZml
   krDFWv1oumOV49QPtaLBVL7cJplhlgGpc9kiIZ1mPTtMY7OeF5DaI4N3c
   bT0KKYL/1lXitCyGeGJwIyvQucUTxXAEAx9u16Cz+D5ZO/2V4zp79jA07
   cbNSqMSQazpJQK90BKotwHniTSRqvssokuDAh0kKrMBbJsSxK78Uo/3Gq
   A==;
X-CSE-ConnectionGUID: aGUVwqNsQY2B2XC4z9PNTw==
X-CSE-MsgGUID: 0pUmlI2CRMS62tDsJooRIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="82341344"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="82341344"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 08:33:59 -0800
X-CSE-ConnectionGUID: bi0piDh9RMy27e4/n4ix0Q==
X-CSE-MsgGUID: TvZGRE1gTby+W/Jff5QS4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="193386799"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 11 Nov 2025 08:33:56 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vIrJZ-0003N1-14;
	Tue, 11 Nov 2025 16:33:53 +0000
Date: Wed, 12 Nov 2025 00:33:07 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Golle <daniel@makrotopia.org>, Xu Liang <lxu@maxlinear.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: phy: mxl-gpy: add support for MXL86211C
Message-ID: <202511120056.YRAPru3f-lkp@intel.com>
References: <92e7bdac9a581276219b5c985ab3814d65e0a7b5.1762813829.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92e7bdac9a581276219b5c985ab3814d65e0a7b5.1762813829.git.daniel@makrotopia.org>

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Golle/net-phy-mxl-gpy-add-MxL862xx-support/20251111-064014
base:   net-next/main
patch link:    https://lore.kernel.org/r/92e7bdac9a581276219b5c985ab3814d65e0a7b5.1762813829.git.daniel%40makrotopia.org
patch subject: [PATCH net-next 1/2] net: phy: mxl-gpy: add support for MXL86211C
config: x86_64-buildonly-randconfig-002-20251111 (https://download.01.org/0day-ci/archive/20251112/202511120056.YRAPru3f-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251112/202511120056.YRAPru3f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511120056.YRAPru3f-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/phy/mxl-gpy.c:1293:25: error: use of undeclared identifier 'gpy_link_change_notify'
    1293 |                 .link_change_notify = gpy_link_change_notify,
         |                                       ^
>> drivers/net/phy/mxl-gpy.c:1296:1: error: invalid application of 'sizeof' to an incomplete type 'struct phy_driver[]'
    1296 | module_phy_driver(gpy_drivers);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/phy.h:2396:35: note: expanded from macro 'module_phy_driver'
    2396 |         phy_module_driver(__phy_drivers, ARRAY_SIZE(__phy_drivers))
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:32: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                ^
   include/linux/phy.h:2386:45: note: expanded from macro 'phy_module_driver'
    2386 |         return phy_drivers_register(__phy_drivers, __count, THIS_MODULE); \
         |                                                    ^~~~~~~
>> drivers/net/phy/mxl-gpy.c:1296:1: error: invalid application of 'sizeof' to an incomplete type 'struct phy_driver[]'
    1296 | module_phy_driver(gpy_drivers);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/phy.h:2396:35: note: expanded from macro 'module_phy_driver'
    2396 |         phy_module_driver(__phy_drivers, ARRAY_SIZE(__phy_drivers))
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:32: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                ^
   include/linux/phy.h:2391:40: note: expanded from macro 'phy_module_driver'
    2391 |         phy_drivers_unregister(__phy_drivers, __count);                 \
         |                                               ^~~~~~~
   3 errors generated.


vim +/gpy_link_change_notify +1293 drivers/net/phy/mxl-gpy.c

  1017	
  1018	static struct phy_driver gpy_drivers[] = {
  1019		{
  1020			PHY_ID_MATCH_MODEL(PHY_ID_GPY2xx),
  1021			.name		= "Maxlinear Ethernet GPY2xx",
  1022			.get_features	= genphy_c45_pma_read_abilities,
  1023			.config_init	= gpy_config_init,
  1024			.probe		= gpy_probe,
  1025			.suspend	= genphy_suspend,
  1026			.resume		= genphy_resume,
  1027			.config_aneg	= gpy_config_aneg,
  1028			.aneg_done	= genphy_c45_aneg_done,
  1029			.read_status	= gpy_read_status,
  1030			.config_intr	= gpy_config_intr,
  1031			.handle_interrupt = gpy_handle_interrupt,
  1032			.set_wol	= gpy_set_wol,
  1033			.get_wol	= gpy_get_wol,
  1034			.set_loopback	= gpy_loopback,
  1035			.led_brightness_set = gpy_led_brightness_set,
  1036			.led_hw_is_supported = gpy_led_hw_is_supported,
  1037			.led_hw_control_get = gpy_led_hw_control_get,
  1038			.led_hw_control_set = gpy_led_hw_control_set,
  1039			.led_polarity_set = gpy_led_polarity_set,
  1040		},
  1041		{
  1042			.phy_id		= PHY_ID_GPY115B,
  1043			.phy_id_mask	= PHY_ID_GPYx15B_MASK,
  1044			.name		= "Maxlinear Ethernet GPY115B",
  1045			.get_features	= genphy_c45_pma_read_abilities,
  1046			.config_init	= gpy_config_init,
  1047			.probe		= gpy_probe,
  1048			.suspend	= genphy_suspend,
  1049			.resume		= genphy_resume,
  1050			.config_aneg	= gpy_config_aneg,
  1051			.aneg_done	= genphy_c45_aneg_done,
  1052			.read_status	= gpy_read_status,
  1053			.config_intr	= gpy_config_intr,
  1054			.handle_interrupt = gpy_handle_interrupt,
  1055			.set_wol	= gpy_set_wol,
  1056			.get_wol	= gpy_get_wol,
  1057			.set_loopback	= gpy115_loopback,
  1058			.led_brightness_set = gpy_led_brightness_set,
  1059			.led_hw_is_supported = gpy_led_hw_is_supported,
  1060			.led_hw_control_get = gpy_led_hw_control_get,
  1061			.led_hw_control_set = gpy_led_hw_control_set,
  1062			.led_polarity_set = gpy_led_polarity_set,
  1063		},
  1064		{
  1065			PHY_ID_MATCH_MODEL(PHY_ID_GPY115C),
  1066			.name		= "Maxlinear Ethernet GPY115C",
  1067			.get_features	= genphy_c45_pma_read_abilities,
  1068			.config_init	= gpy_config_init,
  1069			.probe		= gpy_probe,
  1070			.suspend	= genphy_suspend,
  1071			.resume		= genphy_resume,
  1072			.config_aneg	= gpy_config_aneg,
  1073			.aneg_done	= genphy_c45_aneg_done,
  1074			.read_status	= gpy_read_status,
  1075			.config_intr	= gpy_config_intr,
  1076			.handle_interrupt = gpy_handle_interrupt,
  1077			.set_wol	= gpy_set_wol,
  1078			.get_wol	= gpy_get_wol,
  1079			.set_loopback	= gpy115_loopback,
  1080			.led_brightness_set = gpy_led_brightness_set,
  1081			.led_hw_is_supported = gpy_led_hw_is_supported,
  1082			.led_hw_control_get = gpy_led_hw_control_get,
  1083			.led_hw_control_set = gpy_led_hw_control_set,
  1084			.led_polarity_set = gpy_led_polarity_set,
  1085		},
  1086		{
  1087			.phy_id		= PHY_ID_GPY211B,
  1088			.phy_id_mask	= PHY_ID_GPY21xB_MASK,
  1089			.name		= "Maxlinear Ethernet GPY211B",
  1090			.get_features	= genphy_c45_pma_read_abilities,
  1091			.config_init	= gpy21x_config_init,
  1092			.probe		= gpy_probe,
  1093			.suspend	= genphy_suspend,
  1094			.resume		= genphy_resume,
  1095			.config_aneg	= gpy_config_aneg,
  1096			.aneg_done	= genphy_c45_aneg_done,
  1097			.read_status	= gpy_read_status,
  1098			.config_intr	= gpy_config_intr,
  1099			.handle_interrupt = gpy_handle_interrupt,
  1100			.set_wol	= gpy_set_wol,
  1101			.get_wol	= gpy_get_wol,
  1102			.set_loopback	= gpy_loopback,
  1103			.led_brightness_set = gpy_led_brightness_set,
  1104			.led_hw_is_supported = gpy_led_hw_is_supported,
  1105			.led_hw_control_get = gpy_led_hw_control_get,
  1106			.led_hw_control_set = gpy_led_hw_control_set,
  1107			.led_polarity_set = gpy_led_polarity_set,
  1108		},
  1109		{
  1110			PHY_ID_MATCH_MODEL(PHY_ID_GPY211C),
  1111			.name		= "Maxlinear Ethernet GPY211C",
  1112			.get_features	= genphy_c45_pma_read_abilities,
  1113			.config_init	= gpy21x_config_init,
  1114			.probe		= gpy_probe,
  1115			.suspend	= genphy_suspend,
  1116			.resume		= genphy_resume,
  1117			.config_aneg	= gpy_config_aneg,
  1118			.aneg_done	= genphy_c45_aneg_done,
  1119			.read_status	= gpy_read_status,
  1120			.config_intr	= gpy_config_intr,
  1121			.handle_interrupt = gpy_handle_interrupt,
  1122			.set_wol	= gpy_set_wol,
  1123			.get_wol	= gpy_get_wol,
  1124			.set_loopback	= gpy_loopback,
  1125			.led_brightness_set = gpy_led_brightness_set,
  1126			.led_hw_is_supported = gpy_led_hw_is_supported,
  1127			.led_hw_control_get = gpy_led_hw_control_get,
  1128			.led_hw_control_set = gpy_led_hw_control_set,
  1129			.led_polarity_set = gpy_led_polarity_set,
  1130		},
  1131		{
  1132			.phy_id		= PHY_ID_GPY212B,
  1133			.phy_id_mask	= PHY_ID_GPY21xB_MASK,
  1134			.name		= "Maxlinear Ethernet GPY212B",
  1135			.get_features	= genphy_c45_pma_read_abilities,
  1136			.config_init	= gpy21x_config_init,
  1137			.probe		= gpy_probe,
  1138			.suspend	= genphy_suspend,
  1139			.resume		= genphy_resume,
  1140			.config_aneg	= gpy_config_aneg,
  1141			.aneg_done	= genphy_c45_aneg_done,
  1142			.read_status	= gpy_read_status,
  1143			.config_intr	= gpy_config_intr,
  1144			.handle_interrupt = gpy_handle_interrupt,
  1145			.set_wol	= gpy_set_wol,
  1146			.get_wol	= gpy_get_wol,
  1147			.set_loopback	= gpy_loopback,
  1148			.led_brightness_set = gpy_led_brightness_set,
  1149			.led_hw_is_supported = gpy_led_hw_is_supported,
  1150			.led_hw_control_get = gpy_led_hw_control_get,
  1151			.led_hw_control_set = gpy_led_hw_control_set,
  1152			.led_polarity_set = gpy_led_polarity_set,
  1153		},
  1154		{
  1155			PHY_ID_MATCH_MODEL(PHY_ID_GPY212C),
  1156			.name		= "Maxlinear Ethernet GPY212C",
  1157			.get_features	= genphy_c45_pma_read_abilities,
  1158			.config_init	= gpy21x_config_init,
  1159			.probe		= gpy_probe,
  1160			.suspend	= genphy_suspend,
  1161			.resume		= genphy_resume,
  1162			.config_aneg	= gpy_config_aneg,
  1163			.aneg_done	= genphy_c45_aneg_done,
  1164			.read_status	= gpy_read_status,
  1165			.config_intr	= gpy_config_intr,
  1166			.handle_interrupt = gpy_handle_interrupt,
  1167			.set_wol	= gpy_set_wol,
  1168			.get_wol	= gpy_get_wol,
  1169			.set_loopback	= gpy_loopback,
  1170			.led_brightness_set = gpy_led_brightness_set,
  1171			.led_hw_is_supported = gpy_led_hw_is_supported,
  1172			.led_hw_control_get = gpy_led_hw_control_get,
  1173			.led_hw_control_set = gpy_led_hw_control_set,
  1174			.led_polarity_set = gpy_led_polarity_set,
  1175		},
  1176		{
  1177			.phy_id		= PHY_ID_GPY215B,
  1178			.phy_id_mask	= PHY_ID_GPYx15B_MASK,
  1179			.name		= "Maxlinear Ethernet GPY215B",
  1180			.get_features	= genphy_c45_pma_read_abilities,
  1181			.config_init	= gpy21x_config_init,
  1182			.probe		= gpy_probe,
  1183			.suspend	= genphy_suspend,
  1184			.resume		= genphy_resume,
  1185			.config_aneg	= gpy_config_aneg,
  1186			.aneg_done	= genphy_c45_aneg_done,
  1187			.read_status	= gpy_read_status,
  1188			.config_intr	= gpy_config_intr,
  1189			.handle_interrupt = gpy_handle_interrupt,
  1190			.set_wol	= gpy_set_wol,
  1191			.get_wol	= gpy_get_wol,
  1192			.set_loopback	= gpy_loopback,
  1193			.led_brightness_set = gpy_led_brightness_set,
  1194			.led_hw_is_supported = gpy_led_hw_is_supported,
  1195			.led_hw_control_get = gpy_led_hw_control_get,
  1196			.led_hw_control_set = gpy_led_hw_control_set,
  1197			.led_polarity_set = gpy_led_polarity_set,
  1198		},
  1199		{
  1200			PHY_ID_MATCH_MODEL(PHY_ID_GPY215C),
  1201			.name		= "Maxlinear Ethernet GPY215C",
  1202			.get_features	= genphy_c45_pma_read_abilities,
  1203			.config_init	= gpy21x_config_init,
  1204			.probe		= gpy_probe,
  1205			.suspend	= genphy_suspend,
  1206			.resume		= genphy_resume,
  1207			.config_aneg	= gpy_config_aneg,
  1208			.aneg_done	= genphy_c45_aneg_done,
  1209			.read_status	= gpy_read_status,
  1210			.config_intr	= gpy_config_intr,
  1211			.handle_interrupt = gpy_handle_interrupt,
  1212			.set_wol	= gpy_set_wol,
  1213			.get_wol	= gpy_get_wol,
  1214			.set_loopback	= gpy_loopback,
  1215			.led_brightness_set = gpy_led_brightness_set,
  1216			.led_hw_is_supported = gpy_led_hw_is_supported,
  1217			.led_hw_control_get = gpy_led_hw_control_get,
  1218			.led_hw_control_set = gpy_led_hw_control_set,
  1219			.led_polarity_set = gpy_led_polarity_set,
  1220		},
  1221		{
  1222			PHY_ID_MATCH_MODEL(PHY_ID_GPY241B),
  1223			.name		= "Maxlinear Ethernet GPY241B",
  1224			.get_features	= genphy_c45_pma_read_abilities,
  1225			.config_init	= gpy_config_init,
  1226			.probe		= gpy_probe,
  1227			.suspend	= genphy_suspend,
  1228			.resume		= genphy_resume,
  1229			.config_aneg	= gpy_config_aneg,
  1230			.aneg_done	= genphy_c45_aneg_done,
  1231			.read_status	= gpy_read_status,
  1232			.config_intr	= gpy_config_intr,
  1233			.handle_interrupt = gpy_handle_interrupt,
  1234			.set_wol	= gpy_set_wol,
  1235			.get_wol	= gpy_get_wol,
  1236			.set_loopback	= gpy_loopback,
  1237		},
  1238		{
  1239			PHY_ID_MATCH_MODEL(PHY_ID_GPY241BM),
  1240			.name		= "Maxlinear Ethernet GPY241BM",
  1241			.get_features	= genphy_c45_pma_read_abilities,
  1242			.config_init	= gpy_config_init,
  1243			.probe		= gpy_probe,
  1244			.suspend	= genphy_suspend,
  1245			.resume		= genphy_resume,
  1246			.config_aneg	= gpy_config_aneg,
  1247			.aneg_done	= genphy_c45_aneg_done,
  1248			.read_status	= gpy_read_status,
  1249			.config_intr	= gpy_config_intr,
  1250			.handle_interrupt = gpy_handle_interrupt,
  1251			.set_wol	= gpy_set_wol,
  1252			.get_wol	= gpy_get_wol,
  1253			.set_loopback	= gpy_loopback,
  1254		},
  1255		{
  1256			PHY_ID_MATCH_MODEL(PHY_ID_GPY245B),
  1257			.name		= "Maxlinear Ethernet GPY245B",
  1258			.get_features	= genphy_c45_pma_read_abilities,
  1259			.config_init	= gpy_config_init,
  1260			.probe		= gpy_probe,
  1261			.suspend	= genphy_suspend,
  1262			.resume		= genphy_resume,
  1263			.config_aneg	= gpy_config_aneg,
  1264			.aneg_done	= genphy_c45_aneg_done,
  1265			.read_status	= gpy_read_status,
  1266			.config_intr	= gpy_config_intr,
  1267			.handle_interrupt = gpy_handle_interrupt,
  1268			.set_wol	= gpy_set_wol,
  1269			.get_wol	= gpy_get_wol,
  1270			.set_loopback	= gpy_loopback,
  1271		},
  1272		{
  1273			PHY_ID_MATCH_MODEL(PHY_ID_MXL86211C),
  1274			.name		= "Maxlinear Ethernet MXL86211C",
  1275			.get_features	= genphy_c45_pma_read_abilities,
  1276			.config_init	= gpy_config_init,
  1277			.probe		= gpy_probe,
  1278			.suspend	= genphy_suspend,
  1279			.resume		= genphy_resume,
  1280			.config_aneg	= gpy_config_aneg,
  1281			.aneg_done	= genphy_c45_aneg_done,
  1282			.read_status	= gpy_read_status,
  1283			.config_intr	= gpy_config_intr,
  1284			.handle_interrupt = gpy_handle_interrupt,
  1285			.set_wol	= gpy_set_wol,
  1286			.get_wol	= gpy_get_wol,
  1287			.set_loopback	= gpy_loopback,
  1288			.led_brightness_set = gpy_led_brightness_set,
  1289			.led_hw_is_supported = gpy_led_hw_is_supported,
  1290			.led_hw_control_get = gpy_led_hw_control_get,
  1291			.led_hw_control_set = gpy_led_hw_control_set,
  1292			.led_polarity_set = gpy_led_polarity_set,
> 1293			.link_change_notify = gpy_link_change_notify,
  1294		},
  1295	};
> 1296	module_phy_driver(gpy_drivers);
  1297	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

