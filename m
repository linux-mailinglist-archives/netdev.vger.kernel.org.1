Return-Path: <netdev+bounces-84583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3EA8977B8
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 20:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59F91C26483
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 18:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C321534E6;
	Wed,  3 Apr 2024 18:02:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0645152E0D
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 18:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167365; cv=none; b=LiugvHE4IHYexCcZ8ZAh5hA9u7nStqL2QxlW3Icg6czzJiTOLbJvPujpgbQ+0AA03s1k/6wxfTmGAloBVf29lVGQGgCFVvw1QBwmDq4GZztGzGGUCsOjtFyyoromUCuuAqO/WFqXTcIJojJ2Kium8fiBG3agdOQRMsnMWqfND/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167365; c=relaxed/simple;
	bh=WnGObgsV1CcvCJj8yb4xkruUyWL7miQ2+aDMKi/RxKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SCyUFg5JZi++wAgZG3UMUgiF+G8aWw6V87DdxR3rVpnv4rvDW/j8oJnr4NSc6qgno/G4bJX5H82GNyWLpqYFu+dEqkSgVO01HMWrlWsfA7wiEDDz0buri34pwmajqeLZOF+6BqWffa4RTNmCWXYcQLT6nN0wc4loma9Yqa3P0fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1rs4wO-0008GE-W9; Wed, 03 Apr 2024 20:02:29 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <l.stach@pengutronix.de>)
	id 1rs4wN-00AE7z-7h; Wed, 03 Apr 2024 20:02:27 +0200
From: Lucas Stach <l.stach@pengutronix.de>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org,
	kernel@pengutronix.de,
	patchwork-lst@pengutronix.de
Subject: [PATCH 3/3] net: dsa: microchip: lan937x: disable VPHY output
Date: Wed,  3 Apr 2024 20:02:26 +0200
Message-Id: <20240403180226.1641383-3-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403180226.1641383-1-l.stach@pengutronix.de>
References: <20240403180226.1641383-1-l.stach@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

While the documented VPHY out-of-reset configuration should autonegotiate
the maximum supported link speed on the CPU interface, that doesn't work
on RGMII links, where the VPHY negotiates 100MBit speed. This causes the
RGMII TX interface to run with a wrong clock rate.

Disable the VPHY output altogether, so it doesn't interfere with the
CPU interface configuration set via fixed-link. The VPHY is a compatibility
functionality to be able to attach network drivers without fixed-link
support to the switch, which generally should not be needed with linux
network drivers.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/net/dsa/microchip/lan937x_main.c | 3 +++
 drivers/net/dsa/microchip/lan937x_reg.h  | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index 04fa74c7dcbe..9db1d278ee9b 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -400,6 +400,9 @@ int lan937x_setup(struct dsa_switch *ds)
 	lan937x_cfg(dev, REG_SW_GLOBAL_OUTPUT_CTRL__1,
 		    (SW_CLK125_ENB | SW_CLK25_ENB), true);
 
+	/* disable VPHY output*/
+	ksz_rmw32(dev, REG_SW_CFG_STRAP_OVR, SW_VPHY_DISABLE, SW_VPHY_DISABLE);
+
 	return 0;
 }
 
diff --git a/drivers/net/dsa/microchip/lan937x_reg.h b/drivers/net/dsa/microchip/lan937x_reg.h
index e36bcb155f54..be553e23a964 100644
--- a/drivers/net/dsa/microchip/lan937x_reg.h
+++ b/drivers/net/dsa/microchip/lan937x_reg.h
@@ -37,6 +37,10 @@
 #define SW_CLK125_ENB			BIT(1)
 #define SW_CLK25_ENB			BIT(0)
 
+/* 2 - PHY Control */
+#define REG_SW_CFG_STRAP_OVR		0x214
+#define SW_VPHY_DISABLE			BIT(31)
+
 /* 3 - Operation Control */
 #define REG_SW_OPERATION		0x0300
 
-- 
2.39.2


