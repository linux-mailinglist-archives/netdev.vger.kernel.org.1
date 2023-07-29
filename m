Return-Path: <netdev+bounces-22546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E21767F28
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 14:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57F92825AA
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 12:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5B4168AF;
	Sat, 29 Jul 2023 12:32:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F858168AD
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 12:32:29 +0000 (UTC)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC8E2D71
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 05:32:28 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-63cf28db24cso17936966d6.2
        for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 05:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690633948; x=1691238748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lngQvXDPyBuidB6/rPDqoDNpZHxGFh1LY55Kja1Ci+c=;
        b=kVz+HhdvU8n1EdvpHUeTb1vj22dyzO8ERJeAYsmNoQNlPVoRFKfS4ljGM2z99DMU7E
         m2h+WcFLMus92gNRspvTa59a/jgIM7JiDESO+SzlvyrXwnZCTlPYkkzkEVr1xSsJRMbK
         cU0apEiUmHznp013jmXec5Ut3Ww2GuHAoqxByIzNwG9C9RZz3nT1fkYWjreDlaK6Krg7
         nAgAk+1Pm6MCf3rjYDXp/pbbkUTjub86eqi3zT0ry6T6fWEMUFLjf9BM4p3mAR5mTz7J
         I3a6LNhx84HCkIkxHAF4y8jznOS8n6/k4Q75J4q0OI17ZCnsYKua5IxFZ5CjKD+eKBCQ
         09ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690633948; x=1691238748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lngQvXDPyBuidB6/rPDqoDNpZHxGFh1LY55Kja1Ci+c=;
        b=QtdrF/+ZPs1zw3dQQ7Xlaw+93M33Yc0KB7yz2p9LenTEI09tNbKoUIhhBQE4GG/U9B
         ZB5nFxYe5feRvp3vIQ9aQcoT5WLhF41DNKG+zIVcKdbAIXSr8yX7+QIwrDE/ILrUlR4N
         25xJnWzwDnSsCdBjWqBL2IaWEHpcuVExCKcJJqxPFZtrsVc6P/8QHqNPOvb3Fpn9VIkZ
         clto11bQ3yxll8RWSo9U43nSx+A3rckwfm6Nsi+8WRydjdHbJTy2lhyh5YzpodF6TZT9
         XuVhXKi3gNILMoeDdFBnG7ybQgAQJwhggh14Xq3XmmAZPPEvMdkIA59VgRE3wML+VowZ
         b1rQ==
X-Gm-Message-State: ABy/qLagafDXvofiE7oH9uyJC2o3SGWzypDdoOhUkjJF+SJoBbw9Ibb/
	WXcL7DDvL2iaZW/2x+0rXuvYug==
X-Google-Smtp-Source: APBJJlFJ+L2ujJF1WF7HhhCZGJIRYzUOF4m3om0qiyL9BVTpQj9EbxXrezrDVZi0AQS2HkkEOt162Q==
X-Received: by 2002:a0c:f4c3:0:b0:636:79d1:d5a7 with SMTP id o3-20020a0cf4c3000000b0063679d1d5a7mr5797409qvm.47.1690633947791;
        Sat, 29 Jul 2023 05:32:27 -0700 (PDT)
Received: from majuu.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id x12-20020a0ce0cc000000b006263c531f61sm2024716qvk.24.2023.07.29.05.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 05:32:27 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com
Cc: jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	netdev@vger.kernel.org,
	sec@valis.email,
	ramdhan@starlabs.sg,
	billy@starlabs.sg,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net v2 3/3] net/sched: cls_route: No longer copy tcf_result on update to avoid use-after-free
Date: Sat, 29 Jul 2023 08:32:02 -0400
Message-Id: <20230729123202.72406-4-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230729123202.72406-1-jhs@mojatatu.com>
References: <20230729123202.72406-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: valis <sec@valis.email>

When route4_change() is called on an existing filter, the whole
tcf_result struct is always copied into the new instance of the filter.

This causes a problem when updating a filter bound to a class,
as tcf_unbind_filter() is always called on the old instance in the
success path, decreasing filter_cnt of the still referenced class
and allowing it to be deleted, leading to a use-after-free.

Fix this by no longer copying the tcf_result struct from the old filter.

Fixes: 1109c00547fc ("net: sched: RCU cls_route")
Reported-by: valis <sec@valis.email>
Reported-by: Bing-Jhong Billy Jheng <billy@starlabs.sg>
Signed-off-by: valis <sec@valis.email>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/cls_route.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
index d0c53724d3e8..1e20bbd687f1 100644
--- a/net/sched/cls_route.c
+++ b/net/sched/cls_route.c
@@ -513,7 +513,6 @@ static int route4_change(struct net *net, struct sk_buff *in_skb,
 	if (fold) {
 		f->id = fold->id;
 		f->iif = fold->iif;
-		f->res = fold->res;
 		f->handle = fold->handle;
 
 		f->tp = fold->tp;
-- 
2.34.1


