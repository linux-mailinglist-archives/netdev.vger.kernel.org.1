Return-Path: <netdev+bounces-14425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9714E7410CC
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 14:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913581C20431
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 12:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9086BBE7A;
	Wed, 28 Jun 2023 12:12:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A47BA2F
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 12:12:30 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194441BC3
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 05:12:26 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-66c729f5618so4126216b3a.1
        for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 05:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687954345; x=1690546345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lJiTry9gNlpI6gYGzYcuzGMDSalOG8oEa6qJhFK4e+s=;
        b=jpUj/FtE4VmbjxRsC2UoXs4FFp0dKAyVb7pJqFEBrMUMOHSzqXe8Xof+z7TnMQy5z5
         bcqLa0RkJQsIIS2E1tHA2tsw5x52SaiFpIWxxM+GCuzpd52Wj4Lhg5pxj9cLPMhgAMct
         e9eo8ewEgHgptCdPoQEFbWKLeZWTj/VRIGghvQCPbnIxzNV78GVmvIMOvi54OB8PAnIX
         UsscJACFIdKixqMyeAO3WeUOdN3GttDWy4PYIIi4RaH4nZ7Q2iZysZn162H8XMsQs0jO
         63ODN91FTsScyiXK+iAg/x9TRKruTz4+4YlcP6PwibAIpkU9MnpxVecn4bpe6sWMcO5R
         /UlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687954345; x=1690546345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lJiTry9gNlpI6gYGzYcuzGMDSalOG8oEa6qJhFK4e+s=;
        b=UzOIpWbxkZGYNTof9ife4y26/jfpp6BSdapjMbHJZtUV1XUJIaIj5/OJMB4wsI0E1T
         cpRq4w/MF2xGruajGrP4mVYyKqMPku4GtyREvdmG7GIeTgQwzQXJegl2ZwRFkNf6AKwh
         Fv0NSp+6Ce4h0VGpXRZW87ownsI3wqh41+X8AvQdFUMJrIMGqklVbtShNXq+6BPTx8Kd
         Mz9gOqc3/nmZzPZJKD+aiJvD7GFOVwxFZeAcBMGsTXvAqn6Qn5fbwCKSpNl0cUgnyC2Y
         XY8mG5CBRBAJMCb5SM6fPIvIlUjwWJ9yP5vK34KF/Qjuaw7kzCTkBN6AysjQ2JRcXu82
         cJjw==
X-Gm-Message-State: AC+VfDxcvxNG05ekCy51B+cwy8o3s7TaPsB3EBm+zKIZr/OKlAd2+ciZ
	AeOjTqacQezTnQYRSFSRFJQ=
X-Google-Smtp-Source: ACHHUZ7NEmoXvPQ8tdQt/vPaJn7ElJ2AXcISVoLt691fou4+sGQ1hfqiEF6rtVxOEFZefCeAyXn+pA==
X-Received: by 2002:a05:6a00:3a0a:b0:657:bdf1:cce1 with SMTP id fj10-20020a056a003a0a00b00657bdf1cce1mr45700790pfb.25.1687954345476;
        Wed, 28 Jun 2023 05:12:25 -0700 (PDT)
Received: from localhost.localdomain ([38.145.203.66])
        by smtp.gmail.com with ESMTPSA id i3-20020aa787c3000000b006666699be98sm4926733pfo.34.2023.06.28.05.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 05:12:24 -0700 (PDT)
From: Liang Chen <liangchen.linux@gmail.com>
To: ilias.apalodimas@linaro.org,
	hawk@kernel.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linyunsheng@huawei.com,
	netdev@vger.kernel.org,
	liangchen.linux@gmail.com
Subject: [PATCH net-next] skbuff: Optimize SKB coalescing for page pool case
Date: Wed, 28 Jun 2023 20:11:50 +0800
Message-Id: <20230628121150.47778-1-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In order to address the issues encountered with commit 1effe8ca4e34
("skbuff: fix coalescing for page_pool fragment recycling"), the
combination of the following condition was excluded from skb coalescing:

from->pp_recycle = 1
from->cloned = 1
to->pp_recycle = 1

However, with page pool environments, the aforementioned combination can
be quite common. In scenarios with a higher number of small packets, it
can significantly affect the success rate of coalescing. For example,
when considering packets of 256 bytes size, our comparison of coalescing
success rate is as follows:

Without page pool: 70%
With page pool: 13%

Consequently, this has an impact on performance:

Without page pool: 2.64 Gbits/sec
With page pool: 2.41 Gbits/sec

Therefore, it seems worthwhile to optimize this scenario and enable
coalescing of this particular combination. To achieve this, we need to
ensure the correct increment of the "from" SKB page's page pool fragment
count (pp_frag_count).

Following this optimization, the success rate of coalescing measured in our
environment has improved as follows:

With page pool: 60%

This success rate is approaching the rate achieved without using page pool,
and the performance has also been improved:

With page pool: 2.61 Gbits/sec

Below is the performance comparison for small packets before and after this
optimization. We observe no impact to packets larger than 4K.

without page pool fragment(PP_FLAG_PAGE_FRAG)
packet size     before      after
(bytes)         (Gbits/sec) (Gbits/sec)
128             1.28        1.37
256             2.41        2.61
512             4.56        4.87
1024            7.69        8.21
2048            12.85       13.41

with page pool fragment(PP_FLAG_PAGE_FRAG)
packet size     before      after
(bytes)         (Gbits/sec) (Gbits/sec)
128             1.28        1.37
256             2.35        2.62
512             4.37        4.86
1024            7.62        8.41
2048            13.07       13.53

with page pool fragment(PP_FLAG_PAGE_FRAG) and high order(order = 3)
packet size     before      after
(bytes)         (Gbits/sec) (Gbits/sec)
128             1.28        1.41
256             2.41        2.74
512             4.57        5.25
1024            8.61        9.71
2048            14.81       16.78

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
---
 include/net/page_pool.h | 21 +++++++++++++++++++++
 net/core/skbuff.c       | 11 +++++++----
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index 126f9e294389..05e5d8ead63b 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -399,4 +399,25 @@ static inline void page_pool_nid_changed(struct page_pool *pool, int new_nid)
 		page_pool_update_nid(pool, new_nid);
 }
 
+static inline bool page_pool_is_pp_page(struct page *page)
+{
+	return (page->pp_magic & ~0x3UL) == PP_SIGNATURE;
+}
+
+static inline bool page_pool_is_pp_page_frag(struct page *page)
+{
+	return !!(page->pp->p.flags & PP_FLAG_PAGE_FRAG);
+}
+
+static inline void page_pool_page_ref(struct page *page)
+{
+	struct page *head_page = compound_head(page);
+
+	if (page_pool_is_pp_page(head_page) &&
+			page_pool_is_pp_page_frag(head_page))
+		atomic_long_inc(&head_page->pp_frag_count);
+	else
+		get_page(head_page);
+}
+
 #endif /* _NET_PAGE_POOL_H */
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6c5915efbc17..9806b091f0f6 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5666,8 +5666,7 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 	 * !@to->pp_recycle but its tricky (due to potential race with
 	 * the clone disappearing) and rare, so not worth dealing with.
 	 */
-	if (to->pp_recycle != from->pp_recycle ||
-	    (from->pp_recycle && skb_cloned(from)))
+	if (to->pp_recycle != from->pp_recycle)
 		return false;
 
 	if (len <= skb_tailroom(to)) {
@@ -5724,8 +5723,12 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 	/* if the skb is not cloned this does nothing
 	 * since we set nr_frags to 0.
 	 */
-	for (i = 0; i < from_shinfo->nr_frags; i++)
-		__skb_frag_ref(&from_shinfo->frags[i]);
+	if (from->pp_recycle)
+		for (i = 0; i < from_shinfo->nr_frags; i++)
+			page_pool_page_ref(skb_frag_page(&from_shinfo->frags[i]));
+	else
+		for (i = 0; i < from_shinfo->nr_frags; i++)
+			__skb_frag_ref(&from_shinfo->frags[i]);
 
 	to->truesize += delta;
 	to->len += len;
-- 
2.31.1


