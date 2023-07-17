Return-Path: <netdev+bounces-18299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8036B756584
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 15:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B630281323
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 13:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204C5BA39;
	Mon, 17 Jul 2023 13:53:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1541FBA2E
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 13:53:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19315F5
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 06:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689602022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fJ7M8ndWWkx3e/2RVZAso//ELmQ26/rKM/2vgLOQ29k=;
	b=EqOOqx5+LcmZ5if9Ef1gZORjO9ygNJtA2KrvdUQy8Yo5CfgB4zhyNHGVDNSJEKjwZZg9mf
	VU1FtNn2Ima+nGPducsk28J7MJLCpRPwywG4pazBhy5TguzH+UGwCEogoZVVglXPhBfjmp
	PTdvBmg+RqzqFgE5f2ma9sGFc+bl4Zg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-oq97MgMCP7aUTHaXaUMFVg-1; Mon, 17 Jul 2023 09:53:40 -0400
X-MC-Unique: oq97MgMCP7aUTHaXaUMFVg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-76746f54ba9so613264185a.0
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 06:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689602020; x=1692194020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJ7M8ndWWkx3e/2RVZAso//ELmQ26/rKM/2vgLOQ29k=;
        b=QFWd2EBjiPCVklkJnwB2LCU3N1UrQtmHZa6m7/FFnkDoiW/ox6XQRy9uatZlMLZaW7
         UUgm/XvUy4STFEY+cNC+XPfWW1u+fZbzjfJfI9bhx+oUx+xkSwuOF+qchfiGtLEjAUqH
         E9pnnZCgvcgYdweDIUZcbNCn9kcmmEWTXGiYoy+vTFgrFXHe7EPny5sfdu5JUWbmZiMt
         E+KKeDuW3FJ8n9rW7IekiCZ8avFGjQfuyb5DSPkNKThQITZacI5bXZUx386Q4xLo0WGb
         eewGVDAxLtXPgxwy26fUYDaaMr8GgwPYVTmSKwwhTZ/oWzyy+U/G8pTmBZdpscsNNk3h
         fwlg==
X-Gm-Message-State: ABy/qLYhihzwELC1KVqmG0ucFnZd6VKD3MRRnGwbmz5Oyq9K0U7D24ic
	PbQPNMCdqpW+yooupV+ecm7OaRgYZ472o2wywJNxpm7AFf8b0GJribAW70h3giwpJaGtYKoKjUu
	AmeoOsj8VFMDvfM17
X-Received: by 2002:a05:620a:1a0d:b0:765:3e03:10db with SMTP id bk13-20020a05620a1a0d00b007653e0310dbmr15047525qkb.48.1689602020510;
        Mon, 17 Jul 2023 06:53:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFzWZdgTUrzDhDU1m1IObzlkNO78/Af8/69MC3hhvRl/+ryasnFWZC/PcNIbS+6mi1LboTVdQ==
X-Received: by 2002:a05:620a:1a0d:b0:765:3e03:10db with SMTP id bk13-20020a05620a1a0d00b007653e0310dbmr15047511qkb.48.1689602020293;
        Mon, 17 Jul 2023 06:53:40 -0700 (PDT)
Received: from debian ([92.62.32.42])
        by smtp.gmail.com with ESMTPSA id g18-20020a05620a13d200b00767cd2dbd82sm6108028qkl.15.2023.07.17.06.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 06:53:39 -0700 (PDT)
Date: Mon, 17 Jul 2023 15:53:35 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, dccp@vger.kernel.org
Subject: [PATCH net-next 2/3] dccp: Set TOS and routing scope independently
 for fib lookups.
Message-ID: <d316b3692ee6ef6c91bfcf246aeae45c0e104dd0.1689600901.git.gnault@redhat.com>
References: <cover.1689600901.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689600901.git.gnault@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There's no reason for setting the RTO_ONLINK flag in ->flowi4_tos as
RT_CONN_FLAGS() does. We can easily set ->flowi4_scope properly
instead. This makes the code more explicit and will allow to convert
->flowi4_tos to dscp_t in the future.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/dccp/ipv4.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index fa8079303cb0..8e919cfe6e23 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -474,7 +474,8 @@ static struct dst_entry* dccp_v4_route_skb(struct net *net, struct sock *sk,
 		.flowi4_oif = inet_iif(skb),
 		.daddr = iph->saddr,
 		.saddr = iph->daddr,
-		.flowi4_tos = RT_CONN_FLAGS(sk),
+		.flowi4_tos = ip_sock_rt_tos(sk),
+		.flowi4_scope = ip_sock_rt_scope(sk),
 		.flowi4_proto = sk->sk_protocol,
 		.fl4_sport = dccp_hdr(skb)->dccph_dport,
 		.fl4_dport = dccp_hdr(skb)->dccph_sport,
-- 
2.39.2


