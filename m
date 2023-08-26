Return-Path: <netdev+bounces-30834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C110D789306
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 03:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA88281A08
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 01:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE812571;
	Sat, 26 Aug 2023 01:21:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3338923DA
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 01:21:38 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3043B26B9
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 18:21:37 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bf11b1c7d0so17807905ad.0
        for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 18:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20221208.gappssmtp.com; s=20221208; t=1693012896; x=1693617696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+GIQ4i5ByNuKwYrRpt0EIU7cHtWJOixaax1XVLnBrM=;
        b=nXv8bQTvoYGWtC9p28ZjXDtWRJf+tYf/7bWYFv3nSsEewRsswG/TdLNViCy1WlQwD3
         ZE35++RBVA5uyfkW59Nynz6i0Exhr3SWHmze1o57+5y1BITvZb31UXQTvSfnN8wWFJMf
         oAZIL+CkM6AeuUNWIBjgS1eAzl2t/RLLJlOTD2TA19SPs3FwtRg9YyvpD6ww4FpvBt7D
         qLFyzq0/qTPC8VkSnPed+rIAng6pGSKcT9cs6acTzj0lkeWMVaWSaXcqewVe5+ekuDcq
         K00tg942WVH6rUb6eYJOiFFV138WUjzwDoq1qcJLDXyU0qZ/WMg6h389T72epTcA8QEL
         WhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693012896; x=1693617696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+GIQ4i5ByNuKwYrRpt0EIU7cHtWJOixaax1XVLnBrM=;
        b=SJgrLN8rrYwOm8rc3L3H5/Ryn3UO58BcXogqaEUJe8h3Jz87W63xgYSv1UmvXcac6u
         gWI0mEFsx2SepuY1JvVLa3RpuRu8HJaDq1IMPx+HWX/soOQrl9PpM+2lRyIukq6B3Oo7
         BYYGlhVaj9gtgkgY7e3OiKeii0c60vm5V8ejfielj8SUz7UZL/YRsplhrpp9aPubaMfF
         gpX1FiZCSPhozsVf1ecJgd2VKGi9CcWi64hZAnD4XZur4owZk5pdVre2tH3eD4CrdcXh
         /9usXzpF0P0jKive2TEcdhLCJ6dStmPESQqDEbDehEXYks53T6ZNhyYI/Ea3QCFVsLEa
         T6dQ==
X-Gm-Message-State: AOJu0YyCAjHDldtWC0sHaIv+KBGMp4X8850ecDwaF3gRz1VSLTC2gykz
	qxBUuUPUk4Ed6FQ/b7f3xbGgvQ==
X-Google-Smtp-Source: AGHT+IHt+Sg8b3jOaEY8egeSjKUg1cs7Q6AX6j8Ek5+75e/yD/eutQFeYEqR6YHa46DAgcpUZmxx8Q==
X-Received: by 2002:a17:903:2304:b0:1b8:8682:62fb with SMTP id d4-20020a170903230400b001b8868262fbmr29753180plh.4.1693012896717;
        Fri, 25 Aug 2023 18:21:36 -0700 (PDT)
Received: from localhost (fwdproxy-prn-002.fbsv.net. [2a03:2880:ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c10600b001bbb598b8bbsm2425921pli.41.2023.08.25.18.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 18:21:36 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org,
	netdev@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 09/11] io_uring: delay ZC pool destruction
Date: Fri, 25 Aug 2023 18:19:52 -0700
Message-Id: <20230826011954.1801099-10-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230826011954.1801099-1-dw@davidwei.uk>
References: <20230826011954.1801099-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: David Wei <davidhwei@meta.com>

At a point in time, a ZC buf may be in:

* RX queue
* Socket
* One of the ifq ringbufs
* Userspace

The ZC pool region and the pool itself cannot be destroyed until all
bufs have been returned.

This patch changes the ZC pool destruction to be delayed work, waiting
for up to 10 seconds for bufs to be returned before unconditionally
destroying the pool.

Signed-off-by: David Wei <davidhwei@meta.com>
Co-developed-by: Jonathan Lemon <jonathan.lemon@gmail.com>
---
 io_uring/zc_rx.c | 50 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/io_uring/zc_rx.c b/io_uring/zc_rx.c
index b8dd699e2777..70e39f851e47 100644
--- a/io_uring/zc_rx.c
+++ b/io_uring/zc_rx.c
@@ -28,6 +28,10 @@ struct io_zc_rx_pool {
 	u32			cache_count;
 	u32			cache[POOL_CACHE_SIZE];
 
+	/* delayed destruction */
+	unsigned long		delay_end;
+	struct delayed_work	destroy_work;
+
 	/* freelist */
 	spinlock_t		freelist_lock;
 	u32			free_count;
@@ -222,20 +226,56 @@ int io_zc_rx_create_pool(struct io_ring_ctx *ctx,
 	return ret;
 }
 
-static void io_zc_rx_destroy_pool(struct io_zc_rx_pool *pool)
+static void io_zc_rx_destroy_ifq(struct io_zc_rx_ifq *ifq)
+{
+	if (ifq->dev)
+		dev_put(ifq->dev);
+	io_free_rbuf_ring(ifq);
+	kfree(ifq);
+}
+
+static void io_zc_rx_destroy_pool_work(struct work_struct *work)
 {
+	struct io_zc_rx_pool *pool = container_of(
+			to_delayed_work(work), struct io_zc_rx_pool, destroy_work);
 	struct device *dev = netdev2dev(pool->ifq->dev);
 	struct io_zc_rx_buf *buf;
+	int i, refc, count;
 
-	for (int i = 0; i < pool->nr_pages; i++) {
+	for (i = 0; i < pool->nr_pages; i++) {
 		buf = &pool->bufs[i];
+		refc = atomic_read(&buf->refcount) & IO_ZC_RX_KREF_MASK;
+		if (refc) {
+			if (time_before(jiffies, pool->delay_end)) {
+				schedule_delayed_work(&pool->destroy_work, HZ);
+				return;
+			}
+			count++;
+		}
+	}
+
+	if (count)
+		pr_debug("freeing pool with %d/%d outstanding pages\n",
+			 count, pool->nr_pages);
 
+
+	for (i = 0; i < pool->nr_pages; i++) {
+		buf = &pool->bufs[i];
 		io_zc_rx_unmap_buf(dev, buf);
 	}
+
+	io_zc_rx_destroy_ifq(pool->ifq);
 	kvfree(pool->bufs);
 	kvfree(pool);
 }
 
+static void io_zc_rx_destroy_pool(struct io_zc_rx_pool *pool)
+{
+	pool->delay_end = jiffies + HZ * 10;
+	INIT_DELAYED_WORK(&pool->destroy_work, io_zc_rx_destroy_pool_work);
+	schedule_delayed_work(&pool->destroy_work, 0);
+}
+
 static struct io_zc_rx_ifq *io_zc_rx_ifq_alloc(struct io_ring_ctx *ctx)
 {
 	struct io_zc_rx_ifq *ifq;
@@ -256,10 +296,8 @@ static void io_zc_rx_ifq_free(struct io_zc_rx_ifq *ifq)
 		io_close_zc_rxq(ifq);
 	if (ifq->pool)
 		io_zc_rx_destroy_pool(ifq->pool);
-	if (ifq->dev)
-		dev_put(ifq->dev);
-	io_free_rbuf_ring(ifq);
-	kfree(ifq);
+	else
+		io_zc_rx_destroy_ifq(ifq);
 }
 
 int io_register_zc_rx_ifq(struct io_ring_ctx *ctx,
-- 
2.39.3


