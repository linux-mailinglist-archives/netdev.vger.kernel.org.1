Return-Path: <netdev+bounces-244960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC583CC4137
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 16:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC0B23102D75
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 15:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1FF28C862;
	Tue, 16 Dec 2025 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="DFsfglev"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9650472602;
	Tue, 16 Dec 2025 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765900124; cv=none; b=YLmeQqxiqHIFaI8c0Pi773PMd6ZNzzgCsH0e13/17xKZJKndXlaKdJJSQKls/x4HTgYF7v5I0rp95hupSnz2laYaCCE2mY0ifjembpZQGiMuzyuWKnEZoYTWowp4iZxdf3n3frrtoi9AQDTlraB3UKjIw3twoUYI8hJRVKaReOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765900124; c=relaxed/simple;
	bh=TwUV9C0BYn+5xXzesc+3z3QkcwKSCf2WRRwWvz1YIRw=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=K04w9AsBcr40wm1XmTyOE5CblCw2czshGsaaeW1rCT1apJv46UK9OPcdBJ038JgLs5vQWkDpLrqgVjXKUZkYlpaP0Ra6KioKILkYgzHQ4tK94cQGfWrkAJfPjjaGoikSrwstuvCaz6YRL8kDWPvl/DxkXZuFdOof/Njkjb67/dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=DFsfglev; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 80E0C3D8537E;
	Tue, 16 Dec 2025 10:48:40 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id pslP6wxY4uq9; Tue, 16 Dec 2025 10:48:39 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 93CD23D85148;
	Tue, 16 Dec 2025 10:48:39 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 93CD23D85148
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1765900119; bh=LugX9z8CtHbe5+evOl5uhx+CgSBUC9nIVhygVadcZQo=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=DFsfglevfG+5yp/Jsl3ehb3G0cspCCq3/lE2+38E2s0/FKF8tJXqJbIGlo2tm07jY
	 /y/5Cmlrwa12nPfR13I8r5liPVTOxZwWxZrUpdZj+4ed8PUTuPZssRkB2wB99q1XXb
	 mbKJmTQy5WlrUMS05XFCOlx/TRNOJUH+6N4KdaFlpwYbQadZtsuDIoXNM/lZOnJ/Ak
	 tlUPEETXQmPDiq3FpiEvuyYboMHyYt94WnHjqimgt9SxIfH0M/saCB6edl3YbPQyIZ
	 e18svHijBAxzu0sI3I25q3/l6+d5ZZhCCn/YTCnJLDNBJWEG9svROZ99f4PTASzR0T
	 LR9R8AS2l4smg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id WCvCEcJkDwTZ; Tue, 16 Dec 2025 10:48:39 -0500 (EST)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 3AA6B3D8482F;
	Tue, 16 Dec 2025 10:48:39 -0500 (EST)
Date: Tue, 16 Dec 2025 10:48:39 -0500 (EST)
From: Osose Itua <osose.itua@savoirfairelinux.com>
To: netdev <netdev@vger.kernel.org>
Cc: devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Michael Hennerich <michael.hennerich@analog.com>, 
	=?utf-8?B?SsOpcsO0bWU=?= Oufella <jerome.oufella@savoirfairelinux.com>
Message-ID: <1695319092.1512780.1765900119201.JavaMail.zimbra@savoirfairelinux.com>
Subject: [PATCH 1/2] net: phy: adin: enable configuration of the LP
  Termination Register
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 10.1.6_GA_0225 (ZimbraWebClient - GC141 (Linux)/10.1.6_GA_0225)
Thread-Index: hGdGaIZ/TEW52TQsSs5ZKvo3NMSZHw==
Thread-Topic: adin: enable configuration of the LP Termination Register

From 9c68d9082a9c0550891f24c5902c1f0de15de949 Mon Sep 17 00:00:00 2001
From: Osose Itua <osose.itua@savoirfairelinux.com>
Date: Fri, 14 Nov 2025 17:00:14 -0500
Subject: [PATCH 1/2] net: phy: adin: enable configuration of the LP
 Termination Register

The ADIN1200/ADIN1300 provide a control bit that selects between normal
receive termination and the lowest common mode impedance for 100BASE-TX
operation. This behavior is controlled through the Low Power Termination
register (B_100_ZPTM_EN_DIMRX).

Bit 0 of this register enables normal termination when set (this is the
default), and selects the lowest common mode impedance when cleared.

Signed-off-by: Osose Itua <osose.itua@savoirfairelinux.com>
---
 drivers/net/phy/adin.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/phy/adin.c b/drivers/net/phy/adin.c
index 7fa713ca8d45..2969480a7be3 100644
--- a/drivers/net/phy/adin.c
+++ b/drivers/net/phy/adin.c
@@ -89,6 +89,9 @@
 #define ADIN1300_CLOCK_STOP_REG			0x9400
 #define ADIN1300_LPI_WAKE_ERR_CNT_REG		0xa000
 
+#define ADIN1300_B_100_ZPTM_DIMRX		0xB685
+#define ADIN1300_B_100_ZPTM_EN_DIMRX		BIT(0)
+
 #define ADIN1300_CDIAG_RUN			0xba1b
 #define   ADIN1300_CDIAG_RUN_EN			BIT(0)
 
@@ -522,6 +525,31 @@ static int adin_config_clk_out(struct phy_device *phydev)
 			      ADIN1300_GE_CLK_CFG_MASK, sel);
 }
 
+static int adin_config_zptm100(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	u8 reg;
+	int rc;
+
+	if (!(device_property_read_bool(dev, "adi,low-cmode-impedance")))
+		return 0;
+
+	/* set to 0 to configure for lowest common-mode impedance */
+	rc = phy_write_mmd(phydev, MDIO_MMD_VEND1, ADIN1300_B_100_ZPTM_DIMRX, 0x0);
+	if (rc < 0)
+		return rc;
+
+	reg = phy_read_mmd(phydev, MDIO_MMD_VEND1, ADIN1300_B_100_ZPTM_DIMRX);
+	if (reg < 0)
+		return reg;
+
+	if (reg != 0x0)
+		phydev_err(phydev,
+			   "Lowest common-mode impedance configuration failed\n");
+
+	return 0;
+}
+
 static int adin_config_init(struct phy_device *phydev)
 {
 	int rc;
@@ -548,6 +576,10 @@ static int adin_config_init(struct phy_device *phydev)
 	if (rc < 0)
 		return rc;
 
+	rc = adin_config_zptm100(phydev);
+	if (rc < 0)
+		return rc;
+
 	phydev_dbg(phydev, "PHY is using mode '%s'\n",
 		   phy_modes(phydev->interface));
 

