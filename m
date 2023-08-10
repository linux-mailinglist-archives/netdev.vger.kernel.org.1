Return-Path: <netdev+bounces-26120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D63776DCE
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 04:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52C961C2115A
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 02:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFB7111C;
	Thu, 10 Aug 2023 01:58:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6063D1100
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:58:21 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CABC1BD9
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 18:58:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d1c693a29a0so450044276.1
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 18:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691632699; x=1692237499;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=230l8c/KQ2ub7YMPLfgz4BJig3YoPpRYkLaR90fiHkY=;
        b=UOU2WHdByV36J0UbI8RByL1ERbNx1NeSgDEZpmHEkI8h3kqdPwe4+Kdbiw7B7y0uSW
         AXvt36vDSALuBy8YhsOJAr3vNYeoEzi+wNYmAEkMqp31kP70XmpbNr/HJgwLC02sphw+
         5GcVWmT2QBY6LrobMNsg6VIkZiJeiSI106vFCYJKORLY+5C82dDXG5ZBVA/eNDBebHcE
         tDiXeKuurb882atISdP7An6L1nAeZZ4IJtt3WII2swvXRcp3Qgiu6cs+og9EzPSr+w7Q
         lzAXziXlagA5ULGkJealwWCQGNRPRS0s0R3tH3EznN1r9aO2zO5WPBi9pgzUk2nxaOVU
         DpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691632699; x=1692237499;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=230l8c/KQ2ub7YMPLfgz4BJig3YoPpRYkLaR90fiHkY=;
        b=PyskthvU87V8eaAthskPx4XoYTlA/DeF3sJ1TAX7z/Fsm0uvDTaOlCKBno3kjKb9VK
         C0NqGbgRoYniXMDdG+a2XHrUpWi22pt1z55mV96+Jv69h8rEa0PU3AZFyZli7Lg27KMH
         N3SbOPJOi8SggBqlR5DrNJ2jhytSDIfit1BARsiC3qZGFYROPzQayBQFRLbtD+Do4a0b
         hyNubUqmYmhPy4WX077d0F3/Wvv3iLNEE36wh4/7iWolXQx/qDGjrX5VPhgJFyWgd3UH
         lGeoZE3LrFibYST/bwukpHwl9czhGXRtmH/3tsYGLj5iX2o85mZRbbZPzd8cDaoSZ5sa
         SA2Q==
X-Gm-Message-State: AOJu0Yz6/5i7fOF9rtTNmaIqHi2Fpn9Nh6U5WadiWXcFp3DxSILH4oOL
	hNBg9CDqnjnq5clmnFGP6GvhLfTa9zg8B7veoSYweFdLs2KqIIOuPN6YnPqyxQ1DT2f8TytXQyV
	vMT2h5PBcstWjvltWWSPyXkMk3buJzdM478MoDnNRbk1tLgZdbQGnGc/1rl+M3khbr7hL8VtjY9
	4=
X-Google-Smtp-Source: AGHT+IGOBsrytp60efHaHvAx2HEbWRVp5N3ZqokBBk6DlKyxgFv5Ol7RPor2cCHaz6v7c/yxheslvjT0xrqHee9vIQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:73ad:9ed5:e067:2b9b])
 (user=almasrymina job=sendgmr) by 2002:a25:6813:0:b0:d49:e117:3a17 with SMTP
 id d19-20020a256813000000b00d49e1173a17mr18327ybc.4.1691632698981; Wed, 09
 Aug 2023 18:58:18 -0700 (PDT)
Date: Wed,  9 Aug 2023 18:57:43 -0700
In-Reply-To: <20230810015751.3297321-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230810015751.3297321-1-almasrymina@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230810015751.3297321-8-almasrymina@google.com>
Subject: [RFC PATCH v2 07/11] net: support non paged skb frags
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Hari Ramakrishnan <rharix@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Andy Lutomirski <luto@kernel.org>, stephen@networkplumber.org, sdf@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Make skb_frag_page() fail in the case where the frag is not backed
by a page, and fix its relevent callers to handle this case.

Correctly handle skb_frag refcounting in the page_pool_iovs case.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/linux/skbuff.h | 40 +++++++++++++++++++++++++++++++++-------
 net/core/gro.c         |  2 +-
 net/core/skbuff.c      |  3 +++
 net/ipv4/tcp.c         | 10 +++++++++-
 4 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index faaba050f843..5520587050c4 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3389,15 +3389,38 @@ static inline void skb_frag_off_copy(skb_frag_t *fragto,
 	fragto->bv_offset = fragfrom->bv_offset;
 }
 
+/* Returns true if the skb_frag contains a page_pool_iov. */
+static inline bool skb_frag_is_page_pool_iov(const skb_frag_t *frag)
+{
+	return page_is_page_pool_iov(frag->bv_page);
+}
+
 /**
  * skb_frag_page - retrieve the page referred to by a paged fragment
  * @frag: the paged fragment
  *
- * Returns the &struct page associated with @frag.
+ * Returns the &struct page associated with @frag. Returns NULL if this frag
+ * has no associated page.
  */
 static inline struct page *skb_frag_page(const skb_frag_t *frag)
 {
-	return frag->bv_page;
+	if (!page_is_page_pool_iov(frag->bv_page))
+		return frag->bv_page;
+
+	return NULL;
+}
+
+/**
+ * skb_frag_page_pool_iov - retrieve the page_pool_iov referred to by fragment
+ * @frag: the fragment
+ *
+ * Returns the &struct page_pool_iov associated with @frag. Returns NULL if this
+ * frag has no associated page_pool_iov.
+ */
+static inline struct page_pool_iov *
+skb_frag_page_pool_iov(const skb_frag_t *frag)
+{
+	return page_to_page_pool_iov(frag->bv_page);
 }
 
 /**
@@ -3408,7 +3431,7 @@ static inline struct page *skb_frag_page(const skb_frag_t *frag)
  */
 static inline void __skb_frag_ref(skb_frag_t *frag)
 {
-	get_page(skb_frag_page(frag));
+	page_pool_page_get_many(frag->bv_page, 1);
 }
 
 /**
@@ -3426,13 +3449,13 @@ static inline void skb_frag_ref(struct sk_buff *skb, int f)
 static inline void
 napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
 {
-	struct page *page = skb_frag_page(frag);
-
 #ifdef CONFIG_PAGE_POOL
-	if (recycle && page_pool_return_skb_page(page, napi_safe))
+	if (recycle && page_pool_return_skb_page(frag->bv_page, napi_safe))
 		return;
+	page_pool_page_put_many(frag->bv_page, 1);
+#else
+	put_page(skb_frag_page(frag));
 #endif
-	put_page(page);
 }
 
 /**
@@ -3472,6 +3495,9 @@ static inline void skb_frag_unref(struct sk_buff *skb, int f)
  */
 static inline void *skb_frag_address(const skb_frag_t *frag)
 {
+	if (!skb_frag_page(frag))
+		return NULL;
+
 	return page_address(skb_frag_page(frag)) + skb_frag_off(frag);
 }
 
diff --git a/net/core/gro.c b/net/core/gro.c
index 0759277dc14e..42d7f6755f32 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -376,7 +376,7 @@ static inline void skb_gro_reset_offset(struct sk_buff *skb, u32 nhoff)
 	NAPI_GRO_CB(skb)->frag0 = NULL;
 	NAPI_GRO_CB(skb)->frag0_len = 0;
 
-	if (!skb_headlen(skb) && pinfo->nr_frags &&
+	if (!skb_headlen(skb) && pinfo->nr_frags && skb_frag_page(frag0) &&
 	    !PageHighMem(skb_frag_page(frag0)) &&
 	    (!NET_IP_ALIGN || !((skb_frag_off(frag0) + nhoff) & 3))) {
 		NAPI_GRO_CB(skb)->frag0 = skb_frag_address(frag0);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a298992060e6..ac79881a2630 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2939,6 +2939,9 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
 	for (seg = 0; seg < skb_shinfo(skb)->nr_frags; seg++) {
 		const skb_frag_t *f = &skb_shinfo(skb)->frags[seg];
 
+		if (WARN_ON_ONCE(!skb_frag_page(f)))
+			return false;
+
 		if (__splice_segment(skb_frag_page(f),
 				     skb_frag_off(f), skb_frag_size(f),
 				     offset, len, spd, false, sk, pipe))
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 88f4ebab12ac..7893df0e22ee 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2160,6 +2160,9 @@ static int tcp_zerocopy_receive(struct sock *sk,
 			break;
 		}
 		page = skb_frag_page(frags);
+		if (WARN_ON_ONCE(!page))
+			break;
+
 		prefetchw(page);
 		pages[pages_to_map++] = page;
 		length += PAGE_SIZE;
@@ -4415,7 +4418,12 @@ int tcp_md5_hash_skb_data(struct tcp_md5sig_pool *hp,
 	for (i = 0; i < shi->nr_frags; ++i) {
 		const skb_frag_t *f = &shi->frags[i];
 		unsigned int offset = skb_frag_off(f);
-		struct page *page = skb_frag_page(f) + (offset >> PAGE_SHIFT);
+		struct page *page = skb_frag_page(f);
+
+		if (WARN_ON_ONCE(!page))
+			return 1;
+
+		page += offset >> PAGE_SHIFT;
 
 		sg_set_page(&sg, page, skb_frag_size(f),
 			    offset_in_page(offset));
-- 
2.41.0.640.ga95def55d0-goog


