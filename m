Return-Path: <netdev+bounces-111058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C2A92F9BB
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 13:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AFC628472F
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 11:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BA316A93F;
	Fri, 12 Jul 2024 11:54:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0BF155A39;
	Fri, 12 Jul 2024 11:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720785264; cv=none; b=S+0zJI4Yt6AWpygCAM2aDb0jcRLD/eVq8p1Q/cCsHTqVBijsCZoa4MgeyzZK0fDwFWG+HW34TDy3sP5T3FXgO/sze5WDPdwyrpM28zKhif8YPGZ316UDvB9/U/+7dBWSDBmHzSHJbIFoaz/aqm34gwGeBAJuakiYnT5zksNYrKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720785264; c=relaxed/simple;
	bh=6jQq9w4RlXoevsFAm7Zi5RQIGcv8h3svhEsJaymp9as=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=soYvhLa05BZ5QvQPy2zorxcfY2iqwS6e/lb93cOpl5Ra+8RpgyibiNjA8IT2foAWGsM4D72neKyfCj2ieOup+zpv83BK2/XiVXgfhzefbCFNMPZwlNje1SZL9pyKjX1ujDmbDgMcy0l3XWPvgE5waqf0bHS+M0qnLcRZsB/0QkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-59589a9be92so2719276a12.2;
        Fri, 12 Jul 2024 04:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720785261; x=1721390061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aylUUjY+eZRZ5UTaJ9YsIwls7PGxo5tR8Y5wxZlssUg=;
        b=lq6QWTv1KqfohSDEjC+sZX3/ukEzoL2DMRHfvycDwLjfoz5HbycbRNeGTxDK8vZlLy
         +WSdbVN+Q4pa6ZuAdCEK+owKxPV65ewozrbLBnmwZVMhZ2Y0Po5fjELdbWThnhuz8uwi
         /KcQE18Ck9v+t7ajYaXfqUOolN2kcPynq1NBsB4vLw1qB1tZ6iNXvMAkvnob7bG/c+uD
         dDVDInp9tEB73PzqY9S6N/KQMUCGDx50RY608Mw2qYHa+Wdyooq6vvOlPUa2y/40FHe2
         gs83nX8pv7tXRqzsJYotBLHeznOA3PSyKRmnXiuQwpR3s+EC0gNMreaaY/qQvuWnKwJm
         jQIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOyobjqJ1fDunNNUIUYbNu5wMVu83mQe4bmHK0Zcn1ibLp4P7skXmHsgaMVztdlEP43uzxD8WumNCjQXhynkel3pPTZbdSUpOemhhOKgv4OyqwzHUaXtPH3BzWpBm5Dylb2zPH
X-Gm-Message-State: AOJu0Yy7E+bM7S3Fpyb2XMWKyxoRnZsmYyxblnbPwzYVoRW7GhRU8zqA
	Ag7xTsFIZT8U1nRCCXYZ3JiSqbD/cfIoBIv+8EhlFtYWJS0SmSkz
X-Google-Smtp-Source: AGHT+IFjCvvGOIX9tsFRJ9Dy0AlCrRfCMApaUx1noM7pWNy8sfC/jqsyqBLhaPGYhuXidj8vb8G5sQ==
X-Received: by 2002:a05:6402:210f:b0:58b:6096:5554 with SMTP id 4fb4d7f45d1cf-594bcba7e40mr9350900a12.37.1720785260712;
        Fri, 12 Jul 2024 04:54:20 -0700 (PDT)
Received: from localhost (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bbe2d0f4sm4570995a12.35.2024.07.12.04.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 04:54:20 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: rbc@meta.com,
	horms@kernel.org,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] virtio_net: Fix napi_skb_cache_put warning
Date: Fri, 12 Jul 2024 04:53:25 -0700
Message-ID: <20240712115325.54175-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the commit bdacf3e34945 ("net: Use nested-BH locking for
napi_alloc_cache.") was merged, the following warning began to appear:

	 WARNING: CPU: 5 PID: 1 at net/core/skbuff.c:1451 napi_skb_cache_put+0x82/0x4b0

	  __warn+0x12f/0x340
	  napi_skb_cache_put+0x82/0x4b0
	  napi_skb_cache_put+0x82/0x4b0
	  report_bug+0x165/0x370
	  handle_bug+0x3d/0x80
	  exc_invalid_op+0x1a/0x50
	  asm_exc_invalid_op+0x1a/0x20
	  __free_old_xmit+0x1c8/0x510
	  napi_skb_cache_put+0x82/0x4b0
	  __free_old_xmit+0x1c8/0x510
	  __free_old_xmit+0x1c8/0x510
	  __pfx___free_old_xmit+0x10/0x10

The issue arises because virtio is assuming it's running in NAPI context
even when it's not, such as in the netpoll case.

To resolve this, modify virtnet_poll_tx() to only set NAPI when budget
is available. Same for virtnet_poll_cleantx(), which always assumed that
it was in a NAPI context.

Fixes: df133f3f9625 ("virtio_net: bulk free tx skbs")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/virtio_net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0b4747e81464..fb1331827308 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2341,7 +2341,7 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 	return packets;
 }
 
-static void virtnet_poll_cleantx(struct receive_queue *rq)
+static void virtnet_poll_cleantx(struct receive_queue *rq, int budget)
 {
 	struct virtnet_info *vi = rq->vq->vdev->priv;
 	unsigned int index = vq2rxq(rq->vq);
@@ -2359,7 +2359,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 
 		do {
 			virtqueue_disable_cb(sq->vq);
-			free_old_xmit(sq, txq, true);
+			free_old_xmit(sq, txq, !!budget);
 		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
 
 		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
@@ -2404,7 +2404,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	unsigned int xdp_xmit = 0;
 	bool napi_complete;
 
-	virtnet_poll_cleantx(rq);
+	virtnet_poll_cleantx(rq, budget);
 
 	received = virtnet_receive(rq, budget, &xdp_xmit);
 	rq->packets_in_napi += received;
@@ -2526,7 +2526,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	txq = netdev_get_tx_queue(vi->dev, index);
 	__netif_tx_lock(txq, raw_smp_processor_id());
 	virtqueue_disable_cb(sq->vq);
-	free_old_xmit(sq, txq, true);
+	free_old_xmit(sq, txq, !!budget);
 
 	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
 		if (netif_tx_queue_stopped(txq)) {
-- 
2.43.0


