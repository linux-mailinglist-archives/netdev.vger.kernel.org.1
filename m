Return-Path: <netdev+bounces-43740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9057D4593
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 04:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3D91F225B8
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 02:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403376FD5;
	Tue, 24 Oct 2023 02:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WCu9otX4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C48E7468
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 02:35:45 +0000 (UTC)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E52F10C9
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 19:35:40 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-77897c4ac1fso259364285a.3
        for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 19:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1698114939; x=1698719739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6S93RbRglo4zJtt34VMTicjVThmJc0ap31UZOgLJcsE=;
        b=WCu9otX47GCdVRdugIJIAODwuN1dOZ9H2eEAtQfYrgUmi2E9JeCLwzPF9328sqKmM7
         RdXiUp/zbaF1EgGI/YQT39EY5C64RCCiqM6ztsE1SE4J2ZkWT6e54ghifIPsFHHS1e/g
         bC1hUwswNLjBiw4FkvBN20kAz5K9pIdbW3EUNMIWbpvIohA3HlQp893nJGEtp3j/BSE9
         0Uj/MPZ7Tg2ppgri9wn5LVowrgCZrr/6rczgvFTtx11L6vtw2v70aFEEY92OwUfGkDAc
         nXjt8OkTaT0zQQPrMYw53MCntTldvVX2t8RBeKCA0sHftL9TPi/itqIUOw3E77n2gAkM
         Gnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698114939; x=1698719739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6S93RbRglo4zJtt34VMTicjVThmJc0ap31UZOgLJcsE=;
        b=YlZ9MFR3RtvhCZG8FzpZRQETyzkHVZloqDNLxeuVDywCalIP3JmVir0l/2JT2kc5dI
         UpWr7OklfPpzQx4h9KMoIpBDXzE/kQxPUGUgiSDDvGn4nVk4gGHIzyb/3hBENUgESqJA
         f/pzzwrPdip+qJ/HffsunICqr8o7mfIP5LZfH0y+Md9DJ/8nRLrzFx2LHd3jPeic47r5
         3OBWDXM84/xaO86dcYTcUaM4UCFBSW/74u+pLVWgSoJjae9M+z+GZGFfksanoozsqAAz
         t1uSHuv2duu8amVOCmsLACGxUSmENhJTSQScIOTrEWM54a1yVLrlW13Amn10an5Zmi7q
         dZeg==
X-Gm-Message-State: AOJu0Yz0y6g+Ta9cxdEvpsUEEd85O2ugP6UN00DcXC7WT4WUA904ec9E
	tiXy36K39o4Xt3UbeVrasp+5xhtiOk5Yxfj11wwE7w==
X-Google-Smtp-Source: AGHT+IFeSNLxbbaTEz7kuBUXmZKSLILtgAtkYjWmUsJsYLJo9qtUUPYsz1aa129SuvLRTlepJgm2LQ==
X-Received: by 2002:a05:620a:24cb:b0:775:9e64:f5be with SMTP id m11-20020a05620a24cb00b007759e64f5bemr12393344qkn.55.1698114939293;
        Mon, 23 Oct 2023 19:35:39 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id e6-20020a05620a208600b007742218dc42sm3122060qka.119.2023.10.23.19.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 19:35:38 -0700 (PDT)
Date: Mon, 23 Oct 2023 19:35:37 -0700
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
Subject: [PATCH v4 net-next 3/3] ipv6: avoid atomic fragment on GSO packets
Message-ID: <6b2347a888c8b2d8f259dbb4662c4995ba9a505e.1698114636.git.yan@cloudflare.com>
References: <cover.1698114636.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698114636.git.yan@cloudflare.com>

When the ipv6 stack output a GSO packet, if its gso_size is larger than
dst MTU, then all segments would be fragmented. However, it is possible
for a GSO packet to have a trailing segment with smaller actual size
than both gso_size as well as the MTU, which leads to an "atomic
fragment". Atomic fragments are considered harmful in RFC-8021. An
Existing report from APNIC also shows that atomic fragments are more
likely to be dropped even it is equivalent to a no-op [1].

Add an extra check in the GSO slow output path. For each segment from
the original over-sized packet, if it fits with the path MTU, then avoid
generating an atomic fragment.

Link: https://www.potaroo.net/presentations/2022-03-01-ipv6-frag.pdf [1]
Fixes: b210de4f8c97 ("net: ipv6: Validate GSO SKB before finish IPv6 processing")
Reported-by: David Wragg <dwragg@cloudflare.com>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 net/ipv6/ip6_output.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 4010dd97aaf8..a722a43dd668 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -164,7 +164,13 @@ ip6_finish_output_gso_slowpath_drop(struct net *net, struct sock *sk,
 		int err;
 
 		skb_mark_not_on_list(segs);
-		err = ip6_fragment(net, sk, segs, ip6_finish_output2);
+		/* Last GSO segment can be smaller than gso_size (and MTU).
+		 * Adding a fragment header would produce an "atomic fragment",
+		 * which is considered harmful (RFC-8021). Avoid that.
+		 */
+		err = segs->len > mtu ?
+			ip6_fragment(net, sk, segs, ip6_finish_output2) :
+			ip6_finish_output2(net, sk, segs);
 		if (err && ret == 0)
 			ret = err;
 	}
-- 
2.30.2



