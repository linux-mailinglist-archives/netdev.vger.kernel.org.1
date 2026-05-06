Return-Path: <netdev+bounces-284772-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIXILfkQ+2mbVQMAu9opvQ
	(envelope-from <netdev+bounces-284772-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 11:59:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEB94D90F8
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 11:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60709307EBD5
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 09:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0B23FAE13;
	Wed,  6 May 2026 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="e41WIoUu"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F553F7AA9;
	Wed,  6 May 2026 09:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778061394; cv=none; b=okTvpVPAVYrBdixzop9A8TcwWLs3CXu6E4IYvvUkT7u+awTjKHoTGidGIgObT3PrlewpDMXQx3trzPWnIX1HVc9M0UYOBYtPffTfiAN9Rk3ZljipJI860YsZfASUqXW0cmMI7sbQ6c8s5M3xyw7l9oX8kezCZj33z4WDsEqLP4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778061394; c=relaxed/simple;
	bh=S5jtHuUhrgP7XIFMEEWihE9bYWRHbKX3EMbbwVINYPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nv6GoQka9WdxbNyS2Ro/3pHuQeDCJFfMkFduRbMXXnmTWrNJZwYAHWlNKaI2nIKWAcsGQmSeX/04JI0J1ZIpFt4LEo3CNM+bC9IvviN6oVbLS9w5yXsmT9MYRHYq+uk4HVLJsQ/GCQT9M9ylGzYMq3Y2F8tUQDaqUKDWU1qtF9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=e41WIoUu; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EF457A50CB;
	Wed,  6 May 2026 11:56:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1778061369; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=+9XrctG5iXFk07Qp+2Ed8G6CZPkaK5zapnSggzPOoc8=;
	b=e41WIoUuG0/47uvGDc5R+3BHdzlW4awxKfB9HphbLztUIXIvLSElT5vRiO372nmDQT69sA
	B952fIO6W9tmEnNA2IfeafSmXZOfYsnwcESOnf3ZnTw0wQvcpYU6LI/VlC/K2r6ZzLBtLu
	0WBwOiGj7ey9Vfh5u2EMwI2b2CLnvTOdGJ1PDVUUABarY/3fMAUJLKLt2lLDcXsxzPwbk4
	8VqHu9AkVgxEriH3Oqz4JG8x3FC2tEH8QtmCeBTTuQE52oJ3p/jo4KJmEsN9+1+MW0G0sN
	3iuWUojTo2n7Y+15if9cV3+wXn8bDC4qMNxzNL/eiqYo6550ZPdQcJUBrHJKgw==
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
Subject: [PATCH net-next v9 6/7] net: bcmgenet: add XDP statistics counters
Date: Wed,  6 May 2026 11:55:49 +0200
Message-ID: <20260506095553.55357-7-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260506095553.55357-1-nb@tipi-net.de>
References: <20260506095553.55357-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 6FEB94D90F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284772-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,gmail.com,lunn.ch,google.com,redhat.com,tipi-net.de,davemloft.net,iogearbox.net,fomichev.me,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:email,tipi-net.de:dkim,tipi-net.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Expose per-action XDP counters via ethtool -S: xdp_pass, xdp_drop,
xdp_tx, xdp_tx_err, xdp_redirect, and xdp_redirect_err.

These use the existing soft MIB infrastructure and are incremented in
bcmgenet_run_xdp() alongside the existing driver statistics.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 17 +++++++++++++++++
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |  7 +++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 4e4fe785f0bf..359a297a25e6 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1170,6 +1170,14 @@ static const struct bcmgenet_stats bcmgenet_gstrings_stats[] = {
 	STAT_GENET_SOFT_MIB("tx_realloc_tsb", mib.tx_realloc_tsb),
 	STAT_GENET_SOFT_MIB("tx_realloc_tsb_failed",
 			    mib.tx_realloc_tsb_failed),
+	/* XDP counters */
+	STAT_GENET_SOFT_MIB("xdp_pass", mib.xdp_pass),
+	STAT_GENET_SOFT_MIB("xdp_drop", mib.xdp_drop),
+	STAT_GENET_SOFT_MIB("xdp_aborted", mib.xdp_aborted),
+	STAT_GENET_SOFT_MIB("xdp_tx", mib.xdp_tx),
+	STAT_GENET_SOFT_MIB("xdp_tx_err", mib.xdp_tx_err),
+	STAT_GENET_SOFT_MIB("xdp_redirect", mib.xdp_redirect),
+	STAT_GENET_SOFT_MIB("xdp_redirect_err", mib.xdp_redirect_err),
 	/* Per TX queues */
 	STAT_GENET_Q(0),
 	STAT_GENET_Q(1),
@@ -2432,6 +2440,7 @@ static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
 
 	switch (act) {
 	case XDP_PASS:
+		priv->mib.xdp_pass++;
 		return XDP_PASS;
 	case XDP_TX:
 		/* Prepend a zeroed TSB (Transmit Status Block).  The GENET
@@ -2444,6 +2453,7 @@ static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
 		    sizeof(struct status_64) + sizeof(struct xdp_frame)) {
 			page_pool_put_full_page(ring->page_pool, rx_page,
 						true);
+			priv->mib.xdp_tx_err++;
 			return XDP_DROP;
 		}
 		xdp->data -= sizeof(struct status_64);
@@ -2454,6 +2464,7 @@ static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
 		if (unlikely(!xdpf)) {
 			page_pool_put_full_page(ring->page_pool, rx_page,
 						true);
+			priv->mib.xdp_tx_err++;
 			return XDP_DROP;
 		}
 
@@ -2463,19 +2474,24 @@ static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
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
@@ -2483,6 +2499,7 @@ static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
 		fallthrough;
 	case XDP_ABORTED:
 		trace_xdp_exception(priv->dev, prog, act);
+		priv->mib.xdp_aborted++;
 		page_pool_put_full_page(ring->page_pool, rx_page, true);
 		return XDP_ABORTED;
 	}
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 7e5d9ab0050b..e5e775a53f6d 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -156,6 +156,13 @@ struct bcmgenet_mib_counters {
 	u32	tx_dma_failed;
 	u32	tx_realloc_tsb;
 	u32	tx_realloc_tsb_failed;
+	u32	xdp_pass;
+	u32	xdp_drop;
+	u32	xdp_aborted;
+	u32	xdp_tx;
+	u32	xdp_tx_err;
+	u32	xdp_redirect;
+	u32	xdp_redirect_err;
 };
 
 struct bcmgenet_tx_stats64 {
-- 
2.51.0


