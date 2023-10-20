Return-Path: <netdev+bounces-42875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411637D07A2
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 07:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B052823A3
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 05:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF45A8F40;
	Fri, 20 Oct 2023 05:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UCHRbXYL"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F577476
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:32:55 +0000 (UTC)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800E3D57
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 22:32:54 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-49d0a704ac7so168676e0c.1
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 22:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1697779973; x=1698384773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QERO0uRdQXqqSaQdJAhee2LXGn28nhRHE84yn6ioXDc=;
        b=UCHRbXYL3xC0knyXFuBAsnyrkLGlT5t1Rqg+cpKWHrQednZoHGoTfiInP7UE+NCSFR
         wXSUe6Jwu7zzaVd3n85LoZnXW8+dqlE1Bhuxl3jPFfvL6x46DSNj9/D3DLF2LqmuCB9D
         tWbot+5hrUbZVTCTn349B4xeWIal6d8nHMFgT+1sGLA7ZjBc5ojYa5D9rR9B8t5ub5VW
         NV0+7zd6FNrsiehybQSpW6+JXRZkUN448cicU2ypFjj3plmy96MfLdNhMBjvLdQQpkcG
         wiKlBsYehe+nSW73EcWYNU+qIicC6wCqfKAZSWXlkk4Az0wwxr7oLzYz2pnDrUz+I0OD
         VnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697779973; x=1698384773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QERO0uRdQXqqSaQdJAhee2LXGn28nhRHE84yn6ioXDc=;
        b=OJ8nbghIa30DOxeU2SZ+Yk07djvHLcVjHd5vvKH5z2soqyrBMJBrOFL+27SRO0Cufi
         ZZ9BgYq6rP4TKeNEe2B/WFV+c0PCb7xznm6s6Km6LcCX/GdEJBhJv+bXCx4Z3VtN0+sF
         Z3GBUoqHdvcNE9DYSAwM5dls1mwxOwcNrzxNELp5qRfSuEas/jE4MCr9CnNtzd8R/WlG
         VNntvmAfAADzip/uowQpKzUf7qNRlYpe5BNv+a+w/1TFTdJf/MTO1wPRl0+ykDh+bm3x
         n/2FWsb+ruNFGIh8I/e+sS90kv93rdS4gd3R9XTayGBClNHL0F5LE6SKkFG8uTzH0cfZ
         n9WQ==
X-Gm-Message-State: AOJu0Ywnf+hkJI/9ghRiWfkCe+rPGT67urQ8yPdDQe8JSaHFmzn1+j1x
	fQwdm6WwNRFr3aEmcRJyYu1zwsZHwzsbmICkR8ZlEA==
X-Google-Smtp-Source: AGHT+IEuHUJNvQq/HPA6H9apAJz8f05F78aDSMAqahV84NRcnvPy5dpCqHEpkhIlb+0srBHZfqHiYw==
X-Received: by 2002:a67:ae05:0:b0:452:5798:64bd with SMTP id x5-20020a67ae05000000b00452579864bdmr920744vse.35.1697779973258;
        Thu, 19 Oct 2023 22:32:53 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id vq6-20020a05620a558600b0076e672f535asm359098qkn.57.2023.10.19.22.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 22:32:52 -0700 (PDT)
Date: Thu, 19 Oct 2023 22:32:51 -0700
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
Subject: [PATCH v3 net-next 3/3] ipv6: avoid atomic fragment on GSO packets
Message-ID: <77423bb774612f0e8eaabfd9501d03389ff2cdbd.1697779681.git.yan@cloudflare.com>
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
index 3270d56b5c37..3d4e8edaa10b 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -162,7 +162,13 @@ ip6_finish_output_gso_slowpath_drop(struct net *net, struct sock *sk,
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



