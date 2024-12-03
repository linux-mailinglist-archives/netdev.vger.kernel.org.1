Return-Path: <netdev+bounces-148383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57F89E140D
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C6C7B244F7
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 07:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EDF1E1C16;
	Tue,  3 Dec 2024 07:22:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BE71DF242
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 07:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210534; cv=none; b=DztMdWilYx4daNp/14MVgsfz8yPby1pdx33lcv6eF3e9wj17pGA4HrPqehqtjCRziiHHdvSSwPBL0K/aTz+5tXlZ9ENyZKqosxVaEiPar/7b0+rPwQnVd0IFO/TNLuZqQyUZ9WEVyPhaTsAMOu19kIJsL+KFBbcQ7AKxf0uOYcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210534; c=relaxed/simple;
	bh=Mdid41HpR/uZUM79Qmv1K9Q8mfecEHCml7VhDgPU3vE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hFVOjeRruPeFiujv1iAlZln5G9JWGNRniqAcoWgZsav+GUBlqJyWV1qgyz19NMFQtaPHFwdTKp7/prwgHSneGUy5kyY9/ZbV6KjMVt8cXRvISPnHiQi1SeG/8utPB4ZcUfoo85Xw4Nk+x9JfECAbYxdCVdA7O48tOiwmcJeJ7mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEP-0004sI-MC; Tue, 03 Dec 2024 08:22:01 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEJ-001QzJ-1P;
	Tue, 03 Dec 2024 08:21:56 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEK-00AEpo-04;
	Tue, 03 Dec 2024 08:21:56 +0100
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
Subject: [PATCH net-next v1 20/21] net: usb: lan78xx: Rename lan78xx_phy_wait_not_busy to lan78xx_mdiobus_wait_not_busy
Date: Tue,  3 Dec 2024 08:21:53 +0100
Message-Id: <20241203072154.2440034-21-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241203072154.2440034-1-o.rempel@pengutronix.de>
References: <20241203072154.2440034-1-o.rempel@pengutronix.de>
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

Rename `lan78xx_phy_wait_not_busy` to `lan78xx_mdiobus_wait_not_busy`
for clarity and accuracy, as the function operates on the MII bus rather
than a specific PHY. Update all references to reflect the new name.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 9852526be002..0403aea1a9fa 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -953,7 +953,7 @@ static int lan78xx_flush_rx_fifo(struct lan78xx_net *dev)
 }
 
 /* Loop until the read is completed with timeout called with phy_mutex held */
-static int lan78xx_phy_wait_not_busy(struct lan78xx_net *dev)
+static int lan78xx_mdiobus_wait_not_busy(struct lan78xx_net *dev)
 {
 	unsigned long start_time = jiffies;
 	u32 val;
@@ -1602,7 +1602,7 @@ static int lan78xx_mac_reset(struct lan78xx_net *dev)
 	 * bus can result in the MAC interface locking up and not
 	 * completing register access transactions.
 	 */
-	ret = lan78xx_phy_wait_not_busy(dev);
+	ret = lan78xx_mdiobus_wait_not_busy(dev);
 	if (ret < 0)
 		goto mac_reset_done;
 
@@ -2243,7 +2243,7 @@ static int lan78xx_mdiobus_read(struct mii_bus *bus, int phy_id, int idx)
 	mutex_lock(&dev->phy_mutex);
 
 	/* confirm MII not busy */
-	ret = lan78xx_phy_wait_not_busy(dev);
+	ret = lan78xx_mdiobus_wait_not_busy(dev);
 	if (ret < 0)
 		goto done;
 
@@ -2253,7 +2253,7 @@ static int lan78xx_mdiobus_read(struct mii_bus *bus, int phy_id, int idx)
 	if (ret < 0)
 		goto done;
 
-	ret = lan78xx_phy_wait_not_busy(dev);
+	ret = lan78xx_mdiobus_wait_not_busy(dev);
 	if (ret < 0)
 		goto done;
 
@@ -2284,7 +2284,7 @@ static int lan78xx_mdiobus_write(struct mii_bus *bus, int phy_id, int idx,
 	mutex_lock(&dev->phy_mutex);
 
 	/* confirm MII not busy */
-	ret = lan78xx_phy_wait_not_busy(dev);
+	ret = lan78xx_mdiobus_wait_not_busy(dev);
 	if (ret < 0)
 		goto done;
 
@@ -2299,7 +2299,7 @@ static int lan78xx_mdiobus_write(struct mii_bus *bus, int phy_id, int idx,
 	if (ret < 0)
 		goto done;
 
-	ret = lan78xx_phy_wait_not_busy(dev);
+	ret = lan78xx_mdiobus_wait_not_busy(dev);
 	if (ret < 0)
 		goto done;
 
-- 
2.39.5


