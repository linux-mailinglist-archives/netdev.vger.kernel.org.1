Return-Path: <netdev+bounces-109236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8C49277FA
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 16:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB7C1F21867
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 14:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9F81B0106;
	Thu,  4 Jul 2024 14:14:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1F21ABC25
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 14:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720102440; cv=none; b=oXehbvMyflmP1QR5SBchC87FtpM427c+EDdfhXQncC3ThikUSeOFe0c1mAjLFsmb0LIyOzoWyHGBNBcs/nOKCwFkRXRH0z//fmln/dLrShukyBZpWIJi7oxAIPThX8S0MFy2s4hLXu5tbjrTE27uw21lg07bUlpHejqyEUonfRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720102440; c=relaxed/simple;
	bh=h9s8lt9FQqG7ktE4LECfjMZgHlDb+6WbwnDyQhTRyo4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k3SpdOXxBtcu4wNeaQhgOWzzo+OIUXfCBdDGff0uDNv3zgSuI076ptDAqEsJzNj/39eNKt2+bPV2Cnmk3OxlY4XHCR64taPAt0yOaO8eLqL97aSD+dDw18ST/MLIZwcQXmJGzI0MlZd0xCptdv8BlzieZ2qvQ0Ow1V+ia6GZQ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sPNDb-0004OQ-7c; Thu, 04 Jul 2024 16:13:51 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sPNDa-0076mu-EM; Thu, 04 Jul 2024 16:13:50 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sPNDa-00GYrQ-1D;
	Thu, 04 Jul 2024 16:13:50 +0200
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
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net-next v1 1/1] net: dsa: microchip: lan9371/2: update MAC capabilities for port 4
Date: Thu,  4 Jul 2024 16:13:48 +0200
Message-Id: <20240704141348.3947232-1-o.rempel@pengutronix.de>
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
integrated 100BaseTX PHY.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/lan937x_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index 83ac33fede3f5..44911bc7cea1d 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -324,6 +324,11 @@ void lan937x_phylink_get_caps(struct ksz_device *dev, int port,
 		/* MII/RMII/RGMII ports */
 		config->mac_capabilities |= MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
 					    MAC_100HD | MAC_10 | MAC_1000FD;
+	} else if ((dev->info->chip_id == LAN9371_CHIP_ID ||
+		    dev->info->chip_id == LAN9372_CHIP_ID) &&
+		   port == KSZ_PORT_4) {
+		config->mac_capabilities |= MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+					    MAC_100HD | MAC_10;
 	}
 }
 
-- 
2.39.2


