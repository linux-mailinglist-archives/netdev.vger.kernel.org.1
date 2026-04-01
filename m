Return-Path: <netdev+bounces-273928-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMFdNkjJzGn5WgYAu9opvQ
	(envelope-from <netdev+bounces-273928-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:29:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 503A2375E30
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD7F4306363D
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4820937B012;
	Wed,  1 Apr 2026 07:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="am8nDDvd"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8820E37A486
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 07:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028094; cv=none; b=Kv1sIsCiUMBIleB8k+pLid6E3U5v0Vmsx0RDvZjQ8pK2WNs/z+bUHcAt4k5H4q/8SvjeOvSCNwbl1przhjWN/aQRLDQWF3jTuFoJ86Le+S9mn3szz0KjuCLbiG3UM07s4P8NTX7KbQ3mmvj+lw3WKyRYqNYpcxw+I4zytW7nPVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028094; c=relaxed/simple;
	bh=N8fK+ZPA3zG0Zmj+Z1NWBZfS/VUgHY66DeRpWflGGv8=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=YFRuWU4APMV9rsMrjgyuWoS7SjTaYDlzrkInuf+LbfLcgKtFXtHvVeHAZ8E8lrGZ6IbcRpUZOuBnzc46zARaRnhUaxM7wyXrgNR8BTQYv/S2HnVeBd27OmdHB7LgLrEW3CdkzDq73zylB7fuASFYOI8G4O64jaPj+B3iwo3SetQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=am8nDDvd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hHAJzxBi4jtiVuEdQes88GJtJsxfjTpth99yOnhHr4I=; b=am8nDDvdRVCzrRXXyLUGH8rSy5
	TixduHQN8xllopGhkG0DaIiMbmH6MAKBovr9zGzj0vMfy4jeDjt0U+MhuwgPP10kkhusOXP435mVU
	ih/pozTHlnRM7IHdPSsJVZMmZTFg4D0KjSUePG9QhVzbeOc7M5eyguIvtiB3q0AG9fP5CQRnA99Ix
	BcfTOLug9IrMZJ5XjZFzWi4evMvH+PZkBRBcnkwltLRFCorKq/B3wovl0TKxB9Gu+kkWW4DvHIPQy
	IBKWUTRSIU4ORIgTRiFTZLPceYruebhtujNTp4AU8On+sTuEYoCLGdmJJfPuSMmv6MvMkwZ31RJgw
	5RE7Rqow==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37612 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w7ptF-000000002fz-2J51;
	Wed, 01 Apr 2026 08:21:25 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w7ptE-0000000Easz-28tv;
	Wed, 01 Apr 2026 08:21:24 +0100
In-Reply-To: <aczHVF04LIGq_lYO@shell.armlinux.org.uk>
References: <aczHVF04LIGq_lYO@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 03/14] net: stmmac: fix TSO support when some
 channels have TBS available
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w7ptE-0000000Easz-28tv@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 01 Apr 2026 08:21:24 +0100
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273928-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.880];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rmk-PC.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 503A2375E30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

According to the STM32MP25xx manual, which is dwmac v5.3, TBS (time
based scheduling) is not permitted for channels which have hardware
TSO enabled. Intel's commit 5e6038b88a57 ("net: stmmac: fix TSO and
TBS feature enabling during driver open") concurs with this, but it
is incomplete.

This commit avoids enabling TSO support on the channels which have
TBS available, which, as far as the hardware is concerned, means we
do not set the TSE bit in the DMA channel's transmit control register.

However, the net device's features apply to all queues(channels), which
means these channels may still be handed TSO skbs to transmit, and the
driver will pass them to stmmac_tso_xmit(). This will generate the
descriptors for TSO, even though the channel has the TSE bit clear.

Fix this by checking whether the queue(channel) has TBS available,
and if it does, fall back to software GSO support.

Fixes: 5e6038b88a57 ("net: stmmac: fix TSO and TBS feature enabling during driver open")
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 32 ++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index c80b4a375ddb..890a1efb8733 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3619,6 +3619,17 @@ static void stmmac_safety_feat_configuration(struct stmmac_priv *priv)
 	}
 }
 
+/* STM32MP25xx (dwmac v5.3) states "Do not enable time-based scheduling for
+ * channels on which the TSO feature is enabled." If we have a skb for a
+ * channel which has TBS enabled, fall back to software GSO.
+ */
+static bool stmmac_tso_channel_permitted(struct stmmac_priv *priv,
+					 unsigned int chan)
+{
+	/* TSO and TBS cannot co-exist */
+	return !(priv->dma_conf.tx_queue[chan].tbs & STMMAC_TBS_AVAIL);
+}
+
 /**
  * stmmac_hw_setup - setup mac in a usable state.
  *  @dev : pointer to the device structure.
@@ -3707,10 +3718,7 @@ static int stmmac_hw_setup(struct net_device *dev)
 	/* Enable TSO */
 	if (priv->dma_cap.tsoen && priv->plat->flags & STMMAC_FLAG_TSO_EN) {
 		for (chan = 0; chan < tx_cnt; chan++) {
-			struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[chan];
-
-			/* TSO and TBS cannot co-exist */
-			if (tx_q->tbs & STMMAC_TBS_AVAIL)
+			if (!stmmac_tso_channel_permitted(priv, chan))
 				continue;
 
 			stmmac_enable_tso(priv, priv->ioaddr, 1, chan);
@@ -4919,6 +4927,21 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
+static netdev_features_t stmmac_features_check(struct sk_buff *skb,
+					       struct net_device *dev,
+					       netdev_features_t features)
+{
+	u16 queue;
+
+	if (skb_is_gso(skb)) {
+		queue = skb_get_queue_mapping(skb);
+		if (!stmmac_tso_channel_permitted(netdev_priv(dev), queue))
+			features &= ~NETIF_F_GSO_MASK;
+	}
+
+	return vlan_features_check(skb, features);
+}
+
 static void stmmac_rx_vlan(struct net_device *dev, struct sk_buff *skb)
 {
 	struct vlan_ethhdr *veth = skb_vlan_eth_hdr(skb);
@@ -7214,6 +7237,7 @@ static void stmmac_get_stats64(struct net_device *dev, struct rtnl_link_stats64
 static const struct net_device_ops stmmac_netdev_ops = {
 	.ndo_open = stmmac_open,
 	.ndo_start_xmit = stmmac_xmit,
+	.ndo_features_check = stmmac_features_check,
 	.ndo_stop = stmmac_release,
 	.ndo_change_mtu = stmmac_change_mtu,
 	.ndo_fix_features = stmmac_fix_features,
-- 
2.47.3


