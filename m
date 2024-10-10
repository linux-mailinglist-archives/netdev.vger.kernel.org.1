Return-Path: <netdev+bounces-134103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E99099804F
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 10:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D091F2562C
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 08:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F731C9EA4;
	Thu, 10 Oct 2024 08:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OFWcrvZb"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9103E192B78;
	Thu, 10 Oct 2024 08:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548564; cv=none; b=bBXqKff/Fj0ZUdSyrXEeRQkBQHsxEQ6sBrINDmLvpIr1ijvps86VRGvrm/m/Wwg/JRao/3ZEqQxXoIPllrxttO1y5B6cCYmpGgUon8/8JxsK2nT8z05h4IbTZwLD83BGoLJzTEYtTYN54SLElGhmimRfLq8REs84azU3NthhFtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548564; c=relaxed/simple;
	bh=j0vLyCJPFlst34XH3yVWN9TjDQ7Y3e3Ov6+1OgCePC4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WCrrvjIeozmqJ+YUq7GSctnQa6y9KdfSG2Kx6Sp12DjdI0yqI07OOB5RIjAYoE1VGQB6cRT0gZ1tKw3WNYtpT3vduATC/z/LnOPwimgswpRmGNY1AWScJkj8bDFIqzuzB1mQACJYXMdPnUJV34bs3NLzaKKVMLCoyrGU7QXkXpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OFWcrvZb; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728548562; x=1760084562;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j0vLyCJPFlst34XH3yVWN9TjDQ7Y3e3Ov6+1OgCePC4=;
  b=OFWcrvZbnpipwkt0kR+vE3nWMURI1Jo9FKaImM2UBvAycYqoPNyFrbOM
   0WWNJICI0s01D1/o9tuRh/NKLoOzBRZcNh0EC+6OR0ymfCOvfcjBHXDjJ
   brnl78a/z19SszYrnqlFbkIFnMpjSHOwrRfQVl4pVDRK0g6/EgQq37Aic
   18CEsHTOz3CS+nhdHKOj06FviuQ+hqzBQOeFKsM1ZS0q5BmpOpqmU04at
   NYMqBdRet0huqG0jcfYEE2kJyBjIgngSjIA1hAT+3wBYWIozeVbcAsmHP
   xxxiWYW/+n1farMS2rtBW2DFKTnLZFVaSv4/TxIfCeSCCnqUxn64BlWTb
   A==;
X-CSE-ConnectionGUID: guzCieAiRJ+z8jrS4dvLsQ==
X-CSE-MsgGUID: 6D/vm6A/SGue7z3Z89Lrzg==
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="33418975"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Oct 2024 01:22:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 10 Oct 2024 01:22:30 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 10 Oct 2024 01:22:26 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parthiban.veerasooran@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>
Subject: [PATCH net-next v4 1/7] net: phy: microchip_t1s: restructure cfg read/write functions arguments
Date: Thu, 10 Oct 2024 13:51:59 +0530
Message-ID: <20241010082205.221493-2-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010082205.221493-1-parthiban.veerasooran@microchip.com>
References: <20241010082205.221493-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Restructure lan865x_write_cfg_params() and lan865x_read_cfg_params()
functions arguments to more generic which will be useful for the next
patch which updates the improved initial configuration for LAN8650/1
Rev.B0 published in the Configuration Note.

Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index 3614839a8e51..24f992aba7d7 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -112,7 +112,7 @@ static int lan865x_revb0_indirect_read(struct phy_device *phydev, u16 addr)
 /* This is pulled straight from AN1760 from 'calculation of offset 1' &
  * 'calculation of offset 2'
  */
-static int lan865x_generate_cfg_offsets(struct phy_device *phydev, s8 offsets[2])
+static int lan865x_generate_cfg_offsets(struct phy_device *phydev, s8 offsets[])
 {
 	const u16 fixup_regs[2] = {0x0004, 0x0008};
 	int ret;
@@ -130,13 +130,15 @@ static int lan865x_generate_cfg_offsets(struct phy_device *phydev, s8 offsets[2]
 	return 0;
 }
 
-static int lan865x_read_cfg_params(struct phy_device *phydev, u16 cfg_params[])
+static int lan865x_read_cfg_params(struct phy_device *phydev,
+				   const u16 cfg_regs[], u16 cfg_params[],
+				   u8 count)
 {
 	int ret;
 
-	for (int i = 0; i < ARRAY_SIZE(lan865x_revb0_fixup_cfg_regs); i++) {
+	for (int i = 0; i < count; i++) {
 		ret = phy_read_mmd(phydev, MDIO_MMD_VEND2,
-				   lan865x_revb0_fixup_cfg_regs[i]);
+				   cfg_regs[i]);
 		if (ret < 0)
 			return ret;
 		cfg_params[i] = (u16)ret;
@@ -145,13 +147,14 @@ static int lan865x_read_cfg_params(struct phy_device *phydev, u16 cfg_params[])
 	return 0;
 }
 
-static int lan865x_write_cfg_params(struct phy_device *phydev, u16 cfg_params[])
+static int lan865x_write_cfg_params(struct phy_device *phydev,
+				    const u16 cfg_regs[], u16 cfg_params[],
+				    u8 count)
 {
 	int ret;
 
-	for (int i = 0; i < ARRAY_SIZE(lan865x_revb0_fixup_cfg_regs); i++) {
-		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
-				    lan865x_revb0_fixup_cfg_regs[i],
+	for (int i = 0; i < count; i++) {
+		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, cfg_regs[i],
 				    cfg_params[i]);
 		if (ret)
 			return ret;
@@ -162,8 +165,8 @@ static int lan865x_write_cfg_params(struct phy_device *phydev, u16 cfg_params[])
 
 static int lan865x_setup_cfgparam(struct phy_device *phydev)
 {
+	u16 cfg_results[ARRAY_SIZE(lan865x_revb0_fixup_cfg_regs)];
 	u16 cfg_params[ARRAY_SIZE(lan865x_revb0_fixup_cfg_regs)];
-	u16 cfg_results[5];
 	s8 offsets[2];
 	int ret;
 
@@ -171,7 +174,8 @@ static int lan865x_setup_cfgparam(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	ret = lan865x_read_cfg_params(phydev, cfg_params);
+	ret = lan865x_read_cfg_params(phydev, lan865x_revb0_fixup_cfg_regs,
+				      cfg_params, ARRAY_SIZE(cfg_params));
 	if (ret)
 		return ret;
 
@@ -190,7 +194,8 @@ static int lan865x_setup_cfgparam(struct phy_device *phydev)
 			  FIELD_PREP(GENMASK(15, 8), 17 + offsets[0]) |
 			  (22 + offsets[0]);
 
-	return lan865x_write_cfg_params(phydev, cfg_results);
+	return lan865x_write_cfg_params(phydev, lan865x_revb0_fixup_cfg_regs,
+					cfg_results, ARRAY_SIZE(cfg_results));
 }
 
 static int lan865x_revb0_config_init(struct phy_device *phydev)
-- 
2.34.1


