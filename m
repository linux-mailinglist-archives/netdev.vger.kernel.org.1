Return-Path: <netdev+bounces-21573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F7E763ED7
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 20:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390851C21317
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61084CE70;
	Wed, 26 Jul 2023 18:48:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD827E1
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 18:48:03 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC561BFB
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 11:47:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d052f58b7deso67016276.2
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 11:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690397270; x=1691002070;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nqtTxpG12ZD3yxqR/qZ9puKoyidG8uVE6UklCN/EyNM=;
        b=turhR/u+Q+tusFWjsUHshIPXfpl5+utl95nacU+YoPJZTlbRw2+PLutBAL1al+uHd7
         CFemOLIGXipmIr4d9jQ7v+UzziTtXF/pDZoEsoj6O43Vd0iwn1MC5qqyDrtp/9dpFzIs
         SZd9AKtlWZHgAgIvuwcyG6n8ucXFmUNWZ+lmS0KR18zkRO+wMgIpIPFSfAtyRxwBZAf2
         ZSB/szcBtOQNTM4HKbYsoD4FpJFDoPL0xhdd0edv+bZ+brLHaGDwIVn7pM0xI0SizYOl
         05mratFe7+A8q3uQZSdKkG7yxGW2YITRD5fjhnK0Vmj+qgLpjkT50ukqg1fe9LyGbZcD
         VIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690397270; x=1691002070;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nqtTxpG12ZD3yxqR/qZ9puKoyidG8uVE6UklCN/EyNM=;
        b=bQUoph2xT4/vP1rBz2fiBQ2SyqrZAmIFU+9yEV0WAHdh6YtZuUccTTiPaNg5lf7nSM
         N30AIJCDVTNf+l16yS5Sa55LCDYuLd8BjeAI2+jjLYZ24KFbFLqXDItdnaAtGslIFffb
         FIrmK8jovoYwsSracKdxDs1isPXGJOOHpTEi2+ASyEKXPNCZs4Y2PalvXowOik107rIl
         KKEKCh2LOim1OHbaD5AfX02QnX3mwaLZ1Akf6AYyuFaF5MJO138qsrzGs/seqfNDrDSX
         ybPe176XGD/MhbSa3QFeWvJzP31wh6WrlFfHdwujs0+t5BxF8af1o7ITMULFcIKWVC/I
         LWYw==
X-Gm-Message-State: ABy/qLZXltuBjXGKe6t4vip1UafNX8ri+IrKGPe/Xd/1olWGsbEzxNv+
	V/kMWo62++SJLpZeXsRY9QRJmzppig==
X-Google-Smtp-Source: APBJJlGBXJ9jGBqvh+uEptE0Rp9MGJ7vG3akbYqh9KEnaN8sMdJlUcpLTXZ1ZGUSxuC4dusOI9gcTYNwgA==
X-Received: from prohr-desktop.mtv.corp.google.com ([2620:15c:211:200:3dc1:ca05:df9a:6b7a])
 (user=prohr job=sendgmr) by 2002:a25:26cb:0:b0:c65:b18c:ad0d with SMTP id
 m194-20020a2526cb000000b00c65b18cad0dmr13740ybm.11.1690397269656; Wed, 26 Jul
 2023 11:47:49 -0700 (PDT)
Date: Wed, 26 Jul 2023 11:47:42 -0700
In-Reply-To: <c3f90818-3991-4b76-6f3a-9e9aed976dea@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <c3f90818-3991-4b76-6f3a-9e9aed976dea@kernel.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230726184742.342825-1-prohr@google.com>
Subject: [PATCH v2] net: remove comment in ndisc_router_discovery
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

Removes superfluous (and misplaced) comment from ndisc_router_discovery.

Signed-off-by: Patrick Rohr <prohr@google.com>
---
 net/ipv6/ndisc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index eeb60888187f..c394799be38f 100644
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
-- 
2.41.0.487.g6d72f3e995-goog


