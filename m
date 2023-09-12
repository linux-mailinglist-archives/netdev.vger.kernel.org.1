Return-Path: <netdev+bounces-33307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5519F79D5BD
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038B8281B74
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067B819BDF;
	Tue, 12 Sep 2023 16:02:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE64819BD9
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 16:02:29 +0000 (UTC)
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E261703
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:02:21 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id d75a77b69052e-414bbfbdf37so67001761cf.1
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694534541; x=1695139341; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E5P9mty+RBBPJYFvp4EBUStqOIkAMIzYvbMv5tpdYBg=;
        b=fI8EBbCBVCZYnFOm64RYD0Zq4PNDHEV5EY3F0ZPvpHXaWBKYYRdDWjwKrZbm5zhh16
         ZN9lUi0rinqyoIKgHv/XMSPmQNaNHQPu9Rxtl2Oy7KzFBrWvchHY8Av1tgkCMfRlDV6H
         l9pIA6UOIdiAgV+Y2qa4tC+rEDnPahGEn6v9sMS2YiaLYPKly2i4o26AoT0dHC0uWoxe
         l3KNamLbXni/RtJ5c9DDQiy9G/ewMFlGHtnrpazq5qPTuri7ODOm8n5AC1adq2L2aaEz
         wDwyb2cMDHzKvkIco30a5L0bfzAmM0ji/WSto3ijfUpQBzmM3a57Amo1uWo7ygO3PDdD
         UWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694534541; x=1695139341;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E5P9mty+RBBPJYFvp4EBUStqOIkAMIzYvbMv5tpdYBg=;
        b=kc1WtoZG6jLOhEDNU8BD3Y044Zl5ONaJ7EOZsB4POPM8o7hJ+FBuMq7n7LP2fcbZZF
         djBHfFF8BhLPBZpJHAr+pi5+JfIeDaXIRxv5u2GJnTfdACLbddMdnQkVdJyd+y69xXxz
         uphCVxvybMGEgXl+I1n/FQmF7AYIMOzpf9Kpu0Sg8tfszhvIcY2aWb2S2Gpm5qP7KFp+
         SP9IY3DUa5b42jl3eeOoa4+a4kOFOnTkHMCfc6A01/JD6rjoRwRfplbH1DAvsgWle6Q+
         CVmkpf8OMO6rO473QXGyFhSSeT4YkgBpmR1ZaVbi6euU7yA8+/U+BmrAgnm+6A4PLpN9
         eIWQ==
X-Gm-Message-State: AOJu0YwYXmR+PFJjt5sn/DLBov9CT6EEHxknguSORcm6SGGTtI5eJSuR
	+YoSYpL3PuyfYVpe5vlkDZqc5NIv8uIjUw==
X-Google-Smtp-Source: AGHT+IFsqZT1eHV4Cn0FClwfbbBRIxBrRvF2AkvmPHUCPPkSlcfeiFSlTnszVel8PjxEL+gW+P+OlG8NVPh+HA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:622a:181b:b0:412:26be:464f with SMTP
 id t27-20020a05622a181b00b0041226be464fmr321815qtc.7.1694534540895; Tue, 12
 Sep 2023 09:02:20 -0700 (PDT)
Date: Tue, 12 Sep 2023 16:02:02 +0000
In-Reply-To: <20230912160212.3467976-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230912160212.3467976-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912160212.3467976-5-edumazet@google.com>
Subject: [PATCH net-next 04/14] ipv6: lockless IPV6_MTU implementation
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

np->frag_size can be read/written without holding socket lock.

Add missing annotations and make IPV6_MTU setsockopt() lockless.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6_output.c    | 19 +++++++++++--------
 net/ipv6/ipv6_sockglue.c | 15 +++++++--------
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 1e16d56d8c38ac51bd999038ae4e8478bf2f5f8c..ab7ede4a731a96fe6dce3205df29b298c923acc7 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -881,9 +881,11 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 			mtu = IPV6_MIN_MTU;
 	}
 
-	if (np && np->frag_size < mtu) {
-		if (np->frag_size)
-			mtu = np->frag_size;
+	if (np) {
+		u32 frag_size = READ_ONCE(np->frag_size);
+
+		if (frag_size && frag_size < mtu)
+			mtu = frag_size;
 	}
 	if (mtu < hlen + sizeof(struct frag_hdr) + 8)
 		goto fail_toobig;
@@ -1392,7 +1394,7 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 			  struct rt6_info *rt)
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
-	unsigned int mtu;
+	unsigned int mtu, frag_size;
 	struct ipv6_txoptions *nopt, *opt = ipc6->opt;
 
 	/* callers pass dst together with a reference, set it first so
@@ -1441,10 +1443,11 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 	else
 		mtu = np->pmtudisc >= IPV6_PMTUDISC_PROBE ?
 			READ_ONCE(rt->dst.dev->mtu) : dst_mtu(xfrm_dst_path(&rt->dst));
-	if (np->frag_size < mtu) {
-		if (np->frag_size)
-			mtu = np->frag_size;
-	}
+
+	frag_size = READ_ONCE(np->frag_size);
+	if (frag_size && frag_size < mtu)
+		mtu = frag_size;
+
 	cork->base.fragsize = mtu;
 	cork->base.gso_size = ipc6->gso_size;
 	cork->base.tx_flags = 0;
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 5fff19a87c75518358bae067dfeb227d6738bb03..3b2a34828daab5c666d7b429afa961279739c70b 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -441,6 +441,13 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		WRITE_ONCE(np->mcast_hops,
 			   val == -1 ? IPV6_DEFAULT_MCASTHOPS : val);
 		return 0;
+	case IPV6_MTU:
+		if (optlen < sizeof(int))
+			return -EINVAL;
+		if (val && val < IPV6_MIN_MTU)
+			return -EINVAL;
+		WRITE_ONCE(np->frag_size, val);
+		return 0;
 	}
 	if (needs_rtnl)
 		rtnl_lock();
@@ -910,14 +917,6 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		np->pmtudisc = val;
 		retv = 0;
 		break;
-	case IPV6_MTU:
-		if (optlen < sizeof(int))
-			goto e_inval;
-		if (val && val < IPV6_MIN_MTU)
-			goto e_inval;
-		np->frag_size = val;
-		retv = 0;
-		break;
 	case IPV6_RECVERR:
 		if (optlen < sizeof(int))
 			goto e_inval;
-- 
2.42.0.283.g2d96d420d3-goog


