Return-Path: <netdev+bounces-181231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BD1A84248
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 13:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A09DA00D64
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 11:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0CC28CF4D;
	Thu, 10 Apr 2025 11:53:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056A8283CB7
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 11:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744286002; cv=none; b=JphLNdFtT3xxwyBBZiPvvT5A9LuHZG5SY88xD6OXZjH+WJTnGgHhtwmSMlqvtA2rtpstWktPIsBn+K1EGhKwFqZ1ly2UmQEV3xca3R86ss9fRCrcDS6M2113QGUTh/4rvn5z2OFkSuJ85fPf3Yat4QF4aoxjXuYFHR9ehQQsBFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744286002; c=relaxed/simple;
	bh=UXELpa1UU70rhDlnJufWAH05ykovzyZtSXFEGrbnpxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dYphhGi7EVuCEh6k3TGBHE9in8odK9a8bqDAojKn9BhalxfSts7eZmZenr+4wFgJRSCQNNvz3WaoEESULKPjdjTYXP/zx+pGcUwC4M6mpy3rAAEmVnN7OXdsOA/uG+tkcUZj1OPXcL6jsFSgOyFNajt/UGqIUFTgPuOlZ5jhPs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u2qSz-0002y2-Im; Thu, 10 Apr 2025 13:53:09 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u2qSu-004GLH-0j;
	Thu, 10 Apr 2025 13:53:04 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u2qSu-00AkgW-0E;
	Thu, 10 Apr 2025 13:53:04 +0200
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
Subject: [PATCH net-next v6 12/12] net: usb: lan78xx: remove unused struct members
Date: Thu, 10 Apr 2025 13:53:02 +0200
Message-Id: <20250410115302.2562562-13-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250410115302.2562562-1-o.rempel@pengutronix.de>
References: <20250410115302.2562562-1-o.rempel@pengutronix.de>
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

Remove unused members from struct lan78xx_net, including:

    driver_priv
    suspend_count
    mdix_ctrl

These fields are no longer used in the driver and can be safely removed
as part of a cleanup.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v6:
- drop only those fields not already removed in previous patches
- align patch structure with review feedback from Russell King
---
 drivers/net/usb/lan78xx.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 053c7a31d65c..8868f4a19760 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -414,7 +414,6 @@ struct lan78xx_net {
 	struct net_device	*net;
 	struct usb_device	*udev;
 	struct usb_interface	*intf;
-	void			*driver_priv;
 
 	unsigned int		tx_pend_data_len;
 	size_t			n_tx_urbs;
@@ -449,15 +448,12 @@ struct lan78xx_net {
 	unsigned long		flags;
 
 	wait_queue_head_t	*wait;
-	unsigned char		suspend_count;
 
 	unsigned int		maxpacket;
 	struct timer_list	stat_monitor;
 
 	unsigned long		data[5];
 
-	u8			mdix_ctrl;
-
 	u32			chipid;
 	u32			chiprev;
 	struct mii_bus		*mdiobus;
-- 
2.39.5


