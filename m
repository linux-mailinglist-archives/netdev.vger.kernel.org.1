Return-Path: <netdev+bounces-16848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF39674EFDD
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 15:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B86FA1C20EDF
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 13:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909B918C15;
	Tue, 11 Jul 2023 13:06:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E0018C02
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 13:06:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A04598
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 06:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689080788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S4UxQdp/748YKmly8xTnwGt7CRzv2lMZ1LWZ2RMF/iY=;
	b=jF9HbgSsl/xnmc+/RWNTCAlX2zHTsK3oawaBqH7FVWHJTMnPGO8hXBjJQJGnjrjTjVKjeO
	qhk1e7q0qBj4t4HbliKkD3w54+2aEv1FZTOkPEw3BVM3OXVMev6cPIAtf1fZRUSsg0CCLs
	OOYNomyjmoIyZnYzMlXRZBlhRUOHf50=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-RwW1RCp6Oymzt3kAwlR32g-1; Tue, 11 Jul 2023 09:06:27 -0400
X-MC-Unique: RwW1RCp6Oymzt3kAwlR32g-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7624ca834b5so840782385a.0
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 06:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689080786; x=1691672786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4UxQdp/748YKmly8xTnwGt7CRzv2lMZ1LWZ2RMF/iY=;
        b=GA2UqGwC3npnzcN8BUcCgnXQeKehoWAFeZHJ1i/kcdqDwYykj532rBBWtKpNj/YLei
         9bSMQeAL/TyS8FmZakhK1NkqkMP12BI6BcF78qYrhMrKMhDChMDHQ0FDQlBoV9SbMw5s
         eqSO5dY3WQ5AF4NAAcL/HvUz/omwzE4qxA063kv8uR2OSbTkVjuTKsjw79OxJuLUW9dJ
         xkd1PdxQS75HRWsjkPtLD81dRwKFidyLRjKg/KK5OSXaIAL9ndJvj53/lxxirPKeliIR
         ahfDsl6QAA7ak7+QxbQH6NzWLES3lpCzaQdiktdYz3mLyXTHcLNo7CjQXNFlY+x/SNbK
         Rteg==
X-Gm-Message-State: ABy/qLZUTXIHwHu8+6wibEc4SP5pB8LzHdeBu9KrXps7KLtIY4blJJ50
	gnw8fsAImcWKqWYeuFfBaf16HiZ4Kmex3bjGZcecCpZpEmQyQeTR6yKvVBvnAla0RFAUcABaPlp
	L2J0ot5AfQUv9yEkc
X-Received: by 2002:a05:620a:2551:b0:767:7de5:85f2 with SMTP id s17-20020a05620a255100b007677de585f2mr19408430qko.68.1689080786684;
        Tue, 11 Jul 2023 06:06:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHcyYcD0n17FmHvuJcJGOJnNE0KzA64NIZiM7v9jh1GK9RTyTJiQ5muyg/YwfQwvgTSlpykWA==
X-Received: by 2002:a05:620a:2551:b0:767:7de5:85f2 with SMTP id s17-20020a05620a255100b007677de585f2mr19408407qko.68.1689080786453;
        Tue, 11 Jul 2023 06:06:26 -0700 (PDT)
Received: from debian ([92.62.32.42])
        by smtp.gmail.com with ESMTPSA id x7-20020a05620a01e700b007621b1bcbbfsm957820qkn.102.2023.07.11.06.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 06:06:26 -0700 (PDT)
Date: Tue, 11 Jul 2023 15:06:21 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next 3/4] ipv6: Constify the sk parameter of several
 helper functions.
Message-ID: <38ea4cdcbd51177aae71c2e9fd9ca4a837ae01ec.1689077819.git.gnault@redhat.com>
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

icmpv6_flow_init(), ip6_datagram_flow_key_init() and ip6_mc_hdr() don't
need to modify their sk argument. Make that explicit using const.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 include/linux/icmpv6.h | 10 ++++------
 net/ipv6/datagram.c    |  7 ++++---
 net/ipv6/icmp.c        |  6 ++----
 net/ipv6/mcast.c       |  8 +++-----
 4 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/include/linux/icmpv6.h b/include/linux/icmpv6.h
index db0f4fcfdaf4..e3b3b0fa2a8f 100644
--- a/include/linux/icmpv6.h
+++ b/include/linux/icmpv6.h
@@ -85,12 +85,10 @@ extern void				icmpv6_param_prob_reason(struct sk_buff *skb,
 
 struct flowi6;
 struct in6_addr;
-extern void				icmpv6_flow_init(struct sock *sk,
-							 struct flowi6 *fl6,
-							 u8 type,
-							 const struct in6_addr *saddr,
-							 const struct in6_addr *daddr,
-							 int oif);
+
+void icmpv6_flow_init(const struct sock *sk, struct flowi6 *fl6, u8 type,
+		      const struct in6_addr *saddr,
+		      const struct in6_addr *daddr, int oif);
 
 static inline void icmpv6_param_prob(struct sk_buff *skb, u8 code, int pos)
 {
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index 9b6818453afe..d80d6024cafa 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -38,10 +38,11 @@ static bool ipv6_mapped_addr_any(const struct in6_addr *a)
 	return ipv6_addr_v4mapped(a) && (a->s6_addr32[3] == 0);
 }
 
-static void ip6_datagram_flow_key_init(struct flowi6 *fl6, struct sock *sk)
+static void ip6_datagram_flow_key_init(struct flowi6 *fl6,
+				       const struct sock *sk)
 {
-	struct inet_sock *inet = inet_sk(sk);
-	struct ipv6_pinfo *np = inet6_sk(sk);
+	const struct inet_sock *inet = inet_sk(sk);
+	const struct ipv6_pinfo *np = inet6_sk(sk);
 	int oif = sk->sk_bound_dev_if;
 
 	memset(fl6, 0, sizeof(*fl6));
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 9edf1f45b1ed..988d21166837 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -1031,11 +1031,9 @@ static int icmpv6_rcv(struct sk_buff *skb)
 	return 0;
 }
 
-void icmpv6_flow_init(struct sock *sk, struct flowi6 *fl6,
-		      u8 type,
+void icmpv6_flow_init(const struct sock *sk, struct flowi6 *fl6, u8 type,
 		      const struct in6_addr *saddr,
-		      const struct in6_addr *daddr,
-		      int oif)
+		      const struct in6_addr *daddr, int oif)
 {
 	memset(fl6, 0, sizeof(*fl6));
 	fl6->saddr = *saddr;
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 714cdc9e2b8e..5ce25bcb9974 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -1699,11 +1699,9 @@ mld_scount(struct ifmcaddr6 *pmc, int type, int gdeleted, int sdeleted)
 	return scount;
 }
 
-static void ip6_mc_hdr(struct sock *sk, struct sk_buff *skb,
-		       struct net_device *dev,
-		       const struct in6_addr *saddr,
-		       const struct in6_addr *daddr,
-		       int proto, int len)
+static void ip6_mc_hdr(const struct sock *sk, struct sk_buff *skb,
+		       struct net_device *dev, const struct in6_addr *saddr,
+		       const struct in6_addr *daddr, int proto, int len)
 {
 	struct ipv6hdr *hdr;
 
-- 
2.39.2


