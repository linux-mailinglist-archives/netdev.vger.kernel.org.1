Return-Path: <netdev+bounces-182256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5731A88603
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9036D565DE5
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1906228B506;
	Mon, 14 Apr 2025 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="iZi+G63+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="GQLpSNbK"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B60B17BBF;
	Mon, 14 Apr 2025 14:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744640074; cv=none; b=KgylaBcxt1o/oGVjWSfnRhDIa3i1ItASh4aIjm34QdDvlb/AhKfs4PhPwIxZ5CuL7e7IBE6BXMKhIl5zTY8Bt3KyEs4iYiwcA8B8s8FYRMVd99U7fBDnpS7rWGxeez90uuFVNz5dJPbRIbmShGQ6hl4C1D721ROE+RfuKj3KAzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744640074; c=relaxed/simple;
	bh=HxLpkrEFrUtXNpv/Fmgq3bqgPSA51hoGXlg9yry0b40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X2KaQPQz79gSO1qOz/ihPZBknMPRZpJTS8xrGR27JQ91BDWvWwaMagE7GSC7BLyiOEIzdLuHyqh/ivaIYCRPgxS/W9n5ih4pPxMORCm6MGfya+NbbJ5TKSeZwHr3PRRhPUyV7616cQeJ9lXNo5b7xCp3crOsFeK5DI3KPPthEx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=iZi+G63+; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=GQLpSNbK reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1744640069; x=1776176069;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ghpOs9VSowOL1pV8FfmtuNICOLqxa7Du4VsQSt7f24A=;
  b=iZi+G63+3asSourtk+riWv04QxO0Eu6FjzeigNwMXeZvlnbA5nHgwK9L
   fhFr20+Oh8BPuQVhqQrhJa+FqiIRbKsTJfj3ZiVtcv3t5VDiPB5IiKjvI
   /6nhbqvu9BBxOPu0BWQDkTSfJY0uG0uM5ug6dJzqfbWP3R5+yGb2CUixg
   re0PeafaDBh8FtWngX8EnHk2kbVIUnnk8MvgF0oden52p/OfMJhZ9qBXb
   IHF5y8xT4y8I8OBUBfrgw8kZJqiNG0OfVqrfq+KzwxSc7IJrAA1YyqPmn
   LY/buG+lA5XXsYxk5PRHW5SQKqrLb+7pAAAyDnPdVHJD5efU2xM33OKFO
   Q==;
X-CSE-ConnectionGUID: 2l3YtWDOTV2GZSR/efLqJw==
X-CSE-MsgGUID: rZrdxSdsSfSlWdrMDazbYA==
X-IronPort-AV: E=Sophos;i="6.15,212,1739833200"; 
   d="scan'208";a="43517427"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 14 Apr 2025 16:14:26 +0200
X-CheckPoint: {67FD1842-10-DC4DC9A0-F4F29281}
X-MAIL-CPID: DA2A3DC1ECC01433EB7A1E8886AE0492_0
X-Control-Analysis: str=0001.0A006378.67FD1841.003D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1CDDE163E9E;
	Mon, 14 Apr 2025 16:14:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1744640062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ghpOs9VSowOL1pV8FfmtuNICOLqxa7Du4VsQSt7f24A=;
	b=GQLpSNbKY4M2rG94kS0hsxdgLcbqS9CfiBYrQ9AVKxlE7iFhB8ljqWYrSiqY6tRmGv5XV/
	HOqyM9Il1xEOZUziDQyrFdjmJ0JAa4Y3I9YzuDqV3fubkNcaX34E4lwdK89gcueDK0p6FV
	W/NOTkwyVmxnE1JTdch6YTgZfzty4l1v6ErcBn5YzwDEHxryT4G8Qx2mFJzkDXqw65L940
	9uorpvB6/DVp68wG2k+hgLSj6E/37szYB/AiSBVb0vW5K+2hW7pC61xEuDxx+Ww+wbh1Vs
	tlyklcHNClsf6Fuoe4SstHzn5v9KJ4d6XfZuE2br9NPWC43zdZliOgTqfbplew==
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
Subject: [PATCH net-next 1/2] net: phy: dp83867: remove check of delay strap configuration
Date: Mon, 14 Apr 2025 16:13:57 +0200
Message-ID: <8013ae5966dd22bcb698c0c09d2fc0912ae7ac25.1744639988.git.matthias.schiffer@ew.tq-group.com>
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

The check that intended to handle "rgmii" PHY mode differently from the
other RGMII modes never worked as intended:

- added in commit 2a10154abcb7 ("net: phy: dp83867: Add TI dp83867 phy"):
  logic error caused the condition to always evaluate to true
- changed in commit a46fa260f6f5 ("net: phy: dp83867: Fix warning check
  for setting the internal delay"): now the condition always evaluates
  to false
- removed in commit 2b892649254f ("net: phy: dp83867: Set up RGMII TX
  delay")

Around the time of the removal, commit c11669a2757e ("net: phy: dp83867:
Rework delay rgmii delay handling") started clearing the delay enable
flags in RGMIICTL (or it would have, if the condition ever evaluated to
true at that time). The change attempted to preserve the historical
behavior of not disabling internal delays with "rgmii" PHY mode and also
documented this in a comment, but due to a conflict between "Set up
RGMII TX delay" and "Rework delay rgmii delay handling", the behavior
dp83867_verify_rgmii_cfg() warned about (and that was also described in
a commit in dp83867_config_init()) disappeared in the following merge
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


