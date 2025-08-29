Return-Path: <netdev+bounces-218158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC30B3B538
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 10:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ADB9A04545
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 08:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602732BD5BD;
	Fri, 29 Aug 2025 07:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="n3IyQOUI"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4102BEC32;
	Fri, 29 Aug 2025 07:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454265; cv=none; b=tdjVVXzK0xTpdES/AigLzO2B+zLXK+gUgFe5juUwizsEfH81qntllQj7kUm/QMDI+D5+nAIZRGzAthb5oS/1xTszfOKdqASWnaaZF9P2uFztk8+zix4THU/s/jXn1mA1wIyTEpw40dcEYD+9PEGsnFZVcx30vJPu3p95eLhZa3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454265; c=relaxed/simple;
	bh=SjQQL7M+fnCTuiR4j1x063LYMCgkGU/f9QXVhvCVaTE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nMzBpQ6j0PB3+/h4y+1d9H4ZAUNiOCrc0IZyz5dAjOk1Q2eyCzqFTyzmd1RS8E8K/gJfj/pc+vJZMa8s8JhPfTTMfT9kVYmGG/jAZBuPGwdB+oYq6IlhFBj+UNd15OSjgJBQO10O3RlvJguKlqQkDSZr+ZYJIOs4yVmdpO18vO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=n3IyQOUI; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756454264; x=1787990264;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SjQQL7M+fnCTuiR4j1x063LYMCgkGU/f9QXVhvCVaTE=;
  b=n3IyQOUIfN9EYniKMT+/uycF3LkCVbCrZ4OO7ZaJH+nncwMrR4XNNOmv
   REyxnpXChiOJrYOJ5Z6ALJP9zeZTP2VtaVqFOefnk3idLjA5Z76TL1LBk
   xFRr+XEVrw83vdIjcZ7d2bK72byIYoODcTSKpeiz3sXMbGsayloeDYSYP
   tDlRNRW9HFTr3UtJNwTwPtR5tDysrg3b8lsH8BfG4Pw0qrrtRPP6wOdrd
   tbM8+ryp6/1GWlw8Xuh8LJpfn8oKabl5hO0ywMcHqbqaI4ziNBX3qakjP
   x4gpYc3E0si9uYQQKWY0wbaFsDBqPK4sAPMdiDfg7bEaMFMJF4zuvcvjE
   w==;
X-CSE-ConnectionGUID: +ONr1VLDQ0ik60pDu2SRtg==
X-CSE-MsgGUID: KlnBwLBgT1WFbXYxMPur2A==
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="45800780"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Aug 2025 00:57:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 29 Aug 2025 00:57:11 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Fri, 29 Aug 2025 00:57:09 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <vadim.fedorenko@linux.dev>,
	<viro@zeniv.linux.org.uk>, <atenart@kernel.org>, <quentin.schulz@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net] phy: mscc: Stop taking ts_lock for tx_queue and use its own lock
Date: Fri, 29 Aug 2025 09:50:07 +0200
Message-ID: <20250829075007.214431-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

When transmitting a PTP frame which is timestamp using 2 step, the
following warning appears if CONFIG_PROVE_LOCKING is enabled:
=============================
[ BUG: Invalid wait context ]
6.17.0-rc1-00326-ge6160462704e #427 Not tainted
-----------------------------
ptp4l/119 is trying to lock:
c2a44ed4 (&vsc8531->ts_lock){+.+.}-{3:3}, at: vsc85xx_txtstamp+0x50/0xac
other info that might help us debug this:
context-{4:4}
4 locks held by ptp4l/119:
 #0: c145f068 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_xmit+0x58/0x1440
 #1: c29df974 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: __dev_queue_xmit+0x5c4/0x1440
 #2: c2aaaad0 (_xmit_ETHER#2){+.-.}-{2:2}, at: sch_direct_xmit+0x108/0x350
 #3: c2aac170 (&lan966x->tx_lock){+.-.}-{2:2}, at: lan966x_port_xmit+0xd0/0x350
stack backtrace:
CPU: 0 UID: 0 PID: 119 Comm: ptp4l Not tainted 6.17.0-rc1-00326-ge6160462704e #427 NONE
Hardware name: Generic DT based system
Call trace:
 unwind_backtrace from show_stack+0x10/0x14
 show_stack from dump_stack_lvl+0x7c/0xac
 dump_stack_lvl from __lock_acquire+0x8e8/0x29dc
 __lock_acquire from lock_acquire+0x108/0x38c
 lock_acquire from __mutex_lock+0xb0/0xe78
 __mutex_lock from mutex_lock_nested+0x1c/0x24
 mutex_lock_nested from vsc85xx_txtstamp+0x50/0xac
 vsc85xx_txtstamp from lan966x_fdma_xmit+0xd8/0x3a8
 lan966x_fdma_xmit from lan966x_port_xmit+0x1bc/0x350
 lan966x_port_xmit from dev_hard_start_xmit+0xc8/0x2c0
 dev_hard_start_xmit from sch_direct_xmit+0x8c/0x350
 sch_direct_xmit from __dev_queue_xmit+0x680/0x1440
 __dev_queue_xmit from packet_sendmsg+0xfa4/0x1568
 packet_sendmsg from __sys_sendto+0x110/0x19c
 __sys_sendto from sys_send+0x18/0x20
 sys_send from ret_fast_syscall+0x0/0x1c
Exception stack(0xf0b05fa8 to 0xf0b05ff0)
5fa0:                   00000001 0000000e 0000000e 0004b47a 0000003a 00000000
5fc0: 00000001 0000000e 00000000 00000121 0004af58 00044874 00000000 00000000
5fe0: 00000001 bee9d420 00025a10 b6e75c7c

So, instead of using the ts_lock for tx_queue, use the spinlock that
skb_buff_head has.

Fixes: 7d272e63e0979d ("net: phy: mscc: timestamping and PHC support")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/mscc/mscc_ptp.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
index 72847320cb652..d2277b3393fad 100644
--- a/drivers/net/phy/mscc/mscc_ptp.c
+++ b/drivers/net/phy/mscc/mscc_ptp.c
@@ -461,7 +461,7 @@ static void vsc85xx_dequeue_skb(struct vsc85xx_ptp *ptp)
 		return;
 
 	while (len--) {
-		skb = __skb_dequeue(&ptp->tx_queue);
+		skb = skb_dequeue(&ptp->tx_queue);
 		if (!skb)
 			return;
 
@@ -486,7 +486,7 @@ static void vsc85xx_dequeue_skb(struct vsc85xx_ptp *ptp)
 		 * packet in the FIFO right now, reschedule it for later
 		 * packets.
 		 */
-		__skb_queue_tail(&ptp->tx_queue, skb);
+		skb_queue_tail(&ptp->tx_queue, skb);
 	}
 }
 
@@ -1059,6 +1059,7 @@ static int vsc85xx_hwtstamp(struct mii_timestamper *mii_ts,
 		container_of(mii_ts, struct vsc8531_private, mii_ts);
 	struct phy_device *phydev = vsc8531->ptp->phydev;
 	bool one_step = false;
+	unsigned long flags;
 	u32 val;
 
 	switch (cfg->tx_type) {
@@ -1092,8 +1093,11 @@ static int vsc85xx_hwtstamp(struct mii_timestamper *mii_ts,
 
 	mutex_lock(&vsc8531->ts_lock);
 
+	spin_lock_init(&vsc8531->ptp->tx_queue.lock);
+	spin_lock_irqsave(&vsc8531->ptp->tx_queue.lock, flags);
 	__skb_queue_purge(&vsc8531->ptp->tx_queue);
 	__skb_queue_head_init(&vsc8531->ptp->tx_queue);
+	spin_unlock_irqrestore(&vsc8531->ptp->tx_queue.lock, flags);
 
 	/* Disable predictor while configuring the 1588 block */
 	val = vsc85xx_ts_read_csr(phydev, PROCESSOR,
@@ -1180,9 +1184,7 @@ static void vsc85xx_txtstamp(struct mii_timestamper *mii_ts,
 
 	skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 
-	mutex_lock(&vsc8531->ts_lock);
-	__skb_queue_tail(&vsc8531->ptp->tx_queue, skb);
-	mutex_unlock(&vsc8531->ts_lock);
+	skb_queue_tail(&vsc8531->ptp->tx_queue, skb);
 	return;
 
 out:
@@ -1571,7 +1573,7 @@ irqreturn_t vsc8584_handle_ts_interrupt(struct phy_device *phydev)
 	if (rc & VSC85XX_1588_INT_FIFO_ADD) {
 		vsc85xx_get_tx_ts(priv->ptp);
 	} else if (rc & VSC85XX_1588_INT_FIFO_OVERFLOW) {
-		__skb_queue_purge(&priv->ptp->tx_queue);
+		skb_queue_purge(&priv->ptp->tx_queue);
 		vsc85xx_ts_reset_fifo(phydev);
 	}
 
-- 
2.34.1


