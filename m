Return-Path: <netdev+bounces-46131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99457E18DB
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 03:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C81A2812EA
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 02:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D8D6103;
	Mon,  6 Nov 2023 02:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QGXMY136"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74CE15BF
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 02:44:38 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0F7D7B
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 18:44:37 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7af53bde4so54119157b3.0
        for <netdev@vger.kernel.org>; Sun, 05 Nov 2023 18:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699238676; x=1699843476; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bbXy+8EI8/reBuw9EZooMZJzNkS3vxkh8+4Xq7ifx6w=;
        b=QGXMY136SJv8X/CLUqR1CFMrKd0RapdsEmr1qELFYNhEOgXjCagvWEVmBcmV7ofhrR
         KHCu3F+bneF1FArMXc0ACK4cwILfBYi0KP0SWDvQhOuQc3mcsxdASuD3Sq20PRDTQ2dR
         ByZLXG6Cubc25v9QZC0LVUV7xQKT81kml329mEvib+zbkNSpKA23zdIafExJiVFwV9uB
         GqG+hLcxdipbKBRfcQr82h2ep2/HsiV/oB0C/4l6KH9XSf1nxiA4ep4kGEd6P4cM9xYx
         yEAdXko1q+gfSSZpKJr0PWSgIhEewWbB+zsy5iBoMUANzILRzEGyVtaOweVlUcpy96lC
         qWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699238676; x=1699843476;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bbXy+8EI8/reBuw9EZooMZJzNkS3vxkh8+4Xq7ifx6w=;
        b=k3esyqVmuSDdH+exVnSzqOT9pNlGxDgw8y0yFrE4VTTP1qQGClUna9zfnzVFqu6WRg
         THMebIGk7XKi19+mr8mVxUYTv53u7D6qg4peUGAUwFHBYt2pMrGim7QTJv2TwpgzdS7b
         w89Pl5kqbyNy9vh42Nv3vfSEs7WCBTuU/eiis5A9uL1tiC8UfflX/iFiDXBZb51jGT3Q
         AUK8wmQOXUNhLrMSWnl7HnWPI4gYqQH2m7WbzJWy3tnv47dVT7qzGcPJA3T1axhUTnrL
         nOtnKkVwUzZ/NwgidZbrInlPBe9TFz46ajIslzltxp6zYxt2B/QI1viSC7ucEyx/fI6Q
         ks2g==
X-Gm-Message-State: AOJu0Yw8QPYI7oMKSWhW42XALK3lMVRuHtcewoTNgeaCF4E0j2iYd20J
	TBx1VlWPf2RkhbSCsXOunpB5ri5JTiL1zs77agZY4uRC2TwEZ76Bz8/Wq4CTNSM9sNdjIcddyFY
	ZildFDKU6PO5nEri5ghdAUV50mL5TxlM1WGDsa3BRhHcoDyKzj6tvf09Us5k5bXGBpXTCj/6b3W
	E=
X-Google-Smtp-Source: AGHT+IGWdWv+ANGYqQyzA2UyXJhi775o4ifiKnH6NXK6tcVAsYvHc+4YYt6Jkb55wfo8xTcaVhvPEUirYwS2JNQH1Q==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:35de:fff:97b7:db3e])
 (user=almasrymina job=sendgmr) by 2002:a81:92ce:0:b0:59e:ee51:52a1 with SMTP
 id j197-20020a8192ce000000b0059eee5152a1mr195351ywg.10.1699238675828; Sun, 05
 Nov 2023 18:44:35 -0800 (PST)
Date: Sun,  5 Nov 2023 18:44:07 -0800
In-Reply-To: <20231106024413.2801438-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231106024413.2801438-9-almasrymina@google.com>
Subject: [RFC PATCH v3 08/12] net: support non paged skb frags
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

Make skb_frag_page() fail in the case where the frag is not backed
by a page, and fix its relevent callers to handle this case.

Correctly handle skb_frag refcounting in the page_pool_iovs case.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 include/linux/skbuff.h | 42 +++++++++++++++++++++++++++++++++++-------
 net/core/gro.c         |  2 +-
 net/core/skbuff.c      |  3 +++
 net/ipv4/tcp.c         | 10 +++++++++-
 4 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 97bfef071255..1fae276c1353 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -37,6 +37,8 @@
 #endif
 #include <net/net_debug.h>
 #include <net/dropreason-core.h>
+#include <net/page_pool/types.h>
+#include <net/page_pool/helpers.h>
 
 /**
  * DOC: skb checksums
@@ -3402,15 +3404,38 @@ static inline void skb_frag_off_copy(skb_frag_t *fragto,
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
@@ -3421,7 +3446,7 @@ static inline struct page *skb_frag_page(const skb_frag_t *frag)
  */
 static inline void __skb_frag_ref(skb_frag_t *frag)
 {
-	get_page(skb_frag_page(frag));
+	page_pool_page_get_many(frag->bv_page, 1);
 }
 
 /**
@@ -3441,13 +3466,13 @@ bool napi_pp_put_page(struct page *page, bool napi_safe);
 static inline void
 napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
 {
-	struct page *page = skb_frag_page(frag);
-
 #ifdef CONFIG_PAGE_POOL
-	if (recycle && napi_pp_put_page(page, napi_safe))
+	if (recycle && napi_pp_put_page(frag->bv_page, napi_safe))
 		return;
+	page_pool_page_put_many(frag->bv_page, 1);
+#else
+	put_page(skb_frag_page(frag));
 #endif
-	put_page(page);
 }
 
 /**
@@ -3487,6 +3512,9 @@ static inline void skb_frag_unref(struct sk_buff *skb, int f)
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
index c52ddd6891d9..13eca4fd25e1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2994,6 +2994,9 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
 	for (seg = 0; seg < skb_shinfo(skb)->nr_frags; seg++) {
 		const skb_frag_t *f = &skb_shinfo(skb)->frags[seg];
 
+		if (WARN_ON_ONCE(!skb_frag_page(f)))
+			return false;
+
 		if (__splice_segment(skb_frag_page(f),
 				     skb_frag_off(f), skb_frag_size(f),
 				     offset, len, spd, false, sk, pipe))
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a86d8200a1e8..23b29dc49271 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2155,6 +2155,9 @@ static int tcp_zerocopy_receive(struct sock *sk,
 			break;
 		}
 		page = skb_frag_page(frags);
+		if (WARN_ON_ONCE(!page))
+			break;
+
 		prefetchw(page);
 		pages[pages_to_map++] = page;
 		length += PAGE_SIZE;
@@ -4411,7 +4414,12 @@ int tcp_md5_hash_skb_data(struct tcp_md5sig_pool *hp,
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
2.42.0.869.gea05f2083d-goog


