Return-Path: <netdev+bounces-156637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B54FEA072F3
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 11:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E161E188AD25
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05166217707;
	Thu,  9 Jan 2025 10:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vh5hn7I/"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3DB217655;
	Thu,  9 Jan 2025 10:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736418201; cv=none; b=RqVspzYWHWmvX/Qk+TCVfviJ1XlsY+QlDEQNfkbW8IjvVFZaVEeiLU0exjXQvA7PQuf3R4ABYA8Oqk01OaI1myuJ1+x4CNcBx8FgZbQYCYlMoqAo7WX35sKgMoh39PaVgxNb2n1fqjnoY6bCHATJ/zTSDfx0L9DhknOjNGYdD30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736418201; c=relaxed/simple;
	bh=ACMh12Ol2gE0o3UFALZ1oPRJSTDPZzaZwLG+aLfamWc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fyKNWYTFfr7PQ14ui3E6VxVbDaSnrTA2bf6ieY4PyJAYQlCc2EINs2yPWVyTC74vF05H3URJo8L49EM7boJb6bLN4wb/5R3pK+2Pxzy67LPQJLFHVVQ39ocVAlwgozXOsXW0kmpz/3ou4nJUm+wypGTiU7GIIe3Pg6Ko2Csc0+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vh5hn7I/; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736418199; x=1767954199;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=ACMh12Ol2gE0o3UFALZ1oPRJSTDPZzaZwLG+aLfamWc=;
  b=vh5hn7I/IwwdQboqZfjuwqpvogoNXASln++XAG8sIma0KtcH5PACcRMk
   YlaAqT2hFhqayPl6KjS9W/VkoG5cZ0Pe6RFCiAr2eXVq99720uOibtbIW
   n9Ede9FtYIvUy2VsFw0fIFkRRI3cHWEHxFBNbhszO7BGvR+V+UNRmqQja
   46wGMH7gR5K7cAMDaPMWNGsp4n4oRflw2lafkYMyfaa0DMKx6YrzzTqic
   ielfpEAp5QVO7uACWbDlLdWgWIdK25Wsl+gCj5ESReWPL8mdNaK2/sz23
   KkD8lgAa8QISLJepOXnn3lbSshlctWlJla6Ztu/CvXQbV59HvTpTtkSCw
   A==;
X-CSE-ConnectionGUID: pKZMzjv2RsiFZGF8PKVKgw==
X-CSE-MsgGUID: viICJnn3QzmtcPWF4ZQuDQ==
X-IronPort-AV: E=Sophos;i="6.12,301,1728975600"; 
   d="scan'208";a="40189019"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2025 03:23:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 Jan 2025 03:22:42 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 9 Jan 2025 03:22:38 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v2 2/3]  net: phy: microchip_t1: Enable pin out specific to lan887x phy for PEROUT signal
Date: Thu, 9 Jan 2025 15:55:32 +0530
Message-ID: <20250109102533.15621-3-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250109102533.15621-1-divya.koppera@microchip.com>
References: <20250109102533.15621-1-divya.koppera@microchip.com>
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
v1 -> v2
- Added support of periodic output only for the pinout that is specific
  to PEROUT
---
 drivers/net/phy/microchip_t1.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index 73f28463bc35..551a057c516e 100644
--- a/drivers/net/phy/microchip_t1.c
+++ b/drivers/net/phy/microchip_t1.c
@@ -273,6 +273,9 @@
 /* End offset of samples */
 #define SQI_INLIERS_END (SQI_INLIERS_START + SQI_INLIERS_NUM)
 
+#define LAN887X_MX_CHIP_TOP_REG_CONTROL1		0xF002
+#define LAN887X_MX_CHIP_TOP_REG_CONTROL1_EVT_EN		BIT(8)
+
 #define DRIVER_AUTHOR	"Nisar Sayed <nisar.sayed@microchip.com>"
 #define DRIVER_DESC	"Microchip LAN87XX/LAN937x/LAN887x T1 PHY driver"
 
@@ -1286,6 +1289,15 @@ static int lan887x_phy_init(struct phy_device *phydev)
 		if (IS_ERR(priv->clock))
 			return PTR_ERR(priv->clock);
 
+		/* Enable pin mux for EVT */
+		phy_modify_mmd(phydev, MDIO_MMD_VEND1,
+			       LAN887X_MX_CHIP_TOP_REG_CONTROL1,
+			       LAN887X_MX_CHIP_TOP_REG_CONTROL1_EVT_EN,
+			       LAN887X_MX_CHIP_TOP_REG_CONTROL1_EVT_EN);
+
+		 /* Initialize pin numbers specific to PEROUT */
+		priv->clock->event_pin = 3;
+
 		priv->init_done = true;
 	}
 
-- 
2.17.1


