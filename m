Return-Path: <netdev+bounces-38919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C17FD7BD007
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 22:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C701C20A3C
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 20:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E131A5BA;
	Sun,  8 Oct 2023 20:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fl2mfED1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75E31A59B
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 20:12:52 +0000 (UTC)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C58B6
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 13:12:49 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-7742da399a2so264989985a.0
        for <netdev@vger.kernel.org>; Sun, 08 Oct 2023 13:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696795968; x=1697400768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSWNewQqlaIQyWDI9hrczm+cy6FgsRoLMTzAic6qvbE=;
        b=fl2mfED1N+xk57Rka4OQi2pPaSoe84Qy0gG8WyzhxIlHfbz0B1gTMOq0niq6PoyA7P
         eiWC71RwGoBRa+0dIjMNbdJPtI8wRpbi0pP76TIonCvcs/qGofuatoyfbE5STZS7eyVr
         hGIGGpHXvv58ceSdKBywwAcUVbFaABe4YT1psd20lzXOMdhD2qV0ghdxBxREDYVAgdtF
         lBBOmLPoMVbiiuqmQI448nJmGpxmEao683FwJQ1x9z6LzirOE1PviiuD9LkS7mldJst6
         FZvhC3NPaNPoxX1tvT0O/JGoAy9Hhklvgr4vlbIB4jMG07DD+0I+KB8VYFK/UHhsiCe4
         FEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696795968; x=1697400768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSWNewQqlaIQyWDI9hrczm+cy6FgsRoLMTzAic6qvbE=;
        b=iocVcgVN5w+UJ9JSFjLn4fNr88Y9xv+OMCFid7aKHXyT5KP4wk022SVDH7AqurnYc+
         PfIAmKgUp3RZSNv1u8/UKndR4hpU6fMzkMlrU2Z4GXR+5Aay324EZLfc58pdK6vy4w5B
         9ugMIGTyE2YcXkMGHuPOWs6tLqzf0SMTRnFQVwATwE4oXECaDHGja5mc+PcdIIkifOYh
         zCe0QHGMCkkOKOE+hPJm65jr9rCe/4I4Vh1rXnRUdbdfQYH/gkQtbwQp9nZYqr7qyR/W
         eB8FQGnlpF4UfAAqeewTPDlDylEpIrHYdIonYXgdLLx5bNKXNmLnlcxbBvmFbXQiurrv
         6kYw==
X-Gm-Message-State: AOJu0YyimSKgKT8W2nRmlL6+2L3KIlbLHumkuxyY0g8j6cu835GVp/+5
	zwSR9YaRl+s1NJ/5EUWhZfiAC8xrRb5UQg==
X-Google-Smtp-Source: AGHT+IFHy9eUlWfG/7QtSRnZ00C79CtPuMap2tocjK9ndMR2kelO+ZznXK8aeC6TRKxIfRa1PKvnuQ==
X-Received: by 2002:a05:622a:647:b0:418:12d4:c096 with SMTP id a7-20020a05622a064700b0041812d4c096mr17986455qtb.2.1696795968664;
        Sun, 08 Oct 2023 13:12:48 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/3] net: parametrize skb_segment unit test to expand coverage
Date: Sun,  8 Oct 2023 16:12:33 -0400
Message-ID: <20231008201244.3700784-3-willemdebruijn.kernel@gmail.com>
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

Expand the test with variants

- GSO_TEST_NO_GSO:      payload size less than or equal to gso_size
- GSO_TEST_FRAGS:       payload in both linear and page frags
- GSO_TEST_FRAGS_PURE:  payload exclusively in page frags
- GSO_TEST_GSO_PARTIAL: produce one gso segment of multiple of gso_size,
                        plus optionally one non-gso trailer segment

Define a test struct that encodes the input gso skb and output segs.
Input in terms of linear and fragment lengths. Output as length of
each segment.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 net/core/gso_test.c | 129 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 112 insertions(+), 17 deletions(-)

diff --git a/net/core/gso_test.c b/net/core/gso_test.c
index eaa85939ed208..c4e0b0832dbac 100644
--- a/net/core/gso_test.c
+++ b/net/core/gso_test.c
@@ -4,10 +4,7 @@
 #include <linux/skbuff.h>
 
 static const char hdr[] = "abcdefgh";
-static const int gso_size = 1000, last_seg_size = 1;
-
-/* default: create 3 segment gso packet */
-static const int payload_len = (2 * gso_size) + last_seg_size;
+static const int gso_size = 1000;
 
 static void __init_skb(struct sk_buff *skb)
 {
@@ -24,21 +21,121 @@ static void __init_skb(struct sk_buff *skb)
 	skb_shinfo(skb)->gso_size = gso_size;
 }
 
+enum gso_test_nr {
+	GSO_TEST_LINEAR,
+	GSO_TEST_NO_GSO,
+	GSO_TEST_FRAGS,
+	GSO_TEST_FRAGS_PURE,
+	GSO_TEST_GSO_PARTIAL,
+};
+
+struct gso_test_case {
+	enum gso_test_nr id;
+	const char *name;
+
+	/* input */
+	unsigned int linear_len;
+	unsigned int nr_frags;
+	const unsigned int *frags;
+
+	/* output as expected */
+	unsigned int nr_segs;
+	const unsigned int *segs;
+};
+
+static struct gso_test_case cases[] = {
+	{
+		.id = GSO_TEST_NO_GSO,
+		.name = "no_gso",
+		.linear_len = gso_size,
+		.nr_segs = 1,
+		.segs = (const unsigned int[]) { gso_size },
+	},
+	{
+		.id = GSO_TEST_LINEAR,
+		.name = "linear",
+		.linear_len = gso_size + gso_size + 1,
+		.nr_segs = 3,
+		.segs = (const unsigned int[]) { gso_size, gso_size, 1 },
+	},
+	{
+		.id = GSO_TEST_FRAGS,
+		.name = "frags",
+		.linear_len = gso_size,
+		.nr_frags = 2,
+		.frags = (const unsigned int[]) { gso_size, 1 },
+		.nr_segs = 3,
+		.segs = (const unsigned int[]) { gso_size, gso_size, 1 },
+	},
+	{
+		.id = GSO_TEST_FRAGS_PURE,
+		.name = "frags_pure",
+		.nr_frags = 3,
+		.frags = (const unsigned int[]) { gso_size, gso_size, 2 },
+		.nr_segs = 3,
+		.segs = (const unsigned int[]) { gso_size, gso_size, 2 },
+	},
+	{
+		.id = GSO_TEST_GSO_PARTIAL,
+		.name = "gso_partial",
+		.linear_len = gso_size,
+		.nr_frags = 2,
+		.frags = (const unsigned int[]) { gso_size, 3 },
+		.nr_segs = 2,
+		.segs = (const unsigned int[]) { 2 * gso_size, 3 },
+	},
+};
+
+static void gso_test_case_to_desc(struct gso_test_case *t, char *desc)
+{
+	sprintf(desc, "%s", t->name);
+}
+
+KUNIT_ARRAY_PARAM(gso_test, cases, gso_test_case_to_desc);
+
 static void gso_test_func(struct kunit *test)
 {
 	const int shinfo_size = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	const struct gso_test_case *tcase;
 	struct sk_buff *skb, *segs, *cur;
+	netdev_features_t features;
 	struct page *page;
+	int i;
+
+	tcase = test->param_value;
 
 	page = alloc_page(GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, page);
-	skb = build_skb(page_address(page), sizeof(hdr) + payload_len + shinfo_size);
+	skb = build_skb(page_address(page), sizeof(hdr) + tcase->linear_len + shinfo_size);
 	KUNIT_ASSERT_NOT_NULL(test, skb);
-	__skb_put(skb, sizeof(hdr) + payload_len);
+	__skb_put(skb, sizeof(hdr) + tcase->linear_len);
 
 	__init_skb(skb);
 
-	segs = skb_segment(skb, NETIF_F_SG | NETIF_F_HW_CSUM);
+	if (tcase->nr_frags) {
+		unsigned int pg_off = 0;
+
+		page = alloc_page(GFP_KERNEL);
+		KUNIT_ASSERT_NOT_NULL(test, page);
+		page_ref_add(page, tcase->nr_frags - 1);
+
+		for (i = 0; i < tcase->nr_frags; i++) {
+			skb_fill_page_desc(skb, i, page, pg_off, tcase->frags[i]);
+			pg_off += tcase->frags[i];
+		}
+
+		KUNIT_ASSERT_LE(test, pg_off, PAGE_SIZE);
+
+		skb->data_len = pg_off;
+		skb->len += skb->data_len;
+		skb->truesize += skb->data_len;
+	}
+
+	features = NETIF_F_SG | NETIF_F_HW_CSUM;
+	if (tcase->id == GSO_TEST_GSO_PARTIAL)
+		features |= NETIF_F_GSO_PARTIAL;
+
+	segs = skb_segment(skb, features);
 	if (IS_ERR(segs)) {
 		KUNIT_FAIL(test, "segs error %lld", PTR_ERR(segs));
 		goto free_gso_skb;
@@ -47,7 +144,9 @@ static void gso_test_func(struct kunit *test)
 		goto free_gso_skb;
 	}
 
-	for (cur = segs; cur; cur = cur->next) {
+	for (cur = segs, i = 0; cur; cur = cur->next, i++) {
+		KUNIT_ASSERT_EQ(test, cur->len, sizeof(hdr) + tcase->segs[i]);
+
 		/* segs have skb->data pointing to the mac header */
 		KUNIT_ASSERT_PTR_EQ(test, skb_mac_header(cur), cur->data);
 		KUNIT_ASSERT_PTR_EQ(test, skb_network_header(cur), cur->data + sizeof(hdr));
@@ -55,24 +154,20 @@ static void gso_test_func(struct kunit *test)
 		/* header was copied to all segs */
 		KUNIT_ASSERT_EQ(test, memcmp(skb_mac_header(cur), hdr, sizeof(hdr)), 0);
 
-		/* all segs are gso_size, except for last */
-		if (cur->next) {
-			KUNIT_ASSERT_EQ(test, cur->len, sizeof(hdr) + gso_size);
-		} else {
-			KUNIT_ASSERT_EQ(test, cur->len, sizeof(hdr) + last_seg_size);
-
-			/* last seg can be found through segs->prev pointer */
+		/* last seg can be found through segs->prev pointer */
+		if (!cur->next)
 			KUNIT_ASSERT_PTR_EQ(test, cur, segs->prev);
-		}
 	}
 
+	KUNIT_ASSERT_EQ(test, i, tcase->nr_segs);
+
 	consume_skb(segs);
 free_gso_skb:
 	consume_skb(skb);
 }
 
 static struct kunit_case gso_test_cases[] = {
-	KUNIT_CASE(gso_test_func),
+	KUNIT_CASE_PARAM(gso_test_func, gso_test_gen_params),
 	{}
 };
 
-- 
2.42.0.609.gbb76f46606-goog


