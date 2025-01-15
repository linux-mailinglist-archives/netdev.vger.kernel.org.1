Return-Path: <netdev+bounces-158424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933C2A11CBA
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3C53A12AC
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8EB1EEA2C;
	Wed, 15 Jan 2025 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="R1+k1p3I"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EC5246A1F;
	Wed, 15 Jan 2025 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736931691; cv=none; b=GP3bXNuDEl4WB7j21ARiPRb8dBAScgyJ9Ja6CM/P9R9O6eM6iijjQmfwDNarFQP9a6gFl2ayweMvEFPtsrB/brGrDutmiBTixB5hLXCErCY8PotrYUYzOH5cmJ7kVhFH7XJkolwIJ+jK9RbYP1Mq0BOJoNlwfGzK74wwlb4swpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736931691; c=relaxed/simple;
	bh=661dGSArRNs7LYHkjN2hT67bEH+BKe7yMFYzk7kgYik=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IYB9MUiDaalDwHGaf6a2g08eVi7DNBmXDKWHcz2xuYqxZvx/68HVQTdotbY3Zzvk5idDH/17fTbHW8AdpIItjBzSysp79SHGbpbKDI/8E51aJzRKUfpHkC36oaZ6Ditv4Mf0LZJ4ime+7CxcNXKcMAt0eSGTH0KiyuqT7b71hJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=R1+k1p3I; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736931689; x=1768467689;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=661dGSArRNs7LYHkjN2hT67bEH+BKe7yMFYzk7kgYik=;
  b=R1+k1p3IlbZ4KrGqOzDrZ7zK9cVAFEipBMMCESdm3v50IeTOibNhCogc
   mrLiaThbvy8XSXovcnHuFLUH24IYh4PfwgUvuqu3ZY3LzkHbrXKB4I4YE
   QwzKo5Rv6fwFfOpPai0zyAgSZcvgpAOOdnYqzzuPGrVaSz1xNkJbECGBT
   NgqGcr3wO0Zn8iwU+gySUkBJktda1VRjotn1slf0rBLoAkHgtpPkarvE5
   awAHtJ+RrjVOZkve9RasWjsPaNKZEAW1Et44muWhX07oUU8QU1zygG4XR
   c6o2dpKPm1QI9nZWByUj9rU2vmhM6v3+uk2O/1OPTTOJNJzPFP1JP0mXc
   g==;
X-CSE-ConnectionGUID: uUIOS/pbQnKKbt5ehMoa8A==
X-CSE-MsgGUID: j2DxLminR0SmaBEvHCzQ+A==
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="36185963"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jan 2025 02:01:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 Jan 2025 02:00:44 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 15 Jan 2025 02:00:39 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v3 2/3]  net: phy: microchip_t1: Enable pin out specific to lan887x phy for PEROUT signal
Date: Wed, 15 Jan 2025 14:36:33 +0530
Message-ID: <20250115090634.12941-3-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250115090634.12941-1-divya.koppera@microchip.com>
References: <20250115090634.12941-1-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adds support for enabling pin out that is required
to generate periodic output signal on lan887x phy.

Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
---
v2 -> v3
- No changes

v1 -> v2
- Added support of periodic output only for the pinout that is specific
  to PEROUT
---
 drivers/net/phy/microchip_t1.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index 76e5b01832f3..62b36a318100 100644
--- a/drivers/net/phy/microchip_t1.c
+++ b/drivers/net/phy/microchip_t1.c
@@ -238,6 +238,9 @@
 #define LAN887X_INT_MSK_LINK_UP_MSK		BIT(1)
 #define LAN887X_INT_MSK_LINK_DOWN_MSK		BIT(0)
 
+#define LAN887X_MX_CHIP_TOP_REG_CONTROL1	0xF002
+#define LAN887X_MX_CHIP_TOP_REG_CONTROL1_EVT_EN	BIT(8)
+
 #define LAN887X_MX_CHIP_TOP_LINK_MSK	(LAN887X_INT_MSK_LINK_UP_MSK |\
 					 LAN887X_INT_MSK_LINK_DOWN_MSK)
 
@@ -1286,6 +1289,15 @@ static int lan887x_phy_init(struct phy_device *phydev)
 		if (IS_ERR(priv->clock))
 			return PTR_ERR(priv->clock);
 
+		/* Enable pin mux for EVT */
+		phy_modify_mmd(phydev, MDIO_MMD_VEND1,
+			       LAN887X_MX_CHIP_TOP_REG_CONTROL1,
+			       LAN887X_MX_CHIP_TOP_REG_CONTROL1_EVT_EN,
+			       LAN887X_MX_CHIP_TOP_REG_CONTROL1_EVT_EN);
+
+		/* Initialize pin numbers specific to PEROUT */
+		priv->clock->event_pin = 3;
+
 		priv->init_done = true;
 	}
 
@@ -2154,7 +2166,7 @@ static struct phy_driver microchip_t1_phy_driver[] = {
 
 module_phy_driver(microchip_t1_phy_driver);
 
-static const struct mdio_device_id __maybe_unused microchip_t1_tbl[] = {
+static struct mdio_device_id __maybe_unused microchip_t1_tbl[] = {
 	{ PHY_ID_MATCH_MODEL(PHY_ID_LAN87XX) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_LAN937X) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_LAN887X) },
-- 
2.17.1


