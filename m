Return-Path: <netdev+bounces-238007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FABC52AAE
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 15:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 888E2501E1E
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 14:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E35422DA1C;
	Wed, 12 Nov 2025 13:59:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B1C22A4FC
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 13:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762955989; cv=none; b=d9LByQl1yjr+MzXkssSAbL9bSSOkoe+bHdXWSVHyl0zVJsKhpEOf/LVX3IH3hsvaLy6yzIeMt3yUBfbIdAqZGaClA5VE3tAsOW8oThmajiRcJeDsqi+kDe6XQ05EdjVIcFWp4eXTAAtrhQxfQbMJc6tn79X9LmaSEI2fbmr2Btg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762955989; c=relaxed/simple;
	bh=67y+QB76LKUgMYByonrQ6NzfyzBodpUa58l3578dYwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4vXonVmgj523L990I4wYfzRpX8gSyua3vRWwX8kxaueGoI1KRSaPbLr7PzQ9vP0EfzJQkiEkYgsF8Gr7QEctZ5fTPeeLiF8hVQzdNAUE6+LcWDyyTBvHk/cSFo9m5fB+ZUJJ4Yb2Fo4d17w50L/YpxhwE8/BLvZqDLkYXer5uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vJBNv-0002U7-MH; Wed, 12 Nov 2025 14:59:43 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vJBNv-0005pt-1c;
	Wed, 12 Nov 2025 14:59:43 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vJBNv-000000019xs-1lJB;
	Wed, 12 Nov 2025 14:59:43 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: linux@armlinux.org.uk,
	netdev@vger.kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH] net: dp83822/dp83tc811: do not blacklist EEE for now
Date: Wed, 12 Nov 2025 14:59:35 +0100
Message-ID: <20251112135935.266945-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aRRGbAR26GuyKKZl@shell.armlinux.org.uk>
References: <aRRGbAR26GuyKKZl@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

dp83822 driver is supporting DP83822/25/26 PHYs, which are
all 100Mbit variants. TI support forum says - only 1Gbit variants are
broken.

dp83tc811 driver is supporting 1000BaseT1 SPE variant, which do not has
autoneg support towards MDI.

Note: dp83tc811 wires phydev->autoneg to control SGMII autoneg, which
can't be proper decision. But it is a different issue.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/dp83822.c   | 3 ---
 drivers/net/phy/dp83tc811.c | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index 20caf9a5faa7..33db21251f2e 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -1160,7 +1160,6 @@ static int dp83822_led_hw_control_get(struct phy_device *phydev, u8 index,
 		.name		= (_name),			\
 		/* PHY_BASIC_FEATURES */			\
 		.probe          = dp83822_probe,		\
-		.get_features	= phy_get_features_no_eee,	\
 		.soft_reset	= dp83822_phy_reset,		\
 		.config_init	= dp83822_config_init,		\
 		.read_status	= dp83822_read_status,		\
@@ -1181,7 +1180,6 @@ static int dp83822_led_hw_control_get(struct phy_device *phydev, u8 index,
 		.name		= (_name),			\
 		/* PHY_BASIC_FEATURES */			\
 		.probe          = dp8382x_probe,		\
-		.get_features	= phy_get_features_no_eee,	\
 		.soft_reset	= dp83822_phy_reset,		\
 		.config_init	= dp83825_config_init,		\
 		.get_wol = dp83822_get_wol,			\
@@ -1198,7 +1196,6 @@ static int dp83822_led_hw_control_get(struct phy_device *phydev, u8 index,
 		.name		= (_name),			\
 		/* PHY_BASIC_FEATURES */			\
 		.probe          = dp83826_probe,		\
-		.get_features	= phy_get_features_no_eee,	\
 		.soft_reset	= dp83822_phy_reset,		\
 		.config_init	= dp83826_config_init,		\
 		.get_wol = dp83822_get_wol,			\
diff --git a/drivers/net/phy/dp83tc811.c b/drivers/net/phy/dp83tc811.c
index 92c5f3cfee9e..e480c2a07450 100644
--- a/drivers/net/phy/dp83tc811.c
+++ b/drivers/net/phy/dp83tc811.c
@@ -390,7 +390,6 @@ static struct phy_driver dp83811_driver[] = {
 		.phy_id_mask = 0xfffffff0,
 		.name = "TI DP83TC811",
 		/* PHY_BASIC_FEATURES */
-		.get_features = phy_get_features_no_eee,
 		.config_init = dp83811_config_init,
 		.config_aneg = dp83811_config_aneg,
 		.soft_reset = dp83811_phy_reset,
-- 
2.47.3


