Return-Path: <netdev+bounces-116852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 817AB94BDEE
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F292885E5
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 12:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23661190676;
	Thu,  8 Aug 2024 12:43:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC93D18CC1F;
	Thu,  8 Aug 2024 12:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723121015; cv=none; b=J7QsOpQ1bQ1BDPoSXtpuH/CjPprkX/o1MIizm75/2uZAfQn9BRsDGQ+h7TnGv+kC8162ekLZrMU+P3+ce0Xxw1E7qdZX4jNoj/j8xtGyzPNHTmFMy8fqnM2SXOcO+tdDDSqE7HuE51OJ8CF3/hjwoPHmnGHe/4Lf2Q5lN1gtE/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723121015; c=relaxed/simple;
	bh=1YaM3R31sKfQ31OVdn6ZtxT4SNhhWADPGbyscXN3q+k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W/SWa6q4AcCeV2g8Nc3LLCUTFdK2/PXMl+nSd6nW4iU1Gw1Dj2n5LsyxlJRBCxejMHTQqHWFbtAdDAjV0hlJ/j9tdwkizgtmObkqfpOOIB8/y7qziY5ZNkOhpbADHJvKHLgezZlyv0nmr769sCy32O1xf8hU4t5G/F0Ips03Ow8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wfms7012tzpT8r;
	Thu,  8 Aug 2024 20:42:18 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id BB4B618005F;
	Thu,  8 Aug 2024 20:43:30 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 Aug 2024 20:43:30 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH net-next v13 13/14] mm: page_frag: update documentation for page_frag
Date: Thu, 8 Aug 2024 20:37:13 +0800
Message-ID: <20240808123714.462740-14-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240808123714.462740-1-linyunsheng@huawei.com>
References: <20240808123714.462740-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

Update documentation about design, implementation and API usages
for page_frag.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 Documentation/mm/page_frags.rst | 169 +++++++++++++++++++++++++++++++-
 include/linux/page_frag_cache.h | 107 ++++++++++++++++++++
 mm/page_frag_cache.c            |  77 ++++++++++++++-
 3 files changed, 350 insertions(+), 3 deletions(-)

diff --git a/Documentation/mm/page_frags.rst b/Documentation/mm/page_frags.rst
index 503ca6cdb804..abdab415a8e2 100644
--- a/Documentation/mm/page_frags.rst
+++ b/Documentation/mm/page_frags.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ==============
 Page fragments
 ==============
@@ -40,4 +42,169 @@ page via a single call.  The advantage to doing this is that it allows for
 cleaning up the multiple references that were added to a page in order to
 avoid calling get_page per allocation.
 
-Alexander Duyck, Nov 29, 2016.
+
+Architecture overview
+=====================
+
+.. code-block:: none
+
+                      +----------------------+
+                      | page_frag API caller |
+                      +----------------------+
+                                  |
+                                  |
+                                  v
+    +------------------------------------------------------------------+
+    |                   request page fragment                          |
+    +------------------------------------------------------------------+
+             |                                 |                     |
+             |                                 |                     |
+             |                          Cache not enough             |
+             |                                 |                     |
+             |                         +-----------------+           |
+             |                         | reuse old cache |--Usable-->|
+             |                         +-----------------+           |
+             |                                 |                     |
+             |                             Not usable                |
+             |                                 |                     |
+             |                                 v                     |
+        Cache empty                   +-----------------+            |
+             |                        | drain old cache |            |
+             |                        +-----------------+            |
+             |                                 |                     |
+             v_________________________________v                     |
+                              |                                      |
+                              |                                      |
+             _________________v_______________                       |
+            |                                 |              Cache is enough
+            |                                 |                      |
+ PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE         |                      |
+            |                                 |                      |
+            |               PAGE_SIZE >= PAGE_FRAG_CACHE_MAX_SIZE    |
+            v                                 |                      |
+    +----------------------------------+      |                      |
+    | refill cache with order > 0 page |      |                      |
+    +----------------------------------+      |                      |
+      |                    |                  |                      |
+      |                    |                  |                      |
+      |              Refill failed            |                      |
+      |                    |                  |                      |
+      |                    v                  v                      |
+      |      +------------------------------------+                  |
+      |      |   refill cache with order 0 page   |                  |
+      |      +----------------------------------=-+                  |
+      |                       |                                      |
+ Refill succeed               |                                      |
+      |                 Refill succeed                               |
+      |                       |                                      |
+      v                       v                                      v
+    +------------------------------------------------------------------+
+    |             allocate fragment from cache                         |
+    +------------------------------------------------------------------+
+
+API interface
+=============
+As the design and implementation of page_frag API implies, the allocation side
+does not allow concurrent calling. Instead it is assumed that the caller must
+ensure there is not concurrent alloc calling to the same page_frag_cache
+instance by using its own lock or rely on some lockless guarantee like NAPI
+softirq.
+
+Depending on different aligning requirement, the page_frag API caller may call
+page_frag_alloc*_align*() to ensure the returned virtual address or offset of
+the page is aligned according to the 'align/alignment' parameter. Note the size
+of the allocated fragment is not aligned, the caller needs to provide an aligned
+fragsz if there is an alignment requirement for the size of the fragment.
+
+Depending on different use cases, callers expecting to deal with va, page or
+both va and page for them may call page_frag_alloc_va*, page_frag_alloc_pg*,
+or page_frag_alloc* API accordingly.
+
+There is also a use case that needs minimum memory in order for forward progress,
+but more performant if more memory is available. Using page_frag_alloc_prepare()
+and page_frag_alloc_commit() related API, the caller requests the minimum memory
+it needs and the prepare API will return the maximum size of the fragment
+returned. The caller needs to either call the commit API to report how much
+memory it actually uses, or not do so if deciding to not use any memory.
+
+.. kernel-doc:: include/linux/page_frag_cache.h
+   :identifiers: page_frag_cache_init page_frag_cache_is_pfmemalloc
+                 page_frag_cache_page_offset page_frag_alloc_va
+                 page_frag_alloc_va_align page_frag_alloc_va_prepare_align
+                 page_frag_alloc_probe page_frag_alloc_commit
+                 page_frag_alloc_commit_noref page_frag_alloc_abort
+
+.. kernel-doc:: mm/page_frag_cache.c
+   :identifiers: __page_frag_alloc_va_align page_frag_alloc_pg
+                 page_frag_alloc_va_prepare page_frag_alloc_pg_prepare
+                 page_frag_alloc_prepare page_frag_cache_drain
+                 page_frag_free_va
+
+Coding examples
+===============
+
+Init & Drain API
+----------------
+
+.. code-block:: c
+
+   page_frag_cache_init(pfrag);
+   ...
+   page_frag_cache_drain(pfrag);
+
+
+Alloc & Free API
+----------------
+
+.. code-block:: c
+
+    void *va;
+
+    va = page_frag_alloc_va_align(pfrag, size, gfp, align);
+    if (!va)
+        goto do_error;
+
+    err = do_something(va, size);
+    if (err) {
+        page_frag_free_va(va);
+        goto do_error;
+    }
+
+Prepare & Commit API
+--------------------
+
+.. code-block:: c
+
+    unsigned int offset, size;
+    bool merge = true;
+    struct page *page;
+    void *va;
+
+    size = 32U;
+    page = page_frag_alloc_prepare(pfrag, &offset, &size, &va);
+    if (!page)
+        goto wait_for_space;
+
+    copy = min_t(unsigned int, copy, size);
+    if (!skb_can_coalesce(skb, i, page, offset)) {
+        if (i >= max_skb_frags)
+            goto new_segment;
+
+        merge = false;
+    }
+
+    copy = mem_schedule(copy);
+    if (!copy)
+        goto wait_for_space;
+
+    err = copy_from_iter_full_nocache(va, copy, iter);
+    if (err)
+        goto do_error;
+
+    if (merge) {
+        skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], copy);
+        page_frag_alloc_commit_noref(pfrag, offset, copy);
+    } else {
+        skb_fill_page_desc(skb, i, page, offset, copy);
+        page_frag_alloc_commit(pfrag, offset, copy);
+    }
diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index ba5d7f8a03cd..9a2c9abd23d0 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -52,11 +52,28 @@ static inline void *encoded_page_address(unsigned long encoded_va)
 	return (void *)(encoded_va & PAGE_MASK);
 }
 
+/**
+ * page_frag_cache_init() - Init page_frag cache.
+ * @nc: page_frag cache from which to init
+ *
+ * Inline helper to init the page_frag cache.
+ */
 static inline void page_frag_cache_init(struct page_frag_cache *nc)
 {
 	memset(nc, 0, sizeof(*nc));
 }
 
+/**
+ * page_frag_cache_is_pfmemalloc() - Check for pfmemalloc.
+ * @nc: page_frag cache from which to check
+ *
+ * Used to check if the current page in page_frag cache is pfmemalloc'ed.
+ * It has the same calling context expectation as the alloc API.
+ *
+ * Return:
+ * true if the current page in page_frag cache is pfmemalloc'ed, otherwise
+ * return false.
+ */
 static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)
 {
 	return encoded_page_pfmemalloc(nc->encoded_va);
@@ -76,6 +93,19 @@ void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
 				 unsigned int fragsz, gfp_t gfp_mask,
 				 unsigned int align_mask);
 
+/**
+ * page_frag_alloc_va_align() - Alloc a page fragment with aligning requirement.
+ * @nc: page_frag cache from which to allocate
+ * @fragsz: the requested fragment size
+ * @gfp_mask: the allocation gfp to use when cache needs to be refilled
+ * @align: the requested aligning requirement for virtual address of fragment
+ *
+ * WARN_ON_ONCE() checking for @align before allocing a page fragment from
+ * page_frag cache with aligning requirement.
+ *
+ * Return:
+ * virtual address of the page fragment, otherwise return NULL.
+ */
 static inline void *page_frag_alloc_va_align(struct page_frag_cache *nc,
 					     unsigned int fragsz,
 					     gfp_t gfp_mask, unsigned int align)
@@ -84,11 +114,32 @@ static inline void *page_frag_alloc_va_align(struct page_frag_cache *nc,
 	return __page_frag_alloc_va_align(nc, fragsz, gfp_mask, -align);
 }
 
+/**
+ * page_frag_cache_page_offset() - Return the current page fragment's offset.
+ * @nc: page_frag cache from which to check
+ *
+ * The API is only used in net/sched/em_meta.c for historical reason, do not use
+ * it for new caller unless there is a strong reason.
+ *
+ * Return:
+ * the offset of the current page fragment in the page_frag cache.
+ */
 static inline unsigned int page_frag_cache_page_offset(const struct page_frag_cache *nc)
 {
 	return page_frag_cache_page_size(nc->encoded_va) - nc->remaining;
 }
 
+/**
+ * page_frag_alloc_va() - Alloc a page fragment.
+ * @nc: page_frag cache from which to allocate
+ * @fragsz: the requested fragment size
+ * @gfp_mask: the allocation gfp to use when cache need to be refilled
+ *
+ * Get a page fragment from page_frag cache.
+ *
+ * Return:
+ * virtual address of the page fragment, otherwise return NULL.
+ */
 static inline void *page_frag_alloc_va(struct page_frag_cache *nc,
 				       unsigned int fragsz, gfp_t gfp_mask)
 {
@@ -98,6 +149,21 @@ static inline void *page_frag_alloc_va(struct page_frag_cache *nc,
 void *page_frag_alloc_va_prepare(struct page_frag_cache *nc, unsigned int *fragsz,
 				 gfp_t gfp);
 
+/**
+ * page_frag_alloc_va_prepare_align() - Prepare allocing a page fragment with
+ * aligning requirement.
+ * @nc: page_frag cache from which to prepare
+ * @fragsz: in as the requested size, out as the available size
+ * @gfp: the allocation gfp to use when cache need to be refilled
+ * @align: the requested aligning requirement
+ *
+ * WARN_ON_ONCE() checking for @align before preparing an aligned page fragment
+ * with minimum size of @fragsz, @fragsz is also used to report the maximum size
+ * of the page fragment the caller can use.
+ *
+ * Return:
+ * virtual address of the page fragment, otherwise return NULL.
+ */
 static inline void *page_frag_alloc_va_prepare_align(struct page_frag_cache *nc,
 						     unsigned int *fragsz,
 						     gfp_t gfp,
@@ -117,6 +183,21 @@ struct page *page_frag_alloc_prepare(struct page_frag_cache *nc,
 				     unsigned int *fragsz,
 				     void **va, gfp_t gfp);
 
+/**
+ * page_frag_alloc_probe - Probe the available page fragment.
+ * @nc: page_frag cache from which to probe
+ * @offset: out as the offset of the page fragment
+ * @fragsz: in as the requested size, out as the available size
+ * @va: out as the virtual address of the returned page fragment
+ *
+ * Probe the current available memory to caller without doing cache refilling.
+ * If no space is available in the page_frag cache, return NULL.
+ * If the requested space is available, up to @fragsz bytes may be added to the
+ * fragment using commit API.
+ *
+ * Return:
+ * the page fragment, otherwise return NULL.
+ */
 static inline struct page *page_frag_alloc_probe(struct page_frag_cache *nc,
 						 unsigned int *offset,
 						 unsigned int *fragsz,
@@ -138,6 +219,14 @@ static inline struct page *page_frag_alloc_probe(struct page_frag_cache *nc,
 	return page;
 }
 
+/**
+ * page_frag_alloc_commit - Commit allocing a page fragment.
+ * @nc: page_frag cache from which to commit
+ * @fragsz: size of the page fragment has been used
+ *
+ * Commit the actual used size for the allocation that was either prepared or
+ * probed.
+ */
 static inline void page_frag_alloc_commit(struct page_frag_cache *nc,
 					  unsigned int fragsz)
 {
@@ -146,6 +235,16 @@ static inline void page_frag_alloc_commit(struct page_frag_cache *nc,
 	nc->remaining -= fragsz;
 }
 
+/**
+ * page_frag_alloc_commit_noref - Commit allocing a page fragment without taking
+ * page refcount.
+ * @nc: page_frag cache from which to commit
+ * @fragsz: size of the page fragment has been used
+ *
+ * Commit the alloc preparing or probing by passing the actual used size, but
+ * not taking refcount. Mostly used for fragmemt coalescing case when the
+ * current fragment can share the same refcount with previous fragment.
+ */
 static inline void page_frag_alloc_commit_noref(struct page_frag_cache *nc,
 						unsigned int fragsz)
 {
@@ -153,6 +252,14 @@ static inline void page_frag_alloc_commit_noref(struct page_frag_cache *nc,
 	nc->remaining -= fragsz;
 }
 
+/**
+ * page_frag_alloc_abort - Abort the page fragment allocation.
+ * @nc: page_frag cache to which the page fragment is aborted back
+ * @fragsz: size of the page fragment to be aborted
+ *
+ * It is expected to be called from the same context as the alloc API.
+ * Mostly used for error handling cases where the fragment is no longer needed.
+ */
 static inline void page_frag_alloc_abort(struct page_frag_cache *nc,
 					 unsigned int fragsz)
 {
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index f8fad7d2cca8..509bcc4603d3 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -97,6 +97,18 @@ static struct page *__page_frag_cache_reload(struct page_frag_cache *nc,
 	return page;
 }
 
+/**
+ * page_frag_alloc_va_prepare() - Prepare allocing a page fragment.
+ * @nc: page_frag cache from which to prepare
+ * @fragsz: in as the requested size, out as the available size
+ * @gfp: the allocation gfp to use when cache needs to be refilled
+ *
+ * Prepare a page fragment with minimum size of @fragsz, @fragsz is also used
+ * to report the maximum size of the page fragment the caller can use.
+ *
+ * Return:
+ * virtual address of the page fragment, otherwise return NULL.
+ */
 void *page_frag_alloc_va_prepare(struct page_frag_cache *nc,
 				 unsigned int *fragsz, gfp_t gfp)
 {
@@ -125,6 +137,19 @@ void *page_frag_alloc_va_prepare(struct page_frag_cache *nc,
 }
 EXPORT_SYMBOL(page_frag_alloc_va_prepare);
 
+/**
+ * page_frag_alloc_pg_prepare - Prepare allocing a page fragment.
+ * @nc: page_frag cache from which to prepare
+ * @offset: out as the offset of the page fragment
+ * @fragsz: in as the requested size, out as the available size
+ * @gfp: the allocation gfp to use when cache needs to be refilled
+ *
+ * Prepare a page fragment with minimum size of @fragsz, @fragsz is also used
+ * to report the maximum size of the page fragment the caller can use.
+ *
+ * Return:
+ * the page fragment, otherwise return NULL.
+ */
 struct page *page_frag_alloc_pg_prepare(struct page_frag_cache *nc,
 					unsigned int *offset,
 					unsigned int *fragsz, gfp_t gfp)
@@ -152,6 +177,21 @@ struct page *page_frag_alloc_pg_prepare(struct page_frag_cache *nc,
 }
 EXPORT_SYMBOL(page_frag_alloc_pg_prepare);
 
+/**
+ * page_frag_alloc_prepare - Prepare allocing a page fragment.
+ * @nc: page_frag cache from which to prepare
+ * @offset: out as the offset of the page fragment
+ * @fragsz: in as the requested size, out as the available size
+ * @va: out as the virtual address of the returned page fragment
+ * @gfp: the allocation gfp to use when cache needs to be refilled
+ *
+ * Prepare a page fragment with minimum size of @fragsz, @fragsz is also used
+ * to report the maximum size of the page fragment. Return both 'struct page'
+ * and virtual address of the fragment to the caller.
+ *
+ * Return:
+ * the page fragment, otherwise return NULL.
+ */
 struct page *page_frag_alloc_prepare(struct page_frag_cache *nc,
 				     unsigned int *offset,
 				     unsigned int *fragsz,
@@ -183,6 +223,18 @@ struct page *page_frag_alloc_prepare(struct page_frag_cache *nc,
 }
 EXPORT_SYMBOL(page_frag_alloc_prepare);
 
+/**
+ * page_frag_alloc_pg - Alloce a page fragment.
+ * @nc: page_frag cache from which to alloce
+ * @offset: out as the offset of the page fragment
+ * @fragsz: the requested fragment size
+ * @gfp: the allocation gfp to use when cache needs to be refilled
+ *
+ * Get a page fragment from page_frag cache.
+ *
+ * Return:
+ * the page fragment, otherwise return NULL.
+ */
 struct page *page_frag_alloc_pg(struct page_frag_cache *nc,
 				unsigned int *offset, unsigned int fragsz,
 				gfp_t gfp)
@@ -215,6 +267,10 @@ struct page *page_frag_alloc_pg(struct page_frag_cache *nc,
 }
 EXPORT_SYMBOL(page_frag_alloc_pg);
 
+/**
+ * page_frag_cache_drain - Drain the current page from page_frag cache.
+ * @nc: page_frag cache from which to drain
+ */
 void page_frag_cache_drain(struct page_frag_cache *nc)
 {
 	if (!nc->encoded_va)
@@ -235,6 +291,19 @@ void __page_frag_cache_drain(struct page *page, unsigned int count)
 }
 EXPORT_SYMBOL(__page_frag_cache_drain);
 
+/**
+ * __page_frag_alloc_va_align() - Alloc a page fragment with aligning
+ * requirement.
+ * @nc: page_frag cache from which to allocate
+ * @fragsz: the requested fragment size
+ * @gfp_mask: the allocation gfp to use when cache need to be refilled
+ * @align_mask: the requested aligning requirement for the 'va'
+ *
+ * Get a page fragment from page_frag cache with aligning requirement.
+ *
+ * Return:
+ * Return va of the page fragment, otherwise return NULL.
+ */
 void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
 				 unsigned int fragsz, gfp_t gfp_mask,
 				 unsigned int align_mask)
@@ -281,8 +350,12 @@ void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
 }
 EXPORT_SYMBOL(__page_frag_alloc_va_align);
 
-/*
- * Frees a page fragment allocated out of either a compound or order 0 page.
+/**
+ * page_frag_free_va - Free a page fragment.
+ * @addr: va of page fragment to be freed
+ *
+ * Free a page fragment allocated out of either a compound or order 0 page by
+ * virtual address.
  */
 void page_frag_free_va(void *addr)
 {
-- 
2.33.0


