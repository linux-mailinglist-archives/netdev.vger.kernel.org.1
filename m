Return-Path: <netdev+bounces-34003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD0D7A152C
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 07:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76C1828228D
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 05:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABDC3FC2;
	Fri, 15 Sep 2023 05:13:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5478863D
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 05:13:03 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A30E2710
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 22:13:02 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68fdcc37827so2084640b3a.0
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 22:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694754781; x=1695359581; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lb0icnfc1cF/eJVDwTwmuah1DCftBxds9QT3EaNBBts=;
        b=YzTPvLWYTNjsvpUdLZv4e1vTUzjeoEtZxUO1LLfR0EA2iyViNku3L7hrc1+E0KDGV1
         QY2UWYpv+9QBBUC6dRp81g7N4JKYMacrArerD78VafI59FhPMkiRpD5th74sRvdUeePE
         JS/sJ/nmdMIVAjQSwUIRkmpk6DJrOMYUfdWMsaj0TR28EfTJVPVbRt+IYiTyiXn/iAmb
         jk06Sigzf2pt5jmufheU+ZCGnUMsQiCe3qz5+6bfEP5E9ngMScehOIfndyO1t9r3rUgR
         k1zly1XgEbPF2Cb4ZoD67E313OjLEeVBNgeWvmscxZo0LGx+5eIscXSGPrb4jV2Vizqu
         aYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694754781; x=1695359581;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lb0icnfc1cF/eJVDwTwmuah1DCftBxds9QT3EaNBBts=;
        b=RQFS+UDkBk1FNyh8DA8YLaQJyUzDqEdTOS6qqaLO6thHIahXV/4eHP+qSFNP8ApT41
         SPsGVGQ4FxAbwpryTsVJfNcGifkWMTPwiMkLYD2c3RYGYrGIFckVda1qQlVlZ3exbOpP
         PT3T91M0MPC2fC2GFZOOOLKT0NEPxqsoJKnuu8R3UpOf8Ye2+DCL8KnhnfXwRIh5qCU8
         jdHpVUcSBf8yBxzAJIlXRdZ+3Mevo0ocnkrQd6D+1rF6NQkPMsftKVJ+BS1FBLsZcJVB
         znn08/vBIg4zdwtNYieLorJlpkKIrL+3KLequ0+smXGZOTh0dyw30QvzpvMqYxwWiwQf
         Z5rA==
X-Gm-Message-State: AOJu0YyF1mNDVjMxMvU36dExYhl3+XL61a3+Wt5/0fGQR4/6KXSGo026
	yw27/uupQpvf9SQb2iksyWs=
X-Google-Smtp-Source: AGHT+IE+QV59omJXyuRG41C7hYFZvaE9MpI4JMUhfV96BjYozPkjb+xBDBVDRoCk44whIvwM9UBhcg==
X-Received: by 2002:a17:902:cecf:b0:1b7:ca9c:4f5c with SMTP id d15-20020a170902cecf00b001b7ca9c4f5cmr6140536plg.28.1694754781343;
        Thu, 14 Sep 2023 22:13:01 -0700 (PDT)
Received: from westworld (209-147-138-147.nat.asu.edu. [209.147.138.147])
        by smtp.gmail.com with ESMTPSA id a11-20020a170903100b00b001bdc664ecd3sm2491588plb.307.2023.09.14.22.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 22:13:00 -0700 (PDT)
Date: Thu, 14 Sep 2023 22:12:57 -0700
From: Kyle Zeng <zengyhkyle@gmail.com>
To: pabeni@redhat.com, dsahern@kernel.org
Cc: vfedorenko@novek.ru, davem@davemloft.net, netdev@vger.kernel.org,
	ssuryaextr@gmail.com
Subject: [PATCH v3 net] ipv4: fix null-deref in ipv4_link_failure
Message-ID: <ZQPn2cF3aX/523eC@westworld>
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

Fixes: ed0de45a1008 ("ipv4: recompile ip options in ipv4_link_failure")
Suggested-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Kyle Zeng <zengyhkyle@gmail.com>
Cc: Stephen Suryaputra <ssuryaextr@gmail.com>
Cc: Vadim Fedorenko <vfedorenko@novek.ru>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 net/ipv4/route.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index d8c99bdc617..cba0d148c27 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1213,6 +1213,7 @@ EXPORT_INDIRECT_CALLABLE(ipv4_dst_check);
 
 static void ipv4_send_dest_unreach(struct sk_buff *skb)
 {
+	struct net_device *dev;
 	struct ip_options opt;
 	int res;
 
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


