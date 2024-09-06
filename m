Return-Path: <netdev+bounces-125824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B599296EC6C
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 09:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 126FD1F27709
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 07:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BE41598EE;
	Fri,  6 Sep 2024 07:43:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC3915530C;
	Fri,  6 Sep 2024 07:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725608594; cv=none; b=IqtDymd3qQDH3RzaxGsSPyl5byBkkJ7S3RALAfN8MgteaHwDWtYPJEvZqHVQL36LBA3aFZ1WWW44oduHCR7dTrhvBkE7azy6IoD3Z3Ddu93nDNAZo0oZVtZAog4fQN7MtiEil48+xt6R6TW21QvJdfqU/FCoT3yNkraNvbLC+ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725608594; c=relaxed/simple;
	bh=SoMfTaEx4qMsC4wo579LZaqSZTH/7PhTTPOLOQtM0rs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oW4Oe12b4DeXxAbPwSJCnXGdem9rb63LUzwR57LmuYKR0m8Vp1Nl4IOU9mPuMlYTq4TmDA9Gd/FOksRcyKycNaCf5lhyzJFKSb7wlrVbmVRVkLnyubEtquQxCadtmAnnW+juGYrYFKvmi1x7S2r6yaIByQN9dWOroVwNVJdGf9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4X0Sr56Wc3z1S9mZ;
	Fri,  6 Sep 2024 15:42:45 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 3F5E21401F0;
	Fri,  6 Sep 2024 15:43:09 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Sep 2024 15:43:08 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH net-next v18 13/14] mm: page_frag: update documentation for page_frag
Date: Fri, 6 Sep 2024 15:36:45 +0800
Message-ID: <20240906073646.2930809-14-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240906073646.2930809-1-linyunsheng@huawei.com>
References: <20240906073646.2930809-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

Update documentation about design, implementation and API usages
for page_frag.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 Documentation/mm/page_frags.rst | 177 +++++++++++++++++++++-
 include/linux/page_frag_cache.h | 259 +++++++++++++++++++++++++++++++-
 mm/page_frag_cache.c            |  26 +++-
 3 files changed, 451 insertions(+), 11 deletions(-)

diff --git a/Documentation/mm/page_frags.rst b/Documentation/mm/page_frags.rst
index 503ca6cdb804..5eec04a3fe90 100644
--- a/Documentation/mm/page_frags.rst
+++ b/Documentation/mm/page_frags.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ==============
 Page fragments
 ==============
@@ -40,4 +42,177 @@ page via a single call.  The advantage to doing this is that it allows for
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
+page_frag_*_align*() to ensure the returned virtual address or offset of the
+page is aligned according to the 'align/alignment' parameter. Note the size of
+the allocated fragment is not aligned, the caller needs to provide an aligned
+fragsz if there is an alignment requirement for the size of the fragment.
+
+Depending on different use cases, callers expecting to deal with va, page or
+both va and page for them may call page_frag_alloc, page_frag_refill, or
+page_frag_alloc_refill API accordingly.
+
+There is also a use case that needs minimum memory in order for forward progress,
+but more performant if more memory is available. Using page_frag_*_prepare() and
+page_frag_commit*() related API, the caller requests the minimum memory it needs
+and the prepare API will return the maximum size of the fragment returned. The
+caller needs to either call the commit API to report how much memory it actually
+uses, or not do so if deciding to not use any memory.
+
+.. kernel-doc:: include/linux/page_frag_cache.h
+   :identifiers: page_frag_cache_init page_frag_cache_is_pfmemalloc
+		 page_frag_cache_page_offset __page_frag_alloc_align
+		 page_frag_alloc_align page_frag_alloc
+		 __page_frag_refill_align page_frag_refill_align
+		 page_frag_refill __page_frag_refill_prepare_align
+		 page_frag_refill_prepare_align page_frag_refill_prepare
+		 __page_frag_alloc_refill_prepare_align
+		 page_frag_alloc_refill_prepare_align
+		 page_frag_alloc_refill_prepare page_frag_alloc_refill_probe
+		 page_frag_refill_probe page_frag_commit
+		 page_frag_commit_noref page_frag_alloc_abort
+
+.. kernel-doc:: mm/page_frag_cache.c
+   :identifiers: page_frag_cache_drain page_frag_free
+		 __page_frag_alloc_refill_probe_align
+
+Coding examples
+===============
+
+Init & Drain API
+----------------
+
+.. code-block:: c
+
+   page_frag_cache_init(nc);
+   ...
+   page_frag_cache_drain(nc);
+
+
+Alloc & Free API
+----------------
+
+.. code-block:: c
+
+    void *va;
+
+    va = page_frag_alloc_align(nc, size, gfp, align);
+    if (!va)
+        goto do_error;
+
+    err = do_something(va, size);
+    if (err) {
+        page_frag_abort(nc, size);
+        goto do_error;
+    }
+
+    ...
+
+    page_frag_free(va);
+
+
+Prepare & Commit API
+--------------------
+
+.. code-block:: c
+
+    struct page_frag page_frag, *pfrag;
+    bool merge = true;
+    void *va;
+
+    pfrag = &page_frag;
+    va = page_frag_alloc_refill_prepare(nc, 32U, pfrag, GFP_KERNEL);
+    if (!va)
+        goto wait_for_space;
+
+    copy = min_t(unsigned int, copy, pfrag->size);
+    if (!skb_can_coalesce(skb, i, pfrag->page, pfrag->offset)) {
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
+        page_frag_commit_noref(nc, pfrag, copy);
+    } else {
+        skb_fill_page_desc(skb, i, pfrag->page, pfrag->offset, copy);
+        page_frag_commit(nc, pfrag, copy);
+    }
diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index 4e9018051956..dff68d8e0f30 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -30,16 +30,43 @@ static inline bool page_frag_encoded_page_pfmemalloc(unsigned long encoded_page)
 	return !!(encoded_page & PAGE_FRAG_CACHE_PFMEMALLOC_BIT);
 }
 
+/**
+ * page_frag_cache_init() - Init page_frag cache.
+ * @nc: page_frag cache from which to init
+ *
+ * Inline helper to init the page_frag cache.
+ */
 static inline void page_frag_cache_init(struct page_frag_cache *nc)
 {
 	nc->encoded_page = 0;
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
 	return page_frag_encoded_page_pfmemalloc(nc->encoded_page);
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
 	return nc->offset;
@@ -68,6 +95,19 @@ static inline unsigned int __page_frag_cache_commit(struct page_frag_cache *nc,
 	return __page_frag_cache_commit_noref(nc, pfrag, used_sz);
 }
 
+/**
+ * __page_frag_alloc_align() - Alloc a page fragment with aligning
+ * requirement.
+ * @nc: page_frag cache from which to allocate
+ * @fragsz: the requested fragment size
+ * @gfp_mask: the allocation gfp to use when cache need to be refilled
+ * @align_mask: the requested aligning requirement for the 'va'
+ *
+ * Alloc a page fragment from page_frag cache with aligning requirement.
+ *
+ * Return:
+ * Virtual address of the page fragment, otherwise return NULL.
+ */
 static inline void *__page_frag_alloc_align(struct page_frag_cache *nc,
 					    unsigned int fragsz, gfp_t gfp_mask,
 					    unsigned int align_mask)
@@ -85,6 +125,19 @@ static inline void *__page_frag_alloc_align(struct page_frag_cache *nc,
 	return va;
 }
 
+/**
+ * page_frag_alloc_align() - Alloc a page fragment with aligning requirement.
+ * @nc: page_frag cache from which to allocate
+ * @fragsz: the requested fragment size
+ * @gfp_mask: the allocation gfp to use when cache needs to be refilled
+ * @align: the requested aligning requirement for the fragment
+ *
+ * WARN_ON_ONCE() checking for @align before allocing a page fragment from
+ * page_frag cache with aligning requirement.
+ *
+ * Return:
+ * virtual address of the page fragment, otherwise return NULL.
+ */
 static inline void *page_frag_alloc_align(struct page_frag_cache *nc,
 					  unsigned int fragsz, gfp_t gfp_mask,
 					  unsigned int align)
@@ -93,12 +146,36 @@ static inline void *page_frag_alloc_align(struct page_frag_cache *nc,
 	return __page_frag_alloc_align(nc, fragsz, gfp_mask, -align);
 }
 
+/**
+ * page_frag_alloc() - Alloc a page fragment.
+ * @nc: page_frag cache from which to allocate
+ * @fragsz: the requested fragment size
+ * @gfp_mask: the allocation gfp to use when cache need to be refilled
+ *
+ * Alloc a page fragment from page_frag cache.
+ *
+ * Return:
+ * virtual address of the page fragment, otherwise return NULL.
+ */
 static inline void *page_frag_alloc(struct page_frag_cache *nc,
 				    unsigned int fragsz, gfp_t gfp_mask)
 {
 	return __page_frag_alloc_align(nc, fragsz, gfp_mask, ~0u);
 }
 
+/**
+ * __page_frag_refill_align() - Refill a page_frag with aligning requirement.
+ * @nc: page_frag cache from which to refill
+ * @fragsz: the requested fragment size
+ * @pfrag: the page_frag to be refilled.
+ * @gfp_mask: the allocation gfp to use when cache need to be refilled
+ * @align_mask: the requested aligning requirement for the fragment
+ *
+ * Refill a page_frag from page_frag cache with aligning requirement.
+ *
+ * Return:
+ * True if refill succeeds, otherwise return false.
+ */
 static inline bool __page_frag_refill_align(struct page_frag_cache *nc,
 					    unsigned int fragsz,
 					    struct page_frag *pfrag,
@@ -113,6 +190,20 @@ static inline bool __page_frag_refill_align(struct page_frag_cache *nc,
 	return true;
 }
 
+/**
+ * page_frag_refill_align() - Refill a page_frag with aligning requirement.
+ * @nc: page_frag cache from which to refill
+ * @fragsz: the requested fragment size
+ * @pfrag: the page_frag to be refilled.
+ * @gfp_mask: the allocation gfp to use when cache needs to be refilled
+ * @align: the requested aligning requirement for the fragment
+ *
+ * WARN_ON_ONCE() checking for @align before refilling a page_frag from
+ * page_frag cache with aligning requirement.
+ *
+ * Return:
+ * True if refill succeeds, otherwise return false.
+ */
 static inline bool page_frag_refill_align(struct page_frag_cache *nc,
 					  unsigned int fragsz,
 					  struct page_frag *pfrag,
@@ -122,6 +213,18 @@ static inline bool page_frag_refill_align(struct page_frag_cache *nc,
 	return __page_frag_refill_align(nc, fragsz, pfrag, gfp_mask, -align);
 }
 
+/**
+ * page_frag_refill() - Refill a page_frag.
+ * @nc: page_frag cache from which to refill
+ * @fragsz: the requested fragment size
+ * @pfrag: the page_frag to be refilled.
+ * @gfp_mask: the allocation gfp to use when cache need to be refilled
+ *
+ * Refill a page_frag from page_frag cache.
+ *
+ * Return:
+ * True if refill succeeds, otherwise return false.
+ */
 static inline bool page_frag_refill(struct page_frag_cache *nc,
 				    unsigned int fragsz,
 				    struct page_frag *pfrag, gfp_t gfp_mask)
@@ -129,6 +232,20 @@ static inline bool page_frag_refill(struct page_frag_cache *nc,
 	return __page_frag_refill_align(nc, fragsz, pfrag, gfp_mask, ~0u);
 }
 
+/**
+ * __page_frag_refill_prepare_align() - Prepare refilling a page_frag with
+ * aligning requirement.
+ * @nc: page_frag cache from which to refill
+ * @fragsz: the requested fragment size
+ * @pfrag: the page_frag to be refilled.
+ * @gfp_mask: the allocation gfp to use when cache need to be refilled
+ * @align_mask: the requested aligning requirement for the fragment
+ *
+ * Prepare refill a page_frag from page_frag cache with aligning requirement.
+ *
+ * Return:
+ * True if prepare refilling succeeds, otherwise return false.
+ */
 static inline bool __page_frag_refill_prepare_align(struct page_frag_cache *nc,
 						    unsigned int fragsz,
 						    struct page_frag *pfrag,
@@ -139,6 +256,21 @@ static inline bool __page_frag_refill_prepare_align(struct page_frag_cache *nc,
 					   align_mask);
 }
 
+/**
+ * page_frag_refill_prepare_align() - Prepare refilling a page_frag with
+ * aligning requirement.
+ * @nc: page_frag cache from which to refill
+ * @fragsz: the requested fragment size
+ * @pfrag: the page_frag to be refilled.
+ * @gfp_mask: the allocation gfp to use when cache needs to be refilled
+ * @align: the requested aligning requirement for the fragment
+ *
+ * WARN_ON_ONCE() checking for @align before prepare refilling a page_frag from
+ * page_frag cache with aligning requirement.
+ *
+ * Return:
+ * True if prepare refilling succeeds, otherwise return false.
+ */
 static inline bool page_frag_refill_prepare_align(struct page_frag_cache *nc,
 						  unsigned int fragsz,
 						  struct page_frag *pfrag,
@@ -150,6 +282,18 @@ static inline bool page_frag_refill_prepare_align(struct page_frag_cache *nc,
 						-align);
 }
 
+/**
+ * page_frag_refill_prepare() - Prepare refilling a page_frag.
+ * @nc: page_frag cache from which to refill
+ * @fragsz: the requested fragment size
+ * @pfrag: the page_frag to be refilled.
+ * @gfp_mask: the allocation gfp to use when cache need to be refilled
+ *
+ * Prepare refilling a page_frag from page_frag cache.
+ *
+ * Return:
+ * True if refill succeeds, otherwise return false.
+ */
 static inline bool page_frag_refill_prepare(struct page_frag_cache *nc,
 					    unsigned int fragsz,
 					    struct page_frag *pfrag,
@@ -159,6 +303,20 @@ static inline bool page_frag_refill_prepare(struct page_frag_cache *nc,
 						~0u);
 }
 
+/**
+ * __page_frag_alloc_refill_prepare_align() - Prepare allocing a fragment and
+ * refilling a page_frag with aligning requirement.
+ * @nc: page_frag cache from which to allocate and refill
+ * @fragsz: the requested fragment size
+ * @pfrag: the page_frag to be refilled.
+ * @gfp_mask: the allocation gfp to use when cache need to be refilled
+ * @align_mask: the requested aligning requirement for the fragment.
+ *
+ * Prepare allocing a fragment and refilling a page_frag from page_frag cache.
+ *
+ * Return:
+ * virtual address of the page fragment, otherwise return NULL.
+ */
 static inline void *__page_frag_alloc_refill_prepare_align(struct page_frag_cache *nc,
 							   unsigned int fragsz,
 							   struct page_frag *pfrag,
@@ -168,6 +326,21 @@ static inline void *__page_frag_alloc_refill_prepare_align(struct page_frag_cach
 	return __page_frag_cache_prepare(nc, fragsz, pfrag, gfp_mask, align_mask);
 }
 
+/**
+ * page_frag_alloc_refill_prepare_align() - Prepare allocing a fragment and
+ * refilling a page_frag with aligning requirement.
+ * @nc: page_frag cache from which to allocate and refill
+ * @fragsz: the requested fragment size
+ * @pfrag: the page_frag to be refilled.
+ * @gfp_mask: the allocation gfp to use when cache need to be refilled
+ * @align: the requested aligning requirement for the fragment.
+ *
+ * WARN_ON_ONCE() checking for @align before prepare allocing a fragment and
+ * refilling a page_frag from page_frag cache.
+ *
+ * Return:
+ * virtual address of the page fragment, otherwise return NULL.
+ */
 static inline void *page_frag_alloc_refill_prepare_align(struct page_frag_cache *nc,
 							 unsigned int fragsz,
 							 struct page_frag *pfrag,
@@ -179,6 +352,19 @@ static inline void *page_frag_alloc_refill_prepare_align(struct page_frag_cache
 						      gfp_mask, -align);
 }
 
+/**
+ * page_frag_alloc_refill_prepare() - Prepare allocing a fragment and refilling
+ * a page_frag.
+ * @nc: page_frag cache from which to allocate and refill
+ * @fragsz: the requested fragment size
+ * @pfrag: the page_frag to be refilled.
+ * @gfp_mask: the allocation gfp to use when cache need to be refilled
+ *
+ * Prepare allocing a fragment and refilling a page_frag from page_frag cache.
+ *
+ * Return:
+ * virtual address of the page fragment, otherwise return NULL.
+ */
 static inline void *page_frag_alloc_refill_prepare(struct page_frag_cache *nc,
 						   unsigned int fragsz,
 						   struct page_frag *pfrag,
@@ -188,6 +374,18 @@ static inline void *page_frag_alloc_refill_prepare(struct page_frag_cache *nc,
 						      gfp_mask, ~0u);
 }
 
+/**
+ * page_frag_alloc_refill_probe() - Probe allocing a fragment and refilling
+ * a page_frag.
+ * @nc: page_frag cache from which to allocate and refill
+ * @fragsz: the requested fragment size
+ * @pfrag: the page_frag to be refilled
+ *
+ * Probe allocing a fragment and refilling a page_frag from page_frag cache.
+ *
+ * Return:
+ * virtual address of the page fragment, otherwise return NULL.
+ */
 static inline void *page_frag_alloc_refill_probe(struct page_frag_cache *nc,
 						 unsigned int fragsz,
 						 struct page_frag *pfrag)
@@ -195,6 +393,17 @@ static inline void *page_frag_alloc_refill_probe(struct page_frag_cache *nc,
 	return __page_frag_alloc_refill_probe_align(nc, fragsz, pfrag, ~0u);
 }
 
+/**
+ * page_frag_refill_probe() - Probe refilling a page_frag.
+ * @nc: page_frag cache from which to refill
+ * @fragsz: the requested fragment size
+ * @pfrag: the page_frag to be refilled
+ *
+ * Probe refilling a page_frag from page_frag cache.
+ *
+ * Return:
+ * True if refill succeeds, otherwise return false.
+ */
 static inline bool page_frag_refill_probe(struct page_frag_cache *nc,
 					  unsigned int fragsz,
 					  struct page_frag *pfrag)
@@ -202,20 +411,54 @@ static inline bool page_frag_refill_probe(struct page_frag_cache *nc,
 	return !!page_frag_alloc_refill_probe(nc, fragsz, pfrag);
 }
 
-static inline void page_frag_commit(struct page_frag_cache *nc,
-				    struct page_frag *pfrag,
-				    unsigned int used_sz)
+/**
+ * page_frag_commit - Commit allocing a page fragment.
+ * @nc: page_frag cache from which to commit
+ * @pfrag: the page_frag to be committed
+ * @used_sz: size of the page fragment has been used
+ *
+ * Commit the actual used size for the allocation that was either prepared
+ * or probed.
+ *
+ * Return:
+ * The true size of the fragment considering the offset alignment.
+ */
+static inline unsigned int page_frag_commit(struct page_frag_cache *nc,
+					    struct page_frag *pfrag,
+					    unsigned int used_sz)
 {
-	__page_frag_cache_commit(nc, pfrag, used_sz);
+	return __page_frag_cache_commit(nc, pfrag, used_sz);
 }
 
-static inline void page_frag_commit_noref(struct page_frag_cache *nc,
-					  struct page_frag *pfrag,
-					  unsigned int used_sz)
+/**
+ * page_frag_commit_noref - Commit allocing a page fragment without taking
+ * page refcount.
+ * @nc: page_frag cache from which to commit
+ * @pfrag: the page_frag to be committed
+ * @used_sz: size of the page fragment has been used
+ *
+ * Commit the alloc preparing or probing by passing the actual used size, but
+ * not taking refcount. Mostly used for fragmemt coalescing case when the
+ * current fragment can share the same refcount with previous fragment.
+ *
+ * Return:
+ * The true size of the fragment considering the offset alignment.
+ */
+static inline unsigned int page_frag_commit_noref(struct page_frag_cache *nc,
+						  struct page_frag *pfrag,
+						  unsigned int used_sz)
 {
-	__page_frag_cache_commit_noref(nc, pfrag, used_sz);
+	return __page_frag_cache_commit_noref(nc, pfrag, used_sz);
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
index c052c77a96eb..209cc1e278ab 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -75,6 +75,10 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 	return page;
 }
 
+/**
+ * page_frag_cache_drain - Drain the current page from page_frag cache.
+ * @nc: page_frag cache from which to drain
+ */
 void page_frag_cache_drain(struct page_frag_cache *nc)
 {
 	if (!nc->encoded_page)
@@ -117,6 +121,20 @@ unsigned int __page_frag_cache_commit_noref(struct page_frag_cache *nc,
 }
 EXPORT_SYMBOL(__page_frag_cache_commit_noref);
 
+/**
+ * __page_frag_alloc_refill_probe_align() - Probe allocing a fragment and
+ * refilling a page_frag with aligning requirement.
+ * @nc: page_frag cache from which to allocate and refill
+ * @fragsz: the requested fragment size
+ * @pfrag: the page_frag to be refilled.
+ * @align_mask: the requested aligning requirement for the fragment.
+ *
+ * Probe allocing a fragment and refilling a page_frag from page_frag cache with
+ * aligning requirement.
+ *
+ * Return:
+ * virtual address of the page fragment, otherwise return NULL.
+ */
 void *__page_frag_alloc_refill_probe_align(struct page_frag_cache *nc,
 					   unsigned int fragsz,
 					   struct page_frag *pfrag,
@@ -208,8 +226,12 @@ void *__page_frag_cache_prepare(struct page_frag_cache *nc, unsigned int fragsz,
 }
 EXPORT_SYMBOL(__page_frag_cache_prepare);
 
-/*
- * Frees a page fragment allocated out of either a compound or order 0 page.
+/**
+ * page_frag_free - Free a page fragment.
+ * @addr: va of page fragment to be freed
+ *
+ * Free a page fragment allocated out of either a compound or order 0 page by
+ * virtual address.
  */
 void page_frag_free(void *addr)
 {
-- 
2.33.0


