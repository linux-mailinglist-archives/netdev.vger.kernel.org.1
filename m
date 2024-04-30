Return-Path: <netdev+bounces-92600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD698B80BA
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 21:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2411F240E7
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 19:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AFA17BB25;
	Tue, 30 Apr 2024 19:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="LR/WfzVk"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E814D190672
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 19:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714506262; cv=none; b=BAjIU8eyM72yjuix0lZGDqw2OFDj8vXPGaoTuwohNq+xFx7NhWtDmynNR9l8yl3wdaDcF5zcpMm7Hv8vhnxbPP2IZIviABTAqRnMmMwkodHsc/EV4kh5Qxkdp40UORqlCcGUdJPZkNywU6hnayzQSQKqN6q54Er7CoQpFiULg94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714506262; c=relaxed/simple;
	bh=5QZLb/Bh8dTMxh2pEN40k0KxyCJ2iydALhUyJju9CrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WNoxmAs+oRYAAqituRK5uHFVesIxqKl8o1K9Fhcd3KWi15O1VHaaGKTnMQVAn30faeDoNr5LsVyonGuwNsgQ/+wmAfe/WjLdYspKZ11qAYdd+xrNCbW1AyMVD0fcswWlFCLWnsjoOhec6HyBBPT2xeCrlu0pRH7hhw20bPwXbIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=LR/WfzVk; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id DE9DE881DE;
	Tue, 30 Apr 2024 21:44:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714506257;
	bh=bQQzZBTvyjr2+tuL4mR6eHtX/eJnbEe/KDDxV9XumdA=;
	h=From:To:Cc:Subject:Date:From;
	b=LR/WfzVk3rqPEtkefAL6pgLxJeF9hF6Z//953U3JiCQWobRhv1dReDpfEVHhufBGp
	 lQTpVs8d0gjOTdZl8Iv9lUq8DzJTnJ3Jx4geZULN2zR+Ethw7U695zgM5I6oW1xAx4
	 0S5es3SRoknkM+/LuVCH+afeNtPwmLBvFKxUN+4csnMt5Q7gGy5u5JfNqyiOzN8POy
	 S7H268wQNpj5BIAr+djLM4rCtBekuuymeoXuij0xNmxGxkEboKBcREaVvqD/U9U+te
	 ElNsZIPvC2tTlHBZz7Px+EpnN4Q+zOfuO7K3qGnttviTRa7waWHIUTfyTOFkEoltOn
	 m7Zn/0d0aI4Ng==
From: Marek Vasut <marex@denx.de>
To: netdev@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [net,PATCH v2] net: ks8851: Queue RX packets in IRQ handler instead of disabling BHs
Date: Tue, 30 Apr 2024 21:43:34 +0200
Message-ID: <20240430194401.118950-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Currently the driver uses local_bh_disable()/local_bh_enable() in its
IRQ handler to avoid triggering net_rx_action() softirq on exit from
netif_rx(). The net_rx_action() could trigger this driver .start_xmit
callback, which is protected by the same lock as the IRQ handler, so
calling the .start_xmit from netif_rx() from the IRQ handler critical
section protected by the lock could lead to an attempt to claim the
already claimed lock, and a hang.

The local_bh_disable()/local_bh_enable() approach works only in case
the IRQ handler is protected by a spinlock, but does not work if the
IRQ handler is protected by mutex, i.e. this works for KS8851 with
Parallel bus interface, but not for KS8851 with SPI bus interface.

Remove the BH manipulation and instead of calling netif_rx() inside
the IRQ handler code protected by the lock, queue all the received
SKBs in the IRQ handler into a queue first, and once the IRQ handler
exits the critical section protected by the lock, dequeue all the
queued SKBs and push them all into netif_rx(). At this point, it is
safe to trigger the net_rx_action() softirq, since the netif_rx()
call is outside of the lock that protects the IRQ handler.

Fixes: be0384bf599c ("net: ks8851: Handle softirqs at the end of IRQ thread to fix hang")
Tested-by: Ronald Wahl <ronald.wahl@raritan.com> # KS8851 SPI
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Ronald Wahl <ronald.wahl@raritan.com>
Cc: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
---
V2: - Add TB from Ronald
    - Operate private skb queue without locking as suggested by Eric
---
Note: This is basically what Jakub originally suggested in
      https://patchwork.kernel.org/project/netdevbpf/patch/20240331142353.93792-2-marex@denx.de/#25785606
---
 drivers/net/ethernet/micrel/ks8851.h        | 1 +
 drivers/net/ethernet/micrel/ks8851_common.c | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/micrel/ks8851.h b/drivers/net/ethernet/micrel/ks8851.h
index 31f75b4a67fd7..f311074ea13bc 100644
--- a/drivers/net/ethernet/micrel/ks8851.h
+++ b/drivers/net/ethernet/micrel/ks8851.h
@@ -399,6 +399,7 @@ struct ks8851_net {
 
 	struct work_struct	rxctrl_work;
 
+	struct sk_buff_head	rxq;
 	struct sk_buff_head	txq;
 	unsigned int		queued_len;
 
diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
index d4cdf3d4f5525..813a41193e3ce 100644
--- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -299,7 +299,7 @@ static void ks8851_rx_pkts(struct ks8851_net *ks)
 					ks8851_dbg_dumpkkt(ks, rxpkt);
 
 				skb->protocol = eth_type_trans(skb, ks->netdev);
-				__netif_rx(skb);
+				__skb_queue_tail(&ks->rxq, skb);
 
 				ks->netdev->stats.rx_packets++;
 				ks->netdev->stats.rx_bytes += rxlen;
@@ -330,8 +330,6 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 	unsigned long flags;
 	unsigned int status;
 
-	local_bh_disable();
-
 	ks8851_lock(ks, &flags);
 
 	status = ks8851_rdreg16(ks, KS_ISR);
@@ -408,7 +406,8 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 	if (status & IRQ_LCI)
 		mii_check_link(&ks->mii);
 
-	local_bh_enable();
+	while (!skb_queue_empty(&ks->rxq))
+		netif_rx(__skb_dequeue(&ks->rxq));
 
 	return IRQ_HANDLED;
 }
@@ -1189,6 +1188,7 @@ int ks8851_probe_common(struct net_device *netdev, struct device *dev,
 						NETIF_MSG_PROBE |
 						NETIF_MSG_LINK);
 
+	__skb_queue_head_init(&ks->rxq);
 	skb_queue_head_init(&ks->txq);
 
 	netdev->ethtool_ops = &ks8851_ethtool_ops;
-- 
2.43.0


