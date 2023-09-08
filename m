Return-Path: <netdev+bounces-32506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAE27980E7
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 05:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 870B52817F7
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 03:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AD9111B;
	Fri,  8 Sep 2023 03:18:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423C71112
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 03:18:24 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E531B1BDA
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 20:18:23 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68a1af910e0so1400729b3a.2
        for <netdev@vger.kernel.org>; Thu, 07 Sep 2023 20:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694143103; x=1694747903; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ue8XDz1KMBwTq//Z+SQ7uhZSwaZfGcgEcy/ft4HiGJc=;
        b=AQXhc2FfBU/nCLPUshxU8qb7lI0Vo6uxaBYBMkNjbsCU8AMSmnxK3N6v5uLZuZQ+eF
         K0abFenyvEIHIB5/2tHE9HhGwSqBTmLyboUNs7AFFfcp5zEHcUK8kk3QGbos+O2ZsPjv
         d2S0wL8aAE4S7z4Da18EUAXC80H/v0ewsMp+vuy2ma7UZcKXTrcffBOgYQJGzzjV1saj
         E+Il6Buiv1URxmeZTyNhZmbnBQaRckhA8dyhdH0fI2Wrxvdh1mR4kMDbguuUiEI3Z55c
         wk0yBGoqpZRcz1YOucmT6cKGbCVrTlcvW8AmkGUks+ybOapD2+HYxvVIy1t9VcQgDRIC
         0Urw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694143103; x=1694747903;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ue8XDz1KMBwTq//Z+SQ7uhZSwaZfGcgEcy/ft4HiGJc=;
        b=UYoD45HpkJPTT+KUFXrnFYxISy2gGkqlHBhxnkfPP32H4twGjz4/CBJ63Z/Zu4VOmL
         3/FhYhJlqgvma7DxnzPAPpNlljQV1Rhjeo6bRpI2RB+cNgEuaLqG1irOe1J6YjbazZbu
         Vwl88O212qC+pyAimuc8ZMV9nNf7FKUdqtiK0zvs+ZV/W489pTrpNb4rwpqbdPr4acbX
         qPwvFHZOs8ORtrGiaBhoJdSe8dc8iGtvdQiqsO/TD9vzrZ3MhofWBCqO/YfG55UOq3DF
         dZ96FmQIP9P1vJIpLjxS0jypWnGGVAwPIMijqE+1oAvBzMn7YRBjU3umpuVZw9soXyTc
         Flpw==
X-Gm-Message-State: AOJu0YyiMOrkNpk6JmB1eilzfPHRg+a6hyrHOOPSgFV4cp7fqILSyDcA
	CE+rdcZsHfzR3RKNVKb4E/I=
X-Google-Smtp-Source: AGHT+IHMw9NbkXSaP/1cC16JBXlGwHfpdr1f3jXXUwu9HZsumoZzfAS8TcQ+uRy74bvDoHogM4EnFg==
X-Received: by 2002:a05:6a20:430c:b0:13c:b1a7:7b1 with SMTP id h12-20020a056a20430c00b0013cb1a707b1mr1715191pzk.25.1694143103242;
        Thu, 07 Sep 2023 20:18:23 -0700 (PDT)
Received: from westworld (209-147-138-147.nat.asu.edu. [209.147.138.147])
        by smtp.gmail.com with ESMTPSA id d3-20020aa78683000000b00686bf824b3bsm375139pfo.136.2023.09.07.20.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 20:18:22 -0700 (PDT)
Date: Thu, 7 Sep 2023 20:18:20 -0700
From: Kyle Zeng <zengyhkyle@gmail.com>
To: pabeni@redhat.com, dsahern@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, ssuryaextr@gmail.com
Subject: [PATCH net] fix null-deref in ipv4_link_failure
Message-ID: <ZPqSfGGAwa1I69Sm@westworld>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, we assume the skb is associated with a device before calling
__ip_options_compile, which is not always the case if it is re-routed by
ipvs.
When skb->dev is NULL, dev_net(skb->dev) will become null-dereference.
This patch adds a check for the edge case and switch to use the net_device
from the rtable when skb->dev is NULL.

Suggested-by: Paolo Abeni<pabeni@redhat.com>
Suggested-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Kyle Zeng <zengyhkyle@gmail.com>
Cc: Stephen Suryaputra <ssuryaextr@gmail.com>
---
 net/ipv4/route.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index d8c99bdc617..1be34e5eea1 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1214,6 +1214,7 @@ EXPORT_INDIRECT_CALLABLE(ipv4_dst_check);
 static void ipv4_send_dest_unreach(struct sk_buff *skb)
 {
 	struct ip_options opt;
+	struct net_device *dev;
 	int res;
 
 	/* Recompile ip options since IPCB may not be valid anymore.
@@ -1230,7 +1231,8 @@ static void ipv4_send_dest_unreach(struct sk_buff *skb)
 		opt.optlen = ip_hdr(skb)->ihl * 4 - sizeof(struct iphdr);
 
 		rcu_read_lock();
-		res = __ip_options_compile(dev_net(skb->dev), &opt, skb, NULL);
+		dev = skb->dev ? skb->dev : skb_rtable(skb)->dst.dev;
+		res = __ip_options_compile(dev_net(dev), &opt, skb, NULL);
 		rcu_read_unlock();
 
 		if (res)
-- 
2.34.1


