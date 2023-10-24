Return-Path: <netdev+bounces-43739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0007B7D4591
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 04:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADCAA281841
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 02:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6590D6D1B;
	Tue, 24 Oct 2023 02:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ZgPXYpxW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69E779FE
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 02:35:43 +0000 (UTC)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB0710D5
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 19:35:38 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-66d190a8f87so25334496d6.0
        for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 19:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1698114937; x=1698719737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ANWtBi2MdCaxrrm0KgoW1Ul1Iz1M5CJm2G0yJPXRo30=;
        b=ZgPXYpxWibYgwNLYUFrWHe7A825rT5FTXIi3PBQql3SiaZVJCVQ+VgFmP2vpSzA2ry
         gpb01jcgA4QCfPbOm25cYE62fq1SPXDNLv/qiqjv3bn4oFu4W1Qga/PQ8hF11khbcd7h
         48sK2vm6tVPPgsLmQy/kkt39ZwK2c5Jwm+vzA9fEH52245eC9Oz8C9N0hmH+M5MyMFuX
         g8qHZzwpUFqBqZ8kKKfd4quZ/Tl7vat76J8IjsOyY40tozL4gaRz/YfnbW+dcjEPEV4o
         9m6VESPn/PekhvERmayft5i0rh5ZdGGmVwn2VmQVbRic7FUzotqLB+W5ex6iDnAQtcdj
         GfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698114937; x=1698719737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANWtBi2MdCaxrrm0KgoW1Ul1Iz1M5CJm2G0yJPXRo30=;
        b=VQnr2yETcsyy3le4ftWgui7z4YDkxkhbxMbl9lYSnw6eAbpe1xe+N1bdBe8o16GtcV
         kpHS4aSQhxXrimMyrRRb1U74Vyg/uvB08j8TcsoMjCYaDmHW4hXFJPdG/jiRGmcMbdjM
         E2iRjIB8kKFAdCr+ZSLvRo2UQcDuUOo0rxk+0WHEqMle9OziSRMZ491HDdM1oYAAYFwE
         k8y5LEaeuEJwyjxVGF+WGOU+c/RdxRSDInJQj9XrZ3j331eHp3lxuneg24/9BdiCXI7u
         2Gd2uxeMX0MxhXNFzSCczOv/RBBh6rDWVoK6Lk5MIMxYZ7+y2KSxa8Nz4HCUmyzHFTV3
         S3mw==
X-Gm-Message-State: AOJu0YwXOSmH+wl3qCFLED/tDOH6BNPWood6UrUT3Y1fEQgzCUTgxVCf
	f/8AZvyRAny/Q7/MV7hWny+LHrpacmBbUw3INPEZkA==
X-Google-Smtp-Source: AGHT+IGeV8Ebnl0uDo642VEo++go/0BPYcDg16vGOID8NEJ25tLFFvSguqvsL73tLZsoAIcbqFP5Vg==
X-Received: by 2002:a05:6214:27eb:b0:65a:fc6a:1423 with SMTP id jt11-20020a05621427eb00b0065afc6a1423mr15754968qvb.17.1698114937549;
        Mon, 23 Oct 2023 19:35:37 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id d11-20020a05620a140b00b00767d4a3f4d9sm3153295qkj.29.2023.10.23.19.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 19:35:37 -0700 (PDT)
Date: Mon, 23 Oct 2023 19:35:35 -0700
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
Subject: [PATCH v4 net-next 2/3] ipv6: refactor ip6_finish_output for GSO
 handling
Message-ID: <489a6b97c123700de4d28df86a95e79471cfe12b.1698114636.git.yan@cloudflare.com>
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

Separate GSO and non-GSO packets handling to make the logic cleaner. For
GSO packets, frag_max_size check can be omitted because it is only
useful for packets defragmented by netfilter hooks. Both local output
and GRO logic won't produce GSO packets when defragment is needed. This
also mirrors what IPv4 side code is doing.

Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv6/ip6_output.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 86efd901ee5a..4010dd97aaf8 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -172,6 +172,16 @@ ip6_finish_output_gso_slowpath_drop(struct net *net, struct sock *sk,
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
@@ -185,16 +195,14 @@ static int __ip6_finish_output(struct net *net, struct sock *sk, struct sk_buff
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



