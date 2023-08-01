Return-Path: <netdev+bounces-23239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0089C76B668
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 15:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FBB71C20944
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8A322F08;
	Tue,  1 Aug 2023 13:55:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B408111E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 13:55:01 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5E9C3
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 06:54:59 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5704995f964so68561457b3.2
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 06:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690898099; x=1691502899;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I1tQ15/xzwCegYa0NeVsW7akJIR8Gm49zV/1+CAsCxU=;
        b=GpBHuS4KRMvhHL5HZp1B0BGFUuikBg2kpi7wTyFcTRBfXG7255Mn4ptttroyO2np9d
         D8+FYqHME1NHZO9Q+o2Je+lcUT1wcQPZhqbx8jJrn2m3S1grm8tNDI2gns76YsCXianx
         zzQ95jZjuoVE0SLNRiDrW+uuc2hprxleMvt2edJdngJdOIs5JvXSxtfLVTVvqOSFcoKr
         cBJcjG4V6CGpdWfxtHBMS6SmmTJRM3S4SGrf8BRaipnYxQmvImp7rqOP4hy3GsGoLWEg
         qm+pt90HImHq2MpTaVZ5iKUt2Yfo4vm8bZz3Pva4NaEzmOqOeUt20qSJF3SCl6q5oYx4
         vzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690898099; x=1691502899;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I1tQ15/xzwCegYa0NeVsW7akJIR8Gm49zV/1+CAsCxU=;
        b=bKl3Rpvx3A8iXC+nMr3T64pT8t1UIrf3qie/raZy6w7tECdxdz1WvbLPW5XkA/xW38
         gWRn258HDKM68NfoIFfIRxWK28PjGB/vm8x4dxrcASkYBu/MhteLfvGNiKSBGyUF9i9Y
         fzgLT9YyL/+F6ODhSpaBiWZLxCXTRH1tD6wLZrcyUlKaoMwcgmftM52OTuMZI8WumNf/
         uNzd7aEhANuOciJ6RfEtDyVGBVBOHmC7NkMoio8ltxMVqYedo+4iSDy15n59ya7NPChX
         Uecu8v20Od+CgYKE9kQxPmHzDgcqIghsYPXNdV4FquDjDSFO6dFTIV2mcZ69qTBo8oI6
         FE/g==
X-Gm-Message-State: ABy/qLbrUtiUKVp2517IEKzaWbijLZor8XDR/VTf6OBFmbh8LO1NE0n8
	s9Dq97WIWAH5hDRQCa5nfTfYp6DLCLKTKQ==
X-Google-Smtp-Source: APBJJlEDAMBBqo8l0VZ2acHjXdGix2v2oqasmtBFLRHf4+a3TiOClCiDwWO5bpPy18NyzuLWPennW8i8s38goA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:e68d:0:b0:d0f:dec4:87a0 with SMTP id
 d135-20020a25e68d000000b00d0fdec487a0mr70093ybh.2.1690898099265; Tue, 01 Aug
 2023 06:54:59 -0700 (PDT)
Date: Tue,  1 Aug 2023 13:54:52 +0000
In-Reply-To: <20230801135455.268935-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230801135455.268935-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230801135455.268935-2-edumazet@google.com>
Subject: [PATCH net-next 1/4] net: allow alloc_skb_with_frags() to allocate
 bigger packets
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Tahsin Erdogan <trdgn@amazon.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Refactor alloc_skb_with_frags() to allow bigger packets allocations.

Instead of assuming that only order-0 allocations will be attempted,
use the caller supplied max order.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Tahsin Erdogan <trdgn@amazon.com>
---
 net/core/skbuff.c | 56 +++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 31 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a298992060e6efdecb87c7ffc8290eafe330583f..0ac70a0144a7c1f4e7824ddc19980aee73e4c121 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6204,7 +6204,7 @@ EXPORT_SYMBOL_GPL(skb_mpls_dec_ttl);
  *
  * @header_len: size of linear part
  * @data_len: needed length in frags
- * @max_page_order: max page order desired.
+ * @order: max page order desired.
  * @errcode: pointer to error code if any
  * @gfp_mask: allocation mask
  *
@@ -6212,21 +6212,17 @@ EXPORT_SYMBOL_GPL(skb_mpls_dec_ttl);
  */
 struct sk_buff *alloc_skb_with_frags(unsigned long header_len,
 				     unsigned long data_len,
-				     int max_page_order,
+				     int order,
 				     int *errcode,
 				     gfp_t gfp_mask)
 {
-	int npages = (data_len + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
 	unsigned long chunk;
 	struct sk_buff *skb;
 	struct page *page;
-	int i;
+	int nr_frags = 0;
 
 	*errcode = -EMSGSIZE;
-	/* Note this test could be relaxed, if we succeed to allocate
-	 * high order pages...
-	 */
-	if (npages > MAX_SKB_FRAGS)
+	if (unlikely(data_len > MAX_SKB_FRAGS * (PAGE_SIZE << order)))
 		return NULL;
 
 	*errcode = -ENOBUFS;
@@ -6234,34 +6230,32 @@ struct sk_buff *alloc_skb_with_frags(unsigned long header_len,
 	if (!skb)
 		return NULL;
 
-	skb->truesize += npages << PAGE_SHIFT;
-
-	for (i = 0; npages > 0; i++) {
-		int order = max_page_order;
-
-		while (order) {
-			if (npages >= 1 << order) {
-				page = alloc_pages((gfp_mask & ~__GFP_DIRECT_RECLAIM) |
-						   __GFP_COMP |
-						   __GFP_NOWARN,
-						   order);
-				if (page)
-					goto fill_page;
-				/* Do not retry other high order allocations */
-				order = 1;
-				max_page_order = 0;
-			}
+	while (data_len) {
+		if (nr_frags == MAX_SKB_FRAGS - 1)
+			goto failure;
+		while (order && data_len < (PAGE_SIZE << order))
 			order--;
+
+		if (order) {
+			page = alloc_pages((gfp_mask & ~__GFP_DIRECT_RECLAIM) |
+					   __GFP_COMP |
+					   __GFP_NOWARN,
+					   order);
+			if (!page) {
+				order--;
+				continue;
+			}
+		} else {
+			page = alloc_page(gfp_mask);
+			if (!page)
+				goto failure;
 		}
-		page = alloc_page(gfp_mask);
-		if (!page)
-			goto failure;
-fill_page:
 		chunk = min_t(unsigned long, data_len,
 			      PAGE_SIZE << order);
-		skb_fill_page_desc(skb, i, page, 0, chunk);
+		skb_fill_page_desc(skb, nr_frags, page, 0, chunk);
+		nr_frags++;
+		skb->truesize += (PAGE_SIZE << order);
 		data_len -= chunk;
-		npages -= 1 << order;
 	}
 	return skb;
 
-- 
2.41.0.585.gd2178a4bd4-goog


