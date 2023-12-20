Return-Path: <netdev+bounces-59279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF43281A344
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 16:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37CC284F15
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 15:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC7C4174F;
	Wed, 20 Dec 2023 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsRjgXTQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7453F4123F
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 15:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FF4C433C8;
	Wed, 20 Dec 2023 15:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703087741;
	bh=YA4C2rvaNt3CD9I5+LSUNt6HD1Jzvog4UWBVauzIASg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MsRjgXTQvaNJV6Pn0wQ5v9GZ1sNoC8LhzuLUgT+2S5XIH9gONJCyTjC6C7HB+Q+2g
	 gscP2EowsbU4sT16N2woumUILp6y7Wbj4yHC4Ug2yErMLgYzx9mvAK4gw8rZllEpgx
	 h+x6zbDYbyVkmdUeqK0AoSp25MJdfCsW+ly/6yu0bOwzG+JBOd17IHWu5XRJbpr2wF
	 BwMNxCjhCY7vTD2qmzwJ3YLp2aDh6RiBllEz3k99HJELq/R4UipC++HDQd1NRXRvCQ
	 wzRL7KMb1O1Ncsrn0Eqj3m8PCZfBokKCPxVs0YOtadjR4nE/eiVvmtnBPryal1nMpC
	 uXwc4h7HJE+zw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
	Alexander Couzens <lynxis@fe80.eu>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Willy Liu <willy.liu@realtek.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	=?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
	=?UTF-8?q?Maximili=C3=A1n=20Maliar?= <maximilian.maliar@nic.cz>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net-next 06/15] net: phy: realtek: use generic MDIO constants
Date: Wed, 20 Dec 2023 16:55:09 +0100
Message-ID: <20231220155518.15692-7-kabel@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231220155518.15692-1-kabel@kernel.org>
References: <20231220155518.15692-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Drop the ad-hoc MDIO constants used in the driver and use generic
constants instead.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/phy/realtek.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 8f11320b38a8..52a7022d6a64 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -57,14 +57,6 @@
 #define RTL8366RB_POWER_SAVE			0x15
 #define RTL8366RB_POWER_SAVE_ON			BIT(12)
 
-#define RTL_SUPPORTS_5000FULL			BIT(14)
-#define RTL_SUPPORTS_2500FULL			BIT(13)
-#define RTL_SUPPORTS_10000FULL			BIT(0)
-#define RTL_ADV_2500FULL			BIT(7)
-#define RTL_LPADV_10000FULL			BIT(11)
-#define RTL_LPADV_5000FULL			BIT(6)
-#define RTL_LPADV_2500FULL			BIT(5)
-
 #define RTL9000A_GINMR				0x14
 #define RTL9000A_GINMR_LINK_STATUS		BIT(4)
 
@@ -653,11 +645,11 @@ static int rtl822x_get_features(struct phy_device *phydev)
 		return val;
 
 	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
-			 phydev->supported, val & RTL_SUPPORTS_2500FULL);
+			 phydev->supported, val & MDIO_PMA_SPEED_2_5G);
 	linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
-			 phydev->supported, val & RTL_SUPPORTS_5000FULL);
+			 phydev->supported, val & MDIO_PMA_SPEED_5G);
 	linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
-			 phydev->supported, val & RTL_SUPPORTS_10000FULL);
+			 phydev->supported, val & MDIO_SPEED_10G);
 
 	return genphy_read_abilities(phydev);
 }
@@ -671,10 +663,11 @@ static int rtl822x_config_aneg(struct phy_device *phydev)
 
 		if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
 				      phydev->advertising))
-			adv2500 = RTL_ADV_2500FULL;
+			adv2500 = MDIO_AN_10GBT_CTRL_ADV2_5G;
 
 		ret = phy_modify_paged_changed(phydev, 0xa5d, 0x12,
-					       RTL_ADV_2500FULL, adv2500);
+					       MDIO_AN_10GBT_CTRL_ADV2_5G,
+					       adv2500);
 		if (ret < 0)
 			return ret;
 	}
@@ -693,11 +686,14 @@ static int rtl822x_read_status(struct phy_device *phydev)
 			return lpadv;
 
 		linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
-			phydev->lp_advertising, lpadv & RTL_LPADV_10000FULL);
+				 phydev->lp_advertising,
+				 lpadv & MDIO_AN_10GBT_STAT_LP10G);
 		linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
-			phydev->lp_advertising, lpadv & RTL_LPADV_5000FULL);
+				 phydev->lp_advertising,
+				 lpadv & MDIO_AN_10GBT_STAT_LP5G);
 		linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
-			phydev->lp_advertising, lpadv & RTL_LPADV_2500FULL);
+				 phydev->lp_advertising,
+				 lpadv & MDIO_AN_10GBT_STAT_LP2_5G);
 	}
 
 	ret = genphy_read_status(phydev);
@@ -715,7 +711,7 @@ static bool rtlgen_supports_2_5gbps(struct phy_device *phydev)
 	val = phy_read(phydev, 0x13);
 	phy_write(phydev, RTL821x_PAGE_SELECT, 0);
 
-	return val >= 0 && val & RTL_SUPPORTS_2500FULL;
+	return val >= 0 && val & MDIO_PMA_SPEED_2_5G;
 }
 
 static int rtlgen_match_phy_device(struct phy_device *phydev)
-- 
2.41.0


