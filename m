Return-Path: <netdev+bounces-124220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F5C968A0B
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B4F41C22371
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7378A1A264F;
	Mon,  2 Sep 2024 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GuBqKHA2"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA04A1A2635;
	Mon,  2 Sep 2024 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287739; cv=none; b=uF4yJVC1kJHkBtb7miNAGzD2Ld4r/s+MA01AC0CFawLgUB1PcHzu79yHVw0OGfU2Wwfe6PoSqLvMkOG9HJrGxORGVrPGaC626zpLgB82uii6Qfp7sBDVJ4TgS/7R2iKf7voqcQuoRGkno1P/qFq/ubvxXMjaMj+6sFASNU/mgQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287739; c=relaxed/simple;
	bh=VcUiUvnQ+Iw67wKMrlmIKXf0zuQv7Pct2IBkVtAe8go=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e2Swhqnwp6TuZVn6ooY0qjJjfsaIdt898dQPPzBZRIk0055W56XFSsGU/r2HxnPbEtQ5D9uykkPQOOpM7wHuArjgBK+LjKGgfuQhJwZqQTC6N1YTNDB2q7sBUG2EnulOgS9qNkeVilF3SKLT+W1IZS8dvNGhUwCt+3VBaiKxLfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GuBqKHA2; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725287737; x=1756823737;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VcUiUvnQ+Iw67wKMrlmIKXf0zuQv7Pct2IBkVtAe8go=;
  b=GuBqKHA2zHvlj9u0vhsmC0DhzbDiDCHDYoGRpbnTNE/rCfocAAtjHx0e
   MrOOtWvvPy++2ivkWptQ5PjFSmBcDJBIVSHbxPm37tkzBxzHCa0jvFnQ5
   3VGu7ck2kGZXw4MLsbLU8kZA2HNoIsxHi0LTOrsUWRUR0uddViYAez8Wv
   f/XmPbe0mlsIkJp9YmdCINjaAgl0YT/REeg9R8ym69FdursDsAf0DDLLf
   5kKnv5T0croIU/YmevkvOJQC+TlOf8NOtSehe7IjDSVf9OZapwRPEIG8U
   yrpQ7vcpAkQ2U6arkZFjMyk6mXDhGhOTK0u3mjPLTVsOgh2GFNsMTJXMW
   w==;
X-CSE-ConnectionGUID: ocGO3RCOTkuOSmOfjK4K+g==
X-CSE-MsgGUID: 5DMk7AcqStOOFIIMVnhPRw==
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="34270501"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 07:35:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 07:35:11 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 2 Sep 2024 07:35:06 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parthiban.veerasooran@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v2 1/7] net: phy: microchip_t1s: restructure cfg read/write functions arguments
Date: Mon, 2 Sep 2024 20:04:52 +0530
Message-ID: <20240902143458.601578-2-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902143458.601578-1-Parthiban.Veerasooran@microchip.com>
References: <20240902143458.601578-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch restructures lan865x_write_cfg_params() and
lan865x_read_cfg_params() functions arguments to more generic which will
be useful for the next patch which updates the improved initial
configuration for LAN8650/1 Rev.B0 published in the Configuration Note.

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index 534ca7d1b061..0110f3357489 100644
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


