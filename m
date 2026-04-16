Return-Path: <netdev+bounces-278938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFepHGd44GkfhgAAu9opvQ
	(envelope-from <netdev+bounces-278938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 07:49:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 578B140A75D
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 07:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A9043307666C
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 05:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF33737DEA5;
	Thu, 16 Apr 2026 05:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="PDoX8ZuI"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8627237B00E;
	Thu, 16 Apr 2026 05:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776318512; cv=none; b=Nw6lpvAAhbIWEjHmximlYp5Qgw3SUL7/HUt5OtH9mj1yBd0z/J4qNGWQnuU7hzeCxbXZ939icKUJusTFPl0mL0lP2NE305zeFsvTH5Q5ZqZLDGdn8VdLg9rVEtUna+0Li127SFsBR6DYYkR3N9831esKGhXevk26WuleWMIhDlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776318512; c=relaxed/simple;
	bh=ugpOcOMYSeUGIn4LleLR8Bj5Y3rMnrlnSG2Z8WaO4tI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OLQjFy7FPrxxfgZHAO8RBQuiIvD8IKmvWqiiDXtK9QIptIpuvkPzye5voumIE8ZPPHGh7M7/hyCP2v03HDeFtTOEBUPa12vKLmBiiizpTlo9/iVAdliYtb4NQ9Tl78fPQclVLyzvq8HHcSDTK2ZjuE+TkXg84d5pjGbEn9Nr/mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=PDoX8ZuI; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2194AA3859;
	Thu, 16 Apr 2026 07:48:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1776318505; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=W8R209rXo9+La5obZzGBZqCQtqGPKUNyLbvCnMdYIuk=;
	b=PDoX8ZuI33xjez/VhPBEQOoZ2QmcrSjK8R/R0hTXMRAVJjBpJhuX6ZoYyWWqJJZT/Sz+FJ
	gc0b8VCOpueLnL2lUPAJgZShrH5R4KySYqVw5xaS3S4M6YrhDBLwvXnPGWPeM8bT32zyuo
	hpib9t+0ZjwODy0lpWS2uPQMaeYQCn7GNvQ/DNZlMeAR1Rs2LRrPwdq2XDP6pDqUuMGLSo
	wGn7+49sw9Wql6DyPuDPnSdU8Na0QnSkUV8b6SeZ3gPGErhWCXheON/rI5OQkneXzCfcpU
	5XLSUDNVbMUhphfSgI66lhBUKtPkHE1gkVPLusNb2/EWAWXI9cTCt/VpH+bKhQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Justin Chen <justin.chen@broadcom.com>,
	Simon Horman <horms@kernel.org>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v7 6/7] net: bcmgenet: add XDP statistics counters
Date: Thu, 16 Apr 2026 07:47:38 +0200
Message-ID: <20260416054743.1289191-7-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260416054743.1289191-1-nb@tipi-net.de>
References: <20260416054743.1289191-1-nb@tipi-net.de>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[tipi-net.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.7.a.0.0.1.0.0.e.9.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	TAGGED_FROM(0.00)[bounces-278938-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,gmail.com,lunn.ch,google.com,redhat.com,tipi-net.de,davemloft.net,iogearbox.net,fomichev.me,vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.980];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tipi-net.de:email,tipi-net.de:dkim,tipi-net.de:mid,broadcom.com:email]
X-Rspamd-Queue-Id: 578B140A75D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Expose per-action XDP counters via ethtool -S: xdp_pass, xdp_drop,
xdp_tx, xdp_tx_err, xdp_redirect, and xdp_redirect_err.

These use the existing soft MIB infrastructure and are incremented in
bcmgenet_run_xdp() alongside the existing driver statistics.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 15 +++++++++++++++
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |  6 ++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index f94e9e287fe9..e74494be7a23 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1169,6 +1169,13 @@ static const struct bcmgenet_stats bcmgenet_gstrings_stats[] = {
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
@@ -2426,6 +2433,7 @@ static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
 
 	switch (act) {
 	case XDP_PASS:
+		priv->mib.xdp_pass++;
 		return XDP_PASS;
 	case XDP_TX:
 		/* Prepend a zeroed TSB (Transmit Status Block).  The GENET
@@ -2438,6 +2446,7 @@ static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
 		    sizeof(struct status_64) + sizeof(struct xdp_frame)) {
 			page_pool_put_full_page(ring->page_pool, rx_page,
 						true);
+			priv->mib.xdp_tx_err++;
 			return XDP_DROP;
 		}
 		xdp->data -= sizeof(struct status_64);
@@ -2457,19 +2466,24 @@ static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
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
@@ -2477,6 +2491,7 @@ static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
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


