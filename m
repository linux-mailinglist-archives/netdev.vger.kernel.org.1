Return-Path: <netdev+bounces-282078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MExQGoEg8WntdgEAu9opvQ
	(envelope-from <netdev+bounces-282078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 23:02:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B35D148C2C7
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 23:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BC3D310334B
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 21:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF76E3A962D;
	Tue, 28 Apr 2026 20:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="mfzOGW/i"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D5F395D86;
	Tue, 28 Apr 2026 20:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777409990; cv=none; b=c0jHkTm+jRtXYozyPPRU7sVgeF+syD9KY/M1FSb/L1QaAnfpxHT/W0RzjslT1bMk4/t4LoyfI5DUvy6URxJ5qjMo6Q3NQzP5Um4Brcu7EnEMifE+A8c0yOhD7q9sL2kbLdJtdP0Fp9uBaBjpJia0Vnb0/9JuI/EPXkeR1asXqjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777409990; c=relaxed/simple;
	bh=8He2VMAePMaIG9YXuFgHmgGUb3pIqps/QMVQDvveJR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNhNNGFPikSVOFx9ejuG8IJiXKn9/zbBJdOLof+JVpUegC3zz3ioc/GT4K/9qsWYIXLlun8B+PrsEenfG0V/q0WhyVAfp6j8DgmCFmPx7Carp65QsQ3aJXIRjQY+VlH80FzRJ9+n/jnTfHV2RG70+pYlfVWPlECQPwNo6OAHowU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=mfzOGW/i; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 411F3A5440;
	Tue, 28 Apr 2026 22:59:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1777409980; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=8yXdzDvzyoOGfkcoRg6CDLAWB9WxR1ZOrTIuLMBMtro=;
	b=mfzOGW/ihHeOvtpIeatcV+Vpu8Ta5wdUKbaALxsm2+NZJtXJUg4hmD23B4FRz1GUD5LHoG
	3D9ZGB12uGxsijYU/KnHl6NxI2EdXE3ScX2nTn1MioGRPIPShjbC4vouROjUd1RRiPWmTC
	v32OMPgLg5TF0NGtOcgANaB1m7g32+Puoo+ykl2HAK+cRB8/AGljT+sz2oEw4GibZ/4NDc
	sG3sMEwR55ajgWGSPaL7G3Eb8Dh7dZWIwcHQOvEDkxmDh1UeSizSi4hJocBqkTIHikESBL
	3MCX8KNomNJQve2EoH3fg6EM0P45p0vOwHbObmz89UDy+JpijHsSwASL7hFdNQ==
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
Subject: [PATCH net-next v8 6/7] net: bcmgenet: add XDP statistics counters
Date: Tue, 28 Apr 2026 22:58:43 +0200
Message-ID: <20260428205846.2625550-7-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428205846.2625550-1-nb@tipi-net.de>
References: <20260428205846.2625550-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: B35D148C2C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-282078-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[tipi-net.de];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,gmail.com,lunn.ch,google.com,redhat.com,tipi-net.de,davemloft.net,iogearbox.net,fomichev.me,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tipi-net.de:email,tipi-net.de:dkim,tipi-net.de:mid,broadcom.com:email]

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
index 9dd258567824..02ad2f410d6c 100644
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
@@ -2428,6 +2435,7 @@ static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
 
 	switch (act) {
 	case XDP_PASS:
+		priv->mib.xdp_pass++;
 		return XDP_PASS;
 	case XDP_TX:
 		/* Prepend a zeroed TSB (Transmit Status Block).  The GENET
@@ -2440,6 +2448,7 @@ static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
 		    sizeof(struct status_64) + sizeof(struct xdp_frame)) {
 			page_pool_put_full_page(ring->page_pool, rx_page,
 						true);
+			priv->mib.xdp_tx_err++;
 			return XDP_DROP;
 		}
 		xdp->data -= sizeof(struct status_64);
@@ -2459,19 +2468,24 @@ static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
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
@@ -2479,6 +2493,7 @@ static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
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


