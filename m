Return-Path: <netdev+bounces-272837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id P9/kF/heyGmjlAUAu9opvQ
	(envelope-from <netdev+bounces-272837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 00:06:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EDD350325
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 00:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8493530065F9
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 23:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC30372695;
	Sat, 28 Mar 2026 23:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Tn1048uM"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE96518DB26;
	Sat, 28 Mar 2026 23:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774739181; cv=none; b=g29ohbZXdCubgoXMUr04WAoTjKeW4xGhVTyM+bJp4n58mV5NV+RO3miuWWXNAmn/TU5mNw70o/xogU9PxTeQqy60STOcCKaZfo2yeYmudausDC3SYuB2athl97hUBIDLy41jZxauAlewnoJV6mJrkgQE1ZjSXmLsjy1rPm51f3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774739181; c=relaxed/simple;
	bh=AtZ3moN5ceTrzdk9n7Rb62LsXZK7LaYDrg+YYNVYmog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHASelSEqT0VXj0QaxO7XNXRro/IF0YeoSzN+gUnE6PrT2In/dCX6iZlMj6usOby8OZ77pPCGIuu5ablcwXSfuNoBjET2Yugnfbj/pI0KitqSkOTza2g3x7ft4hJf/k+cqJ2L76uGAWBC5jdaJNVk2S8X4cL+UdlPkfSn5iR5Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Tn1048uM; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3A3CDA5870;
	Sun, 29 Mar 2026 00:06:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1774739177; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=SLHKU2FK8FdfRAdN14XZV1JwdlFHMY42usYjkOK4Hc4=;
	b=Tn1048uMt9LCPJjhax0sUnwM6rWgyclNYimOKd4i/qGOVoMpy54ExlMAEnLp52jMxD/Fh+
	osT2UYClmW8VgKEesO77FIGk70toyEl38OcIZkDwRUW5kGF0cf7RzmJCNObesy+O/4dUVO
	f8+g4D/llw6I8myonRBe50tALaERlkWqyrJ/VfZzQVuKDX+bbY1jdFkgAYdsXlgmBBruLF
	8Xzqw4ZZqw6yUALAx+dowHC58nAihSIPMLcbn+r2YZK6fFCnD6YtwlcnXTIRmRFf/xvRSs
	Lf/6p/xlBKyWcGISzL7+n/OT1GAi69vGeUZ4NlFgkBzDnMoLFQcgZ8SvnNc+FA==
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
Subject: [PATCH net-next v5 2/6] net: bcmgenet: register xdp_rxq_info for each RX ring
Date: Sun, 29 Mar 2026 00:05:05 +0100
Message-ID: <20260328230513.415790-3-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260328230513.415790-1-nb@tipi-net.de>
References: <20260328230513.415790-1-nb@tipi-net.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272837-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,tipi-net.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	DMARC_DNSFAIL(0.00)[tipi-net.de : query timed out];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 84EDD350325
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Register an xdp_rxq_info per RX ring and associate it with the ring's
page_pool via MEM_TYPE_PAGE_POOL. This is required infrastructure for
XDP program execution: the XDP framework needs to know the memory model
backing each RX queue for correct page lifecycle management.

No functional change - XDP programs are not yet attached or executed.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 18 ++++++++++++++++++
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index f32acacadcf0..9f81192d9e31 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2780,7 +2780,23 @@ static int bcmgenet_rx_ring_create_pool(struct bcmgenet_priv *priv,
 		return err;
 	}
 
+	err = xdp_rxq_info_reg(&ring->xdp_rxq, priv->dev, ring->index, 0);
+	if (err)
+		goto err_free_pp;
+
+	err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq, MEM_TYPE_PAGE_POOL,
+					 ring->page_pool);
+	if (err)
+		goto err_unreg_rxq;
+
 	return 0;
+
+err_unreg_rxq:
+	xdp_rxq_info_unreg(&ring->xdp_rxq);
+err_free_pp:
+	page_pool_destroy(ring->page_pool);
+	ring->page_pool = NULL;
+	return err;
 }
 
 /* Initialize a RDMA ring */
@@ -2809,6 +2825,7 @@ static int bcmgenet_init_rx_ring(struct bcmgenet_priv *priv,
 	if (ret) {
 		for (i = 0; i < ring->size; i++)
 			bcmgenet_free_rx_cb(ring->cbs + i, ring->page_pool);
+		xdp_rxq_info_unreg(&ring->xdp_rxq);
 		page_pool_destroy(ring->page_pool);
 		ring->page_pool = NULL;
 		return ret;
@@ -3014,6 +3031,7 @@ static void bcmgenet_destroy_rx_page_pools(struct bcmgenet_priv *priv)
 	for (i = 0; i <= priv->hw_params->rx_queues; ++i) {
 		ring = &priv->rx_rings[i];
 		if (ring->page_pool) {
+			xdp_rxq_info_unreg(&ring->xdp_rxq);
 			page_pool_destroy(ring->page_pool);
 			ring->page_pool = NULL;
 		}
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 11a0ec563a89..82a6d29f481d 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -16,6 +16,7 @@
 #include <linux/dim.h>
 #include <linux/ethtool.h>
 #include <net/page_pool/helpers.h>
+#include <net/xdp.h>
 
 #include "../unimac.h"
 
@@ -579,6 +580,7 @@ struct bcmgenet_rx_ring {
 	u32		rx_max_coalesced_frames;
 	u32		rx_coalesce_usecs;
 	struct page_pool *page_pool;
+	struct xdp_rxq_info xdp_rxq;
 	struct bcmgenet_priv *priv;
 };
 
-- 
2.51.0


