Return-Path: <netdev+bounces-157560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BAEA0ACC4
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 01:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7513E18866AC
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 00:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F130749A;
	Mon, 13 Jan 2025 00:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="CBvokXmT"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8874B3232;
	Mon, 13 Jan 2025 00:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736727367; cv=none; b=gtc9YIQwq7rDdGYNg0kNE44Yl+nXA9/W3+qZbl30TAYTeEMSuSwbbtJY1Qt3vAdPIh+5tTYgMK4rcEOgg1SrnxYwU1xgLdVWA1eJpL6+n+za2O1NJdciqaZw9GICusY8uzAfZJMGwjfkN/MH/K43sRKfj9LIegtRuRrIw1+gPCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736727367; c=relaxed/simple;
	bh=9Y2muBgGw8NWoQv4AiPobBXbHCSJ80+qNnMu6WDGGvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=blpug1JZrgWukU9jDx5XwS4A+qgkHmQbevo2MDMtyjodR2+oWHAY1JLPu58Eu4OU/SkOtTueXZ3toe6asR1ptz/y+6IQ82HTPcvph0BvlphN+YxnpUvTUwoXo84TGfJ8OcyAN565ZQu7U2aCvliNv5ayWPyd+oKX30OwqCP5nqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=CBvokXmT; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1BDAD101D23A3;
	Mon, 13 Jan 2025 01:15:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1736727359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dCbYM3WI/Pfel/kuVh6uIlLlpYPfti8sFPP6w1LSjJM=;
	b=CBvokXmTHDWePrqnMqaC6FJ07araY5fBHpOOpBXEo71AeZeWoLxQ1vxaV4+XT+Hzfq+pHh
	ehu64kn/Um3pal5HHOFxUBWb1/F52HHPCcs9gjENGldHdfZ5x4bKvzbBDdgcYaPIdcHQdJ
	eVX05Lp65+HFoWdERIc5VEmE63DAFy78mCoEXezpmb6Ce5VPRc986x/l3VKFNsF2Sd5snH
	h0ubh2fSH7GD20HkUNfqxqESCpaihkaDPqQCMTgUPUi8pAF2KO7cwTps5qe7rn7TPqvq1C
	w/Odu+ix2xpa07MPLgzuvObV5A5GVzE7gx7MqRuM2nHcgj3Klt4pobBmGBC5Sw==
From: Marek Vasut <marex@denx.de>
To: netdev@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Tristram Ha <tristram.ha@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	linux-kernel@vger.kernel.org
Subject: [net-next,PATCH 1/2] net: dsa: microchip: Add emulated MIIM access to switch LED config registers
Date: Mon, 13 Jan 2025 01:15:35 +0100
Message-ID: <20250113001543.296510-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The KSZ87xx switch DSA driver binds a simplified KSZ8795 switch PHY driver to
each port. The KSZ8795 switch PHY driver is part of drivers/net/phy/micrel.c
and uses generic PHY register accessors to access MIIM registers 0x00..0x05,
0x1d and 0x1f . The MII access is implemented by the KSZ87xx switch DSA driver
and internally done over whichever interface the KSZ87xx switch is connected
to the SoC.

In order to configure LEDs from the KSZ8795 switch PHY driver, it is necessary
to expose the LED control registers to the PHY driver, however, the LED control
registers are not part of the MIIM block, they are in Switch Config Registers
block.

This preparatory patch exposes the LED control bits in those Switch Config
Registers by mapping them at high addresses in the MIIM space, so the PHY
driver can access those registers and surely not collide with the existing
MIIM block registers. The two registers which are exposed are the global
Register 11 (0x0B): Global Control 9 as MIIM block register 0x0b00 and
port specific Register 29/45/61 (0x1D/0x2D/0x3D): Port 1/2/3 Control 10
as MIIM block register 0x0d00 . The access to those registers is further
restricted only to the LED configuration bits to prevent the PHY driver
or userspace tools like 'phytool' from tampering with any other switch
configuration through this interface.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Tristram Ha <tristram.ha@microchip.com>
Cc: UNGLinuxDriver@microchip.com
Cc: Vladimir Oltean <olteanv@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
---
 drivers/net/dsa/microchip/ksz8.c | 47 ++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index da7110d675583..9698bf53378af 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1044,6 +1044,22 @@ int ksz8_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val)
 			return ret;
 
 		break;
+	/* Emulated access to Register 11 (0x0B): Global Control 9 */
+	case (REG_SW_CTRL_9 << 8):
+		ret = ksz_read8(dev, REG_SW_CTRL_9, &val1);
+		if (ret)
+			return ret;
+
+		data = val1 & 0x30;	/* LED Mode */
+		break;
+	/* Emulated access to Register 29/45/61 (0x1D/0x2D/0x3D): Port 1/2/3 Control 10 */
+	case (REG_PORT_CTRL_10 << 8):
+		ret = ksz_pread8(dev, p, REG_PORT_CTRL_10, &val1);
+		if (ret)
+			return ret;
+
+		data = val1 & BIT(7);	/* LED Off */
+		break;
 	default:
 		processed = false;
 		break;
@@ -1256,6 +1272,37 @@ int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
 		if (ret)
 			return ret;
 		break;
+
+	/* Emulated access to Register 11 (0x0B): Global Control 9 */
+	case (REG_SW_CTRL_9 << 8):
+		ret = ksz_read8(dev, REG_SW_CTRL_9, &data);
+		if (ret)
+			return ret;
+
+		/* Only ever allow LED Mode update */
+		data &= ~0x30;
+		data |= val & 0x30;
+
+		ret = ksz_write8(dev, REG_SW_CTRL_9, data);
+		if (ret)
+			return ret;
+		break;
+
+	/* Emulated access to Register 29/45/61 (0x1D/0x2D/0x3D): Port 1/2/3 Control 10 */
+	case (REG_PORT_CTRL_10 << 8):
+		ret = ksz_pread8(dev, p, REG_PORT_CTRL_10, &data);
+		if (ret)
+			return ret;
+
+		/* Only ever allow LED Off update */
+		data &= ~BIT(7);
+		data |= val & BIT(7);
+
+		ret = ksz_pwrite8(dev, p, REG_PORT_CTRL_10, data);
+		if (ret)
+			return ret;
+		break;
+
 	default:
 		break;
 	}
-- 
2.45.2


