Return-Path: <netdev+bounces-17996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D13754031
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 19:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 849921C2159C
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 17:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91800154AC;
	Fri, 14 Jul 2023 17:10:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FDF15AC6
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 17:10:41 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B403A97;
	Fri, 14 Jul 2023 10:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689354636; x=1720890636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=86sULqDFnJu07kwWFQElzIHICqwXn6tB5JYzyMmvGN4=;
  b=PEh/4PRna+I2xPx8qHnqT4TAbGNSOSFyAwncLocuiUeeOJ3t3y52sEau
   KcvaI00Vmsvfna5qLQ4KvgX8uR0FJu79ItO5rczTFaMPyqS4vFzHbALv3
   3AoRE96vpu/P1Cm+K4jVddLRS4hNdwwN3bKMPn9Tq/EqmgXSMjxDwzRpT
   5i8DdTrK2T5mwlh9sGXge5+nk9gSjmSoX4DWT3n6IsyE0PxctP+hotncE
   iuBlrk+LoAknHNDG5mkFFpO5NeWrIPdQ1akUI5Y5TIUkci54HIRBQ2TpL
   FjL2oL0xuOQXBBZ1FchjAD9pzasHJSu5w2nnsOcrvSWzW5V21TyNa6CNJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="451891891"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="451891891"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 10:10:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="787907051"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="787907051"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jul 2023 10:10:33 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC net-next v2 3/7] net: page_pool: shrink &page_pool_params a tiny bit
Date: Fri, 14 Jul 2023 19:08:48 +0200
Message-ID: <20230714170853.866018-6-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714170853.866018-1-aleksander.lobakin@intel.com>
References: <20230714170853.866018-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For now, this structure takes a whole 64-byte cacheline on x86_64.
But in fact, it has a 4-byte hole before ::init_callback() (yet not
sufficient to change its sizeof()).
::dma_dir is whole 4 bytes, although its values can only be 0 and 2.
Merge it with ::flags and, so that its slot gets freed and reduces
the structure's size to 56 bytes. This adds instruction when reading
that field, but the upcoming change will make those reads happen way
less often.
Pad the freed slot explicitly in &page_pool to not alter cacheline
layout while it's not used.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index 212d72b5cfec..68937deea4b1 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -51,13 +51,13 @@ struct pp_alloc_cache {
 };
 
 struct page_pool_params {
-	unsigned int	flags;
+	unsigned int	flags:30;
+	enum dma_data_direction dma_dir:2; /* DMA mapping direction */
 	unsigned int	order;
 	unsigned int	pool_size;
 	int		nid;  /* Numa node id to allocate from pages from */
 	struct device	*dev; /* device, for DMA pre-mapping purposes */
 	struct napi_struct *napi; /* Sole consumer of pages, otherwise NULL */
-	enum dma_data_direction dma_dir; /* DMA mapping direction */
 	unsigned int	max_len; /* max DMA sync memory size */
 	unsigned int	offset;  /* DMA addr offset */
 	void (*init_callback)(struct page *page, void *arg);
@@ -129,6 +129,7 @@ static inline u64 *page_pool_ethtool_stats_get(u64 *data, void *stats)
 
 struct page_pool {
 	struct page_pool_params p;
+	long pad;
 
 	long frag_users;
 	struct page *frag_page;
-- 
2.41.0


