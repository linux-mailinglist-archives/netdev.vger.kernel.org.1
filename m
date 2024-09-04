Return-Path: <netdev+bounces-124927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD3D96B630
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655AC1F25D16
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315E11CCB35;
	Wed,  4 Sep 2024 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="T93nZzG4"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFE31CC8A2;
	Wed,  4 Sep 2024 09:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441070; cv=none; b=pfH9lpd7Ker2jieawkwQEqObMykk29gAZjqwHDU+B3Wa9m4JofF3lGswcaAjFh1VT14JQ7L4R/7zxcz5ZiqW2zwQx0PEdynlInh3EzzIBPPs5097aaP976dLp1oOo5b6MVtSjvrH6YAi+ObOHauGGt7akVQPkJogbV5IhSiIqOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441070; c=relaxed/simple;
	bh=fWTfPILzAetLL/U2fZPTkSMXsvjy+9i1q5L7nB9rYS0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TLotKcw7LekcljFgvmKjvbr4NaN1MUU+0LCPIdOI3J+LMz1kksYlPm2CFN1f4dGRLccC0lUFw+9+dbbmZF+7nxDZm8eY/hG0vnV08w/qsQC0R8Vm6jjS5kRr9dU/4lMyAr+Vdo/6jOu8MRChkqKJAIVrwrEhFe4JwYqAh3dnTc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=T93nZzG4; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725441068; x=1756977068;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fWTfPILzAetLL/U2fZPTkSMXsvjy+9i1q5L7nB9rYS0=;
  b=T93nZzG4MGxc3iKRpe3+j+zpClP8QoMuR+SnMT4vo+iXHGiz7mbDkq9L
   IXPyyLuERh+BziweI65d6g/QsTCWuGTAqqznrul916IaZmS4A/GExjptg
   XPqpOMX3CYAcwzXb2QMinGCVYtl1vEQR/erx3n8cAkw8alMmP7SYgJYWc
   P8/iR+/KkdNJiR4TkQhRemUwllARnn1v0PmktHYrQ5/Z7cc5zO3Ed31r8
   8Iuq2htKYC/SvoNCa4jyiNREhX+5UdIYqZaCYlg9fyxYlS471g0LLvvc1
   2FGqMLnZzGdAajevn2zY4DM6cv8iAs6UoDc0cTzzkIiNQYjfX+FvhrFZA
   Q==;
X-CSE-ConnectionGUID: 7PtRIbY4RQKJyDxiveGaEQ==
X-CSE-MsgGUID: YjJR6EY/T9OIVt2StvdP/A==
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="31941447"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2024 02:11:07 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 4 Sep 2024 02:10:36 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 4 Sep 2024 02:10:32 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <linux@armlinux.org.uk>, <kuba@kernel.org>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <richardcochran@gmail.com>,
	<rdunlap@infradead.org>, <bryan.whitehead@microchip.com>,
	<edumazet@google.com>, <pabeni@redhat.com>, <maxime.chevallier@bootlin.com>,
	<linux-kernel@vger.kernel.org>, <horms@kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next V5 0/5] Add support to PHYLINK for LAN743x/PCI11x1x chips
Date: Wed, 4 Sep 2024 14:36:40 +0530
Message-ID: <20240904090645.8742-1-Raju.Lakkaraju@microchip.com>
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
 .../net/ethernet/microchip/lan743x_ethtool.c  | 119 ++--
 drivers/net/ethernet/microchip/lan743x_main.c | 672 +++++++++++-------
 drivers/net/ethernet/microchip/lan743x_main.h |   4 +
 drivers/net/phy/phylink.c                     |  42 ++
 include/linux/phylink.h                       |   2 +
 6 files changed, 520 insertions(+), 324 deletions(-)

-- 
2.34.1


