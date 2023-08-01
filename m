Return-Path: <netdev+bounces-23418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EBD76BECF
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 22:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721A0280E1D
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 20:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7345F263BC;
	Tue,  1 Aug 2023 20:53:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8CB4DC77
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 20:53:00 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24E91BFD
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 13:52:58 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-583c49018c6so69204537b3.0
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 13:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690923178; x=1691527978;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=knjH3hE9RM/cd1e1s/UhRNIqpna9dMY5bIcjVhgAKQU=;
        b=1xgoi5I6SS5DmKdtDpx7IXvdXtij33JnKww4xO8r/ZGtcOFYqtC78HYg04evLPaMAS
         hoMv/cfvhho1QvyPycvzPnfXeear1Mw4iTwENmSqxV1MdNdg0+c0yhiLzPFwCk/6XjHi
         YZEhUm1IUYC5JZVQGB9TwLjpfT2FUf0Nqa5oOuHLkWcA8cQJdYyS3AbmxAdmsKOWRDSr
         EdqXpIvswXx4IVcI6WCrfqEuloOeHUf87iGZ0q8xZ/AncG8rJFjo4CxhvLte1vH7VZPi
         fdWm5OtqMJFOtl9+qQr4NYSU68UM3zmJgz4eg9nnsGjByUJ8FiNq3XSOO4YCK7snSEMi
         vzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690923178; x=1691527978;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=knjH3hE9RM/cd1e1s/UhRNIqpna9dMY5bIcjVhgAKQU=;
        b=gl7ZfR6W/dlkAxUiR/69cS8z9MbAqPWX10De5KYbcF5CusKW10Si98nZ/+efxWlmcH
         qtoNxbW8lS8J7+Cg4Kty1D57SswnRnDS8ip9rI9o04PMdsz2S1Kqfo0E/lBrTxn/V9ZT
         duDZ0JQa+4pSqqB+g74ZHNCZNqZ6t3w+sHJnlPG1bEqQpNsnPXKRfX6Y9lLjRbRpQXsB
         LRYePd3eqXNBj3iTV8wikD8L5oUrdCviE5sMDp4gs3wZZIpz69B5fU0CKYRDRRtSyGHF
         5kUKp78S4pvcEyqWMijBeAFw+fMgMTz6Ln5o8bdiV+QwCXDIo+siadZw3e4LuPYfjUqT
         PSeA==
X-Gm-Message-State: ABy/qLbEbkg5PH/HtGREmunSz3LKBoUUsljxlR7f8vzbopNkw40W+6lO
	uGktsWWGQjZG4RJYWeg8HUPYEyDRXaRqmg==
X-Google-Smtp-Source: APBJJlHLu5OPjWHYzXEUn3ad9sNTDOCskUKW2PheaDnXF+HRpCayiEkQBtvNZ5+OX9OGAxRJtdhy3KS7YDtkFw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:ac0e:0:b0:577:617b:f881 with SMTP id
 k14-20020a81ac0e000000b00577617bf881mr107738ywh.8.1690923178232; Tue, 01 Aug
 2023 13:52:58 -0700 (PDT)
Date: Tue,  1 Aug 2023 20:52:51 +0000
In-Reply-To: <20230801205254.400094-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230801205254.400094-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230801205254.400094-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/4] net: allow alloc_skb_with_frags() to allocate
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

v2: try harder to use high-order pages, per Willem feedback.

Link: https://lore.kernel.org/netdev/CANn89iJQfmc_KeUr3TeXvsLQwo3ZymyoCr7Y6AnHrkWSuz0yAg@mail.gmail.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Tahsin Erdogan <trdgn@amazon.com>
---
 net/core/skbuff.c | 56 +++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 31 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a298992060e6efdecb87c7ffc8290eafe330583f..c6f98245582cd4dd01a7c4f5708163122500a4f0 100644
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
+		while (order && PAGE_ALIGN(data_len) < (PAGE_SIZE << order))
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


