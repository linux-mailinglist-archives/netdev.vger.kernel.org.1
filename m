Return-Path: <netdev+bounces-288187-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id B9oCIPWxBmqKnAIAu9opvQ
	(envelope-from <netdev+bounces-288187-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 07:41:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E5C549A09
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 07:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA9E0303DD7C
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 05:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2303630B0;
	Fri, 15 May 2026 05:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZgvlwtMb"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B284A3630A0;
	Fri, 15 May 2026 05:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778823665; cv=none; b=Wc3FONQLN97gADYrJ3Na4jzhDKde++1w8SjO/WNE4i6oTJprolH6IXQbRRnf8R7q5OiQv8q0oWRCQjaknaN3sI+IvD7rEg7HC+5t9vKIRqwVGgwi2IdYvywSUah5lojkGhyvOJFp/2cEvYUr75ianHyKPq0hUNDDhB7voR2NQ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778823665; c=relaxed/simple;
	bh=uVOh53xMN1edsraK67oyKBDMjXWVf+kAplkhDzehMM0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hX3U3IwLWxjsPSBSH9SKnS3bN7bbVmv3Xt1CDYmjcfOg+HqEqJonlqNaETZGDMHfQFZtShaEo1iXd4UwirOKJIKnFzqBQprhSj+DzSry0Ilxoj+DuKkpisPJIjuXJEFqJk7Co9hXi22PyeC5uosS1SN0z4QbaCq96yLoIDjzf4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZgvlwtMb; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ii
	zYTJX5EmybqG8LJ5U61c42f+3Bl+gwgY9z3qf5SUk=; b=ZgvlwtMbvG5zdcwKM1
	bEcBP1pCGEoye4D0eALrnDkBR3EqjbXMyYhyXkdYrBLw4MInHo4EsX/rgGK0dfbS
	Fxy3xuBLGRgTn02mrX7dxRRJt7whzWIK8CT1oL8xXUFO1m0jg1gWKc5SL/7zEucT
	qwl7fSzVxeDaLnhWJibFu6vrU=
Received: from PC-YLX4CAEK.company.local (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3n5GCsQZqBgrWBQ--.2418S2;
	Fri, 15 May 2026 13:39:15 +0800 (CST)
From: Ding Hui <dinghui1111@163.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org (open list:STMMAC ETHERNET DRIVER),
	linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32 ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: dinghui@lixiang.com,
	xiasanbo@lixiang.com,
	yangchen11@lixiang.com,
	liuxuanjun@lixiang.com
Subject: [PATCH] net: stmmac: fix fatal bus error on resume by reinitializing RX buffers
Date: Fri, 15 May 2026 13:38:37 +0800
Message-Id: <20260515053856.2310369-1-dinghui1111@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n5GCsQZqBgrWBQ--.2418S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw1Dtw47Ww4DGw4rCr1ftFb_yoW5Kr1rpa
	9Ik3y2yw1ktF4xJw43Jw48ZFy5XayrtF45G3s7Gws3ua1avF9Yvr13trWjva48CFn5AF1f
	tFW5Caykua1UArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jEsjbUUUUU=
X-CM-SenderInfo: pglqwx1xlriiqr6rljoofrz/xtbC8wOo1GoGsYOaZwAA3v
X-Rspamd-Queue-Id: 70E5C549A09
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-288187-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dinghui1111@163.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lixiang.com:email]
X-Rspamd-Action: no action

From: Ding Hui <dinghui@lixiang.com>

On suspend, stmmac_suspend() calls stmmac_disable_all_queues() which
stops the RX NAPI, but the RX DMA engine may still be running for a
short window before stmmac_stop_all_dma() takes effect. During that
window the hardware can write incoming frames into the buffers pointed
to by the RX descriptors and write back the descriptors (clearing the
OWN bit, updating length/status). Because NAPI is already disabled,
the driver never refills these descriptors, so the RX ring is left in
a "consumed but not refilled" state with HW-written content in the
descriptor buffer-address fields.

On resume, stmmac_clear_descriptors() only re-arms the OWN bit (rdes3)
and does not repopulate the RX buffer address fields. As a result the
descriptors still contain whatever the hardware wrote back during the
suspend race. When the DMA is restarted, it dereferences these stale
addresses and triggers a fatal bus error.

Fix this by treating the RX ring the same way as on close/open around
a PM transition:

 - In stmmac_suspend(), after stmmac_stop_all_dma(), walk every RX
   queue and free its buffers via dma_free_rx_xskbufs() when an XSK
   pool is attached or dma_free_rx_skbufs() otherwise, then reset
   rx_q->buf_alloc_num and clear rx_q->xsk_pool so the queue state
   matches a freshly closed queue.

 - In stmmac_resume(), call init_dma_rx_desc_rings() before
   stmmac_reset_queues_param() so RX buffers are re-allocated and
   the descriptor buffer-address fields are properly repopulated
   before the DMA is restarted.

After this change, post-resume RX descriptors always reference freshly
allocated, driver-owned buffers, and the bus error no longer occurs.

Signed-off-by: Ding Hui <dinghui@lixiang.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3591755ea30b..8ed43187cf20 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -8176,6 +8176,9 @@ int stmmac_suspend(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
+	u32 rx_count = priv->plat->rx_queues_to_use;
+	struct stmmac_rx_queue *rx_q;
+	u32 queue;
 	u8 chan;
 
 	if (!ndev || !netif_running(ndev))
@@ -8198,6 +8201,19 @@ int stmmac_suspend(struct device *dev)
 	/* Stop TX/RX DMA */
 	stmmac_stop_all_dma(priv);
 
+	/* Free RX queue resources */
+	for (queue = 0; queue < rx_count; queue++) {
+		rx_q = &priv->dma_conf.rx_queue[queue];
+
+		/* Release the DMA RX socket buffers */
+		if (rx_q->xsk_pool)
+			dma_free_rx_xskbufs(priv, &priv->dma_conf, queue);
+		else
+			dma_free_rx_skbufs(priv, &priv->dma_conf, queue);
+		rx_q->buf_alloc_num = 0;
+		rx_q->xsk_pool = NULL;
+	}
+
 	stmmac_legacy_serdes_power_down(priv);
 
 	/* Enable Power down mode by programming the PMT regs */
@@ -8316,6 +8332,14 @@ int stmmac_resume(struct device *dev)
 
 	mutex_lock(&priv->lock);
 
+	ret = init_dma_rx_desc_rings(ndev, &priv->dma_conf, GFP_KERNEL);
+	if (ret < 0) {
+		netdev_err(priv->dev, "%s: rx dma desc rings init failed\n", __func__);
+		mutex_unlock(&priv->lock);
+		rtnl_unlock();
+		return ret;
+	}
+
 	stmmac_reset_queues_param(priv);
 
 	stmmac_free_tx_skbufs(priv);
-- 
2.34.1


