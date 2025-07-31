Return-Path: <netdev+bounces-211185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE64EB17116
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 14:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7543C5866F9
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 12:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8302BEC22;
	Thu, 31 Jul 2025 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cBWiLr56"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E90D2853E5;
	Thu, 31 Jul 2025 12:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964635; cv=none; b=YulbzaR0D04IstXth4MJTraKoLnJupqUQqwgayWZC6A+I4lIl43NpBG7ekFEx362sHwT0FhaC82rg29RfjKL7Y8CLh3MJIquLA+OoIhFS7gmfUt63/3LE+U6Fi74nT2sSG6aSgTKrrZNyXHloB41Bnp+c3L0gmgZWBrPzObZQ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964635; c=relaxed/simple;
	bh=gQt4Zav4nAyXjTDlq43UQnhOT5+CBsgSFOjF8Cr4EAk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uTgw4jkEueLERKA/pog9UM3niE82SfsYvkYs2dF6X60mlscNPgQq7OrkjVTjoV64lfTuzlt6Sk5T0dFpHnkPSKIyDDZI1mqJ1GfXNw7QyOt3Dslw0GiZKrHP9KjWv9GbI2jo7xBupZ/wGwK46NDYmQZnpp0d1dNso7X3MJ3heBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cBWiLr56; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1753964633; x=1785500633;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gQt4Zav4nAyXjTDlq43UQnhOT5+CBsgSFOjF8Cr4EAk=;
  b=cBWiLr56PdN2Q0HIUgwDeoX8qYyOMeouiQPmgi8YU3n0A+wnaDVnKjBO
   G6qGjJOfda1pcVZYMlxYefKL2QZGeJG2PRnQGG98XYn3WGYUS+6Jc3Lz4
   ghV8HRIdU9rYp2waYeUszYVOdvFxOC7eVgIZZqIXvhhj19YBMkkeU04gv
   ccF/ZcKyiG9UaCYWgnshMHcPxsgWue/IK4ewvxLl1NJBfRWDe/tV0MWC/
   HecqHicf7zsbLzAGNKjr1sIQa5L41uWjX5vVYW71cgENEQwJOPt/zPu2R
   VQS++Zc9RNkp43qg2VtKyC4eEl8WaUmnf2Hnyk8sLHsuWKyoG+u5ea0a/
   A==;
X-CSE-ConnectionGUID: QWyiuLC3TZO1AEpUgQLdlA==
X-CSE-MsgGUID: 9E0n/GOATEKmaLZcEVzyBA==
X-IronPort-AV: E=Sophos;i="6.17,353,1747724400"; 
   d="scan'208";a="44122147"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jul 2025 05:23:46 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 31 Jul 2025 05:23:39 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 31 Jul 2025 05:23:37 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <viro@zeniv.linux.org.uk>,
	<quentin.schulz@bootlin.com>, <atenart@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net] phy: mscc: Fix timestamping for vsc8584
Date: Thu, 31 Jul 2025 14:19:20 +0200
Message-ID: <20250731121920.2358292-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

There was a problem when we received frames and the frames were
timestamped. The driver is configured to store the nanosecond part of
the timestmap in the ptp reserved bits and it would take the second part
by reading the LTC. The problem is that when reading the LTC we are in
atomic context and to read the second part will go over mdio bus which
might sleep, so we get an error.
The fix consists in actually put all the frames in a queue and start the
aux work and in that work to read the LTC and then calculate the full
received time.

Fixes: 7d272e63e0979d ("net: phy: mscc: timestamping and PHC support")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/mscc/mscc.h     | 11 ++++++
 drivers/net/phy/mscc/mscc_ptp.c | 66 +++++++++++++++++++++++++++------
 2 files changed, 65 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/mscc/mscc.h b/drivers/net/phy/mscc/mscc.h
index 6a3d8a754eb8d..7281eea2395bd 100644
--- a/drivers/net/phy/mscc/mscc.h
+++ b/drivers/net/phy/mscc/mscc.h
@@ -362,6 +362,13 @@ struct vsc85xx_hw_stat {
 	u16 mask;
 };
 
+struct vsc8531_skb {
+	struct list_head list;
+
+	struct sk_buff *skb;
+	u32 ns;
+};
+
 struct vsc8531_private {
 	int rate_magic;
 	u16 supp_led_modes;
@@ -410,6 +417,10 @@ struct vsc8531_private {
 	 */
 	struct mutex ts_lock;
 	struct mutex phc_lock;
+
+	/* rx_skbs_lock: used for accessing rx_skbs_list */
+	spinlock_t rx_skbs_lock;
+	struct list_head rx_skbs_list;
 };
 
 /* Shared structure between the PHYs of the same package.
diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
index 275706de5847c..654add1748df3 100644
--- a/drivers/net/phy/mscc/mscc_ptp.c
+++ b/drivers/net/phy/mscc/mscc_ptp.c
@@ -1194,9 +1194,10 @@ static bool vsc85xx_rxtstamp(struct mii_timestamper *mii_ts,
 {
 	struct vsc8531_private *vsc8531 =
 		container_of(mii_ts, struct vsc8531_private, mii_ts);
-	struct skb_shared_hwtstamps *shhwtstamps = NULL;
+
 	struct vsc85xx_ptphdr *ptphdr;
-	struct timespec64 ts;
+	struct vsc8531_skb *rx_skb;
+	unsigned long flags;
 	unsigned long ns;
 
 	if (!vsc8531->ptp->configured)
@@ -1206,27 +1207,65 @@ static bool vsc85xx_rxtstamp(struct mii_timestamper *mii_ts,
 	    type == PTP_CLASS_NONE)
 		return false;
 
-	vsc85xx_gettime(&vsc8531->ptp->caps, &ts);
-
 	ptphdr = get_ptp_header_rx(skb, vsc8531->ptp->rx_filter);
 	if (!ptphdr)
 		return false;
 
-	shhwtstamps = skb_hwtstamps(skb);
-	memset(shhwtstamps, 0, sizeof(struct skb_shared_hwtstamps));
-
 	ns = ntohl(ptphdr->rsrvd2);
 
-	/* nsec is in reserved field */
-	if (ts.tv_nsec < ns)
-		ts.tv_sec--;
+	rx_skb = kmalloc(sizeof(*rx_skb), GFP_ATOMIC);
+	if (!rx_skb)
+		return false;
+
+	rx_skb->skb = skb;
+	rx_skb->ns = ns;
+	spin_lock_irqsave(&vsc8531->rx_skbs_lock, flags);
+	list_add(&rx_skb->list, &vsc8531->rx_skbs_list);
+	spin_unlock_irqrestore(&vsc8531->rx_skbs_lock, flags);
 
-	shhwtstamps->hwtstamp = ktime_set(ts.tv_sec, ns);
-	netif_rx(skb);
+	ptp_schedule_worker(vsc8531->ptp->ptp_clock, 0);
 
 	return true;
 }
 
+static long vsc85xx_do_aux_work(struct ptp_clock_info *info)
+{
+	struct vsc85xx_ptp *ptp = container_of(info, struct vsc85xx_ptp, caps);
+	struct skb_shared_hwtstamps *shhwtstamps = NULL;
+	struct phy_device *phydev = ptp->phydev;
+	struct vsc8531_private *priv = phydev->priv;
+	struct vsc8531_skb *rx_skb, *tmp;
+	struct timespec64 ts;
+	unsigned long flags;
+	struct list_head skbs;
+
+	INIT_LIST_HEAD(&skbs);
+
+	vsc85xx_gettime(info, &ts);
+	spin_lock_irqsave(&priv->rx_skbs_lock, flags);
+	list_for_each_entry_safe(rx_skb, tmp, &priv->rx_skbs_list, list) {
+		shhwtstamps = skb_hwtstamps(rx_skb->skb);
+		memset(shhwtstamps, 0, sizeof(struct skb_shared_hwtstamps));
+
+		if (ts.tv_nsec < rx_skb->ns)
+			ts.tv_sec--;
+
+		shhwtstamps->hwtstamp = ktime_set(ts.tv_sec, rx_skb->ns);
+
+		list_del(&rx_skb->list);
+		list_add(&rx_skb->list, &skbs);
+	}
+	spin_unlock_irqrestore(&priv->rx_skbs_lock, flags);
+
+	list_for_each_entry_safe(rx_skb, tmp, &skbs, list) {
+		netif_rx(rx_skb->skb);
+		list_del(&rx_skb->list);
+		kfree(rx_skb);
+	}
+
+	return -1;
+}
+
 static const struct ptp_clock_info vsc85xx_clk_caps = {
 	.owner		= THIS_MODULE,
 	.name		= "VSC85xx timer",
@@ -1240,6 +1279,7 @@ static const struct ptp_clock_info vsc85xx_clk_caps = {
 	.adjfine	= &vsc85xx_adjfine,
 	.gettime64	= &vsc85xx_gettime,
 	.settime64	= &vsc85xx_settime,
+	.do_aux_work	= &vsc85xx_do_aux_work,
 };
 
 static struct vsc8531_private *vsc8584_base_priv(struct phy_device *phydev)
@@ -1567,6 +1607,8 @@ int vsc8584_ptp_probe(struct phy_device *phydev)
 
 	mutex_init(&vsc8531->phc_lock);
 	mutex_init(&vsc8531->ts_lock);
+	spin_lock_init(&vsc8531->rx_skbs_lock);
+	INIT_LIST_HEAD(&vsc8531->rx_skbs_list);
 
 	/* Retrieve the shared load/save GPIO. Request it as non exclusive as
 	 * the same GPIO can be requested by all the PHYs of the same package.
-- 
2.34.1


