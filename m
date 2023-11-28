Return-Path: <netdev+bounces-51504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBB77FAF05
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 01:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756F91C20E57
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 00:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F6FA2A;
	Tue, 28 Nov 2023 00:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1ZlfvYMQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681D91A2
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 16:27:31 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6cbcd3e9758so5599574b3a.2
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 16:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701131251; x=1701736051; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=grvOf3tFsqgV1RjCdzyibD/4PsRcEMJwLE5B/qmXM0I=;
        b=1ZlfvYMQcKTx/lANStip+nAaa4xCbpKP73sqoUnCl9QCKbmkAljQZt/4N7bgE0kpkV
         HhHYvCHkDxefFU8C0BeyKCb35BR8ez7B/ciGYWygNWQY5D54UANi+k04YfPA8obJ+PNz
         8ozpKdXeG5HtGRZ0olFz9C31r2khmatFIEDQyCyDOFAQ8+eb2bRRazbCjuCrLMDCBIlX
         K4wGdLKseLPkl4ZJ9xjOu3lTT1e6uXqLn2Pf1CTJhKXobdbzaFMnayxFg3J5spNy4CHH
         mHWNUK5EcA/a8noafjkqcOhobhc2UbjJ3wibNS+VTdz+qTN5RgNc4ntexkR0XZoS01ef
         SQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701131251; x=1701736051;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=grvOf3tFsqgV1RjCdzyibD/4PsRcEMJwLE5B/qmXM0I=;
        b=XHhjV4xMQjdFTJOzWelHdH6csNyY4qN/vtkuFnbIF5BMlfmgnHnm1Fljo/2ZefbGLv
         KAOv7YygBN8LBdnGE5ETGxhRbQ/AROiRb7NggJk/0j+xXmMxz7/W53R3tmWpW67SwQCK
         g7sYwB0Fb8SdVJ8C1RbG1wAWLeIjv7m5NSyqyVdOthqIiBz+q3UbjRwaJabkHDcITGoq
         Nh7s5JuQL1Nmr8XPy5soluDuhrUBetAFMIeKXSOPW+OgLB9h0VbgkuxHA0+rpKWN+t7L
         5spTuwdWwZu64/p9YYmrwc30ccM6TKTGoV95/VolaJoUVYxpcdVUq6SESfmHsF/Jtn5Y
         8RXA==
X-Gm-Message-State: AOJu0Ywo6hIrqdHKbskiPle/ppA4MQN0lA0zNHepGE0rLryg01Hd7iBD
	gk3EqjQzxkxpcj5LA2IyvU6A7PWlDa3f/64kQzn2OGl/Nvjef+1RoWM/hu74WGZNWE1erVEWimQ
	jh9ZOZJZaaKk2M/OFwI98Ngu2pPVGyHKgeVm8kHYXNPnxzx3O/Bwxe/80aSRj90kG
X-Google-Smtp-Source: AGHT+IH8/nM7rG5fsjNfIopxU2v+zO8QT3lDhTdWMR5GcPUHoTFlJ9lR8zawFnHi8ze8BIUo5guw3VSLay/v
X-Received: from jfraker202.plv.corp.google.com ([2620:15c:11c:202:19d5:f826:3460:9345])
 (user=jfraker job=sendgmr) by 2002:a05:6a00:18a4:b0:6cd:852a:8a79 with SMTP
 id x36-20020a056a0018a400b006cd852a8a79mr1946455pfh.6.1701131250846; Mon, 27
 Nov 2023 16:27:30 -0800 (PST)
Date: Mon, 27 Nov 2023 16:26:48 -0800
In-Reply-To: <20231128002648.320892-1-jfraker@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231128002648.320892-1-jfraker@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231128002648.320892-6-jfraker@google.com>
Subject: [PATCH net-next 5/5] gve: Remove dependency on 4k page size.
From: John Fraker <jfraker@google.com>
To: netdev@vger.kernel.org
Cc: John Fraker <jfraker@google.com>, Jordan Kimbrough <jrkim@google.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

Prior to this change, gve crashes when attempting to run in kernels with
page sizes other than 4k. This change removes unnecessary references to
PAGE_SIZE and replaces them with more meaningful constants.

Signed-off-by: Jordan Kimbrough <jrkim@google.com>
Signed-off-by: John Fraker <jfraker@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/ethernet/google/gve/gve.h         | 4 +++-
 drivers/net/ethernet/google/gve/gve_ethtool.c | 2 +-
 drivers/net/ethernet/google/gve/gve_main.c    | 4 ++--
 drivers/net/ethernet/google/gve/gve_rx.c      | 9 ++++-----
 drivers/net/ethernet/google/gve/gve_tx.c      | 2 +-
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index abc0c708b..b80349154 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -49,7 +49,9 @@
 /* PTYPEs are always 10 bits. */
 #define GVE_NUM_PTYPES	1024
 
-#define GVE_RX_BUFFER_SIZE_DQO 2048
+#define GVE_DEFAULT_RX_BUFFER_SIZE 2048
+
+#define GVE_DEFAULT_RX_BUFFER_OFFSET 2048
 
 #define GVE_XDP_ACTIONS 5
 
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 233e59469..e5397aa1e 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -519,7 +519,7 @@ static int gve_set_tunable(struct net_device *netdev,
 	case ETHTOOL_RX_COPYBREAK:
 	{
 		u32 max_copybreak = gve_is_gqi(priv) ?
-			(PAGE_SIZE / 2) : priv->data_buffer_size_dqo;
+			GVE_DEFAULT_RX_BUFFER_SIZE : priv->data_buffer_size_dqo;
 
 		len = *(u32 *)value;
 		if (len > max_copybreak)
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index cc169748f..619bf63ec 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1328,7 +1328,7 @@ static int gve_open(struct net_device *dev)
 		/* Hard code this for now. This may be tuned in the future for
 		 * performance.
 		 */
-		priv->data_buffer_size_dqo = GVE_RX_BUFFER_SIZE_DQO;
+		priv->data_buffer_size_dqo = GVE_DEFAULT_RX_BUFFER_SIZE;
 	}
 	err = gve_create_rings(priv);
 	if (err)
@@ -1664,7 +1664,7 @@ static int verify_xdp_configuration(struct net_device *dev)
 		return -EOPNOTSUPP;
 	}
 
-	if (dev->mtu > (PAGE_SIZE / 2) - sizeof(struct ethhdr) - GVE_RX_PAD) {
+	if (dev->mtu > GVE_DEFAULT_RX_BUFFER_SIZE - sizeof(struct ethhdr) - GVE_RX_PAD) {
 		netdev_warn(dev, "XDP is not supported for mtu %d.\n",
 			    dev->mtu);
 		return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index 3d6b26ac6..3cb3a9ac6 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -282,7 +282,7 @@ static int gve_rx_alloc_ring(struct gve_priv *priv, int idx)
 	/* Allocating half-page buffers allows page-flipping which is faster
 	 * than copying or allocating new pages.
 	 */
-	rx->packet_buffer_size = PAGE_SIZE / 2;
+	rx->packet_buffer_size = GVE_DEFAULT_RX_BUFFER_SIZE;
 	gve_rx_ctx_clear(&rx->ctx);
 	gve_rx_add_to_block(priv, idx);
 
@@ -398,10 +398,10 @@ static struct sk_buff *gve_rx_add_frags(struct napi_struct *napi,
 
 static void gve_rx_flip_buff(struct gve_rx_slot_page_info *page_info, __be64 *slot_addr)
 {
-	const __be64 offset = cpu_to_be64(PAGE_SIZE / 2);
+	const __be64 offset = cpu_to_be64(GVE_DEFAULT_RX_BUFFER_OFFSET);
 
 	/* "flip" to other packet buffer on this page */
-	page_info->page_offset ^= PAGE_SIZE / 2;
+	page_info->page_offset ^= GVE_DEFAULT_RX_BUFFER_OFFSET;
 	*(slot_addr) ^= offset;
 }
 
@@ -506,8 +506,7 @@ static struct sk_buff *gve_rx_copy_to_pool(struct gve_rx_ring *rx,
 		return NULL;
 
 	gve_dec_pagecnt_bias(copy_page_info);
-	copy_page_info->page_offset += rx->packet_buffer_size;
-	copy_page_info->page_offset &= (PAGE_SIZE - 1);
+	copy_page_info->page_offset ^= GVE_DEFAULT_RX_BUFFER_OFFSET;
 
 	if (copy_page_info->can_flip) {
 		/* We have used both halves of this copy page, it
diff --git a/drivers/net/ethernet/google/gve/gve_tx.c b/drivers/net/ethernet/google/gve/gve_tx.c
index 9f6ffc4a5..07ba12478 100644
--- a/drivers/net/ethernet/google/gve/gve_tx.c
+++ b/drivers/net/ethernet/google/gve/gve_tx.c
@@ -819,7 +819,7 @@ int gve_xdp_xmit_one(struct gve_priv *priv, struct gve_tx_ring *tx,
 	return 0;
 }
 
-#define GVE_TX_START_THRESH	PAGE_SIZE
+#define GVE_TX_START_THRESH	4096
 
 static int gve_clean_tx_done(struct gve_priv *priv, struct gve_tx_ring *tx,
 			     u32 to_do, bool try_to_wake)
-- 
2.43.0.rc1.413.gea7ed67945-goog


