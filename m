Return-Path: <netdev+bounces-199689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DC3AE16A8
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 10:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296C83B67BD
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 08:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0825D27466A;
	Fri, 20 Jun 2025 08:46:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93392741C6
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750409198; cv=none; b=Zq4LfPrMWoqaw9Leszt5z3uZK8GUS0AQZI4vqRZVO61saDNQSfYAkwFrO77VwdijvxfH24/Ir7ozBKHdlZRd0DcAtCXXpS6bsk6YUbrVUAG5pv88hWBYvJqIbo/RfwS85FUOoLBDWrPLdOaP+05ibTioY2hnM8Qo8d9sQen9ZPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750409198; c=relaxed/simple;
	bh=R8FzsAn090SuvKZujFThBe6VcyFNEuRPnztyk7IMM+E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SVFfqpEs32t7vt6S4fdH3iSFYux3VB7dK0pYA9m4tk8rO2pdtce6VNm+CFOsc/1RYfV3NPtIcSAp1gW1bo73dL5/8ZqPrctNGLdBR3ixCN2cB0AU2uXfcGVv1jJS4Q0QYnDquzhod30M2NTy13ZDxxIDBLsm1kaxMgExQoGtJP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uSXO9-0001Vl-3o; Fri, 20 Jun 2025 10:46:21 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uSXO7-004QzA-0s;
	Fri, 20 Jun 2025 10:46:19 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uSXO7-007nGl-0a;
	Fri, 20 Jun 2025 10:46:19 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v1 1/1] net: usb: lan78xx: annotate checksum assignment to silence sparse warnings
Date: Fri, 20 Jun 2025 10:46:18 +0200
Message-Id: <20250620084618.1857662-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
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

sparse warns about suspicious type casts in checksum assignment:

drivers/net/usb/lan78xx.c:3865:29: warning: cast to restricted __be16
drivers/net/usb/lan78xx.c:3865:27: warning: incorrect type in assignment
    (different base types) expected restricted __wsum [usertype] csum
got unsigned short [usertype]

Use __force to annotate the casts from u16 to __be16 to __wsum.
This makes the type conversion explicit and silences the warnings.
The code is otherwise correct; this change only clarifies intent.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index f00284c9ad34..565b9847e2ab 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -3819,7 +3819,10 @@ static void lan78xx_rx_csum_offload(struct lan78xx_net *dev,
 	     !(dev->net->features & NETIF_F_HW_VLAN_CTAG_RX))) {
 		skb->ip_summed = CHECKSUM_NONE;
 	} else {
-		skb->csum = ntohs((u16)(rx_cmd_b >> RX_CMD_B_CSUM_SHIFT_));
+		__be16 csum_raw;
+
+		csum_raw = (__force __be16)(rx_cmd_b >> RX_CMD_B_CSUM_SHIFT_);
+		skb->csum = (__force __wsum)ntohs(csum_raw);
 		skb->ip_summed = CHECKSUM_COMPLETE;
 	}
 }
-- 
2.39.5


