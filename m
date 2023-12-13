Return-Path: <netdev+bounces-56713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A0E810928
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 05:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7C20281B18
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 04:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5668FC127;
	Wed, 13 Dec 2023 04:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iIkyWvob"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B6ED2
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 20:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=pB++kTMIshWQzRVpdKypDVNVCvvFB2lrafxKjvtVfFA=; b=iIkyWvobFJrBqCtv1otazMAr1W
	ZbZFvwZSyWhEpveV5vbf7wzoqRmljwDQdnjxW+SvpWvN47VDW9RpxkuEAd6mtu4IXFIPnfnCYP4mB
	kFH1+JosmdNjNQlwnx7LAUW/pEbzeVEncpRFDI+hZ4WUX3HuT2ZfufWCfQLpuTrf/RAZRAJI+oJpB
	bwHSMhNJ8CbBOC5WvPwqdesWRa60M25WyGCv3wbHGgr7JGh9NtjXaAedsgunKot7QHgFU1L0cGUDj
	5jPm/LuofU0pq1yptsbT3MUqnJ6/PeMuGa4YKR26IRFtLUDB1S/Hn1bCRTjFVNjju1J5rxxzS+By+
	+U2DMmwA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rDGzL-00Daia-1t;
	Wed, 13 Dec 2023 04:36:51 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] page_pool: fix typos and punctuation
Date: Tue, 12 Dec 2023 20:36:50 -0800
Message-ID: <20231213043650.12672-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct spelling (s/and/any) and a run-on sentence.
Spell out "multi".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 include/net/page_pool/helpers.h |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff -- a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -11,7 +11,7 @@
  * The page_pool allocator is optimized for recycling page or page fragment used
  * by skb packet and xdp frame.
  *
- * Basic use involves replacing and alloc_pages() calls with page_pool_alloc(),
+ * Basic use involves replacing any alloc_pages() calls with page_pool_alloc(),
  * which allocate memory with or without page splitting depending on the
  * requested memory size.
  *
@@ -37,15 +37,15 @@
  * attach the page_pool object to a page_pool-aware object like skbs marked with
  * skb_mark_for_recycle().
  *
- * page_pool_put_page() may be called multi times on the same page if a page is
- * split into multi fragments. For the last fragment, it will either recycle the
- * page, or in case of page->_refcount > 1, it will release the DMA mapping and
- * in-flight state accounting.
+ * page_pool_put_page() may be called multiple times on the same page if a page
+ * is split into multiple fragments. For the last fragment, it will either
+ * recycle the page, or in case of page->_refcount > 1, it will release the DMA
+ * mapping and in-flight state accounting.
  *
  * dma_sync_single_range_for_device() is only called for the last fragment when
  * page_pool is created with PP_FLAG_DMA_SYNC_DEV flag, so it depends on the
  * last freed fragment to do the sync_for_device operation for all fragments in
- * the same page when a page is split, the API user must setup pool->p.max_len
+ * the same page when a page is split. The API user must setup pool->p.max_len
  * and pool->p.offset correctly and ensure that page_pool_put_page() is called
  * with dma_sync_size being -1 for fragment API.
  */

