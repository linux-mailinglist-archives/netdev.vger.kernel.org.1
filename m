Return-Path: <netdev+bounces-152188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FD49F302B
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69FE61885C4E
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 12:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0DA205AC8;
	Mon, 16 Dec 2024 12:09:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79A7204C08
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734350998; cv=none; b=q7Toj3X/6FA0E8NfV7NNDRhxap4nsATlAnY1icVrQKIilJOuehkAkDAGaKbsytYGdsHjQDwAPYCa6EzkgGv6mzEVyeS1IGDOCI/N9blGaQ4XFcT9q7AQhNZHpEB3yVYKX1wsoM7ymtLXBnU5dMmR4ANdWBXvIegcaeYumOCB4SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734350998; c=relaxed/simple;
	bh=M6/dmU5gV8hkCd8AiX90yM2U2eMQuPz7bbBpyE91QNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V0zi9MtLeuU6a6i/Couos4LaO05CaLdu5+YqDhEitKHwv+KX3JiDe9ZpzvKTY/5fSYkqmZjggZWWwChttFYAw+eElnWyIcvmHu8MIgB/kNfPqYEb1QE1oSoP4PSiZLZPC4VzCBp2Zm2gc/OiqO3w7T9yrEshx6btAlgt8yhf+7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tN9v1-0001C5-9F; Mon, 16 Dec 2024 13:09:47 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tN9uw-003h1k-2O;
	Mon, 16 Dec 2024 13:09:43 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tN9ux-0075uA-1K;
	Mon, 16 Dec 2024 13:09:43 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH net-next v1 4/6] net: usb: lan78xx: rename phy_mutex to mdiobus_mutex
Date: Mon, 16 Dec 2024 13:09:39 +0100
Message-Id: <20241216120941.1690908-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216120941.1690908-1-o.rempel@pengutronix.de>
References: <20241216120941.1690908-1-o.rempel@pengutronix.de>
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

Rename `phy_mutex` to `mdiobus_mutex` for clarity, as the mutex protects
MDIO bus access rather than PHY-specific operations. Update all
references to ensure consistency.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 30301af29ab2..78c75599b8f1 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -439,7 +439,7 @@ struct lan78xx_net {
 	struct usb_anchor	deferred;
 
 	struct mutex		dev_mutex; /* serialise open/stop wrt suspend/resume */
-	struct mutex		phy_mutex; /* for phy access */
+	struct mutex		mdiobus_mutex; /* for MDIO bus access */
 	unsigned int		pipe_in, pipe_out, pipe_intr;
 
 	unsigned int		bulk_in_delay;
@@ -952,7 +952,7 @@ static int lan78xx_flush_rx_fifo(struct lan78xx_net *dev)
 	return lan78xx_flush_fifo(dev, FCT_RX_CTL, FCT_RX_CTL_RST_);
 }
 
-/* Loop until the read is completed with timeout called with phy_mutex held */
+/* Loop until the read is completed with timeout called with mdiobus_mutex held */
 static int lan78xx_mdiobus_wait_not_busy(struct lan78xx_net *dev)
 {
 	unsigned long start_time = jiffies;
@@ -1596,7 +1596,7 @@ static int lan78xx_mac_reset(struct lan78xx_net *dev)
 	u32 val;
 	int ret;
 
-	mutex_lock(&dev->phy_mutex);
+	mutex_lock(&dev->mdiobus_mutex);
 
 	/* Resetting the device while there is activity on the MDIO
 	 * bus can result in the MAC interface locking up and not
@@ -1631,7 +1631,7 @@ static int lan78xx_mac_reset(struct lan78xx_net *dev)
 
 	ret = -ETIMEDOUT;
 exit_unlock:
-	mutex_unlock(&dev->phy_mutex);
+	mutex_unlock(&dev->mdiobus_mutex);
 
 	return ret;
 }
@@ -2249,7 +2249,7 @@ static int lan78xx_mdiobus_read(struct mii_bus *bus, int phy_id, int idx)
 	if (ret < 0)
 		return ret;
 
-	mutex_lock(&dev->phy_mutex);
+	mutex_lock(&dev->mdiobus_mutex);
 
 	/* confirm MII not busy */
 	ret = lan78xx_mdiobus_wait_not_busy(dev);
@@ -2273,7 +2273,7 @@ static int lan78xx_mdiobus_read(struct mii_bus *bus, int phy_id, int idx)
 	ret = (int)(val & 0xFFFF);
 
 done:
-	mutex_unlock(&dev->phy_mutex);
+	mutex_unlock(&dev->mdiobus_mutex);
 	usb_autopm_put_interface(dev->intf);
 
 	return ret;
@@ -2290,7 +2290,7 @@ static int lan78xx_mdiobus_write(struct mii_bus *bus, int phy_id, int idx,
 	if (ret < 0)
 		return ret;
 
-	mutex_lock(&dev->phy_mutex);
+	mutex_lock(&dev->mdiobus_mutex);
 
 	/* confirm MII not busy */
 	ret = lan78xx_mdiobus_wait_not_busy(dev);
@@ -2313,7 +2313,7 @@ static int lan78xx_mdiobus_write(struct mii_bus *bus, int phy_id, int idx,
 		goto done;
 
 done:
-	mutex_unlock(&dev->phy_mutex);
+	mutex_unlock(&dev->mdiobus_mutex);
 	usb_autopm_put_interface(dev->intf);
 	return ret;
 }
@@ -4476,7 +4476,7 @@ static int lan78xx_probe(struct usb_interface *intf,
 	skb_queue_head_init(&dev->rxq_done);
 	skb_queue_head_init(&dev->txq_pend);
 	skb_queue_head_init(&dev->rxq_overflow);
-	mutex_init(&dev->phy_mutex);
+	mutex_init(&dev->mdiobus_mutex);
 	mutex_init(&dev->dev_mutex);
 
 	ret = lan78xx_urb_config_init(dev);
-- 
2.39.5


