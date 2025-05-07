Return-Path: <netdev+bounces-188595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C46AADC48
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 12:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299A39A0B77
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 10:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDB320CCFB;
	Wed,  7 May 2025 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="jFmYYcVR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="JOtr5PqX"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44760748D;
	Wed,  7 May 2025 10:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746612829; cv=none; b=dbY+362Ht2iqE4Th3Bm7d06f/MLhuy2G9LX8Ub6EEBPmRQd17PHmqwfoadRY+K8G7F/bJtII2309Vw2tA3OU7wyvcAJndk9Wj44v7U7rGpnylvhsKn1xByoXlXBljJyjukfYkXJNV0dXMCy+wd3pJcZYGiFzQj1v2RJJYAUx3YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746612829; c=relaxed/simple;
	bh=t2XFlw2L1GGM20gom8kNAAPN4Q3gnxFhpVJoTUsa5QA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UD4IzHmaxdV3hV2BBNcHUXKIpMlInyvIs3PtuX6vdr7SP29mp570EednJdNU1kaJWQ0c7gjHcP9GJUj2SGKQKroqaxUQgQTu/YZj7mkUuhtqAajMvzRF5ta9boCDVF6uqDIgQ7I6I889qqHXYHurxox33lsjLM9ss5ms5oTiP6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=jFmYYcVR; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=JOtr5PqX reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1746612825; x=1778148825;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2QQaB7DRTxqSqjpS2zVPzCvKkCTWVQMMXRupiETUnoA=;
  b=jFmYYcVRLvZqwT/jLByJXS/hktryGFtEwTWmMz09+nDna/s6MdRTE5p9
   KlVmrWH1ln5DokMBT4pQudItGflUi+w4YD89gzLM381FitemETR9pEoIw
   L7NvSw3Gywf/6KNtrH0ZMCxA9gCFIpTdsUWUMeoPP6hIpUyJC4QT8f614
   JD4WTnrV+wCr75PAZCi3qZi8l1g90FZqQOzjtVH0FvOTqQRjQn1aO09OY
   WBRVTN2S+jktD6KR32ZeZZTfqcHLXm3PQPpvLsWx5Yai55tuHhK3sNDqG
   Iiqt1c4ntdxhVR4IJfNdSDotlKEpBorldac2z2VPicDX4ckZzpdaJFB+A
   Q==;
X-CSE-ConnectionGUID: A+sm3Yb4Rh2uGt8v0PnkKw==
X-CSE-MsgGUID: S5wQfo/uRkKGMiH+vSsLTQ==
X-IronPort-AV: E=Sophos;i="6.15,269,1739833200"; 
   d="scan'208";a="43932318"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 07 May 2025 12:13:42 +0200
X-CheckPoint: {681B3256-1B-68AAF6F9-E177A1A4}
X-MAIL-CPID: E3120522F79BE09791CCE17DCAC19F34_2
X-Control-Analysis: str=0001.0A00639A.681B3259.001C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 05108160CD5;
	Wed,  7 May 2025 12:13:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1746612818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2QQaB7DRTxqSqjpS2zVPzCvKkCTWVQMMXRupiETUnoA=;
	b=JOtr5PqXKKZ6bkLbO15iXh4BlntkftwI1OmOr1hqjy/dBGiSd/ROFc/7lO5x831ojgwimG
	p0l/lCA/JjFBS/woFjXcBHumJfXL/wnPorto3ixOmOa3wxE8dzs0+aM4cJdC8hX2RORUgP
	rElFmlLQutMu4lS33Q9w+Chd/j1TozRouLScFG51K5WaIi0RpTklbJ966x+mDMEJ/To8ev
	PZHyBJvojlTf2JxTUWoKnh/hYZV+WMVlkae+NTj/1/StFgyFBWS4rur+z1DOgOk/vtAsah
	bUE4etXjox0a+GoiJYT0VusTXbF7t1tKaihdCq3kJXt+wRDdu73WRV6IK/7bjA==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH net-next v2 1/2] net: phy: dp83867: remove check of delay strap configuration
Date: Wed,  7 May 2025 12:13:20 +0200
Message-ID: <8a286207cd11b460bb0dbd27931de3626b9d7575.1746612711.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The check that intended to handle "rgmii" PHY mode differently to the
RGMII modes with internal delay never worked as intended:

- added in commit 2a10154abcb7 ("net: phy: dp83867: Add TI dp83867 phy"):
  logic error caused the condition to always evaluate to true
- changed in commit a46fa260f6f5 ("net: phy: dp83867: Fix warning check
  for setting the internal delay"): now the condition incorrectly
  evaluates to false for rgmii-txid
- removed in commit 2b892649254f ("net: phy: dp83867: Set up RGMII TX
  delay")

Around the time of the removal, commit c11669a2757e ("net: phy: dp83867:
Rework delay rgmii delay handling") started clearing the delay enable
flags in RGMIICTL. The change attempted to preserve the historical
behavior of not disabling internal delays with "rgmii" PHY mode and also
documented this in a comment, but due to a conflict between "Set up
RGMII TX delay" and "Rework delay rgmii delay handling", the behavior
dp83867_verify_rgmii_cfg() warned about (and that was also described in
a comment in dp83867_config_init()) disappeared in the following merge
of net into net-next in commit b4b12b0d2f02
("Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net").

While is doesn't appear that this breaking change was intentional, it
has been like this since 2019, and the new behavior to disable the delays
with "rgmii" PHY mode is generally desirable - in particular with MAC
drivers that have to fix up the delay mode, resulting in the PHY driver
not even seeing the same mode that was specified in the Device Tree.

Remove the obsolete check and comment.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: fix commit message (typo, incorrect description of behavior after
    a46fa260f6f5)

 drivers/net/phy/dp83867.c | 32 +-------------------------------
 1 file changed, 1 insertion(+), 31 deletions(-)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 063266cafe9c7..e5b0c1b7be13f 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -92,11 +92,6 @@
 #define DP83867_STRAP_STS1_RESERVED		BIT(11)
 
 /* STRAP_STS2 bits */
-#define DP83867_STRAP_STS2_CLK_SKEW_TX_MASK	GENMASK(6, 4)
-#define DP83867_STRAP_STS2_CLK_SKEW_TX_SHIFT	4
-#define DP83867_STRAP_STS2_CLK_SKEW_RX_MASK	GENMASK(2, 0)
-#define DP83867_STRAP_STS2_CLK_SKEW_RX_SHIFT	0
-#define DP83867_STRAP_STS2_CLK_SKEW_NONE	BIT(2)
 #define DP83867_STRAP_STS2_STRAP_FLD		BIT(10)
 
 /* PHY CTRL bits */
@@ -510,25 +505,6 @@ static int dp83867_verify_rgmii_cfg(struct phy_device *phydev)
 {
 	struct dp83867_private *dp83867 = phydev->priv;
 
-	/* Existing behavior was to use default pin strapping delay in rgmii
-	 * mode, but rgmii should have meant no delay.  Warn existing users.
-	 */
-	if (phydev->interface == PHY_INTERFACE_MODE_RGMII) {
-		const u16 val = phy_read_mmd(phydev, DP83867_DEVADDR,
-					     DP83867_STRAP_STS2);
-		const u16 txskew = (val & DP83867_STRAP_STS2_CLK_SKEW_TX_MASK) >>
-				   DP83867_STRAP_STS2_CLK_SKEW_TX_SHIFT;
-		const u16 rxskew = (val & DP83867_STRAP_STS2_CLK_SKEW_RX_MASK) >>
-				   DP83867_STRAP_STS2_CLK_SKEW_RX_SHIFT;
-
-		if (txskew != DP83867_STRAP_STS2_CLK_SKEW_NONE ||
-		    rxskew != DP83867_STRAP_STS2_CLK_SKEW_NONE)
-			phydev_warn(phydev,
-				    "PHY has delays via pin strapping, but phy-mode = 'rgmii'\n"
-				    "Should be 'rgmii-id' to use internal delays txskew:%x rxskew:%x\n",
-				    txskew, rxskew);
-	}
-
 	/* RX delay *must* be specified if internal delay of RX is used. */
 	if ((phydev->interface == PHY_INTERFACE_MODE_RGMII_ID ||
 	     phydev->interface == PHY_INTERFACE_MODE_RGMII_RXID) &&
@@ -836,13 +812,7 @@ static int dp83867_config_init(struct phy_device *phydev)
 		if (ret)
 			return ret;
 
-		/* If rgmii mode with no internal delay is selected, we do NOT use
-		 * aligned mode as one might expect.  Instead we use the PHY's default
-		 * based on pin strapping.  And the "mode 0" default is to *use*
-		 * internal delay with a value of 7 (2.00 ns).
-		 *
-		 * Set up RGMII delays
-		 */
+		/* Set up RGMII delays */
 		val = phy_read_mmd(phydev, DP83867_DEVADDR, DP83867_RGMIICTL);
 
 		val &= ~(DP83867_RGMII_TX_CLK_DELAY_EN | DP83867_RGMII_RX_CLK_DELAY_EN);
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


