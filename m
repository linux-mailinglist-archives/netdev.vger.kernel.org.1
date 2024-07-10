Return-Path: <netdev+bounces-110635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E25C92DA15
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 22:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AEF21C21918
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 20:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252E119883B;
	Wed, 10 Jul 2024 20:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NxvTv4C7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857C6193068
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 20:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720643446; cv=none; b=I0HZ6UduEOcTJmvwTpnn7w5QOmlHyp4eNpMXr/ppLxA9n/f4d8AYFXTFGDz2FX3Cx2FlsmfomR+P62RqKrMqI8NpYxRPrSTdsTtgR9Mi09nIIHPAMN5rWtnFonf/J5ozlAeDy1sN8ABh6F7sgNBWEUje/j+19X9NPssaTs4LJvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720643446; c=relaxed/simple;
	bh=setZJisQTsjPITiRMbuvTZuqB5AUykKImVQ3FzTn1VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVxuPgy9CnXuSBM2Ve5Orq+ThAVzfH1pS/5z5GNghQ8OvGmAKkecUy67vp7CN0P17rlJhj/M9GxtvlIaPMOh0Yk2CQNeZSyKgNrf1mBiUK+KXl1D8X+VDxeDCC2RQVsz3CE1eahJaw1w5Gc35POeY+8VngEFr/lVWTFKai7Bcm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NxvTv4C7; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720643444; x=1752179444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=setZJisQTsjPITiRMbuvTZuqB5AUykKImVQ3FzTn1VQ=;
  b=NxvTv4C71T0js/LaRfekANXtBbSqmVDXZ2wkle1woK28D5MjphVycIn7
   +oQcdF5p0W1ZijV1WXXxf04CjuQhPmqWI/DO27zozJYYnl7VAZLT08C3g
   +Q0ep7rqaHAOs9hMxhPSWSGFgzlWU4gxQ3R6L4QfyQWKT07A52aYqrvPZ
   Lz/VfLqRjA8svsjbHDzn8WOon2rcwIT4eLZ7b1irK7bNs5cpS4LUPKbuW
   zh/qNDj02FAQKMlgr3psjnqahkjUhWuXkvO02Y7GoQEADA5zJGjnYB5dx
   l65WztCa0/xqECGu43Vp0WUrvg7Q4zTWR8DrCV2XG6988U5eOlrNg90/a
   A==;
X-CSE-ConnectionGUID: obP5+771SUCZCceFFkuFlw==
X-CSE-MsgGUID: /dV6Wl8RQKS3WtWikrCuLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="12483749"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="12483749"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 13:30:42 -0700
X-CSE-ConnectionGUID: yv1zjeuNSEmQZ/1LXnzmOA==
X-CSE-MsgGUID: LxbfUUZ2Q7WXe6Y2PWvCkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48223856"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 10 Jul 2024 13:30:41 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	anthony.l.nguyen@intel.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	lihong.yang@intel.com,
	willemb@google.com,
	almasrymina@google.com
Subject: [PATCH net-next 02/14] page_pool: use __cacheline_group_{begin, end}_aligned()
Date: Wed, 10 Jul 2024 13:30:18 -0700
Message-ID: <20240710203031.188081-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240710203031.188081-1-anthony.l.nguyen@intel.com>
References: <20240710203031.188081-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Lobakin <aleksander.lobakin@intel.com>

Instead of doing __cacheline_group_begin() __aligned(), use the new
__cacheline_group_{begin,end}_aligned(), so that it will take care
of the group alignment itself.
Also replace open-coded `4 * sizeof(long)` in two places with
a definition.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 include/net/page_pool/types.h | 22 ++++++++++++----------
 net/core/page_pool.c          |  3 ++-
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index b70bcc14ceda..50569fed7868 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -129,6 +129,16 @@ struct page_pool_stats {
 };
 #endif
 
+/* The whole frag API block must stay within one cacheline. On 32-bit systems,
+ * sizeof(long) == sizeof(int), so that the block size is ``3 * sizeof(long)``.
+ * On 64-bit systems, the actual size is ``2 * sizeof(long) + sizeof(int)``.
+ * The closest pow-2 to both of them is ``4 * sizeof(long)``, so just use that
+ * one for simplicity.
+ * Having it aligned to a cacheline boundary may be excessive and doesn't bring
+ * any good.
+ */
+#define PAGE_POOL_FRAG_GROUP_ALIGN	(4 * sizeof(long))
+
 struct page_pool {
 	struct page_pool_params_fast p;
 
@@ -142,19 +152,11 @@ struct page_pool {
 	bool system:1;			/* This is a global percpu pool */
 #endif
 
-	/* The following block must stay within one cacheline. On 32-bit
-	 * systems, sizeof(long) == sizeof(int), so that the block size is
-	 * ``3 * sizeof(long)``. On 64-bit systems, the actual size is
-	 * ``2 * sizeof(long) + sizeof(int)``. The closest pow-2 to both of
-	 * them is ``4 * sizeof(long)``, so just use that one for simplicity.
-	 * Having it aligned to a cacheline boundary may be excessive and
-	 * doesn't bring any good.
-	 */
-	__cacheline_group_begin(frag) __aligned(4 * sizeof(long));
+	__cacheline_group_begin_aligned(frag, PAGE_POOL_FRAG_GROUP_ALIGN);
 	long frag_users;
 	netmem_ref frag_page;
 	unsigned int frag_offset;
-	__cacheline_group_end(frag);
+	__cacheline_group_end_aligned(frag, PAGE_POOL_FRAG_GROUP_ALIGN);
 
 	struct delayed_work release_dw;
 	void (*disconnect)(void *pool);
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 855271a6cad2..2abe6e919224 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -178,7 +178,8 @@ static void page_pool_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct page_pool, frag, frag_users);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct page_pool, frag, frag_page);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct page_pool, frag, frag_offset);
-	CACHELINE_ASSERT_GROUP_SIZE(struct page_pool, frag, 4 * sizeof(long));
+	CACHELINE_ASSERT_GROUP_SIZE(struct page_pool, frag,
+				    PAGE_POOL_FRAG_GROUP_ALIGN);
 }
 
 static int page_pool_init(struct page_pool *pool,
-- 
2.41.0


