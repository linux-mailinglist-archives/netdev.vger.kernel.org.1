Return-Path: <netdev+bounces-270505-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG+/GAQtwWmbRAQAu9opvQ
	(envelope-from <netdev+bounces-270505-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:07:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C612F1A91
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C88630162A7
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777F839EF06;
	Mon, 23 Mar 2026 12:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="ZppGTAYq"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD52B39BFEE;
	Mon, 23 Mar 2026 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774267620; cv=none; b=TrNIxVTsxKrZaiAuo/3PAgpxB8BS5JylZLQteOfbVISqcA85FEMmP9DagAUAOkQqz7gvqBRacZvcJhJbYWlrtxHings1Zb+zaPMlQNAdTHF3IKR8jbxH5qGe9PSdO5Lzimb4Xtg1DtswRgErCOOMij6NPK61tkKJr/EaTJnaKmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774267620; c=relaxed/simple;
	bh=YyWiHZYNYMEbHsX8EHrRgvCjWozFt9dq8yBcUxM7HnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGTBzYrwCLdlzzta69k1qQOEdcWlbA9Ezoe+0ahWLJCzeSV0wj9Cf2rh2P48BOnsNVgU8qwHDMsOphtU70U1vSnqX1LZG6ka4IPvP+IMhaKahhO7cQCYDavxFjTrQv8ByS0JKWkuMBxg7E5WnrFE3UegP4Cpz+d10Yt8nL1lRSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=ZppGTAYq; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3422FA585C;
	Mon, 23 Mar 2026 13:06:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1774267617; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=vguUB2GS7IjcVqqBN3DbbGmddh9Xr1Ri8KSFQg1+KiA=;
	b=ZppGTAYquVIba8PfUGzHm3YYDVyKCD9wbITcuqJskqsBAvYFdgrr7CAWKBt/8hFcwgIejb
	SB7gn0xxdgBLUkde4A7VkHu5bBHCy3TwthBpwahELM3P8H7McOG4fM5/za5Djvf4rk/CTM
	Ce9ILoVs5K9K5DzWPa0tVOuFvzINoaz8x8dAdvby6WE6ktSMq6sQwTt7eSB9wbFwEnX5qf
	LdLw5QQ0YHwE8s8/CrAo786EsFA9ydWFJJqnT8kfKEZK1op5D47yS6+ZEf89lwxFqWO0Hq
	/T6JJ/PtaMK4jm4jGd5Kgrb69ZW3voU9UrD27leiKjfoAxmzKAshz5Ecr7J4Pw==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Justin Chen <justin.chen@broadcom.com>,
	Simon Horman <horms@kernel.org>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v4 6/6] net: bcmgenet: add XDP statistics counters
Date: Mon, 23 Mar 2026 13:05:35 +0100
Message-ID: <20260323120539.136029-7-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260323120539.136029-1-nb@tipi-net.de>
References: <20260323120539.136029-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270505-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,tipi-net.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid]
X-Rspamd-Queue-Id: 03C612F1A91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Expose per-action XDP counters via ethtool -S: xdp_pass, xdp_drop,
xdp_tx, xdp_tx_err, xdp_redirect, and xdp_redirect_err.

These use the existing soft MIB infrastructure and are incremented in
bcmgenet_run_xdp() alongside the existing driver statistics.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 15 +++++++++++++++
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |  6 ++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index a4457f11efec..e73cdab3808b 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1170,6 +1170,13 @@ static const struct bcmgenet_stats bcmgenet_gstrings_stats[] = {
 	STAT_GENET_SOFT_MIB("tx_realloc_tsb", mib.tx_realloc_tsb),
 	STAT_GENET_SOFT_MIB("tx_realloc_tsb_failed",
 			    mib.tx_realloc_tsb_failed),
+	/* XDP counters */
+	STAT_GENET_SOFT_MIB("xdp_pass", mib.xdp_pass),
+	STAT_GENET_SOFT_MIB("xdp_drop", mib.xdp_drop),
+	STAT_GENET_SOFT_MIB("xdp_tx", mib.xdp_tx),
+	STAT_GENET_SOFT_MIB("xdp_tx_err", mib.xdp_tx_err),
+	STAT_GENET_SOFT_MIB("xdp_redirect", mib.xdp_redirect),
+	STAT_GENET_SOFT_MIB("xdp_redirect_err", mib.xdp_redirect_err),
 	/* Per TX queues */
 	STAT_GENET_Q(0),
 	STAT_GENET_Q(1),
@@ -2425,6 +2432,7 @@ static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
 
 	switch (act) {
 	case XDP_PASS:
+		priv->mib.xdp_pass++;
 		return XDP_PASS;
 	case XDP_TX:
 		tx_ring = &priv->xdp_tx_ring;
@@ -2438,6 +2446,7 @@ static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
 		    sizeof(struct status_64)) {
 			page_pool_put_full_page(ring->page_pool, rx_page,
 						true);
+			priv->mib.xdp_tx_err++;
 			return XDP_DROP;
 		}
 		xdp->data -= sizeof(struct status_64);
@@ -2456,19 +2465,24 @@ static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
 						      xdpf, false))) {
 			spin_unlock(&tx_ring->lock);
 			xdp_return_frame_rx_napi(xdpf);
+			priv->mib.xdp_tx_err++;
 			return XDP_DROP;
 		}
 		bcmgenet_xdp_ring_doorbell(priv, tx_ring);
 		spin_unlock(&tx_ring->lock);
+		priv->mib.xdp_tx++;
 		return XDP_TX;
 	case XDP_REDIRECT:
 		if (unlikely(xdp_do_redirect(priv->dev, xdp, prog))) {
+			priv->mib.xdp_redirect_err++;
 			page_pool_put_full_page(ring->page_pool, rx_page,
 						true);
 			return XDP_DROP;
 		}
+		priv->mib.xdp_redirect++;
 		return XDP_REDIRECT;
 	case XDP_DROP:
+		priv->mib.xdp_drop++;
 		page_pool_put_full_page(ring->page_pool, rx_page, true);
 		return XDP_DROP;
 	default:
@@ -2476,6 +2490,7 @@ static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
 		fallthrough;
 	case XDP_ABORTED:
 		trace_xdp_exception(priv->dev, prog, act);
+		priv->mib.xdp_drop++;
 		page_pool_put_full_page(ring->page_pool, rx_page, true);
 		return XDP_ABORTED;
 	}
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 8966d32efe2f..c4e85c185702 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -156,6 +156,12 @@ struct bcmgenet_mib_counters {
 	u32	tx_dma_failed;
 	u32	tx_realloc_tsb;
 	u32	tx_realloc_tsb_failed;
+	u32	xdp_pass;
+	u32	xdp_drop;
+	u32	xdp_tx;
+	u32	xdp_tx_err;
+	u32	xdp_redirect;
+	u32	xdp_redirect_err;
 };
 
 struct bcmgenet_tx_stats64 {
-- 
2.51.0


