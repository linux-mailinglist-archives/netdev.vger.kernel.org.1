Return-Path: <netdev+bounces-39143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E607BE337
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 16:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A341B1C20D13
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 14:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E991C171DC;
	Mon,  9 Oct 2023 14:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXHwO76b"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1E919BD3
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 14:42:14 +0000 (UTC)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978EEB4
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 07:42:11 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-775810b032aso314374185a.1
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 07:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696862531; x=1697467331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2CneznQ/yZkm1+ntbZ8O9t3a7G8zboj4AqLfjJjUSw=;
        b=QXHwO76b+6LPUUYvEmtvFktUqiKRN+0nCn1RuYLWqnl0TAsCdlZR/Kh2TOJJQ7j/kW
         8JJQzTMzRA6Acv0sprJBi9+Kqd0w/4/SazYKXKYs62cpqLGe3TFzkivIBS2vO2OGuEBC
         1YvHVEOWTTwP0phQvIkw9qpHGeKhTHJ+vyHitWccQZwGeymi1TYUZDeSZPZ7zpMEXlaU
         ffASE2zIeMCb7UfEtptqSSg+Fk1gxa3RHDUTfwwd2rm/uD4ykJUcmYY7pIHi8Bo2UNPh
         /mvvdwGWSSbjdtZCRQnxwcM04ztkTACbttJLAu65luozHXLtsUgGFkNPgfoDLqjvmLOa
         o/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696862531; x=1697467331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2CneznQ/yZkm1+ntbZ8O9t3a7G8zboj4AqLfjJjUSw=;
        b=phNjYQuZHWo9/2aDxd+USBDuNirLabwJ+/7nKw+ykAiflZLCriGP36WfAwXo6vc05H
         LnAaHxBtDv1A+5sqnDYyEdKT6jZLICPSAXE/E++/dUGp6WWN64hPUSJehS7MiZnXCldl
         bnwMbxEXM2nUke4DGOfslz+rsx8EkeivoGRkyxab0AnGU6jwvE43PQxWtnptzWjvzsQV
         jiOO93kBUqM4wfu/bA07Xs/sNYAK/lF1hDzprS3272TK4aLHQO2Mc0C3zDhPdCCio8oK
         jp3jhazIF2VA2LQ59lJ/RzPlfBzNPIYFDAyCyxPmy5yyY2gpMBh+z0VFhzmlVmvT4NJw
         Fc8w==
X-Gm-Message-State: AOJu0YwUZ7Ra1bnCOLM5Im5qy/Lym9MJYI1e6xu3ZERPBW467MK+lZcO
	kI55SQuVANXh+8GPW5CkKpLVeRchUW/ASQ==
X-Google-Smtp-Source: AGHT+IHMv/9KK7CaKX2T5IlEL4/xTIZ9Uw18aSt772hRMhGepLp9MlpNJs6TkDlguJanoI3d5Ds8mw==
X-Received: by 2002:a0c:e48f:0:b0:656:5535:ef27 with SMTP id n15-20020a0ce48f000000b006565535ef27mr17197601qvl.48.1696862530715;
        Mon, 09 Oct 2023 07:42:10 -0700 (PDT)
Received: from willemb.c.googlers.com.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id i1-20020a0cf381000000b0064f43efc844sm3873592qvk.32.2023.10.09.07.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 07:42:10 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	alexander.duyck@gmail.com,
	fw@strlen.de,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v3 3/3] net: expand skb_segment unit test with frag_list coverage
Date: Mon,  9 Oct 2023 10:41:53 -0400
Message-ID: <20231009144205.269931-4-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231009144205.269931-1-willemdebruijn.kernel@gmail.com>
References: <20231009144205.269931-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
Reviewed-by: Florian Westphal <fw@strlen.de>
---

v2->v3
  - add Florian's Reviewed-by based on v1.
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


