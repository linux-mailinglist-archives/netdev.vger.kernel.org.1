Return-Path: <netdev+bounces-225260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB91B914C0
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 15:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7755D3AE948
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 13:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCC92D6E52;
	Mon, 22 Sep 2025 13:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZcAqSJqB"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B68DC120;
	Mon, 22 Sep 2025 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546483; cv=none; b=hGk0g9ON7FdHtI7nL1IZ9v4bqiB5+MVV+ohRtKM3zTgk4+4IS5WWVH6ron3M6EEWBcWNS1+VD+krDj5WzZdynNuH9NMYH8G0O4/niYF7XRw95hxkxJCiQL7vGpraoSlExMFyuOhMqENewcNpk1cO1sAF8WmnsJdoLa9vKQ4NsME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546483; c=relaxed/simple;
	bh=QVsLC+z3WG5ImB4zyT7a9y80b64iWfxOZjKHhCuYOiA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A0t3xlp8fYPj7v8k4Xtc+8y9aw4qWJd3UiXtaBgO2IRvGmCdi1UZvzPpEN37zUmoiIArKRLuE3NsPJL5TRvFV5aaD+Yap6Tmc/MuKmKbxYg8rxH6NFHVyYC4gN35pW940FjigQ5DsM89nr2lGPX/s2X74D17dYbIOwwi4SW6Ufw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZcAqSJqB; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758546482; x=1790082482;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QVsLC+z3WG5ImB4zyT7a9y80b64iWfxOZjKHhCuYOiA=;
  b=ZcAqSJqB6eTJDgHWiAF6I6D5hqkJtPjKRt/RWJikmZFwmD/1vp3NeDgT
   P18ymFrRrAT8NdK44h+Tb7QNmBFNYJXdHV4YA3pfpAEaZqLPpuyGO28Fp
   MFm0t8M9Yn++1rMIPkLZsOPOwQvTozIcTXsI1Hft8BcHG1Xqw8lWHm1CG
   F3wLoqe8kI04G6wLyCHREhv3F+h1FwtKfZFw2rUxmftnwslBCdGvJS2cK
   JtIWNWv4yLzsB+jo+wtMBrrArDAI1uOgVLNQuXvTs/eeFDGjE9K3RJz+R
   DTxbQjiGk5xx/5En+9donse1N4V4l2PrjjdGUFrFH+PEDeA99j17kA+GR
   w==;
X-CSE-ConnectionGUID: FVJ2Zij+QNKIJUYJJlqdNg==
X-CSE-MsgGUID: XEdQEz2jTWeqK2v8yEHvSQ==
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="214200142"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Sep 2025 06:07:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 22 Sep 2025 06:07:22 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 22 Sep 2025 06:07:20 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next] net: phy: micrel: Fix default LED behaviour
Date: Mon, 22 Sep 2025 15:03:14 +0200
Message-ID: <20250922130314.758229-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

By default the LED will be ON when there is a link but they are not
blinking when there is any traffic activity. Therefore change this
to blink when there is any traffic.

Fixes: 5a774b64cd6a ("net: phy: micrel: Add support for lan8842")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

---
This fix is targeting net-next and not net because the blamed commit
doesn't exist on net
---
 drivers/net/phy/micrel.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 399d0cf4d3426..0b42400e5e098 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -267,6 +267,8 @@
 
 #define LAN8814_LED_CTRL_1			0x0
 #define LAN8814_LED_CTRL_1_KSZ9031_LED_MODE_	BIT(6)
+#define LAN8814_LED_CTRL_2			0x1
+#define LAN8814_LED_CTRL_2_LED1_COM_DIS		BIT(8)
 
 /* PHY Control 1 */
 #define MII_KSZPHY_CTRL_1			0x1e
@@ -5894,6 +5896,23 @@ static int lan8842_config_init(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
+	/* Even if the GPIOs are set to control the LEDs the behaviour of the
+	 * LEDs is wrong, they are not blinking when there is traffic.
+	 * To fix this it is required to set extended LED mode
+	 */
+	ret = lanphy_modify_page_reg(phydev, LAN8814_PAGE_PORT_REGS,
+				     LAN8814_LED_CTRL_1,
+				     LAN8814_LED_CTRL_1_KSZ9031_LED_MODE_, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = lanphy_modify_page_reg(phydev, LAN8814_PAGE_PORT_REGS,
+				     LAN8814_LED_CTRL_2,
+				     LAN8814_LED_CTRL_2_LED1_COM_DIS,
+				     LAN8814_LED_CTRL_2_LED1_COM_DIS);
+	if (ret < 0)
+		return ret;
+
 	/* To allow the PHY to control the LEDs the GPIOs of the PHY should have
 	 * a function mode and not the GPIO. Apparently by default the value is
 	 * GPIO and not function even though the datasheet it says that it is
-- 
2.34.1


