Return-Path: <netdev+bounces-252523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHINMoB/cmlElgAAu9opvQ
	(envelope-from <netdev+bounces-252523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:50:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E876D43A
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE58E3007A46
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B59F38FF10;
	Thu, 22 Jan 2026 19:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="astmVQV3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8531388840
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769111414; cv=none; b=FspxuVO6IEwE7TZeIAZm6EoReTLkD4FJIvJj7++5mA+wpf40LvoHKTbTWq1WKWv2qDXJHUFrSdUIzLfADxB55I32xVR56r8HrWzaTIvXMLyFU4IslAVvYDJV47E0MLHnpTIhVpo4UxqkmLiSlHN8Ug66Js62r8hi3Kw7yx3RqdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769111414; c=relaxed/simple;
	bh=RBVqxUaS4cO6ArtPoB/Pxrlc5BfwP6SPMNCpskYj3BQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MK25baGKxluFPhdNO+55g0dD43XZdR83/A51Z1qkRqqZmU+gv6hwa3xgydLBECZEEShIUWLKLShEyRBtzAmkqzsqkrUcoLxQaU2f1v31pyKZbS0qhmN1NHrtC60VuKVdQHMIRVlXOcH7HX3yD8dR/c9ZHRR0Vq1PfUdw9lgksVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=astmVQV3; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3530715386cso1205477a91.2
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 11:50:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769111400; x=1769716200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F3U6DORJ2wyt5p+77fI8xLML2wOZrgSxEmX6SO188PY=;
        b=AZNgXMxoJkr7TiPrEXiPq5t5Lmc9+NAABv8SLF2PJImg+5zOfREobGWQ5OzFAaYpEf
         Dwpt3uLphvfCTjc/agNkPqs6d4ZU25qxNRgUydgFeisKoDgCQsiQ7upsejjqBSvIeF9G
         ImftwP1dMIz/iJou1A5nuBbXSouyY3nsc3HQLJv8BYSFTncNErwC1HZImks6n135S3XU
         ZVJnBdq6pd7XFzHpwiUI9ARHBPNlQvHPWsZ0eC5hhzhmcqRDTWjzZlkvW8EFhtVLFL4F
         ZpvSxLakdwgB9N2m5GgaCiEBdqyUDh/hNXixhTttoG2UmAsza9GHVXnLz53BcD+1rG2n
         149g==
X-Gm-Message-State: AOJu0YwXOoDOYDkFud3eGMHNop7V1iLXw0coWuONEoUOQh5e1I4tEZNA
	aR+eBHC2Wv4levg+yDOdmA0SWe5aAU47e/gZm6hLxnpHYO1ixX4ySZcIBNkjgUK9L6GogRmJF29
	yXq/nGDkW4fwwXYU3FFM6WNfJaVN7AHd8UB2Ospt4w4TvtI4OrhPwoSNCoBo6bZVZJIgOcU6r4t
	lzoQWooeIxbgfDnkzTefn6GQEUIraZlbrguIasR1gC3BjNk0b53B19z5qlf5sVUEwJwFzgFhyen
	kmMipRXgg==
X-Gm-Gg: AZuq6aILJtjGgncvOgcn9/gsKEOySPrZ8cMXg03KV618y9CJDmaDGxaIRvgUkKOqXgG
	AOXDhorllBVexdxRckiLccVE9oZe+nxNXLIGhD+RLbgSUpQdG3zx/F/CpURmkHvBdAA/WiOMXgj
	OcEFrP3QzLcNLhbuVo+EgkXaS/Bp5RPJxDX23JlT3GHXPsf509bv9EOlowiTNaVmpzy3SA1SMH+
	y4JIQLVeZyikIV7r4N3N2q+5vHqpwviJYkCTJyuQf4FUmxU7xmdvu36dMndVJBezNWaZtK+BJE8
	dZKAZPUbjLyQO3pb5AAI/tg8+0bfBRfoIWqvDBW2iqFzrSkUuQ09cTRjCd+he+GYO0g7lF9VF+o
	tY+bYW6se2e4YRS+fU0dpXjb7NX10MT458Y5H0/Tbe9HVt7C4Hf5OM6UBasGOomlQOJX3EN+Hx0
	xNyJqBA+V4/0B3MWTElHpyRFCbqbZysfgcmJ0ZT2x8
X-Received: by 2002:a17:90b:510a:b0:34a:8c77:d386 with SMTP id 98e67ed59e1d1-35367023920mr554044a91.9.1769111399900;
        Thu, 22 Jan 2026 11:49:59 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3533520210esm456530a91.1.2026.01.22.11.49.59
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jan 2026 11:49:59 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-4040b9ea153so2098148fac.1
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 11:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769111398; x=1769716198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3U6DORJ2wyt5p+77fI8xLML2wOZrgSxEmX6SO188PY=;
        b=astmVQV3+Brq0W6QTd5m9rrD66+R/199gSj3kPKPMIAXTNXLZZ57/sWr9a1tW3VMVk
         2AN7804Bfd60mFHQ1zliCrsEy6U7TlA5aPx6FcEQmzpq93VAu6HBiOfMpyaXbVec69c8
         Yrd4zKRPZsL1VBrZ0tPoxjOxINwosM/Noo1pE=
X-Received: by 2002:a05:6870:a7a5:b0:3ec:77e8:7bcc with SMTP id 586e51a60fabf-408ab7a0da9mr424112fac.38.1769111398522;
        Thu, 22 Jan 2026 11:49:58 -0800 (PST)
X-Received: by 2002:a05:6870:a7a5:b0:3ec:77e8:7bcc with SMTP id 586e51a60fabf-408ab7a0da9mr424095fac.38.1769111398009;
        Thu, 22 Jan 2026 11:49:58 -0800 (PST)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-408af88f200sm86671fac.7.2026.01.22.11.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 11:49:57 -0800 (PST)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next v3 1/2] net: bcmasp: clean up some legacy logic
Date: Thu, 22 Jan 2026 11:49:48 -0800
Message-Id: <20260122194949.1145107-2-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260122194949.1145107-1-justin.chen@broadcom.com>
References: <20260122194949.1145107-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252523-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C1E876D43A
X-Rspamd-Action: no action

Removed wol_irq check. This was needed for brcm,asp-v2.0, which was
removed in previous commits.

Removed bcmasp_intf_ops. These function pointers were added to make
it easier to implement pseudo channels. These channels were removed
in newer versions of the hardware and were never implemented.

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.c   |  5 --
 drivers/net/ethernet/broadcom/asp2/bcmasp.h   | 36 ------------
 .../net/ethernet/broadcom/asp2/bcmasp_intf.c  | 58 ++++---------------
 3 files changed, 10 insertions(+), 89 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index 014340f33345..36df7d1a9be3 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -1081,15 +1081,10 @@ static irqreturn_t bcmasp_isr_wol(int irq, void *data)
 	struct bcmasp_priv *priv = data;
 	u32 status;
 
-	/* No L3 IRQ, so we good */
-	if (priv->wol_irq <= 0)
-		goto irq_handled;
-
 	status = wakeup_intr2_core_rl(priv, ASP_WAKEUP_INTR2_STATUS) &
 		~wakeup_intr2_core_rl(priv, ASP_WAKEUP_INTR2_MASK_STATUS);
 	wakeup_intr2_core_wl(priv, status, ASP_WAKEUP_INTR2_CLEAR);
 
-irq_handled:
 	pm_wakeup_event(&priv->pdev->dev, 0);
 	return IRQ_HANDLED;
 }
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.h b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
index e238507be40a..29cd87335ec8 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.h
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
@@ -268,13 +268,6 @@ struct bcmasp_mib_counters {
 	u32	tx_timeout_cnt;
 };
 
-struct bcmasp_intf_ops {
-	unsigned long (*rx_desc_read)(struct bcmasp_intf *intf);
-	void (*rx_buffer_write)(struct bcmasp_intf *intf, dma_addr_t addr);
-	void (*rx_desc_write)(struct bcmasp_intf *intf, dma_addr_t addr);
-	unsigned long (*tx_read)(struct bcmasp_intf *intf);
-	void (*tx_write)(struct bcmasp_intf *intf, dma_addr_t addr);
-};
 
 struct bcmasp_priv;
 
@@ -286,7 +279,6 @@ struct bcmasp_intf {
 	/* ASP Ch */
 	int				channel;
 	int				port;
-	const struct bcmasp_intf_ops	*ops;
 
 	/* Used for splitting shared resources */
 	int				index;
@@ -407,34 +399,6 @@ struct bcmasp_priv {
 	struct mutex			net_lock;
 };
 
-static inline unsigned long bcmasp_intf_rx_desc_read(struct bcmasp_intf *intf)
-{
-	return intf->ops->rx_desc_read(intf);
-}
-
-static inline void bcmasp_intf_rx_buffer_write(struct bcmasp_intf *intf,
-					       dma_addr_t addr)
-{
-	intf->ops->rx_buffer_write(intf, addr);
-}
-
-static inline void bcmasp_intf_rx_desc_write(struct bcmasp_intf *intf,
-					     dma_addr_t addr)
-{
-	intf->ops->rx_desc_write(intf, addr);
-}
-
-static inline unsigned long bcmasp_intf_tx_read(struct bcmasp_intf *intf)
-{
-	return intf->ops->tx_read(intf);
-}
-
-static inline void bcmasp_intf_tx_write(struct bcmasp_intf *intf,
-					dma_addr_t addr)
-{
-	intf->ops->tx_write(intf, addr);
-}
-
 #define __BCMASP_IO_MACRO(name, m)					\
 static inline u32 name##_rl(struct bcmasp_intf *intf, u32 off)		\
 {									\
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index ceb6c11431dd..d0a480430a95 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -231,39 +231,6 @@ static struct sk_buff *bcmasp_csum_offload(struct net_device *dev,
 	return skb;
 }
 
-static unsigned long bcmasp_rx_edpkt_dma_rq(struct bcmasp_intf *intf)
-{
-	return rx_edpkt_dma_rq(intf, RX_EDPKT_DMA_VALID);
-}
-
-static void bcmasp_rx_edpkt_cfg_wq(struct bcmasp_intf *intf, dma_addr_t addr)
-{
-	rx_edpkt_cfg_wq(intf, addr, RX_EDPKT_RING_BUFFER_READ);
-}
-
-static void bcmasp_rx_edpkt_dma_wq(struct bcmasp_intf *intf, dma_addr_t addr)
-{
-	rx_edpkt_dma_wq(intf, addr, RX_EDPKT_DMA_READ);
-}
-
-static unsigned long bcmasp_tx_spb_dma_rq(struct bcmasp_intf *intf)
-{
-	return tx_spb_dma_rq(intf, TX_SPB_DMA_READ);
-}
-
-static void bcmasp_tx_spb_dma_wq(struct bcmasp_intf *intf, dma_addr_t addr)
-{
-	tx_spb_dma_wq(intf, addr, TX_SPB_DMA_VALID);
-}
-
-static const struct bcmasp_intf_ops bcmasp_intf_ops = {
-	.rx_desc_read = bcmasp_rx_edpkt_dma_rq,
-	.rx_buffer_write = bcmasp_rx_edpkt_cfg_wq,
-	.rx_desc_write = bcmasp_rx_edpkt_dma_wq,
-	.tx_read = bcmasp_tx_spb_dma_rq,
-	.tx_write = bcmasp_tx_spb_dma_wq,
-};
-
 static netdev_tx_t bcmasp_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct bcmasp_intf *intf = netdev_priv(dev);
@@ -368,7 +335,7 @@ static netdev_tx_t bcmasp_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	skb_tx_timestamp(skb);
 
-	bcmasp_intf_tx_write(intf, intf->tx_spb_dma_valid);
+	tx_spb_dma_wq(intf, intf->tx_spb_dma_valid, TX_SPB_DMA_VALID);
 
 	if (tx_spb_ring_full(intf, MAX_SKB_FRAGS + 1))
 		netif_stop_queue(dev);
@@ -449,7 +416,7 @@ static int bcmasp_tx_reclaim(struct bcmasp_intf *intf)
 	struct bcmasp_desc *desc;
 	dma_addr_t mapping;
 
-	read = bcmasp_intf_tx_read(intf);
+	read = tx_spb_dma_rq(intf, TX_SPB_DMA_READ);
 	while (intf->tx_spb_dma_read != read) {
 		txcb = &intf->tx_cbs[intf->tx_spb_clean_index];
 		mapping = dma_unmap_addr(txcb, dma_addr);
@@ -519,7 +486,7 @@ static int bcmasp_rx_poll(struct napi_struct *napi, int budget)
 	u64 flags;
 	u32 len;
 
-	valid = bcmasp_intf_rx_desc_read(intf) + 1;
+	valid = rx_edpkt_dma_rq(intf, RX_EDPKT_DMA_VALID) + 1;
 	if (valid == intf->rx_edpkt_dma_addr + DESC_RING_SIZE)
 		valid = intf->rx_edpkt_dma_addr;
 
@@ -591,8 +558,8 @@ static int bcmasp_rx_poll(struct napi_struct *napi, int budget)
 		u64_stats_update_end(&stats->syncp);
 
 next:
-		bcmasp_intf_rx_buffer_write(intf, (DESC_ADDR(desc->buf) +
-					    desc->size));
+		rx_edpkt_cfg_wq(intf, (DESC_ADDR(desc->buf) + desc->size),
+				RX_EDPKT_RING_BUFFER_READ);
 
 		processed++;
 		intf->rx_edpkt_dma_read =
@@ -603,7 +570,7 @@ static int bcmasp_rx_poll(struct napi_struct *napi, int budget)
 						 DESC_RING_COUNT);
 	}
 
-	bcmasp_intf_rx_desc_write(intf, intf->rx_edpkt_dma_read);
+	rx_edpkt_dma_wq(intf, intf->rx_edpkt_dma_read, RX_EDPKT_DMA_READ);
 
 	if (processed < budget && napi_complete_done(&intf->rx_napi, processed))
 		bcmasp_enable_rx_irq(intf, 1);
@@ -1271,7 +1238,6 @@ struct bcmasp_intf *bcmasp_interface_create(struct bcmasp_priv *priv,
 	}
 
 	SET_NETDEV_DEV(ndev, dev);
-	intf->ops = &bcmasp_intf_ops;
 	ndev->netdev_ops = &bcmasp_netdev_ops;
 	ndev->ethtool_ops = &bcmasp_ethtool_ops;
 	intf->msg_enable = netif_msg_init(-1, NETIF_MSG_DRV |
@@ -1336,10 +1302,8 @@ static void bcmasp_suspend_to_wol(struct bcmasp_intf *intf)
 
 	umac_enable_set(intf, UMC_CMD_RX_EN, 1);
 
-	if (intf->parent->wol_irq > 0) {
-		wakeup_intr2_core_wl(intf->parent, 0xffffffff,
-				     ASP_WAKEUP_INTR2_MASK_CLEAR);
-	}
+	wakeup_intr2_core_wl(intf->parent, 0xffffffff,
+			     ASP_WAKEUP_INTR2_MASK_CLEAR);
 
 	if (ndev->phydev && ndev->phydev->eee_cfg.eee_enabled &&
 	    intf->parent->eee_fixup)
@@ -1392,10 +1356,8 @@ static void bcmasp_resume_from_wol(struct bcmasp_intf *intf)
 	reg &= ~UMC_MPD_CTRL_MPD_EN;
 	umac_wl(intf, reg, UMC_MPD_CTRL);
 
-	if (intf->parent->wol_irq > 0) {
-		wakeup_intr2_core_wl(intf->parent, 0xffffffff,
-				     ASP_WAKEUP_INTR2_MASK_SET);
-	}
+	wakeup_intr2_core_wl(intf->parent, 0xffffffff,
+			     ASP_WAKEUP_INTR2_MASK_SET);
 }
 
 int bcmasp_interface_resume(struct bcmasp_intf *intf)
-- 
2.34.1


