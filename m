Return-Path: <netdev+bounces-42873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ED77D07A0
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 07:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B7C1C20F20
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 05:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED88A63B9;
	Fri, 20 Oct 2023 05:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HzbvMgu0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6198920E7
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:32:52 +0000 (UTC)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BFAD51
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 22:32:50 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-41cc0e9d92aso2610091cf.3
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 22:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1697779969; x=1698384769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KV869UUQKRDRmnZ80A1/n7z6+idYBNckQF54inYjS5g=;
        b=HzbvMgu0lCF6faIChfXVinjI8bdH8kCWR2utK3tXvu34fwxKuN+u7vQC/G26UceGv+
         SzAlBbmmwoyVsMMJDSYTFzUfmx4HYcSpKW17SlKRor46zKxpjr6mwSaGGbxtPh0q8TgV
         yFKM4Ca7zSRagheV0IgDbFz4qAx4bITuix1XYKvWn7fxL9oGRbvNwfXRzE8OlLpwFzQo
         ypWPvQR5Vq97WzVambzsJJY1rCxxp6gIoMAoPfLEWaABiCZp25xVa0DQyTSr5qstDPcT
         5/t822WT84u42eN7Th3pb3hEGHGm5n+IjmmX95weEKhR59aX+AtSUMlj/PwMdXA9gR5B
         QijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697779969; x=1698384769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KV869UUQKRDRmnZ80A1/n7z6+idYBNckQF54inYjS5g=;
        b=nQW/gRRUgDyp+N/Epfcfs5X7EW8p9BFf1diAenk0L7okXftfq3ao13gAzCFeBQ9m45
         bb7ixgfvVCbc7VhO3zusbmKyuKqu0+7sjlF3jAyzseaasBy8AmkZ/tS1Sp0SJFAaoWx9
         9sxLPbOzrKoIgEXCD3CvB+UtBG4YyrYLgX+gCGFPanO6MFNa6sFQVgw4ro3J7J/aiiSd
         WSmc18ApQmbEOp3IhoSVT0pPIGbewBxllJm0ubxJEW/5Uw0rLARs/Q8jyje7/ku69uz6
         3yv3FbDvvmwupfj1WlhZuYnlObaAnqj8zTFtQah3lX/c4xI85kL5ub3PUvor/JjeOHCI
         FeGg==
X-Gm-Message-State: AOJu0YxcLhx+svMANy2u71kdrfgpg73VsmjlukcBWLJt80+VDwlqCr/A
	YYXpvKnhZMeL7B5X7IJLYr+YKBkXCzK12ZH1gK9vZw==
X-Google-Smtp-Source: AGHT+IE/sGedLpUr4sLQdyiagGVmU5aZdQlN8A0vLvzrjxYrZUHQz/La835JeQyomnGiOmnneXe/Bg==
X-Received: by 2002:a05:6214:d66:b0:66d:1e25:9774 with SMTP id 6-20020a0562140d6600b0066d1e259774mr916666qvs.61.1697779969555;
        Thu, 19 Oct 2023 22:32:49 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id g20-20020ad457b4000000b0065d0dcc28e3sm421513qvx.73.2023.10.19.22.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 22:32:49 -0700 (PDT)
Date: Thu, 19 Oct 2023 22:32:47 -0700
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
Subject: [PATCH v3 net-next 1/3] ipv6: remove dst_allfrag test on ipv6 output
Message-ID: <e721c615e22fc4d3d53bfa230d5d71462ae9c9a8.1697779681.git.yan@cloudflare.com>
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

dst_allfrag was added before the first git commit:

https://www.mail-archive.com/bk-commits-head@vger.kernel.org/msg03399.html

The feature would send packets to the fragmentation path if a box
receives a PMTU value with less than 1280 byte. However, since commit
9d289715eb5c ("ipv6: stop sending PTB packets for MTU < 1280"), such
message would be simply discarded. The feature flag is neither supported
in iproute2 utility. In theory one can still manipulate it with direct
netlink message, but it is not ideal because it was based on obsoleted
guidance of RFC-2460 (replaced by RFC-8200).

The feature test would always return false at the moment, so remove it
from the output path.

Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 net/ipv6/ip6_output.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index a471c7e91761..ae87a3817d4a 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -189,7 +189,6 @@ static int __ip6_finish_output(struct net *net, struct sock *sk, struct sk_buff
 		return ip6_finish_output_gso_slowpath_drop(net, sk, skb, mtu);
 
 	if ((skb->len > mtu && !skb_is_gso(skb)) ||
-	    dst_allfrag(skb_dst(skb)) ||
 	    (IP6CB(skb)->frag_max_size && skb->len > IP6CB(skb)->frag_max_size))
 		return ip6_fragment(net, sk, skb, ip6_finish_output2);
 	else
-- 
2.30.2



