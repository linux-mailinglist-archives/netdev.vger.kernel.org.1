Return-Path: <netdev+bounces-42874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B638F7D07A1
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 07:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6AB1B21536
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 05:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FE87494;
	Fri, 20 Oct 2023 05:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="W5HYo6Cz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26546AAB
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:32:53 +0000 (UTC)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6615D4C
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 22:32:52 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7781b176131so23900285a.1
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 22:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1697779971; x=1698384771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9xpTogBhloZZ3cgxOHAvGjGFV2B6QzeETWE0jVApmhU=;
        b=W5HYo6CzHn0n+hoSyGPdXLRPk7sDe9kyTLVSvCoWtjMgPhbsnd6DDmh+tFU5wF8rfQ
         RJqEmYP3AU7cmo2moTlMJpLaQ3puZno8yFfEbkDM5H4pLKeTQmWxq8uEsW9WfOFD6I00
         /fB2kMHootI9Y+koucBakT4yLrQPVCLHsxVuvi2cEVfQaTUWOhAUc65d1dHSyABO+ANL
         G9IiC9klk/NZuF12Lc9wfpFHF5RDocpAEGuncVjd3Dps2HpEI8lih07s0p4oQ2FrN67f
         osEGTtzFj/Nt/tAswwLlMTqWHyBSK0FbtVkfRqFOGX7QzKpWAgu15VCQBYGUQoOtQfTM
         kYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697779971; x=1698384771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xpTogBhloZZ3cgxOHAvGjGFV2B6QzeETWE0jVApmhU=;
        b=aylCAAOa1GHjRxC9dKPnKn8xGaxRPRaHId6/rG0NgooNaQ2X+gJmaNoiH/0g/kIqZg
         l6MvpzotuqdBXH1KRf04SZfHkKhKe0qa5v7ZittwMy9c/8vURuPxs+S1G9oG/og9p/6+
         wIbB9CR9X6GfnkexEEuHMmWv2qD4WBn/RVVt/mzq1ahcT0dthtHUhIIGZYFG6WqEbjGU
         9BxqbVmh7JwlWeXMF5SDU5+QSX9qncH8epbgsPC5v8ACX6RxOPKA4Xmk74GsmIVBt9H3
         kOH/iRVE3fq8HhhV8Trt6NYnKwbQjd31e21UQGK01B1dfQO9FFmBAKm4O3Won+cWKJ2E
         899g==
X-Gm-Message-State: AOJu0YyPHvOi/x1vD90Ty4J70hB3IpetZDd2a3c2XafAvmBZRz+JHduG
	1RJi+qr1C/XOBB3ZMmyhxxGeivWNugJPe0tQtGqrig==
X-Google-Smtp-Source: AGHT+IGSkCTT/zquQUwd3swviH/Fg+gESUjwa/1PtV2qfkXpbULyGWMHdHpXDFA8evkAJp9nQqvX3Q==
X-Received: by 2002:a05:620a:40c5:b0:778:8ce0:221a with SMTP id g5-20020a05620a40c500b007788ce0221amr824644qko.63.1697779971342;
        Thu, 19 Oct 2023 22:32:51 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id bq12-20020a05620a468c00b007678973eaa1sm356816qkb.127.2023.10.19.22.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 22:32:50 -0700 (PDT)
Date: Thu, 19 Oct 2023 22:32:49 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Aya Levin <ayal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
	Florian Westphal <fw@strlen.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexander H Duyck <alexander.duyck@gmail.com>
Subject: [PATCH v3 net-next 2/3] ipv6: refactor ip6_finish_output for GSO
 handling
Message-ID: <496ccff707e16e98163d2a3fbcfbc1f824fd8ec3.1697779681.git.yan@cloudflare.com>
References: <cover.1697779681.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697779681.git.yan@cloudflare.com>

Separate GSO and non-GSO packets handling to make the logic cleaner. For
GSO packets, frag_max_size check can be omitted because it is only
useful for packets defragmented by netfilter hooks. Both local output
and GRO logic won't produce GSO packets when defragment is needed. This
also mirrors what IPv4 side code is doing.

Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 net/ipv6/ip6_output.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index ae87a3817d4a..3270d56b5c37 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -170,6 +170,16 @@ ip6_finish_output_gso_slowpath_drop(struct net *net, struct sock *sk,
 	return ret;
 }
 
+static int ip6_finish_output_gso(struct net *net, struct sock *sk,
+				 struct sk_buff *skb, unsigned int mtu)
+{
+	if (!(IP6CB(skb)->flags & IP6SKB_FAKEJUMBO) &&
+	    !skb_gso_validate_network_len(skb, mtu))
+		return ip6_finish_output_gso_slowpath_drop(net, sk, skb, mtu);
+
+	return ip6_finish_output2(net, sk, skb);
+}
+
 static int __ip6_finish_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	unsigned int mtu;
@@ -183,16 +193,14 @@ static int __ip6_finish_output(struct net *net, struct sock *sk, struct sk_buff
 #endif
 
 	mtu = ip6_skb_dst_mtu(skb);
-	if (skb_is_gso(skb) &&
-	    !(IP6CB(skb)->flags & IP6SKB_FAKEJUMBO) &&
-	    !skb_gso_validate_network_len(skb, mtu))
-		return ip6_finish_output_gso_slowpath_drop(net, sk, skb, mtu);
+	if (skb_is_gso(skb))
+		return ip6_finish_output_gso(net, sk, skb, mtu);
 
-	if ((skb->len > mtu && !skb_is_gso(skb)) ||
+	if (skb->len > mtu ||
 	    (IP6CB(skb)->frag_max_size && skb->len > IP6CB(skb)->frag_max_size))
 		return ip6_fragment(net, sk, skb, ip6_finish_output2);
-	else
-		return ip6_finish_output2(net, sk, skb);
+
+	return ip6_finish_output2(net, sk, skb);
 }
 
 static int ip6_finish_output(struct net *net, struct sock *sk, struct sk_buff *skb)
-- 
2.30.2



