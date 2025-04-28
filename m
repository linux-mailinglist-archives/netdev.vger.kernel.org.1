Return-Path: <netdev+bounces-186443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E49A9F1C2
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 15:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 753C61A843D1
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 13:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7337A274FD5;
	Mon, 28 Apr 2025 13:05:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744C5270EA5
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745845559; cv=none; b=dPFdzSN7K0gADOMk+7BcBieDqqoG6RymI96Kz45uQwbX4VXN4NRdqWHUvXmlZvvb8BGYRi8eR2Mj/eIoMHV4hEzRtjDo+mc0ILyq3X0GLVjYDnngTPcvZVS4jli4K/qVF8l2Weba6xvUrqpf4K4lhX3YOyisSKJ5hqPXtuFwl2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745845559; c=relaxed/simple;
	bh=p5K3m/2awqH/wsJhZKbELlqT5m3wW53cDzS4wBXBhoc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=InwO59zCXKW9x+HSFr1ZFcHuStdcsI9/eKqGkzI9zmWXhgEh0xIQvMlb40C4sQZH/ctzC49twXNSDfGGSfECqTAwTw5+Qw8D8L12YrcHeIMsm7F+djr8d2DWU7JSQWV1ehKg47a7gmTjku9M6qxucrikwCCkaywYdOIrfjnd1PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u9OBB-0000MZ-Oh; Mon, 28 Apr 2025 15:05:49 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u9OB6-0006Fe-1S;
	Mon, 28 Apr 2025 15:05:44 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u9OB6-00GJBg-0o;
	Mon, 28 Apr 2025 15:05:44 +0200
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
Subject: [PATCH net-next v7 12/12] net: usb: lan78xx: remove unused struct members
Date: Mon, 28 Apr 2025 15:05:42 +0200
Message-Id: <20250428130542.3879769-13-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250428130542.3879769-1-o.rempel@pengutronix.de>
References: <20250428130542.3879769-1-o.rempel@pengutronix.de>
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
index ba6a6cda779e..647ab9d66334 100644
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


