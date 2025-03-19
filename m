Return-Path: <netdev+bounces-176046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58684A6874C
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 09:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A967F19C87A8
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 08:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADEC254849;
	Wed, 19 Mar 2025 08:50:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CD7253B6F
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 08:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742374209; cv=none; b=TTejhQR9nH7S5xuUGZ9HLHXlDmLHBaNWo2QzdLOny0Yof8hLHrIwHlEqBDbHwN8NDPerXKRNoYG3hT4GTEjUmxfpWjiusDlUn9DAjUxXdW36RUeA7dd0CgprhTSNc8+r8wT/4y/NtaATyMSJlFDBgKajXTD8VYXT+pnGSt52wRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742374209; c=relaxed/simple;
	bh=Xwm0E1e6g5QSnUMSmT60DDnG9y24+z7k0K9HGSv8v1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KVCAW/p0ZCJSA7NW9ZS+92Sywl93brYwgy3f+G+JQjBo+1NZQqsRAmdk+FRs5u2dLirh604SUDhomKAhJ7/UYz0AJMRAZmkhtsjQ3R3bLj4Ty4g2+W/lTf8xlgvq7oxvzBafhvsU3mMWr1Sfadfvvq+wYJBzwnkDo5FLxb0LNaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tup7b-0008Ow-V1; Wed, 19 Mar 2025 09:49:55 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tup7Z-000Z4V-0v;
	Wed, 19 Mar 2025 09:49:53 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tup7Z-001l2N-20;
	Wed, 19 Mar 2025 09:49:53 +0100
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
Subject: [PATCH net-next v5 6/6] net: usb: lan78xx: remove unused struct members
Date: Wed, 19 Mar 2025 09:49:52 +0100
Message-Id: <20250319084952.419051-7-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250319084952.419051-1-o.rempel@pengutronix.de>
References: <20250319084952.419051-1-o.rempel@pengutronix.de>
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
    link_on
    mdix_ctrl
    interface
    fc_autoneg
    fc_request_control

These fields are no longer used in the driver and can be safely removed
as part of a cleanup.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 074ac4d1cbcb..fc6517bb3671 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -414,7 +414,6 @@ struct lan78xx_net {
 	struct net_device	*net;
 	struct usb_device	*udev;
 	struct usb_interface	*intf;
-	void			*driver_priv;
 
 	unsigned int		tx_pend_data_len;
 	size_t			n_tx_urbs;
@@ -449,23 +448,15 @@ struct lan78xx_net {
 	unsigned long		flags;
 
 	wait_queue_head_t	*wait;
-	unsigned char		suspend_count;
 
 	unsigned int		maxpacket;
 	struct timer_list	stat_monitor;
 
 	unsigned long		data[5];
 
-	int			link_on;
-	u8			mdix_ctrl;
-
 	u32			chipid;
 	u32			chiprev;
 	struct mii_bus		*mdiobus;
-	phy_interface_t		interface;
-
-	int			fc_autoneg;
-	u8			fc_request_control;
 
 	int			delta;
 	struct statstage	stats;
-- 
2.39.5


