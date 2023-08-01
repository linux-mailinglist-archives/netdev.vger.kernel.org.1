Return-Path: <netdev+bounces-23421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0307776BED6
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 22:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B25F3281BC6
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 20:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23EF26B96;
	Tue,  1 Aug 2023 20:53:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75824DC77
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 20:53:04 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCF011D
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 13:53:03 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58456435437so71338767b3.0
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 13:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690923183; x=1691527983;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/fKWDhaneLtOE++Bs6lXFJLB9aWVQ1lnzdiH+IUuQ60=;
        b=J9b7lIfS1NWRpT2EwOPkmVEMCNTAq6+K9x+ENiirjqE+r0yK4M9NglpZXSW+i35kn/
         U4eNGgSbG+dpkCI7U/Lpc0iUnLERdf0rqNG5cg5RHpJYFg/JsVWDi8NEAOS/upL3Q//0
         6/tRjxT1EKkvDrshrCOCmzmpfOY35Ff4abxHD43/4jFqMoUOXDvthKzmtxCu46QW7dJc
         E90X6swY8sTe0VbFl/hHIKY4wcQAxXjaCF5hN0RtM+wxMkehAo5dMSkeaVxNDbU1rbv0
         vcoSp3R6JBm7wsfIWAhjXsvr+p4aSOKlvAVYrIxWn8juDzTHDjOSqNeH2r5hk1dSzz/n
         74BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690923183; x=1691527983;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/fKWDhaneLtOE++Bs6lXFJLB9aWVQ1lnzdiH+IUuQ60=;
        b=FfjZWNeTBVX24lnVv73x4YHCAoXW7QQk/Bvs7mHqx4Y3K9BXMRiG2XaV58yKKEM/S9
         mVF7JOrpD1RslboHiTELN3oqZqyLb4U2sD+3AXGfDTNyull73dJtBjKtZFhXMPPoe/b5
         xazAEyhUaaefT2G9wSyP25NQ2Xd0HfAuWkFvkr2NQq0i+8SsEw6WVe0ver9jqWEwptUD
         4lEx9uJDCpZ4K0sC1AvwC2lEaOWK5E/e8cFdVEa6QZvXr3+phy2txY75T53IHPxDRFfY
         U3UmBnuXf/Vogpw1gOHL2eaGn69v0+882NP7lahLWGjSz8nNQ1wpoxUagzfuMNoObEn1
         vtiw==
X-Gm-Message-State: ABy/qLaSEdepuNZOeHUl7Q1fmUfxL5u124D2W0dVz+Fuk97R2m5qH1fY
	O/PiVQGW6iz6oGwH9QOAGfmtPrXNYBsZ9g==
X-Google-Smtp-Source: APBJJlFXI3dHydR4HkUgMQjZlwU4lRgsQW3i8upxei+U3E92BgtEgeXu1d9/CQS7dDVBQHeN+J2RrEX2KPBneg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:b301:0:b0:583:9ace:cf41 with SMTP id
 r1-20020a81b301000000b005839acecf41mr135181ywh.0.1690923183072; Tue, 01 Aug
 2023 13:53:03 -0700 (PDT)
Date: Tue,  1 Aug 2023 20:52:54 +0000
In-Reply-To: <20230801205254.400094-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230801205254.400094-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230801205254.400094-5-edumazet@google.com>
Subject: [PATCH v2 net-next 4/4] net: tap: change tap_alloc_skb() to allow
 bigger paged allocations
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

tap_alloc_skb() is currently calling sock_alloc_send_pskb()
forcing order-0 page allocations.

Switch to PAGE_ALLOC_COSTLY_ORDER, to increase max size by 8x.

Also add logic to increase the linear part if needed.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Tahsin Erdogan <trdgn@amazon.com>
---
 drivers/net/tap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 9137fb8c1c420a792211cb70105144e8c2d73bc9..01574b9d410f0d9bfadbddf748d194e003d9da2f 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -614,8 +614,10 @@ static inline struct sk_buff *tap_alloc_skb(struct sock *sk, size_t prepad,
 	if (prepad + len < PAGE_SIZE || !linear)
 		linear = len;
 
+	if (len - linear > MAX_SKB_FRAGS * (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
+		linear = len - MAX_SKB_FRAGS * (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER);
 	skb = sock_alloc_send_pskb(sk, prepad + linear, len - linear, noblock,
-				   err, 0);
+				   err, PAGE_ALLOC_COSTLY_ORDER);
 	if (!skb)
 		return NULL;
 
-- 
2.41.0.585.gd2178a4bd4-goog


