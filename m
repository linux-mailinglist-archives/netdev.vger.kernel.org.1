Return-Path: <netdev+bounces-109393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864B8928406
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 10:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 413F028372C
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 08:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F72143887;
	Fri,  5 Jul 2024 08:47:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889F160DFA
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720169252; cv=none; b=M1OGf/r4kwmoFsV+T2andMleKNCh21rLZMmdt2vI1+YfGA2uztOcfpN1eaxVLmvQj3vP73BMgZyHNKmmZI7lEouhrx7shU/0aNeUj4VJjvEytA5D/a4ztSGF2Jy+e2qUydYVuOC2qEEInnXW3wz/NDaeblz9zWaMlclRNvSrOvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720169252; c=relaxed/simple;
	bh=cDtMhfKHNJu+RyJUPhUfQrAnwN1cd5gBcYw9LtbXfmc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tKwQuq4Epz1se/ir3m4iyOIYpMpI6WvYn0T6Nqh0bRUhL4V09EdqN0UPOq5WgczhaAKbxEmiAppm8psRwO+fugmvEoZvLG6ZclhSZmYKekT917ZbnnOEoGsK85krYyEWEpN7NrJ141kGLcWmoCAVpV2P9ayNq6bdVpIwXFREfSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sPeb9-00042S-AE; Fri, 05 Jul 2024 10:47:19 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sPeb7-007HqI-C8; Fri, 05 Jul 2024 10:47:17 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sPeb7-000LX1-0z;
	Fri, 05 Jul 2024 10:47:17 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net-next v2 1/1] net: dsa: microchip: lan9371/2: update MAC capabilities for port 4
Date: Fri,  5 Jul 2024 10:47:15 +0200
Message-Id: <20240705084715.82752-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
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

Set proper MAC capabilities for port 4 on LAN9371 and LAN9372 switches with
integrated 100BaseTX PHY. And introduce the is_lan937x_tx_phy() function to
reuse it where applicable.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
changes v2:
- add is_lan937x_tx_phy() function
- reuse is_lan937x_tx_phy() in lan937x_vphy_ind_addr_wr()
- add Reviewed-by: Florian Fainelli
---
 drivers/net/dsa/microchip/ksz_common.h   | 6 ++++++
 drivers/net/dsa/microchip/lan937x_main.c | 6 ++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index c4a4664c03859..5f0a628b9849e 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -638,6 +638,12 @@ static inline int is_lan937x(struct ksz_device *dev)
 		dev->chip_id == LAN9374_CHIP_ID;
 }
 
+static inline bool is_lan937x_tx_phy(struct ksz_device *dev, int port)
+{
+	return (dev->chip_id == LAN9371_CHIP_ID ||
+		dev->chip_id == LAN9372_CHIP_ID) && port == KSZ_PORT_4;
+}
+
 /* STP State Defines */
 #define PORT_TX_ENABLE			BIT(2)
 #define PORT_RX_ENABLE			BIT(1)
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index 83ac33fede3f5..824d9309a3d35 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -55,8 +55,7 @@ static int lan937x_vphy_ind_addr_wr(struct ksz_device *dev, int addr, int reg)
 	u16 addr_base = REG_PORT_T1_PHY_CTRL_BASE;
 	u16 temp;
 
-	if ((dev->info->chip_id == LAN9371_CHIP_ID ||
-	     dev->info->chip_id == LAN9372_CHIP_ID) && addr == KSZ_PORT_4)
+	if (is_lan937x_tx_phy(dev, addr))
 		addr_base = REG_PORT_TX_PHY_CTRL_BASE;
 
 	/* get register address based on the logical port */
@@ -324,6 +323,9 @@ void lan937x_phylink_get_caps(struct ksz_device *dev, int port,
 		/* MII/RMII/RGMII ports */
 		config->mac_capabilities |= MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
 					    MAC_100HD | MAC_10 | MAC_1000FD;
+	} else if (is_lan937x_tx_phy(dev, port)) {
+		config->mac_capabilities |= MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+					    MAC_100HD | MAC_10;
 	}
 }
 
-- 
2.39.2


