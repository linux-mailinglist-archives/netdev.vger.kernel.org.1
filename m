Return-Path: <netdev+bounces-125880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B40B96F1B2
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 12:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778011C21D52
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 10:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DD01C9ED4;
	Fri,  6 Sep 2024 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="s5Cldfab"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1CC1C9ED1;
	Fri,  6 Sep 2024 10:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725619168; cv=none; b=ux8/MZC1dMQoXWMfEHsD8eqmvcSTcfQIFkryzBxOiM9geJuzzG87tmR1biuuw0/OTmV/Dxh+PptpYnqXmDCr2Sn5KQvrmv2k80I18GzJMwBbQ86JFgeJw1wHEVk21OTW7imGwdOvtNnIAm3nn2kz5HJSmMP7On/qbhvaooUYYqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725619168; c=relaxed/simple;
	bh=CpsXDjd9quxqlikAHrshQgUPiYPUj11GTeo+qM8OKaw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ayLaklfutxMge76FW83moRc5nIyJ3vicKcVEknIhnzmTCMjE6rooBLoOC7QdSULhr5fo090yzYX1w+NncfiRGhgWy4X7yuxUdlEhh7eC39/OL6PJ6i4+F1ytdRTJH7tEQJDg8vBTHMVGbXJOX06DJXMHX3UOXQoepaxjM1CTmYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=s5Cldfab; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725619166; x=1757155166;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CpsXDjd9quxqlikAHrshQgUPiYPUj11GTeo+qM8OKaw=;
  b=s5CldfabUUeaJOkLDT/bBKfBBG424SD37tB6rDJgxgCc3O505WrO4ohD
   Vod0ji+202086oGSUtP87W90myFJ2lTTc/GbMvJJaqPQBtz3QORH76r2E
   8Wyj7hCn/IxJ3YPLZ+UeSzPhKfu3O0W5sFG1XgqI95jvJ5uNIDI8HDopF
   BOCjEXnutmHY/EFqVpwir1w6NRq0qMwzG37rKjmmNpbsZIGp0li6DpKec
   +NDta7aGsqZw84SNE+klyWMNvMavvJOF744iKGMQo50HDkKTmOJITst36
   YXx71fJdY9H2nDl5yrxf0wL2ryGA76gz8V0w2eiHX6W5DU/rRUzttUvnx
   w==;
X-CSE-ConnectionGUID: ARynwNKwTMmFStNWNTzFxw==
X-CSE-MsgGUID: RKsHlUQ1SCucATRvq26xkw==
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="34530670"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Sep 2024 03:39:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 6 Sep 2024 03:39:03 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 6 Sep 2024 03:38:58 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <linux@armlinux.org.uk>, <kuba@kernel.org>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <richardcochran@gmail.com>,
	<rdunlap@infradead.org>, <bryan.whitehead@microchip.com>,
	<edumazet@google.com>, <pabeni@redhat.com>, <maxime.chevallier@bootlin.com>,
	<linux-kernel@vger.kernel.org>, <horms@kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next V6 0/5] Add support to PHYLINK for LAN743x/PCI11x1x chips
Date: Fri, 6 Sep 2024 16:05:06 +0530
Message-ID: <20240906103511.28416-1-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This is the follow-up patch series of
https://lkml.iu.edu/hypermail/linux/kernel/2310.2/02078.html

Divide the PHYLINK adaptation and SFP modifications into two separate patch
series.

The current patch series focuses on transitioning the LAN743x driver's PHY
support from phylib to phylink.

Tested on PCI11010 Rev-1 Evaluation board

Change List:
============
V5 -> V6:
  - Remove the lan743x_find_max_speed( ) function. Not require
  - Add EEE enable check before calling lan743x_mac_eee_enable( ) function
V4 -> V5:
  - Remove the fixed_phy_unregister( ) function. Not require 
  - Remove the "phydev->eee_enabled" check to update the MAC EEE
    enable/disable
  - Call lan743x_mac_eee_enable() with true after update tx_lpi_timer.
  - Add phy_support_eee() to initialize the EEE flags 
V3 -> V4:
  - Add fixed-link patch along with this series. 
    Note: Note: This code was developed by Mr.Russell King
    Ref: 
    https://lore.kernel.org/netdev/LV8PR11MB8700C786F5F1C274C73036CC9F8E2@LV8PR11MB8700.namprd11.prod.outlook.com/T/#me943adf54f1ea082edf294aba448fa003a116815
  - Change phylink fixed-link function header's string from "Returns" to
    "Returns:" 
  - Remove the EEE private variable from LAN743x adapter strcture and fix the
    EEE's set/get functions
  - set the individual caps (i.e. _RGMII, _RGMII_ID, _RGMII_RXID and
    __RGMII_TXID) replace with phy_interface_set_rgmii( ) function
  - Change lan743x_set_eee( ) to lan743x_mac_eee_enable( )

V2 -> V3:
  - Remove the unwanted parens in each of these if() sub-blocks 
  - Replace "to_net_dev(config->dev)" with "netdev".
  - Add GMII_ID/RGMII_TXID/RGMII_RXID in supported_interfaces
  - Fix the lan743x_phy_handle_exists( ) return type

V1 -> V2:
  - Fix the Russell King's comments i.e. remove the speed, duplex update in 
    lan743x_phylink_mac_config( )
  - pre-March 2020 legacy support has been removed

V0 -> V1:
  - Integrate with Synopsys DesignWare XPCS drivers
  - Based on external review comments,
  - Changes made to SGMII interface support only 1G/100M/10M bps speed
  - Changes made to 2500Base-X interface support only 2.5Gbps speed
  - Add check for not is_sgmii_en with is_sfp_support_en support
  - Change the "pci11x1x_strap_get_status" function return type from void to
    int
  - Add ethtool phylink wol, eee, pause get/set functions

Raju Lakkaraju (5):
  net: phylink: Add phylink_set_fixed_link() to configure fixed link
    state in phylink
  net: lan743x: Create separate PCS power reset function
  net: lan743x: Create separate Link Speed Duplex state function
  net: lan743x: Migrate phylib to phylink
  net: lan743x: Add support to ethtool phylink get and set settings

 drivers/net/ethernet/microchip/Kconfig        |   5 +-
 .../net/ethernet/microchip/lan743x_ethtool.c  | 123 ++--
 drivers/net/ethernet/microchip/lan743x_main.c | 646 +++++++++++-------
 drivers/net/ethernet/microchip/lan743x_main.h |   4 +
 drivers/net/phy/phylink.c                     |  42 ++
 include/linux/phylink.h                       |   2 +
 6 files changed, 498 insertions(+), 324 deletions(-)

-- 
2.34.1


