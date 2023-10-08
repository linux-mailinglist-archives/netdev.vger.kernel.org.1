Return-Path: <netdev+bounces-38918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEEF7BD006
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 22:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61FFF1C20B2B
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 20:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655631A5B6;
	Sun,  8 Oct 2023 20:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0zrcUJi"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5731A59A
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 20:12:52 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B632BA
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 13:12:50 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4181462ebf0so26192021cf.3
        for <netdev@vger.kernel.org>; Sun, 08 Oct 2023 13:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696795969; x=1697400769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17yqKc1kHaOMA6mN8raOlE7hraCjIklZ3SgNF0zPb1c=;
        b=j0zrcUJiK+qguZJp1HkwDxVytc50EuWIq9D428LlyEOs/kRs621icXA4fj3iJLQKSA
         L7b2fIW3d8zJMmWot4R7+aMRme2WSnXCGz8lc6+SWPNRE0Ys6bFEpW65XfFqN6/bbFkP
         3Q2vMm3ylIBNaBEf1UwTHqvCpmLu7eWVBC2PPTOJl5n/M44hzEIuzkytL3DccNQ6HRR2
         Xq13aNbXCGOmEWR21+Aod61zOeY6GzLNXgBhsY1r3Z6NDNC0qfeJLSc+92KoUzWm7vdG
         A4HclQpkAqMlpdALp7cvZQ2oyr3nonPrItpqBFQ8NhZou8N9CohlTlsu/hm5Oan/qlCo
         WH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696795969; x=1697400769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17yqKc1kHaOMA6mN8raOlE7hraCjIklZ3SgNF0zPb1c=;
        b=h7vjfdeG7zvppow+PPdlzg4XV7kY3AwFxS82RW2SQHkZfnTRsTGYP3L88cEI6Vv4eE
         1hRvf5J1ubaqk/cCkbxDl+doA44CqgSXo4C7YIBkYIVslRu+1XEyjGIDhzmP0J0mSpYb
         C++cJX7znvVYz/jS6HAiqFuLn30JemGMjva4soZ3XkLGRcoabm9u81WF5WEXNZ5dOqAr
         P63iuLO8dFubhmrwZkpfqDYP7aKsT2gmpgV+WUy5qiK7WwphcTJcJ/RYegOyJh6PBkiL
         lQ7ED8TpecaQ+M42C1gFdRBwDvCb6jF4EnDv6kxoxsmGT54kk3E/H0NUh0viQUcn8Emd
         2Kaw==
X-Gm-Message-State: AOJu0YyeSn5Ts82ciMfbqy5MzawyZoOmtKijDgfesJ6Ec1o2BpnKJhdK
	22fyvj7M5PfafBkd8n4z0IWn5CKxKZkU/A==
X-Google-Smtp-Source: AGHT+IFzMwRntua6Sj7EEjeQiR2jzYNjwGuLrAAobzJEJigzgI5Ohz9gCtsRY/P6ZWIvCNAIKWU6Bw==
X-Received: by 2002:a05:622a:1cb:b0:418:10d0:96f6 with SMTP id t11-20020a05622a01cb00b0041810d096f6mr18456834qtw.23.1696795969128;
        Sun, 08 Oct 2023 13:12:49 -0700 (PDT)
Received: from willemb.c.googlers.com.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id v18-20020ac87292000000b00419c9215f0asm3075533qto.53.2023.10.08.13.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 13:12:48 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	alexander.duyck@gmail.com,
	fw@strlen.de,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 3/3] net: expand skb_segment unit test with frag_list coverage
Date: Sun,  8 Oct 2023 16:12:34 -0400
Message-ID: <20231008201244.3700784-4-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231008201244.3700784-1-willemdebruijn.kernel@gmail.com>
References: <20231008201244.3700784-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Willem de Bruijn <willemb@google.com>

Expand the test with these variants that use skb frag_list:

- GSO_TEST_FRAG_LIST:             frag_skb length is gso_size
- GSO_TEST_FRAG_LIST_PURE:        same, data exclusively in frag skbs
- GSO_TEST_FRAG_LIST_NON_UNIFORM: frag_skb length may vary
- GSO_TEST_GSO_BY_FRAGS:          frag_skb length defines gso_size,
                                  i.e., segs may have varying sizes.

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

v1->v2
  - maintain reverse christmas tree
---
 net/core/gso_test.c | 92 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/net/core/gso_test.c b/net/core/gso_test.c
index c4e0b0832dbac..c1a6cffb6f961 100644
--- a/net/core/gso_test.c
+++ b/net/core/gso_test.c
@@ -27,6 +27,10 @@ enum gso_test_nr {
 	GSO_TEST_FRAGS,
 	GSO_TEST_FRAGS_PURE,
 	GSO_TEST_GSO_PARTIAL,
+	GSO_TEST_FRAG_LIST,
+	GSO_TEST_FRAG_LIST_PURE,
+	GSO_TEST_FRAG_LIST_NON_UNIFORM,
+	GSO_TEST_GSO_BY_FRAGS,
 };
 
 struct gso_test_case {
@@ -37,6 +41,8 @@ struct gso_test_case {
 	unsigned int linear_len;
 	unsigned int nr_frags;
 	const unsigned int *frags;
+	unsigned int nr_frag_skbs;
+	const unsigned int *frag_skbs;
 
 	/* output as expected */
 	unsigned int nr_segs;
@@ -84,6 +90,48 @@ static struct gso_test_case cases[] = {
 		.nr_segs = 2,
 		.segs = (const unsigned int[]) { 2 * gso_size, 3 },
 	},
+	{
+		/* commit 89319d3801d1: frag_list on mss boundaries */
+		.id = GSO_TEST_FRAG_LIST,
+		.name = "frag_list",
+		.linear_len = gso_size,
+		.nr_frag_skbs = 2,
+		.frag_skbs = (const unsigned int[]) { gso_size, gso_size },
+		.nr_segs = 3,
+		.segs = (const unsigned int[]) { gso_size, gso_size, gso_size },
+	},
+	{
+		.id = GSO_TEST_FRAG_LIST_PURE,
+		.name = "frag_list_pure",
+		.nr_frag_skbs = 2,
+		.frag_skbs = (const unsigned int[]) { gso_size, gso_size },
+		.nr_segs = 2,
+		.segs = (const unsigned int[]) { gso_size, gso_size },
+	},
+	{
+		/* commit 43170c4e0ba7: GRO of frag_list trains */
+		.id = GSO_TEST_FRAG_LIST_NON_UNIFORM,
+		.name = "frag_list_non_uniform",
+		.linear_len = gso_size,
+		.nr_frag_skbs = 4,
+		.frag_skbs = (const unsigned int[]) { gso_size, 1, gso_size, 2 },
+		.nr_segs = 4,
+		.segs = (const unsigned int[]) { gso_size, gso_size, gso_size, 3 },
+	},
+	{
+		/* commit 3953c46c3ac7 ("sk_buff: allow segmenting based on frag sizes") and
+		 * commit 90017accff61 ("sctp: Add GSO support")
+		 *
+		 * "there will be a cover skb with protocol headers and
+		 *  children ones containing the actual segments"
+		 */
+		.id = GSO_TEST_GSO_BY_FRAGS,
+		.name = "gso_by_frags",
+		.nr_frag_skbs = 4,
+		.frag_skbs = (const unsigned int[]) { 100, 200, 300, 400 },
+		.nr_segs = 4,
+		.segs = (const unsigned int[]) { 100, 200, 300, 400 },
+	},
 };
 
 static void gso_test_case_to_desc(struct gso_test_case *t, char *desc)
@@ -131,10 +179,54 @@ static void gso_test_func(struct kunit *test)
 		skb->truesize += skb->data_len;
 	}
 
+	if (tcase->frag_skbs) {
+		unsigned int total_size = 0, total_true_size = 0, alloc_size = 0;
+		struct sk_buff *frag_skb, *prev = NULL;
+
+		page = alloc_page(GFP_KERNEL);
+		KUNIT_ASSERT_NOT_NULL(test, page);
+		page_ref_add(page, tcase->nr_frag_skbs - 1);
+
+		for (i = 0; i < tcase->nr_frag_skbs; i++) {
+			unsigned int frag_size;
+
+			frag_size = tcase->frag_skbs[i];
+			frag_skb = build_skb(page_address(page) + alloc_size,
+					     frag_size + shinfo_size);
+			KUNIT_ASSERT_NOT_NULL(test, frag_skb);
+			__skb_put(frag_skb, frag_size);
+
+			if (prev)
+				prev->next = frag_skb;
+			else
+				skb_shinfo(skb)->frag_list = frag_skb;
+			prev = frag_skb;
+
+			total_size += frag_size;
+			total_true_size += frag_skb->truesize;
+			alloc_size += frag_size + shinfo_size;
+		}
+
+		KUNIT_ASSERT_LE(test, alloc_size, PAGE_SIZE);
+
+		skb->len += total_size;
+		skb->data_len += total_size;
+		skb->truesize += total_true_size;
+
+		if (tcase->id == GSO_TEST_GSO_BY_FRAGS)
+			skb_shinfo(skb)->gso_size = GSO_BY_FRAGS;
+	}
+
 	features = NETIF_F_SG | NETIF_F_HW_CSUM;
 	if (tcase->id == GSO_TEST_GSO_PARTIAL)
 		features |= NETIF_F_GSO_PARTIAL;
 
+	/* TODO: this should also work with SG,
+	 * rather than hit BUG_ON(i >= nfrags)
+	 */
+	if (tcase->id == GSO_TEST_FRAG_LIST_NON_UNIFORM)
+		features &= ~NETIF_F_SG;
+
 	segs = skb_segment(skb, features);
 	if (IS_ERR(segs)) {
 		KUNIT_FAIL(test, "segs error %lld", PTR_ERR(segs));
-- 
2.42.0.609.gbb76f46606-goog


