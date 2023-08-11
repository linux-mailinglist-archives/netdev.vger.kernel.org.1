Return-Path: <netdev+bounces-26657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 041C2778850
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCFC0281BBE
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 07:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48ACB5668;
	Fri, 11 Aug 2023 07:36:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7C95663
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 07:36:31 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC1112B
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:36:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d61e9cb310dso1739851276.0
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691739389; x=1692344189;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1APcOMErd5MRc/B/1D1SNQrUjR+ZxTLE3V0ZbbhyUk=;
        b=X3lFCWuCzf4ipBMLulzZhcZx4Vq5s3iy4fmEyiMxDJhXzMsoOmAsA5Ytk8hKMv5bAm
         aGgNdOt11r+JAKGnK6RjjW94d2ZJbnqHu28L1HQ6HZTeU+G/NuWa0sIOPHBBqOJupoF7
         iZV4oIxukYLtiLB1KCNPh8OJn0FGKisnqm6jogWPvxUtVAxyUW7VFqv/1aPHN8yZj5+c
         Spwo87yx//+ULDohpK8yBuDXWN3cz6A7ahrACcFZWx7v299BcTk93wnYbVmFe6GeTqwx
         u5NR0jWVA9bP0xJSSXm2ckPrbDJOFSAWh8+Oi3jEXtEB3GTUdTtvfGo/log0WAQehwvh
         KGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691739389; x=1692344189;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1APcOMErd5MRc/B/1D1SNQrUjR+ZxTLE3V0ZbbhyUk=;
        b=kc5BjMn4otuFovjpfganY6Eps0dPZ/KdOghtQEzQMOAQOg1wMwS33NEEmm8wWmAZNK
         Kxsum2EtdLthtZ1v4kxwbp8lxSG/2UFJGLhjbU0+cXKtXOHUtl5Sdt0LdbrMSKzzTjlS
         4ndEbIk8VNLPgE7jrDLH9gW7xniyUy+6mYNlsGRy6zggQm/+04YQYU9keu84EBeNIdqM
         wR86c1tf8xv//DtG0/+/HwcGFoHK0wOiSFwrJ6PMoCHItkd2eoNJPtfyZ6eL3qJp9R5W
         L0SR2FM1IceqMZkNgyLE/mX/ST09MMZnBB7Cu9JauTPBYEJsnBy0Z5TN1Taj8yGzUDZb
         vuEA==
X-Gm-Message-State: AOJu0YyaeHnMkN3nAuhpfadagVvhull38ggen49TqhcRdhL31nE6u7dv
	FQEeKyRJnRJ48/2gag7mGAbEflQ3RNGvWQ==
X-Google-Smtp-Source: AGHT+IFzjSQle2Gah683jJqJWZA9JomaBPYf0roVKm2INCqSUJbRKjhUQLx0b25MfKc3lmWExnnDcEQrpX49Kg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:7443:0:b0:d4c:2a34:aeab with SMTP id
 p64-20020a257443000000b00d4c2a34aeabmr12744ybc.11.1691739389565; Fri, 11 Aug
 2023 00:36:29 -0700 (PDT)
Date: Fri, 11 Aug 2023 07:36:10 +0000
In-Reply-To: <20230811073621.2874702-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230811073621.2874702-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230811073621.2874702-5-edumazet@google.com>
Subject: [PATCH v2 net-next 04/15] inet: move inet->recverr_rfc4884 to inet->inet_flags
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

IP_RECVERR_RFC4884 socket option can now be set/read
without locking the socket.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
---
 include/net/inet_sock.h |  2 +-
 net/ipv4/inet_diag.c    |  2 +-
 net/ipv4/ip_sockglue.c  | 18 +++++++++---------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 552188aa5a2d2f968b1d95e963d48a063ec4fd59..c01f1f64a8617582c68079048f74e0db606e1834 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -238,7 +238,6 @@ struct inet_sock {
 				mc_all:1,
 				nodefrag:1;
 	__u8			bind_address_no_port:1,
-				recverr_rfc4884:1,
 				defer_connect:1; /* Indicates that fastopen_connect is set
 						  * and cookie exists so we defer connect
 						  * until first data frame is written
@@ -271,6 +270,7 @@ enum {
 	INET_FLAGS_RECVFRAGSIZE	= 8,
 
 	INET_FLAGS_RECVERR	= 9,
+	INET_FLAGS_RECVERR_RFC4884 = 10,
 };
 
 /* cmsg flags for inet */
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 25d5f76b66bd82be2c2abc6bd5206ec54f736be6..6255d6fdbc80d82904583a8fc6c439a25e875a0b 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -191,7 +191,7 @@ int inet_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
 	inet_sockopt.mc_all	= inet->mc_all;
 	inet_sockopt.nodefrag	= inet->nodefrag;
 	inet_sockopt.bind_address_no_port = inet->bind_address_no_port;
-	inet_sockopt.recverr_rfc4884 = inet->recverr_rfc4884;
+	inet_sockopt.recverr_rfc4884 = inet_test_bit(RECVERR_RFC4884, sk);
 	inet_sockopt.defer_connect = inet->defer_connect;
 	if (nla_put(skb, INET_DIAG_SOCKOPT, sizeof(inet_sockopt),
 		    &inet_sockopt))
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 8283d862a9dbb5040db4e419e9dff31bbd3cff81..f75f44ad7b11ac169b343b3c26d744cdc81d747c 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -433,7 +433,7 @@ void ip_icmp_error(struct sock *sk, struct sk_buff *skb, int err,
 	serr->port = port;
 
 	if (skb_pull(skb, payload - skb->data)) {
-		if (inet_sk(sk)->recverr_rfc4884)
+		if (inet_test_bit(RECVERR_RFC4884, sk))
 			ipv4_icmp_error_rfc4884(skb, &serr->ee.ee_rfc4884);
 
 		skb_reset_transport_header(skb);
@@ -980,6 +980,11 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 		if (!val)
 			skb_queue_purge(&sk->sk_error_queue);
 		return 0;
+	case IP_RECVERR_RFC4884:
+		if (val < 0 || val > 1)
+			return -EINVAL;
+		inet_assign_bit(RECVERR_RFC4884, sk, val);
+		return 0;
 	}
 
 	err = 0;
@@ -1066,11 +1071,6 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 			goto e_inval;
 		inet->pmtudisc = val;
 		break;
-	case IP_RECVERR_RFC4884:
-		if (val < 0 || val > 1)
-			goto e_inval;
-		inet->recverr_rfc4884 = !!val;
-		break;
 	case IP_MULTICAST_TTL:
 		if (sk->sk_type == SOCK_STREAM)
 			goto e_inval;
@@ -1575,6 +1575,9 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	case IP_RECVERR:
 		val = inet_test_bit(RECVERR, sk);
 		goto copyval;
+	case IP_RECVERR_RFC4884:
+		val = inet_test_bit(RECVERR_RFC4884, sk);
+		goto copyval;
 	}
 
 	if (needs_rtnl)
@@ -1649,9 +1652,6 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		}
 		break;
 	}
-	case IP_RECVERR_RFC4884:
-		val = inet->recverr_rfc4884;
-		break;
 	case IP_MULTICAST_TTL:
 		val = inet->mc_ttl;
 		break;
-- 
2.41.0.640.ga95def55d0-goog


