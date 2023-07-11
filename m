Return-Path: <netdev+bounces-16847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7E274EFDA
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 15:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3726281683
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 13:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD5018C06;
	Tue, 11 Jul 2023 13:06:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E00F18C02
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 13:06:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924241710
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 06:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689080783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jhHE1KP3Eg1fH7yJTxAtaCDI0xpIOjhq6HVm2UfMJCc=;
	b=Jg9es/bfYxZMALzqz3jT6mGgD8Mrg8iNJ48/KzVIFYP7v9tmjKYJleTa5NVPBA7WJdGPd5
	A0xPeepKnH1bFL3RT5spyXiUd/9tQx4nQmhC8ftoMORWuk3ZRNjZZKqp4E2V6XTv3xHSuP
	zN7Cl2+ie9fr936vF9sB/9GvaSzD1Wk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-wxcdXfqiMpmBWmJat99v6g-1; Tue, 11 Jul 2023 09:06:22 -0400
X-MC-Unique: wxcdXfqiMpmBWmJat99v6g-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-635a3b9d24eso46354406d6.0
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 06:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689080781; x=1691672781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhHE1KP3Eg1fH7yJTxAtaCDI0xpIOjhq6HVm2UfMJCc=;
        b=NS0hE96Io8LUs6g/sGFphH9HObvXvKDSc/c9VA5p7RVfQsNpHlgUXggNpa8J5Wss7n
         D4K7pvb6Ju8V8m03SUO4FAbfSiZyURsaM2F6AATwAHKW2mW33ExE28sKb/wn2ikGMr3R
         KWD9i5prZ+m3vu/fb+onPOTu73WYaihHk1rNHuqMP7cRjlS/8mAuTnv6gcuKJz+V7TU/
         eFLqySacRiRFrNpz187TTngsiGSFhQjj5WXXd/OaSZ/1+5FyikA5HPn6a4gzHx8HcUm6
         FQTJxPu8DiUDgrIAOfDiMg/2YkOJXb6o6iPZlz/X9B50tFsQLubEvRdbnt7ohYEsSSaY
         m+AA==
X-Gm-Message-State: ABy/qLZugQDYs/H9wcs/lPD1962Gf7dWfeI5lVBgYP4eOZgXSgPiEqij
	gHtl7fHPtQvVOsBLQ5T3Sk1l3CVUZZKpmgRshbFDIaSSmTGeJbrUF9TIeXK12MsSNLvUPB36gcS
	pxeUaFvsDySP1LmINJPgO9crQ
X-Received: by 2002:a0c:cb14:0:b0:62f:eb6d:1796 with SMTP id o20-20020a0ccb14000000b0062feb6d1796mr11939774qvk.30.1689080781430;
        Tue, 11 Jul 2023 06:06:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEMZPsRke6ph+eFqrQbvXN5A08b/Y9KSSaxpS6KgupBqp1a8yCCdrYkbViNUsXAI0QjcbNIZQ==
X-Received: by 2002:a0c:cb14:0:b0:62f:eb6d:1796 with SMTP id o20-20020a0ccb14000000b0062feb6d1796mr11939735qvk.30.1689080780857;
        Tue, 11 Jul 2023 06:06:20 -0700 (PDT)
Received: from debian ([92.62.32.42])
        by smtp.gmail.com with ESMTPSA id q8-20020a0c8cc8000000b0062ffcda34c6sm1026729qvb.137.2023.07.11.06.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 06:06:20 -0700 (PDT)
Date: Tue, 11 Jul 2023 15:06:14 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next 2/4] ipv4: Constify the sk parameter of
 ip_route_output_*().
Message-ID: <195d71a41fb3e6d2fc36bc843e5909c9240ef163.1689077819.git.gnault@redhat.com>
References: <cover.1689077819.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689077819.git.gnault@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

These functions don't need to modify the socket, so let's allow the
callers to pass a const struct sock *.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 include/net/route.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index 5a5c726472bd..d8d150155195 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -163,7 +163,7 @@ static inline struct rtable *ip_route_output(struct net *net, __be32 daddr,
 }
 
 static inline struct rtable *ip_route_output_ports(struct net *net, struct flowi4 *fl4,
-						   struct sock *sk,
+						   const struct sock *sk,
 						   __be32 daddr, __be32 saddr,
 						   __be16 dport, __be16 sport,
 						   __u8 proto, __u8 tos, int oif)
@@ -309,7 +309,7 @@ static inline void ip_route_connect_init(struct flowi4 *fl4, __be32 dst,
 static inline struct rtable *ip_route_connect(struct flowi4 *fl4, __be32 dst,
 					      __be32 src, int oif, u8 protocol,
 					      __be16 sport, __be16 dport,
-					      struct sock *sk)
+					      const struct sock *sk)
 {
 	struct net *net = sock_net(sk);
 	struct rtable *rt;
@@ -330,7 +330,7 @@ static inline struct rtable *ip_route_connect(struct flowi4 *fl4, __be32 dst,
 static inline struct rtable *ip_route_newports(struct flowi4 *fl4, struct rtable *rt,
 					       __be16 orig_sport, __be16 orig_dport,
 					       __be16 sport, __be16 dport,
-					       struct sock *sk)
+					       const struct sock *sk)
 {
 	if (sport != orig_sport || dport != orig_dport) {
 		fl4->fl4_dport = dport;
-- 
2.39.2


