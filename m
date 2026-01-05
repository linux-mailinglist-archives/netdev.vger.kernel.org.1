Return-Path: <netdev+bounces-247128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66102CF4C61
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 17:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7A443065E0C
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 16:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A885307AD5;
	Mon,  5 Jan 2026 16:38:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5486933A9E2;
	Mon,  5 Jan 2026 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631085; cv=none; b=EWTb2UvasB5BHqZ5YMArYAEx3iGGw+56auidW9+bJi4GT2d2QRxK49nX8wkD8ziXXInpawLYW69vxeMj+f4Z0zSti7ocWPhnFehXUKfMscWPFSvnfZo6bHSaBN1OL1Y0mKcyHs8s41ixDOnvNQ8jC/PofbeXlk9zq8taiUVqE60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631085; c=relaxed/simple;
	bh=f1Xz/8Aaiy5bvEd0QO1NbKWa6tG7E23dKQbBQ3cXYDQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYdLr/I7D+8dgCUP7pkjMyS8EvbVwbz4EyYjQT21QEn2GInFyHIUW5+A75PXmxIRV7nXKC9Px/RLttPEzlJpRBVgTxbzke+ACcATRsZA1avsCM5gtDwHDl/qF4ZmfGRxCjz0Y05AOeqWfFmxv4ybCiI+lBsv73kZa+Tq2sflWOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vcnaf-000000000xU-33Jc;
	Mon, 05 Jan 2026 16:37:57 +0000
Date: Mon, 5 Jan 2026 16:37:54 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Klein <michael@fossekall.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Bevan Weiss <bevan.weiss@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/5] net: phy: realtek: fix whitespace in struct
 phy_driver initializers
Message-ID: <42b0fac53c5c5646707ce3f3a6dacd2bc082a5b2.1767630451.git.daniel@makrotopia.org>
References: <cover.1767630451.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1767630451.git.daniel@makrotopia.org>

Consistently use tabs instead of spaces in struct phy_driver
initializers.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: no changes

 drivers/net/phy/realtek/realtek_main.c | 146 ++++++++++++-------------
 1 file changed, 73 insertions(+), 73 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 6ff0385201a57..e42c5efbfa5ef 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -1976,7 +1976,7 @@ static irqreturn_t rtl8221b_handle_interrupt(struct phy_device *phydev)
 static struct phy_driver realtek_drvs[] = {
 	{
 		PHY_ID_MATCH_EXACT(0x00008201),
-		.name           = "RTL8201CP Ethernet",
+		.name		= "RTL8201CP Ethernet",
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
 	}, {
@@ -2102,7 +2102,7 @@ static struct phy_driver realtek_drvs[] = {
 		.name		= "RTL8226B_RTL8221B 2.5Gbps PHY",
 		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
-		.config_init    = rtl822xb_config_init,
+		.config_init	= rtl822xb_config_init,
 		.get_rate_matching = rtl822xb_get_rate_matching,
 		.read_status	= rtl822xb_read_status,
 		.suspend	= genphy_suspend,
@@ -2111,112 +2111,112 @@ static struct phy_driver realtek_drvs[] = {
 		.write_page	= rtl821x_write_page,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc838),
-		.name           = "RTL8226-CG 2.5Gbps PHY",
-		.soft_reset     = rtl822x_c45_soft_reset,
-		.get_features   = rtl822x_c45_get_features,
-		.config_aneg    = rtl822x_c45_config_aneg,
-		.config_init    = rtl822x_config_init,
-		.read_status    = rtl822xb_c45_read_status,
-		.suspend        = genphy_c45_pma_suspend,
-		.resume         = rtlgen_c45_resume,
+		.name		= "RTL8226-CG 2.5Gbps PHY",
+		.soft_reset	= rtl822x_c45_soft_reset,
+		.get_features	= rtl822x_c45_get_features,
+		.config_aneg	= rtl822x_c45_config_aneg,
+		.config_init	= rtl822x_config_init,
+		.read_status	= rtl822xb_c45_read_status,
+		.suspend	= genphy_c45_pma_suspend,
+		.resume		= rtlgen_c45_resume,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc848),
-		.name           = "RTL8226B-CG_RTL8221B-CG 2.5Gbps PHY",
-		.get_features   = rtl822x_get_features,
-		.config_aneg    = rtl822x_config_aneg,
-		.config_init    = rtl822xb_config_init,
+		.name		= "RTL8226B-CG_RTL8221B-CG 2.5Gbps PHY",
+		.get_features	= rtl822x_get_features,
+		.config_aneg	= rtl822x_config_aneg,
+		.config_init	= rtl822xb_config_init,
 		.get_rate_matching = rtl822xb_get_rate_matching,
-		.read_status    = rtl822xb_read_status,
-		.suspend        = genphy_suspend,
-		.resume         = rtlgen_resume,
-		.read_page      = rtl821x_read_page,
-		.write_page     = rtl821x_write_page,
+		.read_status	= rtl822xb_read_status,
+		.suspend	= genphy_suspend,
+		.resume		= rtlgen_resume,
+		.read_page	= rtl821x_read_page,
+		.write_page	= rtl821x_write_page,
 	}, {
 		.match_phy_device = rtl8221b_vb_cg_c22_match_phy_device,
-		.name           = "RTL8221B-VB-CG 2.5Gbps PHY (C22)",
+		.name		= "RTL8221B-VB-CG 2.5Gbps PHY (C22)",
 		.probe		= rtl822x_probe,
-		.get_features   = rtl822x_get_features,
-		.config_aneg    = rtl822x_config_aneg,
-		.config_init    = rtl822xb_config_init,
+		.get_features	= rtl822x_get_features,
+		.config_aneg	= rtl822x_config_aneg,
+		.config_init	= rtl822xb_config_init,
 		.get_rate_matching = rtl822xb_get_rate_matching,
-		.read_status    = rtl822xb_read_status,
-		.suspend        = genphy_suspend,
-		.resume         = rtlgen_resume,
-		.read_page      = rtl821x_read_page,
-		.write_page     = rtl821x_write_page,
+		.read_status	= rtl822xb_read_status,
+		.suspend	= genphy_suspend,
+		.resume		= rtlgen_resume,
+		.read_page	= rtl821x_read_page,
+		.write_page	= rtl821x_write_page,
 	}, {
 		.match_phy_device = rtl8221b_vb_cg_c45_match_phy_device,
-		.name           = "RTL8221B-VB-CG 2.5Gbps PHY (C45)",
+		.name		= "RTL8221B-VB-CG 2.5Gbps PHY (C45)",
 		.config_intr	= rtl8221b_config_intr,
 		.handle_interrupt = rtl8221b_handle_interrupt,
 		.probe		= rtl822x_probe,
-		.config_init    = rtl822xb_config_init,
+		.config_init	= rtl822xb_config_init,
 		.get_rate_matching = rtl822xb_get_rate_matching,
-		.get_features   = rtl822x_c45_get_features,
-		.config_aneg    = rtl822x_c45_config_aneg,
-		.read_status    = rtl822xb_c45_read_status,
-		.suspend        = genphy_c45_pma_suspend,
-		.resume         = rtlgen_c45_resume,
+		.get_features	= rtl822x_c45_get_features,
+		.config_aneg	= rtl822x_c45_config_aneg,
+		.read_status	= rtl822xb_c45_read_status,
+		.suspend	= genphy_c45_pma_suspend,
+		.resume		= rtlgen_c45_resume,
 	}, {
 		.match_phy_device = rtl8221b_vm_cg_c22_match_phy_device,
-		.name           = "RTL8221B-VM-CG 2.5Gbps PHY (C22)",
+		.name		= "RTL8221B-VM-CG 2.5Gbps PHY (C22)",
 		.probe		= rtl822x_probe,
-		.get_features   = rtl822x_get_features,
-		.config_aneg    = rtl822x_config_aneg,
-		.config_init    = rtl822xb_config_init,
+		.get_features	= rtl822x_get_features,
+		.config_aneg	= rtl822x_config_aneg,
+		.config_init	= rtl822xb_config_init,
 		.get_rate_matching = rtl822xb_get_rate_matching,
-		.read_status    = rtl822xb_read_status,
-		.suspend        = genphy_suspend,
-		.resume         = rtlgen_resume,
-		.read_page      = rtl821x_read_page,
-		.write_page     = rtl821x_write_page,
+		.read_status	= rtl822xb_read_status,
+		.suspend	= genphy_suspend,
+		.resume		= rtlgen_resume,
+		.read_page	= rtl821x_read_page,
+		.write_page	= rtl821x_write_page,
 	}, {
 		.match_phy_device = rtl8221b_vm_cg_c45_match_phy_device,
-		.name           = "RTL8221B-VM-CG 2.5Gbps PHY (C45)",
+		.name		= "RTL8221B-VM-CG 2.5Gbps PHY (C45)",
 		.config_intr	= rtl8221b_config_intr,
 		.handle_interrupt = rtl8221b_handle_interrupt,
 		.probe		= rtl822x_probe,
-		.config_init    = rtl822xb_config_init,
+		.config_init	= rtl822xb_config_init,
 		.get_rate_matching = rtl822xb_get_rate_matching,
-		.get_features   = rtl822x_c45_get_features,
-		.config_aneg    = rtl822x_c45_config_aneg,
-		.read_status    = rtl822xb_c45_read_status,
-		.suspend        = genphy_c45_pma_suspend,
-		.resume         = rtlgen_c45_resume,
+		.get_features	= rtl822x_c45_get_features,
+		.config_aneg	= rtl822x_c45_config_aneg,
+		.read_status	= rtl822xb_c45_read_status,
+		.suspend	= genphy_c45_pma_suspend,
+		.resume		= rtlgen_c45_resume,
 	}, {
 		.match_phy_device = rtl8251b_c45_match_phy_device,
-		.name           = "RTL8251B 5Gbps PHY",
+		.name		= "RTL8251B 5Gbps PHY",
 		.probe		= rtl822x_probe,
-		.get_features   = rtl822x_get_features,
-		.config_aneg    = rtl822x_config_aneg,
-		.read_status    = rtl822x_read_status,
-		.suspend        = genphy_suspend,
-		.resume         = rtlgen_resume,
-		.read_page      = rtl821x_read_page,
-		.write_page     = rtl821x_write_page,
+		.get_features	= rtl822x_get_features,
+		.config_aneg	= rtl822x_config_aneg,
+		.read_status	= rtl822x_read_status,
+		.suspend	= genphy_suspend,
+		.resume		= rtlgen_resume,
+		.read_page	= rtl821x_read_page,
+		.write_page	= rtl821x_write_page,
 	}, {
 		.match_phy_device = rtl_internal_nbaset_match_phy_device,
-		.name           = "Realtek Internal NBASE-T PHY",
+		.name		= "Realtek Internal NBASE-T PHY",
 		.flags		= PHY_IS_INTERNAL,
 		.probe		= rtl822x_probe,
-		.get_features   = rtl822x_get_features,
-		.config_aneg    = rtl822x_config_aneg,
-		.read_status    = rtl822x_read_status,
-		.suspend        = genphy_suspend,
-		.resume         = rtlgen_resume,
-		.read_page      = rtl821x_read_page,
-		.write_page     = rtl821x_write_page,
+		.get_features	= rtl822x_get_features,
+		.config_aneg	= rtl822x_config_aneg,
+		.read_status	= rtl822x_read_status,
+		.suspend	= genphy_suspend,
+		.resume		= rtlgen_resume,
+		.read_page	= rtl821x_read_page,
+		.write_page	= rtl821x_write_page,
 		.read_mmd	= rtl822x_read_mmd,
 		.write_mmd	= rtl822x_write_mmd,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001ccad0),
 		.name		= "RTL8224 2.5Gbps PHY",
 		.flags		= PHY_POLL_CABLE_TEST,
-		.get_features   = rtl822x_c45_get_features,
-		.config_aneg    = rtl822x_c45_config_aneg,
-		.read_status    = rtl822x_c45_read_status,
-		.suspend        = genphy_c45_pma_suspend,
-		.resume         = rtlgen_c45_resume,
+		.get_features	= rtl822x_c45_get_features,
+		.config_aneg	= rtl822x_c45_config_aneg,
+		.read_status	= rtl822x_c45_read_status,
+		.suspend	= genphy_c45_pma_suspend,
+		.resume		= rtlgen_c45_resume,
 		.cable_test_start = rtl8224_cable_test_start,
 		.cable_test_get_status = rtl8224_cable_test_get_status,
 	}, {
@@ -2235,7 +2235,7 @@ static struct phy_driver realtek_drvs[] = {
 	}, {
 		PHY_ID_MATCH_EXACT(0x001ccb00),
 		.name		= "RTL9000AA_RTL9000AN Ethernet",
-		.features       = PHY_BASIC_T1_FEATURES,
+		.features	= PHY_BASIC_T1_FEATURES,
 		.config_init	= rtl9000a_config_init,
 		.config_aneg	= rtl9000a_config_aneg,
 		.read_status	= rtl9000a_read_status,
-- 
2.52.0

