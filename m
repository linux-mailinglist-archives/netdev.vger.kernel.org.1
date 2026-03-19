Return-Path: <netdev+bounces-269423-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAg2KSnku2njpQIAu9opvQ
	(envelope-from <netdev+bounces-269423-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:55:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1FF2CAAFE
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 31826301BD61
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 11:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26AB3CCFAA;
	Thu, 19 Mar 2026 11:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="ReWn0+xQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3741F3CCA01;
	Thu, 19 Mar 2026 11:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921298; cv=none; b=OiLnvun4MqfdOSYucLYNH1O9wOe8K422UYFQZHXdd0iP/svMcLBa9bTE3/gWor023j2MgvX7iPnmAqz3iUF9Y5EsD4sstWqvJLI2iOM5wxEoMh5fm0uqrsfcGazdsyfcfpNL41S03fQcGY7T8/uKp47gY7C/hbm6neyLyjNvxy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921298; c=relaxed/simple;
	bh=fllZxkDRUNeCABiWG3jVqUjJSnmkYnXd6EO39R29dWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SGO9VW1Uo6tI443ReU9u+7dgxnaUpy6FhjgxBFbMDKaCi5jp5ddO8VzJPirIRCeBNRgHg3F6AEv81xIijymzYQQxHI7w09OYR5V+k6Z5kYcQCq2Ik9r+ZQPKSwe8ssfMXuvb0rw99whjAqzHsHEsOXU9jaFNBS/4j6mM7HvS5wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=ReWn0+xQ; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 17A8BA57BA;
	Thu, 19 Mar 2026 12:54:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1773921289; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=LrqSBjFg0lxjthVlm691SVDRHN7NxeZf6tRtCC91mf4=;
	b=ReWn0+xQT3NeIVMo19UYgQ1XJ2hqnfJB/p0zbIMC9qP4JqEj6916v2eFEt65JqnhY39eXF
	gkhsF6Nq8CLVYNDH2MiPKvgrj4Hrp0smKsSMdDHA2/TZKgEPlC23IUqtgFQUuaqyr1bj6e
	Fdkf98F086dBdOiOWes88LK/Gh5AFnjG+g5P7lu4XgS2+fAVuMWeOgrOtSpfX9dZxcOsk4
	3NB4aAiwQIrsgsaUcn5C/d8Ni79btZ+UpMj4AXTBOMn5WzJIQr901xmPg7YBRGAuEUWh8q
	yo4VW1CD7ap9gEWT3e6P+p0uznsSKAGM/ZSZpbVA+KFATPExkKXlBSMssjsUYA==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Nicolai Buchwitz <nb@tipi-net.de>,
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
Subject: [PATCH net-next v3 2/6] net: bcmgenet: register xdp_rxq_info for each RX ring
Date: Thu, 19 Mar 2026 12:53:55 +0100
Message-ID: <20260319115402.353509-3-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319115402.353509-1-nb@tipi-net.de>
References: <20260319115402.353509-1-nb@tipi-net.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269423-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	FREEMAIL_CC(0.00)[tipi-net.de,gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,fomichev.me,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.974];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF1FF2CAAFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Register an xdp_rxq_info per RX ring and associate it with the ring's
page_pool via MEM_TYPE_PAGE_POOL. This is required infrastructure for
XDP program execution: the XDP framework needs to know the memory model
backing each RX queue for correct page lifecycle management.

No functional change - XDP programs are not yet attached or executed.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 22 +++++++++++++++++--
 .../net/ethernet/broadcom/genet/bcmgenet.h    |  2 ++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 7410034d9bdc..6e610e73e12f 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2771,16 +2771,32 @@ static int bcmgenet_rx_ring_create_pool(struct bcmgenet_priv *priv,
 		.offset = GENET_XDP_HEADROOM,
 		.max_len = RX_BUF_LENGTH,
 	};
+	int err;
 
 	ring->page_pool = page_pool_create(&pp_params);
 	if (IS_ERR(ring->page_pool)) {
-		int err = PTR_ERR(ring->page_pool);
-
+		err = PTR_ERR(ring->page_pool);
 		ring->page_pool = NULL;
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
@@ -2807,6 +2823,7 @@ static int bcmgenet_init_rx_ring(struct bcmgenet_priv *priv,
 
 	ret = bcmgenet_alloc_rx_buffers(priv, ring);
 	if (ret) {
+		xdp_rxq_info_unreg(&ring->xdp_rxq);
 		page_pool_destroy(ring->page_pool);
 		ring->page_pool = NULL;
 		return ret;
@@ -3012,6 +3029,7 @@ static void bcmgenet_destroy_rx_page_pools(struct bcmgenet_priv *priv)
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


