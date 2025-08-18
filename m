Return-Path: <netdev+bounces-214471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8732B29BD5
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 10:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92E384E240B
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 08:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1404E2FDC3A;
	Mon, 18 Aug 2025 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UizifVZ6"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FBD2FB98D;
	Mon, 18 Aug 2025 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755504996; cv=none; b=cQfdKHdS7zOZ5q369Lk+dt2jDqVX7aW1ZCpa2nxtuYPIVl3PkUR0jzYAh9F+rj1A2+hshiZGeysbwnZy7BDZEAD0hi8K4eLeKgYl9c+GaihpLm+r+oFTDd9UdwQpSIpVIo5L6Vuc1sq5tJlVDc641rhsi3jUpEIjdsvYg2ktTGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755504996; c=relaxed/simple;
	bh=G+aHlvQ+CweaIXV2IXq48IipOx5UUo5t880wy4OPl1k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uus9OpI91w0kymSMcjzShacJhPc3POn2zqu/ryt6bSwIqORtxvmMagpE5ZtT9STuEMb5hcPGvqg/Tep/gQw+Fr/V7mQ4ZGxo5WV5ttxMu31s+ctBiCrMemsDLNaTO4Lb1hzZ67eCV+Bp7UO4gileECsNNPIL0i2ak1hkSuvb6Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UizifVZ6; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755504995; x=1787040995;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=G+aHlvQ+CweaIXV2IXq48IipOx5UUo5t880wy4OPl1k=;
  b=UizifVZ6OOTI93X5pS/Vsz7ttD9upmS1b6EpPTq565sE1t5CEo/bcQWT
   ZgV0C9kV/U2XB+7BiGDJO9xY4KLrrHQ0NfcdZtKthzthw/H9k1x5/QODB
   pyU1ndRvKEH09kt3gJWrwsISRzfGEAULgZWA17ra+ytNJm9fpqN6XtIJ7
   9YOvm+SG76mZcn1MgQ2uCst5tC52muvByYhceGLeaZt56KUvLGNDwIuTh
   7obv5wTEAZeSfoJfUfaiI23P0EFrUskjMIe5TaatkaYyT6Bp9m5J4wxd0
   MfT4rTdrtKhHOuEsffM40SPJ8sn2T7rzDidD+I5w29ute2MZu1hW6Bzre
   Q==;
X-CSE-ConnectionGUID: DwC6mKDGSdioEGdvpUJHIA==
X-CSE-MsgGUID: bN7t/wOcQFGpXpVdOUpFVA==
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="45303678"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Aug 2025 01:16:34 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 18 Aug 2025 01:16:20 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 18 Aug 2025 01:16:17 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>,
	<rmk+kernel@armlinux.org.uk>, <vladimir.oltean@nxp.com>, <rosenp@gmail.com>,
	<christophe.jaillet@wanadoo.fr>, <viro@zeniv.linux.org.uk>,
	<quentin.schulz@bootlin.com>, <atenart@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net v4] phy: mscc: Fix timestamping for vsc8584
Date: Mon, 18 Aug 2025 10:10:29 +0200
Message-ID: <20250818081029.1300780-1-horatiu.vultur@microchip.com>
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
v3->v4:
- remove empty line

v2->v3:
- make sure to flush the rx_skbs_list when the driver is removed

v1->v2:
- use sk_buff_head instead of a list_head and spinlock_t
- stop allocating vsc8431_skb but put the timestamp in skb->cb
---
 drivers/net/phy/mscc/mscc.h      | 12 ++++++++
 drivers/net/phy/mscc/mscc_main.c | 12 ++++++++
 drivers/net/phy/mscc/mscc_ptp.c  | 49 ++++++++++++++++++++++++--------
 3 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/mscc/mscc.h b/drivers/net/phy/mscc/mscc.h
index 138355f1ab0bc..b8c6ba7c7834e 100644
--- a/drivers/net/phy/mscc/mscc.h
+++ b/drivers/net/phy/mscc/mscc.h
@@ -365,6 +365,13 @@ struct vsc85xx_hw_stat {
 	u16 mask;
 };
 
+struct vsc8531_skb_cb {
+	u32 ns;
+};
+
+#define VSC8531_SKB_CB(skb) \
+	((struct vsc8531_skb_cb *)((skb)->cb))
+
 struct vsc8531_private {
 	int rate_magic;
 	u16 supp_led_modes;
@@ -413,6 +420,11 @@ struct vsc8531_private {
 	 */
 	struct mutex ts_lock;
 	struct mutex phc_lock;
+
+	/* list of skbs that were received and need timestamp information but it
+	 * didn't received it yet
+	 */
+	struct sk_buff_head rx_skbs_list;
 };
 
 /* Shared structure between the PHYs of the same package.
diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 37e3e931a8e53..800da302ae632 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -2368,6 +2368,13 @@ static int vsc85xx_probe(struct phy_device *phydev)
 	return vsc85xx_dt_led_modes_get(phydev, default_mode);
 }
 
+static void vsc85xx_remove(struct phy_device *phydev)
+{
+	struct vsc8531_private *priv = phydev->priv;
+
+	skb_queue_purge(&priv->rx_skbs_list);
+}
+
 /* Microsemi VSC85xx PHYs */
 static struct phy_driver vsc85xx_driver[] = {
 {
@@ -2630,6 +2637,7 @@ static struct phy_driver vsc85xx_driver[] = {
 	.config_intr    = &vsc85xx_config_intr,
 	.suspend	= &genphy_suspend,
 	.resume		= &genphy_resume,
+	.remove		= &vsc85xx_remove,
 	.probe		= &vsc8574_probe,
 	.set_wol	= &vsc85xx_wol_set,
 	.get_wol	= &vsc85xx_wol_get,
@@ -2657,6 +2665,7 @@ static struct phy_driver vsc85xx_driver[] = {
 	.config_intr    = &vsc85xx_config_intr,
 	.suspend	= &genphy_suspend,
 	.resume		= &genphy_resume,
+	.remove		= &vsc85xx_remove,
 	.probe		= &vsc8574_probe,
 	.set_wol	= &vsc85xx_wol_set,
 	.get_wol	= &vsc85xx_wol_get,
@@ -2684,6 +2693,7 @@ static struct phy_driver vsc85xx_driver[] = {
 	.config_intr    = &vsc85xx_config_intr,
 	.suspend	= &genphy_suspend,
 	.resume		= &genphy_resume,
+	.remove		= &vsc85xx_remove,
 	.probe		= &vsc8584_probe,
 	.get_tunable	= &vsc85xx_get_tunable,
 	.set_tunable	= &vsc85xx_set_tunable,
@@ -2709,6 +2719,7 @@ static struct phy_driver vsc85xx_driver[] = {
 	.config_intr    = &vsc85xx_config_intr,
 	.suspend	= &genphy_suspend,
 	.resume		= &genphy_resume,
+	.remove		= &vsc85xx_remove,
 	.probe		= &vsc8584_probe,
 	.get_tunable	= &vsc85xx_get_tunable,
 	.set_tunable	= &vsc85xx_set_tunable,
@@ -2734,6 +2745,7 @@ static struct phy_driver vsc85xx_driver[] = {
 	.config_intr    = &vsc85xx_config_intr,
 	.suspend	= &genphy_suspend,
 	.resume		= &genphy_resume,
+	.remove		= &vsc85xx_remove,
 	.probe		= &vsc8584_probe,
 	.get_tunable	= &vsc85xx_get_tunable,
 	.set_tunable	= &vsc85xx_set_tunable,
diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
index 275706de5847c..de6c7312e8f29 100644
--- a/drivers/net/phy/mscc/mscc_ptp.c
+++ b/drivers/net/phy/mscc/mscc_ptp.c
@@ -1194,9 +1194,7 @@ static bool vsc85xx_rxtstamp(struct mii_timestamper *mii_ts,
 {
 	struct vsc8531_private *vsc8531 =
 		container_of(mii_ts, struct vsc8531_private, mii_ts);
-	struct skb_shared_hwtstamps *shhwtstamps = NULL;
 	struct vsc85xx_ptphdr *ptphdr;
-	struct timespec64 ts;
 	unsigned long ns;
 
 	if (!vsc8531->ptp->configured)
@@ -1206,27 +1204,52 @@ static bool vsc85xx_rxtstamp(struct mii_timestamper *mii_ts,
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
+	VSC8531_SKB_CB(skb)->ns = ns;
+	skb_queue_tail(&vsc8531->rx_skbs_list, skb);
 
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
+	struct sk_buff_head received;
+	struct sk_buff *rx_skb;
+	struct timespec64 ts;
+	unsigned long flags;
+
+	__skb_queue_head_init(&received);
+	spin_lock_irqsave(&priv->rx_skbs_list.lock, flags);
+	skb_queue_splice_tail_init(&priv->rx_skbs_list, &received);
+	spin_unlock_irqrestore(&priv->rx_skbs_list.lock, flags);
+
+	vsc85xx_gettime(info, &ts);
+	while ((rx_skb = __skb_dequeue(&received)) != NULL) {
+		shhwtstamps = skb_hwtstamps(rx_skb);
+		memset(shhwtstamps, 0, sizeof(struct skb_shared_hwtstamps));
+
+		if (ts.tv_nsec < VSC8531_SKB_CB(rx_skb)->ns)
+			ts.tv_sec--;
+
+		shhwtstamps->hwtstamp = ktime_set(ts.tv_sec,
+						  VSC8531_SKB_CB(rx_skb)->ns);
+		netif_rx(rx_skb);
+	}
+
+	return -1;
+}
+
 static const struct ptp_clock_info vsc85xx_clk_caps = {
 	.owner		= THIS_MODULE,
 	.name		= "VSC85xx timer",
@@ -1240,6 +1263,7 @@ static const struct ptp_clock_info vsc85xx_clk_caps = {
 	.adjfine	= &vsc85xx_adjfine,
 	.gettime64	= &vsc85xx_gettime,
 	.settime64	= &vsc85xx_settime,
+	.do_aux_work	= &vsc85xx_do_aux_work,
 };
 
 static struct vsc8531_private *vsc8584_base_priv(struct phy_device *phydev)
@@ -1567,6 +1591,7 @@ int vsc8584_ptp_probe(struct phy_device *phydev)
 
 	mutex_init(&vsc8531->phc_lock);
 	mutex_init(&vsc8531->ts_lock);
+	skb_queue_head_init(&vsc8531->rx_skbs_list);
 
 	/* Retrieve the shared load/save GPIO. Request it as non exclusive as
 	 * the same GPIO can be requested by all the PHYs of the same package.
-- 
2.34.1


