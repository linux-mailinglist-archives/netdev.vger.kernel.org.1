Return-Path: <netdev+bounces-31652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBD378F4BE
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 23:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41D521C20B2D
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 21:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01B31AA74;
	Thu, 31 Aug 2023 21:38:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAC55399
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 21:38:16 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A258107
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 14:38:15 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59285f1e267so43539467b3.0
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 14:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693517894; x=1694122694; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gEyyA5WGaBb4SvWvFMDKFZvmXfal9HC1160gvHOLwQ4=;
        b=0lLeZdeJq2TcV3TAHVhsPtUo+1rRUiEBomMbD8dwM6F6oyEdBSaq++gCkAi7xrypIZ
         h0H0FufA5hYf/5L4wM9VWHdYFrOO1/eL5+W4DgEazc+J8FLA6WYqr23RtRkE5r3Wwg7u
         J5TuprQVq6d49CDuiAIlTwb6vFRfnqOfkxGagE5wpxGW+t8oZy7KaDvIAywWp3Hha7uV
         Z4ohvd9pKahhIeVpdRsfHAjDveAI28y92werzlVFLyEXn2AuvbJxKS6hUBAYmvLHlQgu
         kGutMdIfhMhFETpGKkmS0BMKTAN6IaX1wCk+JoZM/gRBNiB7S/TpoeASV7YfFSyutNse
         4XKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693517894; x=1694122694;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gEyyA5WGaBb4SvWvFMDKFZvmXfal9HC1160gvHOLwQ4=;
        b=W2or7gZrd3f+6bgO7grHiUbtQFSOqbwFVUjVA4XWVKgTWRwrum8xSMo83CVyHKtkaw
         ygVO2WPdpB/ugZKGQxzm0AIXoCu+xFgVO+P4+1zioKWjSmF6sPUBuZ9rUQRuDtXMBGVv
         RN0RsQR/6rQsTwiLvcA5rDbCgLZQMj25Q42rtO3OtYKITA6EV6M62lENFMi6qHe7q9qK
         m0OnQ3xojYIUsl8o9K8mifqzuwfWeOI4lDMflBsULawOvnTx2YWn4Iw64g55N5B63Y97
         ESBrkWsDa57nztoeWBehl6KnjCXcolo7rQmR78u9kLEer6sBiDWhID1d3jlwwZ/Rp/UD
         4ivQ==
X-Gm-Message-State: AOJu0Yxn49GTyqyAHe538uehdahIrYvlhvF3TINCXPsVXgEEXXwKQldh
	RcSodSugbPGuTeB9wQifatch92FTDzHmag==
X-Google-Smtp-Source: AGHT+IGHaPQrzHy9wiGiMGr79tJRYPJmDr+2ayYXInEgOiB8VPwPQuoROiSC83hpwG0lViUz5y80nTJbKe2U5A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:8d02:0:b0:595:8166:7be with SMTP id
 d2-20020a818d02000000b00595816607bemr25894ywg.0.1693517894334; Thu, 31 Aug
 2023 14:38:14 -0700 (PDT)
Date: Thu, 31 Aug 2023 21:38:12 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230831213812.3042540-1-edumazet@google.com>
Subject: [PATCH net] gve: fix frag_list chaining
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Bailey Forrest <bcf@google.com>, 
	Willem de Bruijn <willemb@google.com>, Catherine Sullivan <csully@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

gve_rx_append_frags() is able to build skbs chained with frag_list,
like GRO engine.

Problem is that shinfo->frag_list should only be used
for the head of the chain.

All other links should use skb->next pointer.

Otherwise, built skbs are not valid and can cause crashes.

Equivalent code in GRO (skb_gro_receive()) is:

    if (NAPI_GRO_CB(p)->last == p)
        skb_shinfo(p)->frag_list = skb;
    else
        NAPI_GRO_CB(p)->last->next = skb;
    NAPI_GRO_CB(p)->last = skb;

Fixes: 9b8dd5e5ea48 ("gve: DQO: Add RX path")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Bailey Forrest <bcf@google.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Catherine Sullivan <csully@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index ea0e38b4d9e9f6c41441729d6ae5693186f03040..f281e42a7ef9680e2049a185782a37d402c7f886 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -570,7 +570,10 @@ static int gve_rx_append_frags(struct napi_struct *napi,
 		if (!skb)
 			return -1;
 
-		skb_shinfo(rx->ctx.skb_tail)->frag_list = skb;
+		if (rx->ctx.skb_tail == rx->ctx.skb_head)
+			skb_shinfo(rx->ctx.skb_head)->frag_list = skb;
+		else
+			rx->ctx.skb_tail->next = skb;
 		rx->ctx.skb_tail = skb;
 		num_frags = 0;
 	}
-- 
2.42.0.283.g2d96d420d3-goog


