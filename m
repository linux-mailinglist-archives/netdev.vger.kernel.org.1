Return-Path: <netdev+bounces-16632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB55F74E176
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 00:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B8528141C
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 22:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9921A168B0;
	Mon, 10 Jul 2023 22:35:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A44A168AE
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 22:35:31 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEA91705
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 15:34:53 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c0f35579901so5919506276.0
        for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 15:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689028459; x=1691620459;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UnMZL8UhzWb/0aBP8bCpuACSexb4BfJiKzPPZTajpks=;
        b=ZycEIM/tzN0od6DMdpG2ZBlkJqdG/YaEAiXfT+38tW9bimX5mFjLfnmha8sMd1FwJJ
         P1YTcXkuScRdFZ+6Nke3Sdy4NjMA2W+JEp3F6Wzh3QRgc3G5LGn1Zu1iHZ4RyIqBjoHq
         k9jtQN4DN+tPVpc1G/NOC+sNs6OMyg6jWMhgxeuaJcoDHd6HbM1Xh1fktrKhCJh7t8TZ
         2mOqQGiKrSnTwbDIJsz/RpKI8MeOMnJHXoAtfD0XSqgWhXjbLkfzJLjhD09BOkgZES0H
         docmIVXKHe4UX6CgXt/bh6mysKACg9wyOus054kiN2CxJmmkeSAQzjRyHNih7/Suny73
         Z7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689028459; x=1691620459;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UnMZL8UhzWb/0aBP8bCpuACSexb4BfJiKzPPZTajpks=;
        b=Zf3WEbXGYxNZSpZOU0bSEOv1YxFHJ9Pvpblk9ebnHfO/UxsVnwzeSSu1Lxd/qqCbGp
         LM5m2E4A3M1LTKxxZeGtiGDijvCeTDJCypIuw9Y0bQ1/+soh8jFsx7WO20ixZvdoI+ps
         V4Ij67pfjgDxO8O3Vx1qqMGgwPSHNHZSCVNQQWmi/EM5aLAslvyK26T7ZQYDOw4bhqQ1
         +CifxvOJqevwWMWT8Z50rnBgC2QmvvJPXQ2tdxd3sC7HbvEmRmc+/nvXCXk++wmQ8roB
         E2G2wnzltFzhczRb9GRO0gDQwImmzTHuRlx9NLRDMyoQKz9AMapKeWZ8ThFlHUWkowSp
         +3YA==
X-Gm-Message-State: ABy/qLZL6NKjxYRrxppr6NhJ3bdul6BO4sgr+dPYgAi7cnYh9FFaJPD/
	gSUm8QNQvsqBNclqKMYlDvtZbFl64swkQp6jHA==
X-Google-Smtp-Source: APBJJlEXtctaXcsu/1jDVZnB9gs4bZSM839Y7nw3IybEX7aGlwuQfZwRkT28XLvKo+wcjjO6pG3pnxDTATxBbfxAfA==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:4c0f:bfb6:9942:8c53])
 (user=almasrymina job=sendgmr) by 2002:a25:11c6:0:b0:c85:934:7ad2 with SMTP
 id 189-20020a2511c6000000b00c8509347ad2mr21545ybr.8.1689028458996; Mon, 10
 Jul 2023 15:34:18 -0700 (PDT)
Date: Mon, 10 Jul 2023 15:33:00 -0700
In-Reply-To: <20230710223304.1174642-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230710223304.1174642-1-almasrymina@google.com>
X-Mailer: git-send-email 2.41.0.390.g38632f3daf-goog
Message-ID: <20230710223304.1174642-10-almasrymina@google.com>
Subject: [RFC PATCH 09/10] memory-provider: updates core provider API for
 devmem TCP
From: Mina Almasry <almasrymina@google.com>
To: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	netdev@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, jgg@ziepe.ca
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement a few updates to Jakub's RFC memory provider API to make it
suitable for device memory TCP:

1. Currently for devmem TCP the driver's netdev_rx_queue holds a reference to
   the dma_buf_pages struct and needs to pass that to the page_pool's memory
   provider somehow. For PoC purposes, create a pp->mp_priv field that is set
   by the driver. Likely needs a better API (likely dependant on the
   general memory provider API).

2. The current memory_provider API gives the memory_provider the option
   to override put_page(), but tries page_pool_clear_pp_info() after the
   memory provider has released the page. IMO if the page freeing is
   delegated to the provider then the page_pool should not modify the
   page after release_page() has been called.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/net/page_pool.h | 1 +
 net/core/page_pool.c    | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index 364fe6924258..7b6668479baf 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -78,6 +78,7 @@ struct page_pool_params {
 	struct device	*dev; /* device, for DMA pre-mapping purposes */
 	struct napi_struct *napi; /* Sole consumer of pages, otherwise NULL */
 	u8		memory_provider; /* haaacks! should be user-facing */
+	void		*mp_priv; /* argument to pass to the memory provider */
 	enum dma_data_direction dma_dir; /* DMA mapping direction */
 	unsigned int	max_len; /* max DMA sync memory size */
 	unsigned int	offset;  /* DMA addr offset */
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index d50f6728e4f6..df3f431fcff3 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -241,6 +241,7 @@ static int page_pool_init(struct page_pool *pool,
 		goto free_ptr_ring;
 	}
 
+	pool->mp_priv = pool->p.mp_priv;
 	if (pool->mp_ops) {
 		err = pool->mp_ops->init(pool);
 		if (err) {
@@ -564,16 +565,16 @@ void page_pool_return_page(struct page_pool *pool, struct page *page)
 	else
 		__page_pool_release_page_dma(pool, page);
 
-	page_pool_clear_pp_info(page);
-
 	/* This may be the last page returned, releasing the pool, so
 	 * it is not safe to reference pool afterwards.
 	 */
 	count = atomic_inc_return_relaxed(&pool->pages_state_release_cnt);
 	trace_page_pool_state_release(pool, page, count);
 
-	if (put)
+	if (put) {
+		page_pool_clear_pp_info(page);
 		put_page(page);
+	}
 	/* An optimization would be to call __free_pages(page, pool->p.order)
 	 * knowing page is not part of page-cache (thus avoiding a
 	 * __page_cache_release() call).
-- 
2.41.0.390.g38632f3daf-goog


