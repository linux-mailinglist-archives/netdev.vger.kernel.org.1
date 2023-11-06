Return-Path: <netdev+bounces-46125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03307E18BD
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 03:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9E428138A
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 02:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B247199;
	Mon,  6 Nov 2023 02:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3fASEIAw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D9F1391
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 02:44:25 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076C3184
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 18:44:24 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a909b4e079so56287827b3.2
        for <netdev@vger.kernel.org>; Sun, 05 Nov 2023 18:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699238663; x=1699843463; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2aWBuORvTMxiaxkeVBpZ19MJEVfIpSc8yfaq5OEMLWc=;
        b=3fASEIAw+83aeyOPu29o+h9e9Py/WA3mB46W/RzTuxb5g5o9BZanbIUVaUumEMHy9o
         frqRfDo8Q3gjyTIYmA2v6GzWsPC14qQfKTlRvE5jCLdJ/j0YveO/NOyVQplB165lZeuZ
         NuYK0pfyrwTi7QtGrHXTwbaYcTTp00wu4oYFTcz8fq16lOuATHbTnvXy0I8UT13P6i7x
         IB3SL0mL29a99hli8I05b/sp0F7kvL+sF2aVoOYtW1aspfbOeXjoEMcfYvo6EOmnQETH
         Sb6BLKvGdH+EXSFm6oTa2iGlPUs4US/OiwD3HXkCLJ/mNaB7aB7wmd9kVDZD0COMIkyl
         d5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699238663; x=1699843463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2aWBuORvTMxiaxkeVBpZ19MJEVfIpSc8yfaq5OEMLWc=;
        b=qzp04Iv9OEqTiQtYcXZ6NRXdwyIyBoWJGtPgt94fJUM7fJaI5NqHR4iS1qq2iqZdeL
         I+oJXIvj3oQh9vFP/B4de2Gul0gTE3Fx6DNdfQwhMQfdVmqp6HJhIo9Y86tioXMklGd6
         MiE6w38hY6BeK4QzZBRmKEVAfzGp5BmWFRP/4Cs0ED4lSEkR5WaHF7sRg9Irkod70PLY
         swKNlaxgAQm4byTKXU0E0FXHYDoL3asF3UeuxeAkgFdummalLy0Nrqnn1Bv73JyxGTk0
         HfrNBbGo+u9m7haMdoObxvQXGIX6UZJm2WR4SCViwV9M+Norey+wQ2Yk7uuwX1XwGv+r
         tqKQ==
X-Gm-Message-State: AOJu0YwKd6m7AIprRcML2FB7xZ6UjqT01DqvAO4NKSUtfTNfZC20ve3X
	1/cTY0yyWVdzFU52+VlYGChOPYxfjllA9YXIYle6VFW2Cg9IpohMKWUqg2Jlgd7XSd0IJEHhAgZ
	bDMqkRxyShlSRC3eLcLerwChVwP6vFvfMPnxcDA1WDIQzrz+LYQJfVt3e3tlheodrGmw5qtg6C+
	U=
X-Google-Smtp-Source: AGHT+IEw+DPriD5kGCKLp7L9RvV3A2PIEZmUjmOXZu2L4QcO1pjeWSWUha8L2tTFId6zhwFVRynJBYuZ216EpkRCrw==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:35de:fff:97b7:db3e])
 (user=almasrymina job=sendgmr) by 2002:a25:688b:0:b0:da0:46e5:a7ef with SMTP
 id d133-20020a25688b000000b00da046e5a7efmr496838ybc.3.1699238662743; Sun, 05
 Nov 2023 18:44:22 -0800 (PST)
Date: Sun,  5 Nov 2023 18:44:01 -0800
In-Reply-To: <20231106024413.2801438-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231106024413.2801438-3-almasrymina@google.com>
Subject: [RFC PATCH v3 02/12] net: page_pool: create hooks for custom page providers
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jakub Kicinski <kuba@kernel.org>

The page providers which try to reuse the same pages will
need to hold onto the ref, even if page gets released from
the pool - as in releasing the page from the pp just transfers
the "ownership" reference from pp to the provider, and provider
will wait for other references to be gone before feeding this
page back into the pool.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mina Almasry <almasrymina@google.com>


---

This is implemented by Jakub in his RFC:
https://lore.kernel.org/netdev/f8270765-a27b-6ccf-33ea-cda097168d79@redhat.com/T/

I take no credit for the idea or implementation; I only added minor
edits to make this workable with device memory TCP, and removed some
hacky test code. This is a critical dependency of device memory TCP
and thus I'm pulling it into this series to make it revewable and
mergable.

---
 include/net/page_pool/types.h | 18 +++++++++++++
 net/core/page_pool.c          | 51 +++++++++++++++++++++++++++++++----
 2 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 6fc5134095ed..d4bea053bb7e 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -60,6 +60,8 @@ struct page_pool_params {
 	int		nid;
 	struct device	*dev;
 	struct napi_struct *napi;
+	u8		memory_provider;
+	void            *mp_priv;
 	enum dma_data_direction dma_dir;
 	unsigned int	max_len;
 	unsigned int	offset;
@@ -118,6 +120,19 @@ struct page_pool_stats {
 };
 #endif
 
+struct mem_provider;
+
+enum pp_memory_provider_type {
+	__PP_MP_NONE, /* Use system allocator directly */
+};
+
+struct pp_memory_provider_ops {
+	int (*init)(struct page_pool *pool);
+	void (*destroy)(struct page_pool *pool);
+	struct page *(*alloc_pages)(struct page_pool *pool, gfp_t gfp);
+	bool (*release_page)(struct page_pool *pool, struct page *page);
+};
+
 struct page_pool {
 	struct page_pool_params p;
 
@@ -165,6 +180,9 @@ struct page_pool {
 	 */
 	struct ptr_ring ring;
 
+	const struct pp_memory_provider_ops *mp_ops;
+	void *mp_priv;
+
 #ifdef CONFIG_PAGE_POOL_STATS
 	/* recycle stats are per-cpu to avoid locking */
 	struct page_pool_recycle_stats __percpu *recycle_stats;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 578b6f2eeb46..7ea1f4682479 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -23,6 +23,8 @@
 
 #include <trace/events/page_pool.h>
 
+static DEFINE_STATIC_KEY_FALSE(page_pool_mem_providers);
+
 #define DEFER_TIME (msecs_to_jiffies(1000))
 #define DEFER_WARN_INTERVAL (60 * HZ)
 
@@ -172,6 +174,7 @@ static int page_pool_init(struct page_pool *pool,
 			  const struct page_pool_params *params)
 {
 	unsigned int ring_qsize = 1024; /* Default */
+	int err;
 
 	memcpy(&pool->p, params, sizeof(pool->p));
 
@@ -225,10 +228,34 @@ static int page_pool_init(struct page_pool *pool,
 	/* Driver calling page_pool_create() also call page_pool_destroy() */
 	refcount_set(&pool->user_cnt, 1);
 
+	switch (pool->p.memory_provider) {
+	case __PP_MP_NONE:
+		break;
+	default:
+		err = -EINVAL;
+		goto free_ptr_ring;
+	}
+
+	pool->mp_priv = pool->p.mp_priv;
+	if (pool->mp_ops) {
+		err = pool->mp_ops->init(pool);
+		if (err) {
+			pr_warn("%s() mem-provider init failed %d\n",
+				__func__, err);
+			goto free_ptr_ring;
+		}
+
+		static_branch_inc(&page_pool_mem_providers);
+	}
+
 	if (pool->p.flags & PP_FLAG_DMA_MAP)
 		get_device(pool->p.dev);
 
 	return 0;
+
+free_ptr_ring:
+	ptr_ring_cleanup(&pool->ring, NULL);
+	return err;
 }
 
 /**
@@ -490,7 +517,10 @@ struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp)
 		return page;
 
 	/* Slow-path: cache empty, do real allocation */
-	page = __page_pool_alloc_pages_slow(pool, gfp);
+	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
+		page = pool->mp_ops->alloc_pages(pool, gfp);
+	else
+		page = __page_pool_alloc_pages_slow(pool, gfp);
 	return page;
 }
 EXPORT_SYMBOL(page_pool_alloc_pages);
@@ -542,10 +572,13 @@ void __page_pool_release_page_dma(struct page_pool *pool, struct page *page)
 void page_pool_return_page(struct page_pool *pool, struct page *page)
 {
 	int count;
+	bool put;
 
-	__page_pool_release_page_dma(pool, page);
-
-	page_pool_clear_pp_info(page);
+	put = true;
+	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
+		put = pool->mp_ops->release_page(pool, page);
+	else
+		__page_pool_release_page_dma(pool, page);
 
 	/* This may be the last page returned, releasing the pool, so
 	 * it is not safe to reference pool afterwards.
@@ -553,7 +586,10 @@ void page_pool_return_page(struct page_pool *pool, struct page *page)
 	count = atomic_inc_return_relaxed(&pool->pages_state_release_cnt);
 	trace_page_pool_state_release(pool, page, count);
 
-	put_page(page);
+	if (put) {
+		page_pool_clear_pp_info(page);
+		put_page(page);
+	}
 	/* An optimization would be to call __free_pages(page, pool->p.order)
 	 * knowing page is not part of page-cache (thus avoiding a
 	 * __page_cache_release() call).
@@ -821,6 +857,11 @@ static void __page_pool_destroy(struct page_pool *pool)
 	if (pool->disconnect)
 		pool->disconnect(pool);
 
+	if (pool->mp_ops) {
+		pool->mp_ops->destroy(pool);
+		static_branch_dec(&page_pool_mem_providers);
+	}
+
 	ptr_ring_cleanup(&pool->ring, NULL);
 
 	if (pool->p.flags & PP_FLAG_DMA_MAP)
-- 
2.42.0.869.gea05f2083d-goog


