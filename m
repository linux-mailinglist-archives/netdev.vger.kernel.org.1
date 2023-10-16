Return-Path: <netdev+bounces-41505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DAF7CB26F
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 20:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C470BB20DB0
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 18:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2120E33995;
	Mon, 16 Oct 2023 18:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RFypY+mw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1F231A9F
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 18:23:43 +0000 (UTC)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0186EB
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 11:23:41 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4194c3cf04aso33858311cf.3
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 11:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1697480620; x=1698085420; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=slLQdIKd076Wd/jcmKbWiuJysNgl1PI1tXfrw1I/2ns=;
        b=RFypY+mwC6t9sbo9JHt5O+rjkefCfBzGS49N5fFZj8PUbzoS3S6Aj6MwA2jbzru8lR
         DLNX0alfgU7cg9eQW0ro2+bduCFveSQnesQXwTo6TqNx2LxdyIRvEnQuvijKJNSlQRHk
         y/afqiecl0K5CmfBjUpNmHQSASw0J1+8XluEByDF52F+Ykdi838LVuTgMB8MxwFMzBm0
         NyN8e8PiyeYg+/sZqV+ggJITbWRUDz0zVBlSkSxMImTO8ehOworSAxAN3acOFEhJvr4F
         9o2C/6cnlNKgMW+mpapWsizs39HaygxZL7uZZfsRJAzkJNd4D1Ttyz7Xxp+p98L5oZjA
         xI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480620; x=1698085420;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=slLQdIKd076Wd/jcmKbWiuJysNgl1PI1tXfrw1I/2ns=;
        b=qIUoS4CXGNWKoxMUu1yeU9KEUPlfAcn2ZMwI8aHA+O9fylAd161HMlLCncmnxuN959
         tQWmICboa7HoXfJluFrDx1fHXlQ+HPvUa9F7f5vD48jkuiF/+CiP/9rx8EDRKKfW2mIl
         3t8r2yKLLcoX1OqWV5jS+urboQQAfQAPZUbENNM+XTKMtrKv7dxr64hvY6xy+9UJAfYY
         gm2Ruo3634X2WjluBb5cY6IpU6ML4gppQ2tuHJgbxySr9kkfn4Yket+YIXwcWRwlpNzf
         Wed71aEOr3jlFXWBSiqe/nF82k2s5vq0TB35V8GpsP2VoQubSELIL9EY2N10OEDqQ5WD
         /d5w==
X-Gm-Message-State: AOJu0YzOzp3Blf/g70CNam0l2psJaB8NssMDzofgcBQ5hSNK/vyw0MAu
	I3g9YuBW4h30MqXCe4Cb1fTWekfqf5npAFKvFU3bOw==
X-Google-Smtp-Source: AGHT+IE9m6qZCIFd9+yWOJ5ESCvJa4O2jE3aDP2pNfipsaG168iLj05O0ysZ6/OU2HA3fAy3U3Motg==
X-Received: by 2002:ac8:5916:0:b0:418:163b:c5d7 with SMTP id 22-20020ac85916000000b00418163bc5d7mr55277qty.58.1697480620673;
        Mon, 16 Oct 2023 11:23:40 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id kq19-20020ac86193000000b00405502aaf76sm3218093qtb.57.2023.10.16.11.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:23:40 -0700 (PDT)
Date: Mon, 16 Oct 2023 11:23:38 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Aya Levin <ayal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
	Florian Westphal <fw@strlen.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH v2 net-next] ipv6: avoid atomic fragment on GSO packets
Message-ID: <ZS1/qtr0dZJ35VII@debian.debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

GSO packets can contain a trailing segment that is smaller than
gso_size. When examining the dst MTU for such packet, if its gso_size is
too large, then all segments would be fragmented. However, there is a
good chance the trailing segment has smaller actual size than both
gso_size as well as the MTU, which leads to an "atomic fragment". It is
considered harmful in RFC-8021. An Existing report from APNIC also shows
that atomic fragments are more likely to be dropped even it is
equivalent to a no-op [1].

Refactor __ip6_finish_output code to separate GSO and non-GSO packet
processing. It mirrors __ip_finish_output logic now. Add an extra check
in GSO handling to avoid atomic fragments. Lastly, drop dst_allfrag
check, which is no longer true since commit 9d289715eb5c ("ipv6: stop
sending PTB packets for MTU < 1280").

Link: https://www.potaroo.net/presentations/2022-03-01-ipv6-frag.pdf [1]
Fixes: b210de4f8c97 ("net: ipv6: Validate GSO SKB before finish IPv6 processing")
Suggested-by: Florian Westphal <fw@strlen.de>
Reported-by: David Wragg <dwragg@cloudflare.com>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 net/ipv6/ip6_output.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index a471c7e91761..1de6f3c11655 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -162,7 +162,14 @@ ip6_finish_output_gso_slowpath_drop(struct net *net, struct sock *sk,
 		int err;
 
 		skb_mark_not_on_list(segs);
-		err = ip6_fragment(net, sk, segs, ip6_finish_output2);
+		/* Last gso segment might be smaller than actual MTU. Adding
+		 * a fragment header to it would produce an "atomic fragment",
+		 * which is considered harmful (RFC-8021)
+		 */
+		err = segs->len > mtu ?
+			ip6_fragment(net, sk, segs, ip6_finish_output2) :
+			ip6_finish_output2(net, sk, segs);
+
 		if (err && ret == 0)
 			ret = err;
 	}
@@ -170,10 +177,19 @@ ip6_finish_output_gso_slowpath_drop(struct net *net, struct sock *sk,
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
-
 #if defined(CONFIG_NETFILTER) && defined(CONFIG_XFRM)
 	/* Policy lookup after SNAT yielded a new policy */
 	if (skb_dst(skb)->xfrm) {
@@ -183,17 +199,14 @@ static int __ip6_finish_output(struct net *net, struct sock *sk, struct sk_buff
 #endif
 
 	mtu = ip6_skb_dst_mtu(skb);
-	if (skb_is_gso(skb) &&
-	    !(IP6CB(skb)->flags & IP6SKB_FAKEJUMBO) &&
-	    !skb_gso_validate_network_len(skb, mtu))
-		return ip6_finish_output_gso_slowpath_drop(net, sk, skb, mtu);
+	if (skb_is_gso(skb))
+		return ip6_finish_output_gso(net, sk, skb, mtu);
 
-	if ((skb->len > mtu && !skb_is_gso(skb)) ||
-	    dst_allfrag(skb_dst(skb)) ||
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


