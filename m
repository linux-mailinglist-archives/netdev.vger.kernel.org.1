Return-Path: <netdev+bounces-108050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5779891DAB3
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 10:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D89A5B2112F
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 08:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2FE84D34;
	Mon,  1 Jul 2024 08:53:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F57D84037
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719824034; cv=none; b=RDCaPG+lntHd0twUvQ2b5Q4q6Zaxp7TsirAc8nZvsGShl9kiNVSC0Hvv0aiIX7hD3/MbpK33LqsrLigqQ82gzpvNAkPEJcwRg+w4SXGnW04U+J4FDyqTB2YJogVLRUc+q5uXPvFD+EPF2UBYCJ9FkgV+agp2qZD8pe0QpG1/FHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719824034; c=relaxed/simple;
	bh=5aS9mvQ/Irljen8wjikG89TM/g9nsYb8aM4QkYtKZPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fGnoUDrQdIN0OhQ5hs+vk+8W5qh3I6SGWukTI5TIy5GVLTY6BkH658er/cbie99nwYbvBVnQ75MycU+c9fCIiAArUMlqis32nPmFQKsiIi2hv6y+bNpa5kY0J7td3uUkZW3Y8tCWYQyXe8YCDVferANE6jaq4mhZDVZrtbYaKzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sOCnB-0006bE-92; Mon, 01 Jul 2024 10:53:45 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sOCnA-006Kdp-KC; Mon, 01 Jul 2024 10:53:44 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sOCnA-00ClWO-1m;
	Mon, 01 Jul 2024 10:53:44 +0200
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
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net-next v2 3/3] net: dsa: microchip: lan937x: disable VPHY support
Date: Mon,  1 Jul 2024 10:53:43 +0200
Message-Id: <20240701085343.3042567-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701085343.3042567-1-o.rempel@pengutronix.de>
References: <20240701085343.3042567-1-o.rempel@pengutronix.de>
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

From: Lucas Stach <l.stach@pengutronix.de>

As described by the microchip article "LAN937X - The required
configuration for the external MAC port to operate at RGMII-to-RGMII
1Gbps link speed." [1]:

"When VPHY is enabled, the auto-negotiation process following IEEE 802.3
standard will be triggered and will result in RGMII-to-RGMII signal
failure on the interface because VPHY will try to poll the PHY status
that is not available in the scenario of RGMII-to-RGMII connection
(normally the link partner is usually an external processor).

Note that when VPHY fails on accessing PHY registers, it will fall back
to 100Mbps speed, it indicates disabling VPHY is optional if you only
need the port to link at 100Mbps speed.

Again, VPHY must and can only be disabled by writing VPHY_DISABLE bit in
the register below as there is no strapping pin for the control."

This patch was tested on LAN9372, so far it seems to not to affect VPHY
based clock crossing optimization for the ports with integrated PHYs.

[1]: https://microchip.my.site.com/s/article/LAN937X-The-required-configuration-for-the-external-MAC-port-to-operate-at-RGMII-to-RGMII-1Gbps-link-speed

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v2:
- reword the comment and link microchip article
---
 drivers/net/dsa/microchip/lan937x_main.c | 3 +++
 drivers/net/dsa/microchip/lan937x_reg.h  | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index eaa862eb6b265..0606796b14856 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -390,6 +390,9 @@ int lan937x_setup(struct dsa_switch *ds)
 	lan937x_cfg(dev, REG_SW_GLOBAL_OUTPUT_CTRL__1,
 		    (SW_CLK125_ENB | SW_CLK25_ENB), true);
 
+	/* Disable global VPHY support. Related to CPU interface only? */
+	ksz_rmw32(dev, REG_SW_CFG_STRAP_OVR, SW_VPHY_DISABLE, SW_VPHY_DISABLE);
+
 	return 0;
 }
 
diff --git a/drivers/net/dsa/microchip/lan937x_reg.h b/drivers/net/dsa/microchip/lan937x_reg.h
index 7ecada9240233..2f22a9d01de36 100644
--- a/drivers/net/dsa/microchip/lan937x_reg.h
+++ b/drivers/net/dsa/microchip/lan937x_reg.h
@@ -37,6 +37,10 @@
 #define SW_CLK125_ENB			BIT(1)
 #define SW_CLK25_ENB			BIT(0)
 
+/* 2 - PHY Control */
+#define REG_SW_CFG_STRAP_OVR		0x0214
+#define SW_VPHY_DISABLE			BIT(31)
+
 /* 3 - Operation Control */
 #define REG_SW_OPERATION		0x0300
 
-- 
2.39.2


