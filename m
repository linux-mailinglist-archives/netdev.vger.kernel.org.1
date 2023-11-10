Return-Path: <netdev+bounces-47119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1897E7D77
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 16:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFEEAB20BAC
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 15:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC62A1CA89;
	Fri, 10 Nov 2023 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwxR4mnX"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5971CA83
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 15:36:36 +0000 (UTC)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4499A3AE23
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 07:36:35 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-77891c236fcso140568185a.3
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 07:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699630594; x=1700235394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dmcoxY6SSqGPaF0Dga3rcxKS15grctp8lJRPODJHZKg=;
        b=hwxR4mnX6utH3QB6wWNO2vRbX5cLxnfkS9rASv3whcCqa9CXeuQxi8tdY5hF8Mc8dv
         bOknGABWieyAO6YoA3CXk1Of/NZDtbnAlUuBFJTtuHASiOyp4vV3f8VkB8LYQUlgqAa2
         65Y3NW0g8wl5z2vzmd92mdZ7cd3xKx6HhBnXnse0z7ACjz538a73qNn5U8pr7+lONKCs
         JUllkDga1dn+u+zTs8Ebai4PhkOzfx/HMduKnxBtOYiPArCCzS+UtDD1C86QRWjPj0Nj
         FZs4voDuXjOAiKnTwcnImQzVHkmXRdG3CJHuZAtQSNLtUPv80aBTLHUKrm17ltllJACC
         QbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699630594; x=1700235394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dmcoxY6SSqGPaF0Dga3rcxKS15grctp8lJRPODJHZKg=;
        b=rt/B06u16qjnw3U/mTMUIZ1af3aBTfDmn+RIz6IaVLJFfHIcNFLUOf0gGoxgtPQ5yS
         0KIelBP0RjFJWKS2qGFEfG6KFNRKHbqepDdp6e2yffuuR2pPphdg2BRoFJql6Qg6Kju8
         2RA3DvgmjhHpBbtTjEi+4wJqlqbDJOnVITREhyokV/A+0W4ZFxV3zBG9M6a+hyRJbAjx
         EbO+FuTgzRWT5i0fj87YFOgKYVA/9ERdVbae1hS+xFC33I+q/EGIMa8DC1BrU6vXEKGc
         9eomH9jgGL3Om/N/+alJv+nHzz4eys4RyIhqQFhb30eD91ChQBuGNUcmmvSU1nZK1WeG
         pIgg==
X-Gm-Message-State: AOJu0YwjfPMCziOpvS75Xwn+wxiplJRUWybhFZqMfpMg2bhFW6enZrWG
	fwjkG3Yb744BzdvN2phhIhcNE42RNso=
X-Google-Smtp-Source: AGHT+IGCS0dxZOXUmDPgwL8USAlWtxtKW2n9KGGn4QZUSg3xdAVZFKE438hNjIJrHt33o+3eOTeemA==
X-Received: by 2002:ad4:5c66:0:b0:659:e547:ca72 with SMTP id i6-20020ad45c66000000b00659e547ca72mr9979914qvh.40.1699630594007;
        Fri, 10 Nov 2023 07:36:34 -0800 (PST)
Received: from willemb.c.googlers.com.com (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id v17-20020a05620a091100b0077731466526sm759525qkv.70.2023.11.10.07.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 07:36:33 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net] net: gso_test: support CONFIG_MAX_SKB_FRAGS up to 45
Date: Fri, 10 Nov 2023 10:36:00 -0500
Message-ID: <20231110153630.161171-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

The test allocs a single page to hold all the frag_list skbs. This
is insufficient on kernels with CONFIG_MAX_SKB_FRAGS=45, due to the
increased skb_shared_info frags[] array length.

        gso_test_func: ASSERTION FAILED at net/core/gso_test.c:210
        Expected alloc_size <= ((1UL) << 12), but
            alloc_size == 5075 (0x13d3)
            ((1UL) << 12) == 4096 (0x1000)

Simplify the logic. Just allocate a page for each frag_list skb.

Fixes: 4688ecb1385f ("net: expand skb_segment unit test with frag_list coverage")
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 net/core/gso_test.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/net/core/gso_test.c b/net/core/gso_test.c
index ceb684be4cbf..4c2e77bd12f4 100644
--- a/net/core/gso_test.c
+++ b/net/core/gso_test.c
@@ -180,18 +180,17 @@ static void gso_test_func(struct kunit *test)
 	}
 
 	if (tcase->frag_skbs) {
-		unsigned int total_size = 0, total_true_size = 0, alloc_size = 0;
+		unsigned int total_size = 0, total_true_size = 0;
 		struct sk_buff *frag_skb, *prev = NULL;
 
-		page = alloc_page(GFP_KERNEL);
-		KUNIT_ASSERT_NOT_NULL(test, page);
-		page_ref_add(page, tcase->nr_frag_skbs - 1);
-
 		for (i = 0; i < tcase->nr_frag_skbs; i++) {
 			unsigned int frag_size;
 
+			page = alloc_page(GFP_KERNEL);
+			KUNIT_ASSERT_NOT_NULL(test, page);
+
 			frag_size = tcase->frag_skbs[i];
-			frag_skb = build_skb(page_address(page) + alloc_size,
+			frag_skb = build_skb(page_address(page),
 					     frag_size + shinfo_size);
 			KUNIT_ASSERT_NOT_NULL(test, frag_skb);
 			__skb_put(frag_skb, frag_size);
@@ -204,11 +203,8 @@ static void gso_test_func(struct kunit *test)
 
 			total_size += frag_size;
 			total_true_size += frag_skb->truesize;
-			alloc_size += frag_size + shinfo_size;
 		}
 
-		KUNIT_ASSERT_LE(test, alloc_size, PAGE_SIZE);
-
 		skb->len += total_size;
 		skb->data_len += total_size;
 		skb->truesize += total_true_size;
-- 
2.43.0.rc0.421.g78406f8d94-goog


