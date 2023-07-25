Return-Path: <netdev+bounces-20998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400B87621CB
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 20:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B3F1C20F58
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 18:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043DB263A0;
	Tue, 25 Jul 2023 18:52:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0821F927
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 18:52:25 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40A21BC2
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 11:52:24 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-584341f9cb3so2890127b3.0
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 11:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690311144; x=1690915944;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dT0YzD5qGPW+7Z304F1tg4sfWV1IrnAiZkIMxNqneuE=;
        b=7Vbo3oQ9bvUM6iPPx7Jt/ko9QtrVOH0bC3wDsfn4jh+7biX5SlixgWCQYk1QJR8+tl
         l7otHyFMoYimgPTJHC7QD0wciyq9fkLWfDuEn/i37+3lOe0DO0BBjmvygQ7ZnqoLVkjh
         F9D4SnzAumuZZdGC2SJOnMMcaewstY0D5oY4Kf+zOhDPwxww6IXVaD0sw+CMV4GdNICu
         czcZ5uSfP89Mrbfv+EAnqzMJaRe8GI4jrfswsvNiAy1ZmVeJvf9rxre6FTKH28K9MR7F
         6roXPAqhoAkY47kWBIqRHIR/KIkKM0xPnWItLeXVPxGMJ0e7p25S48KSaTJzAKPh1L+5
         Ck8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690311144; x=1690915944;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dT0YzD5qGPW+7Z304F1tg4sfWV1IrnAiZkIMxNqneuE=;
        b=j/yqc3wO0Q2nNIuRQLnwbQ1rj6EoeqwySOdidBAMLdGk94D6pLtTQ9sov+E/GaQDbC
         kADTI/d+U2/KZoDxVw/xLeNysCIlEPgXpa72Hgi8WRAQMYXE1TnLslftOnNbYdrw9Dix
         i+R9Ns4baCNhaGnhHKgOIP8ImMGm+lrDqOhcnWCWIWP/A1q9ErIAYXspR39+wPA5nq+W
         f6enDguUbc/lb8gumXF7GKEGTamWXqLx7mNLkZ9NDhRVXuHQt/9xFlC8WgSjzVc0O++v
         Ame0GpHtdnFVYdvpTynixHFqvOGmeF7Vq9i7bZCvhN8yS3VDN0AhZLGRygV4Nn6vwujI
         f6VA==
X-Gm-Message-State: ABy/qLZ7Ti1yTKmxOASywKIk3ArM2vtbmcc3pxt71Byx6PkWDwerbNAA
	W8uDq2fk8Pfb4Uhrdtk2JJD6Sz/c2w==
X-Google-Smtp-Source: APBJJlH4YFDsguijZmeCeI8xJjRMwtrp1/euoNuvoJ3l6+LjqTfpnUNpWLD2+a+XqDZgwCxCFnQ76n7Imw==
X-Received: from prohr-desktop.mtv.corp.google.com ([2620:15c:211:200:12d9:d7b:133f:2bfa])
 (user=prohr job=sendgmr) by 2002:a25:c544:0:b0:ceb:324c:ba8e with SMTP id
 v65-20020a25c544000000b00ceb324cba8emr1393ybe.4.1690311143908; Tue, 25 Jul
 2023 11:52:23 -0700 (PDT)
Date: Tue, 25 Jul 2023 11:51:51 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725185151.37310-1-prohr@google.com>
Subject: [PATCH] net: move comment in ndisc_router_discovery
From: Patrick Rohr <prohr@google.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, Patrick Rohr <prohr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Move setting the received flag comment to the appropriate section.

Signed-off-by: Patrick Rohr <prohr@google.com>
---
 net/ipv6/ndisc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index eeb60888187f..0a29a4626194 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1266,10 +1266,6 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 	}
 #endif
 
-	/*
-	 *	set the RA_RECV flag in the interface
-	 */
-
 	in6_dev = __in6_dev_get(skb->dev);
 	if (!in6_dev) {
 		ND_PRINTK(0, err, "RA: can't find inet6 device for %s\n",
@@ -1297,6 +1293,10 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 	}
 #endif
 
+	/*
+	 *	set the RA_RECV flag in the interface
+	 */
+
 	if (in6_dev->if_flags & IF_RS_SENT) {
 		/*
 		 *	flag that an RA was received after an RS was sent
-- 
2.41.0.487.g6d72f3e995-goog


