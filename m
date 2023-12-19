Return-Path: <netdev+bounces-59053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1814819208
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 22:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E7A128274E
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 21:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DF840C06;
	Tue, 19 Dec 2023 21:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="KC8owpaR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F4D3EA7A
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 21:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-28b06be7cf6so2306618a91.2
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 13:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1703019863; x=1703624663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEQ6N11l7v8r/nsFkAQ5qbz/E3VFP+byl5ecjp5V+Xo=;
        b=KC8owpaRkA58F5+Z25p+K2xkowfxp4/q1LQm6UrBkDSn+16W93lYhGwzbSTPHeZKP5
         Ya2DbPp6CM7EzydW+fWitqJpTQRZLe2hEBN248j6JTuAR3yTCiHaQ/07/1vTR71ua7SV
         rwmuLIHEzLtKOCHNXLBG4HkuJUlINu0BLdhoR29q3TlfKw+/Tmj0uGWEZHEHw941DLI6
         WMYnH7K8DKyd0/SRAlqHFsyAupiYqi2h8zohThRcH327GfeFQTTEAax9wgQPCnQiUZET
         JSEKRluk4n2rgC9eSCPcsXLUvSKP5tir6XtvYDZK4a79MuJMS7w8NimN/FQBYVrWEZvm
         PYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703019863; x=1703624663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEQ6N11l7v8r/nsFkAQ5qbz/E3VFP+byl5ecjp5V+Xo=;
        b=tLVWpKFJ5Q9cA4ZyxBAO9kQZPgC/MGL+RRFG9SyB8mXSqsb/25+qwnEjzEBXo3l1RP
         oRCGbapB5NyDWT4NpHqQkc+sgItokQ6rssgcGOsyq+OeGzxa39h7hDW1f0dJPBh8o5L6
         1nZ5OqHDnAhmUNtYLE6f9eX91eQIIHdvbEMMZXz4oTQiv9ra9GDbvw457G20OzixcqHP
         klysM1c2Pkeq/agO3VlDveas+1pdGU+iuhEoC4DNSMO6Uqglw3G+lcw0z7eGp7BNDAMc
         JcnvJkoJmwyr8ZEIPPE1NSQD8tJUYsf8yyMW8IeYG23ffUP749ScZVPJ3LFKhMCbQSjq
         8UWQ==
X-Gm-Message-State: AOJu0Yy7ZjYSOkzTwAM4EgGh/A8xfcFhCFoYCRMLZunGA/F3L71eEGl0
	kVbnlq1vt/EbBpTIGyuebqjR1g==
X-Google-Smtp-Source: AGHT+IEMwF0JJgfJeogY5EMwB8SgA6SA/QjJDc0LnTgjbd/Zd8UA2CKgdeV6xAqemSSppOsZza1xMQ==
X-Received: by 2002:a17:90a:d790:b0:28b:2e12:4fb3 with SMTP id z16-20020a17090ad79000b0028b2e124fb3mr3330341pju.33.1703019862907;
        Tue, 19 Dec 2023 13:04:22 -0800 (PST)
Received: from localhost (fwdproxy-prn-002.fbsv.net. [2a03:2880:ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id dj15-20020a17090ad2cf00b0028bbf4c0264sm1752924pjb.10.2023.12.19.13.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 13:04:22 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>
Subject: [RFC PATCH v3 19/20] net: page pool: generalise ppiov dma address get
Date: Tue, 19 Dec 2023 13:03:56 -0800
Message-Id: <20231219210357.4029713-20-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231219210357.4029713-1-dw@davidwei.uk>
References: <20231219210357.4029713-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

io_uring pp memory provider doesn't have contiguous dma addresses,
implement page_pool_iov_dma_addr() via callbacks.

Note: it might be better to stash dma address into struct page_pool_iov.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/page_pool/helpers.h | 5 +----
 include/net/page_pool/types.h   | 2 ++
 io_uring/zc_rx.c                | 8 ++++++++
 net/core/page_pool.c            | 9 +++++++++
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index aca3a52d0e22..10dba1f2aa0c 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -105,10 +105,7 @@ static inline unsigned int page_pool_iov_idx(const struct page_pool_iov *ppiov)
 static inline dma_addr_t
 page_pool_iov_dma_addr(const struct page_pool_iov *ppiov)
 {
-	struct dmabuf_genpool_chunk_owner *owner = page_pool_iov_owner(ppiov);
-
-	return owner->base_dma_addr +
-	       ((dma_addr_t)page_pool_iov_idx(ppiov) << PAGE_SHIFT);
+	return ppiov->pp->mp_ops->ppiov_dma_addr(ppiov);
 }
 
 static inline unsigned long
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index f54ee759e362..1b9266835ab6 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -125,6 +125,7 @@ struct page_pool_stats {
 #endif
 
 struct mem_provider;
+struct page_pool_iov;
 
 enum pp_memory_provider_type {
 	__PP_MP_NONE, /* Use system allocator directly */
@@ -138,6 +139,7 @@ struct pp_memory_provider_ops {
 	void (*scrub)(struct page_pool *pool);
 	struct page *(*alloc_pages)(struct page_pool *pool, gfp_t gfp);
 	bool (*release_page)(struct page_pool *pool, struct page *page);
+	dma_addr_t (*ppiov_dma_addr)(const struct page_pool_iov *ppiov);
 };
 
 extern const struct pp_memory_provider_ops dmabuf_devmem_ops;
diff --git a/io_uring/zc_rx.c b/io_uring/zc_rx.c
index f7d99d569885..20fb89e6bad7 100644
--- a/io_uring/zc_rx.c
+++ b/io_uring/zc_rx.c
@@ -600,12 +600,20 @@ static void io_pp_zc_destroy(struct page_pool *pp)
 	percpu_ref_put(&ifq->ctx->refs);
 }
 
+static dma_addr_t io_pp_zc_ppiov_dma_addr(const struct page_pool_iov *ppiov)
+{
+	struct io_zc_rx_buf *buf = io_iov_to_buf((struct page_pool_iov *)ppiov);
+
+	return buf->dma;
+}
+
 const struct pp_memory_provider_ops io_uring_pp_zc_ops = {
 	.alloc_pages		= io_pp_zc_alloc_pages,
 	.release_page		= io_pp_zc_release_page,
 	.init			= io_pp_zc_init,
 	.destroy		= io_pp_zc_destroy,
 	.scrub			= io_pp_zc_scrub,
+	.ppiov_dma_addr		= io_pp_zc_ppiov_dma_addr,
 };
 EXPORT_SYMBOL(io_uring_pp_zc_ops);
 
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index ebf5ff009d9d..6586631ecc2e 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1105,10 +1105,19 @@ static bool mp_dmabuf_devmem_release_page(struct page_pool *pool,
 	return true;
 }
 
+static dma_addr_t mp_dmabuf_devmem_ppiov_dma_addr(const struct page_pool_iov *ppiov)
+{
+	struct dmabuf_genpool_chunk_owner *owner = page_pool_iov_owner(ppiov);
+
+	return owner->base_dma_addr +
+	       ((dma_addr_t)page_pool_iov_idx(ppiov) << PAGE_SHIFT);
+}
+
 const struct pp_memory_provider_ops dmabuf_devmem_ops = {
 	.init			= mp_dmabuf_devmem_init,
 	.destroy		= mp_dmabuf_devmem_destroy,
 	.alloc_pages		= mp_dmabuf_devmem_alloc_pages,
 	.release_page		= mp_dmabuf_devmem_release_page,
+	.ppiov_dma_addr		= mp_dmabuf_devmem_ppiov_dma_addr,
 };
 EXPORT_SYMBOL(dmabuf_devmem_ops);
-- 
2.39.3


