Return-Path: <netdev+bounces-26284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A570777620
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 12:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E0421C212BC
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BB0200C9;
	Thu, 10 Aug 2023 10:39:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8775C1EA7B
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:39:52 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1763270E
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:39:46 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5840614b13cso14794247b3.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691663986; x=1692268786;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U6fQ6LEzhuoLxLnVyh4YpGt5GNogLrDcLVz8fE+53eM=;
        b=InnWlXfAd6/4/qLCrorrjIqhwHTjUZTPngU3qxxnJDJp+DpEWDYw+eY1IdoEn9vRTM
         rI3eyEk+GpBylkKPN19i9SFydAEQPUtvkrt24g+l6Lj9EbDT1+U0xQIgGvqP2lVmjljq
         YqAYDujRjXb0W1+pHl128y93HjcvYgrNQuAYDLkf21ClBOa9aVvcEUIcPGdcdXgIkviK
         IQFYRna3tJUyDEBXdBCdPZXg0dD3SmF08pizDNeX8SLNdztC2fMCCm2SPUyP/Pl1MVTo
         /NIrrtOx16ioA8i/LTtb+YLHmqw90VwgK3i4k8+MAk8T59F+w+JF2R9SfgjRhHeTfky6
         PZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691663986; x=1692268786;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U6fQ6LEzhuoLxLnVyh4YpGt5GNogLrDcLVz8fE+53eM=;
        b=CEup+P2ajESgtEXyNI6IMVyUJVGTVvqEbj56TkhmARfGH07wurWL48KOiJvrLOOwvq
         4/eKPobYqqxDCMyoHcnH+twyedUJwIn1U0hydeAqdsTtwoJxoXfVSNOfP87m8Obz00Cb
         qjGVdDru3smYkgZPE+rjYHIMtIHp9KDY6PKE7eUc7RVp5XKQ8/ugcG9sP4pw2B7UT6NZ
         LDeN0NIxEG4vjMlszsz12tSvKfSR6gZDo2aFfQsmOWDawfEnOOMSk19nG1NV1ZGf3FeP
         /2QgyWyH97AcWlLtz0IRj+SlqnmBzVtiFSgPi+TM28SlHVFZslUX4p74xCiFDEwNYLqk
         YkEQ==
X-Gm-Message-State: AOJu0Yxs8a6iv8viB4XTlbfrZn3SO9VuzNBE+WYghQ+41Y49Q1c+5bu6
	3xvk2211huX9e4v+E5nndub8Q1bxDW8B2Q==
X-Google-Smtp-Source: AGHT+IFwgebbV66p6OMrY8I+uzBZebyoEfKtpYOX6qmCR0RsKClEA0g8OMLomPKhX+Vw06EuoC3LRRAV2O0aOQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:5705:0:b0:589:a533:405b with SMTP id
 l5-20020a815705000000b00589a533405bmr31731ywb.3.1691663986007; Thu, 10 Aug
 2023 03:39:46 -0700 (PDT)
Date: Thu, 10 Aug 2023 10:39:16 +0000
In-Reply-To: <20230810103927.1705940-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230810103927.1705940-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230810103927.1705940-5-edumazet@google.com>
Subject: [PATCH net-next 04/15] inet: move inet->recverr_rfc4884 to inet->inet_flags
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


