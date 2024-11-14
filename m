Return-Path: <netdev+bounces-144886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC609C8A00
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 13:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BEC4B2F6B0
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D1E1FAEE3;
	Thu, 14 Nov 2024 12:22:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D341FA837;
	Thu, 14 Nov 2024 12:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731586975; cv=none; b=hwRqr35LBHZ0EhM5NmGsYDaua2SuqIGkNUtcCsbh9WcnO/Jms+z6T75RLRGNSNQpac7ZlPoAT4HdicZ4HLNc4GJwEmkhZkXakcFULxGyuNX+vb0BQrjLs1qiAqgQ8oh1PXunYEMBfa2psncq91iojCb6vt0QkYY8s/MuWMFGPws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731586975; c=relaxed/simple;
	bh=AnS873QB+hwd0VrFLf/D5rY6qh3rve2wNTTBNEyvE14=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oqMJJ94vPA4O/7+dvYe4qMNZYb5dR9tWbtgNa74tMuFMSHId1ajkIJTlYwzDVqm4yWyfnkspdZZF2YW4s8K560pDn2tWBvMXMZzo//ofZUfb7QjGKtDeBN1Ie/dSQOrr0uhLCAaXJMmqWkJQiH4IhhluALK3tWpL5nVOt/Ihgus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Xpzl866ddz2Dgwf;
	Thu, 14 Nov 2024 20:20:52 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 3F9491A0188;
	Thu, 14 Nov 2024 20:22:44 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Nov 2024 20:22:43 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, Jonathan
 Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: [PATCH net-next v1 03/10] mm: page_frag: update documentation for page_frag
Date: Thu, 14 Nov 2024 20:15:58 +0800
Message-ID: <20241114121606.3434517-4-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241114121606.3434517-1-linyunsheng@huawei.com>
References: <20241114121606.3434517-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

Update documentation about design, implementation and API usages
for page_frag.

CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Linux-MM <linux-mm@kvack.org>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 Documentation/mm/page_frags.rst | 110 +++++++++++++++++++++++++++++++-
 include/linux/page_frag_cache.h |  54 ++++++++++++++++
 mm/page_frag_cache.c            |  12 +++-
 3 files changed, 173 insertions(+), 3 deletions(-)

diff --git a/Documentation/mm/page_frags.rst b/Documentation/mm/page_frags.rst
index 503ca6cdb804..34e654c2956e 100644
--- a/Documentation/mm/page_frags.rst
+++ b/Documentation/mm/page_frags.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ==============
 Page fragments
 ==============
@@ -40,4 +42,110 @@ page via a single call.  The advantage to doing this is that it allows for
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
+
+Depending on different aligning requirement, the page_frag API caller may call
+page_frag_*_align*() to ensure the returned virtual address or offset of the
+page is aligned according to the 'align/alignment' parameter. Note the size of
+the allocated fragment is not aligned, the caller needs to provide an aligned
+fragsz if there is an alignment requirement for the size of the fragment.
+
+.. kernel-doc:: include/linux/page_frag_cache.h
+   :identifiers: page_frag_cache_init page_frag_cache_is_pfmemalloc
+		 __page_frag_alloc_align page_frag_alloc_align page_frag_alloc
+
+.. kernel-doc:: mm/page_frag_cache.c
+   :identifiers: page_frag_cache_drain page_frag_free
+
+Coding examples
+===============
+
+Initialization and draining API
+-------------------------------
+
+.. code-block:: c
+
+   page_frag_cache_init(nc);
+   ...
+   page_frag_cache_drain(nc);
+
+
+Allocation & freeing API
+------------------------
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
+    if (err)
+        goto do_error;
+
+    ...
+
+    page_frag_free(va);
diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index 5ae97f93a0a1..a2b1127e8ac8 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -28,11 +28,28 @@ static inline bool encoded_page_decode_pfmemalloc(unsigned long encoded_page)
 	return !!(encoded_page & PAGE_FRAG_CACHE_PFMEMALLOC_BIT);
 }
 
+/**
+ * page_frag_cache_init() - Init page_frag cache.
+ * @nc: page_frag cache from which to init
+ *
+ * Inline helper to initialize the page_frag cache.
+ */
 static inline void page_frag_cache_init(struct page_frag_cache *nc)
 {
 	nc->encoded_page = 0;
 }
 
+/**
+ * page_frag_cache_is_pfmemalloc() - Check for pfmemalloc.
+ * @nc: page_frag cache from which to check
+ *
+ * Check if the current page in page_frag cache is allocated from the pfmemalloc
+ * reserves. It has the same calling context expectation as the allocation API.
+ *
+ * Return:
+ * true if the current page in page_frag cache is allocated from the pfmemalloc
+ * reserves, otherwise return false.
+ */
 static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)
 {
 	return encoded_page_decode_pfmemalloc(nc->encoded_page);
@@ -57,6 +74,19 @@ static inline unsigned int __page_frag_cache_commit(struct page_frag_cache *nc,
 	return __page_frag_cache_commit_noref(nc, pfrag, used_sz);
 }
 
+/**
+ * __page_frag_alloc_align() - Allocate a page fragment with aligning
+ * requirement.
+ * @nc: page_frag cache from which to allocate
+ * @fragsz: the requested fragment size
+ * @gfp_mask: the allocation gfp to use when cache need to be refilled
+ * @align_mask: the requested aligning requirement for the 'va'
+ *
+ * Allocate a page fragment from page_frag cache with aligning requirement.
+ *
+ * Return:
+ * Virtual address of the page fragment, otherwise return NULL.
+ */
 static inline void *__page_frag_alloc_align(struct page_frag_cache *nc,
 					    unsigned int fragsz, gfp_t gfp_mask,
 					    unsigned int align_mask)
@@ -72,6 +102,19 @@ static inline void *__page_frag_alloc_align(struct page_frag_cache *nc,
 	return va;
 }
 
+/**
+ * page_frag_alloc_align() - Allocate a page fragment with aligning requirement.
+ * @nc: page_frag cache from which to allocate
+ * @fragsz: the requested fragment size
+ * @gfp_mask: the allocation gfp to use when cache needs to be refilled
+ * @align: the requested aligning requirement for the fragment
+ *
+ * WARN_ON_ONCE() checking for @align before allocating a page fragment from
+ * page_frag cache with aligning requirement.
+ *
+ * Return:
+ * virtual address of the page fragment, otherwise return NULL.
+ */
 static inline void *page_frag_alloc_align(struct page_frag_cache *nc,
 					  unsigned int fragsz, gfp_t gfp_mask,
 					  unsigned int align)
@@ -80,6 +123,17 @@ static inline void *page_frag_alloc_align(struct page_frag_cache *nc,
 	return __page_frag_alloc_align(nc, fragsz, gfp_mask, -align);
 }
 
+/**
+ * page_frag_alloc() - Allocate a page fragment.
+ * @nc: page_frag cache from which to allocate
+ * @fragsz: the requested fragment size
+ * @gfp_mask: the allocation gfp to use when cache need to be refilled
+ *
+ * Allocate a page fragment from page_frag cache.
+ *
+ * Return:
+ * virtual address of the page fragment, otherwise return NULL.
+ */
 static inline void *page_frag_alloc(struct page_frag_cache *nc,
 				    unsigned int fragsz, gfp_t gfp_mask)
 {
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index f55d34cf7d43..d014130fb893 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -70,6 +70,10 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 	return page;
 }
 
+/**
+ * page_frag_cache_drain - Drain the current page from page_frag cache.
+ * @nc: page_frag cache from which to drain
+ */
 void page_frag_cache_drain(struct page_frag_cache *nc)
 {
 	if (!nc->encoded_page)
@@ -182,8 +186,12 @@ void *__page_frag_cache_prepare(struct page_frag_cache *nc, unsigned int fragsz,
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


