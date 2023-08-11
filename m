Return-Path: <netdev+bounces-26665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EFF778864
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C11281099
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 07:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9316D3F;
	Fri, 11 Aug 2023 07:36:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B176E187A
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 07:36:44 +0000 (UTC)
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3F2E75
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:36:43 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id af79cd13be357-7656c94fc4eso220745185a.2
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691739403; x=1692344203;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qJUt8+f/+lp6alciWEhSRJjX+TyyCJ1VsXvCo76rQ/8=;
        b=wXH1lY7gTmD8SswhSEzVlK2rpDxjF++hguN4LYII3x/zldLqwd+1Hg1sq7Ycu0fe5L
         FvLOkjCSEUlxQMrfRTXuKnCeue2utvL1l0VGcWWnZgkSS4KJJEsYu2GOVhX2E5X5r5ed
         QVEuNEyR4VjMuIe6w9A7mGRLXuuHPdJ4t2yakvj13Abg+LL11kYnzKxUnx5EU50InY9t
         af8a/2vNEoVklbTsTGLpa1uk6SypD+2QyqZwq6yz2+/KDxRxgUbKJn+MGVRndasgnYEi
         4sZqjwfTc/SJOEU1eo862HQKmx+4VomekrWZ3Zpeq48Bx5trqSa3w+WG/JiwnIV/qJNu
         uVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691739403; x=1692344203;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJUt8+f/+lp6alciWEhSRJjX+TyyCJ1VsXvCo76rQ/8=;
        b=AifZZjf1Nq/Cc/C+C61iM8bM40F2vSC3AV81v+tJBJ52mXUlTOmn1W4OUU9l741Xh5
         nvtIX2bpKaWSHQB8nIfUj/cjCjAvBwR3nUB5Tteo48BJ64QsqwGS/q0GTJkDbJKyJEDH
         vZESzdSLthMS2SVUPRXajTH8ijd76S+h9CcwURM+6oIq6dvUBDj39jxiuAX/euPftmbn
         hno/quX1xg6XkJk9J66Qiy9fo0uyJqj+UAQy2EZ3BAQIOtM6ye+kMdr4qVrV2tt5I2WB
         IXOO9GtN+DijkGNju+GHt1QXG0Uv9whHPCOKiwaIkOr7c2F4euTMW9FcIyTjoMfve0lJ
         J3Iw==
X-Gm-Message-State: AOJu0YwLLawa1P2OriQ8IiEL2YA1Bz2Uz2MeBLw+mP2nW9CF0SgOAYYC
	o1OB8id6n26lulPoaNQRd51C1Tjw3vvTlQ==
X-Google-Smtp-Source: AGHT+IE4I0j+S8m5SL5e2o4NfFlA5JExY7yn2BGKqt6ElCAHZkf5jEyeCS52BB2B849N44Y7l3xuotDRSY+K2A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a37:bdc7:0:b0:767:a7c1:e769 with SMTP id
 n190-20020a37bdc7000000b00767a7c1e769mr11947qkf.0.1691739402985; Fri, 11 Aug
 2023 00:36:42 -0700 (PDT)
Date: Fri, 11 Aug 2023 07:36:18 +0000
In-Reply-To: <20230811073621.2874702-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230811073621.2874702-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230811073621.2874702-13-edumazet@google.com>
Subject: [PATCH v2 net-next 12/15] inet: move inet->bind_address_no_port to inet->inet_flags
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>, Soheil Hassas Yeganeh <soheil@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

IP_BIND_ADDRESS_NO_PORT socket option can now be set/read
without locking the socket.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
---
 include/net/inet_sock.h |  4 ++--
 net/ipv4/af_inet.c      |  2 +-
 net/ipv4/inet_diag.c    |  2 +-
 net/ipv4/ip_sockglue.c  | 12 ++++++------
 net/ipv6/af_inet6.c     |  2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 0e6e1b017efb1f738be1682448675ecece43c1f7..5eca2e70cbb2c16d26caa7f219ae53fe066ea3bd 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -229,8 +229,7 @@ struct inet_sock {
 	__u8			min_ttl;
 	__u8			mc_ttl;
 	__u8			pmtudisc;
-	__u8			bind_address_no_port:1,
-				defer_connect:1; /* Indicates that fastopen_connect is set
+	__u8			defer_connect:1; /* Indicates that fastopen_connect is set
 						  * and cookie exists so we defer connect
 						  * until first data frame is written
 						  */
@@ -270,6 +269,7 @@ enum {
 	INET_FLAGS_TRANSPARENT	= 15,
 	INET_FLAGS_IS_ICSK	= 16,
 	INET_FLAGS_NODEFRAG	= 17,
+	INET_FLAGS_BIND_ADDRESS_NO_PORT = 18,
 };
 
 /* cmsg flags for inet */
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index f684310c8f24ca08170f39ec955d20209566d7c5..c591f04eb6a9fc3b7b37a4b93b826a35488b9b50 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -519,7 +519,7 @@ int __inet_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
 		inet->inet_saddr = 0;  /* Use device */
 
 	/* Make sure we are allowed to bind here. */
-	if (snum || !(inet->bind_address_no_port ||
+	if (snum || !(inet_test_bit(BIND_ADDRESS_NO_PORT, sk) ||
 		      (flags & BIND_FORCE_ADDRESS_NO_PORT))) {
 		err = sk->sk_prot->get_port(sk, snum);
 		if (err) {
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 39606caad484a99a78beae399e38e56584f23f28..128966dea5540caaa94f6b87db4d3960d177caac 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -190,7 +190,7 @@ int inet_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
 	inet_sockopt.transparent = inet_test_bit(TRANSPARENT, sk);
 	inet_sockopt.mc_all	= inet_test_bit(MC_ALL, sk);
 	inet_sockopt.nodefrag	= inet_test_bit(NODEFRAG, sk);
-	inet_sockopt.bind_address_no_port = inet->bind_address_no_port;
+	inet_sockopt.bind_address_no_port = inet_test_bit(BIND_ADDRESS_NO_PORT, sk);
 	inet_sockopt.recverr_rfc4884 = inet_test_bit(RECVERR_RFC4884, sk);
 	inet_sockopt.defer_connect = inet->defer_connect;
 	if (nla_put(skb, INET_DIAG_SOCKOPT, sizeof(inet_sockopt),
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index ec946c13ea206dde3c5634d6dcd07aab7090cad8..cfa65a0b0900f2f77bfd800f105ea079e2afff7c 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1020,6 +1020,9 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 			return -ENOPROTOOPT;
 		inet_assign_bit(NODEFRAG, sk, val);
 		return 0;
+	case IP_BIND_ADDRESS_NO_PORT:
+		inet_assign_bit(BIND_ADDRESS_NO_PORT, sk, val);
+		return 0;
 	}
 
 	err = 0;
@@ -1084,9 +1087,6 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 			goto e_inval;
 		inet->uc_ttl = val;
 		break;
-	case IP_BIND_ADDRESS_NO_PORT:
-		inet->bind_address_no_port = val ? 1 : 0;
-		break;
 	case IP_MTU_DISCOVER:
 		if (val < IP_PMTUDISC_DONT || val > IP_PMTUDISC_OMIT)
 			goto e_inval;
@@ -1587,6 +1587,9 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	case IP_NODEFRAG:
 		val = inet_test_bit(NODEFRAG, sk);
 		goto copyval;
+	case IP_BIND_ADDRESS_NO_PORT:
+		val = inet_test_bit(BIND_ADDRESS_NO_PORT, sk);
+		goto copyval;
 	}
 
 	if (needs_rtnl)
@@ -1634,9 +1637,6 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		       inet->uc_ttl);
 		break;
 	}
-	case IP_BIND_ADDRESS_NO_PORT:
-		val = inet->bind_address_no_port;
-		break;
 	case IP_MTU_DISCOVER:
 		val = inet->pmtudisc;
 		break;
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index fea7918ad6ef351afc6bfb45d54aae8d658d4b55..37af30fefeca317a6fa1a32db84b6ee3500301a9 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -399,7 +399,7 @@ static int __inet6_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
 		sk->sk_ipv6only = 1;
 
 	/* Make sure we are allowed to bind here. */
-	if (snum || !(inet->bind_address_no_port ||
+	if (snum || !(inet_test_bit(BIND_ADDRESS_NO_PORT, sk) ||
 		      (flags & BIND_FORCE_ADDRESS_NO_PORT))) {
 		err = sk->sk_prot->get_port(sk, snum);
 		if (err) {
-- 
2.41.0.640.ga95def55d0-goog


