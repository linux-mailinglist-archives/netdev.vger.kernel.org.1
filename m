Return-Path: <netdev+bounces-35469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A10347A99D4
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 20:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8381C204F0
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 18:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AB943ABB;
	Thu, 21 Sep 2023 17:25:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EF8171C9
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:25:45 +0000 (UTC)
Received: from mail-io1-xd49.google.com (mail-io1-xd49.google.com [IPv6:2607:f8b0:4864:20::d49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1279245600
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:23:33 -0700 (PDT)
Received: by mail-io1-xd49.google.com with SMTP id ca18e2360f4ac-797f3f27badso78836339f.2
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695317012; x=1695921812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wyKr/bVLupYdd/YebkDscHpJV4B40NfOHgvIP+5KWxw=;
        b=sbimkM5VPAHk93ckeNN3wPd3fd84tloyFpsPCmS+dOkz5vq8GwrOB/IN5pGFHnAlGw
         SMtv5xcTHD4s8fqbJTjw/y4MAal8PgtLZO/E/IDOEre7/QI/AyWleT/sHvpmLbry9lhx
         D4hjGwvqw1mcCLgzIgjB2PjyVQ/QXAiOlitasC5+qcbCt4YZP1PmznqI2fYmzeVin+hg
         Ij4BUZmHmaoNNs+8eap/eIrhemKHUEa4N0LwAoWJ2gVKgaI9t2Byq2pqD5VptZeA3e6r
         3kGkPtje+13Thz8J6xWXOqxZ/P85kU/m0IJ3ZFVs4BS3T8HbS72djv8+X+eRRXJC/vTA
         TW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317012; x=1695921812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wyKr/bVLupYdd/YebkDscHpJV4B40NfOHgvIP+5KWxw=;
        b=BSYn0g+adxpqyKsdiA419abR/Tfsm38h0G3EVJXeAzz1sLP57aiNnU2bJWw1zWeeCl
         XQrnrR0B/FeY7DAKPxmD087JhFdxrw0gMmDU1mEm1vtBrM2ERJtFgWP3wRFlh2eXCZGl
         G01+9C1tokWtfrsMLiAUJxXIbvSYOFi6AtL8jhTyJ4gGgEbAyGOBQxHze6F/gcTK1xga
         J44vOS6jTWhQN25bQZAyrlsdEWVBp6q4LrL2jiHSvuzuAA44frmSNFxmADjM0xSeXDkp
         zS6XmUsGzOAcp7vZWQAFGGTUWkJ4b5f6aQV763difakVU1c78LbrLTwUw91T/0Hv2viU
         hrOw==
X-Gm-Message-State: AOJu0YxNJAJyClQcMzFLLrWGdkvIak/OLFy+73AJD7c2ZF9sN9tlBKP+
	QKo33iejlEl9LYxuouOI+Pus2XF2FinNbg==
X-Google-Smtp-Source: AGHT+IHDPbFMxgmwCYnNa+RWYo2tIx8JzCBN5YPWb1px2DY4B541X3aPu/dxNAKXtfL8IOr/8vpVyszDMEdo+A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:abe4:0:b0:d7f:809a:9787 with SMTP id
 v91-20020a25abe4000000b00d7f809a9787mr81553ybi.1.1695303027556; Thu, 21 Sep
 2023 06:30:27 -0700 (PDT)
Date: Thu, 21 Sep 2023 13:30:14 +0000
In-Reply-To: <20230921133021.1995349-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230921133021.1995349-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230921133021.1995349-2-edumazet@google.com>
Subject: [PATCH net-next 1/8] inet: implement lockless IP_MULTICAST_TTL
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

inet->mc_ttl can be read locklessly.

Implement proper lockless reads and writes to inet->mc_ttl

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ip_output.c            |  2 +-
 net/ipv4/ip_sockglue.c          | 31 ++++++++++++++++---------------
 net/netfilter/ipvs/ip_vs_sync.c |  2 +-
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 4ab877cf6d35f229761986d5c6a17eb2a3ad4043..adad16f1e872ce20941a087b3965fdb040868d4e 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1430,7 +1430,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 	if (cork->ttl != 0)
 		ttl = cork->ttl;
 	else if (rt->rt_type == RTN_MULTICAST)
-		ttl = inet->mc_ttl;
+		ttl = READ_ONCE(inet->mc_ttl);
 	else
 		ttl = ip_select_ttl(inet, &rt->dst);
 
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index cce9cb25f3b31cd57fa883ae0dedb6829d8da2fa..4ad3003378ae6b186513000264f77b54a7babe6d 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1039,6 +1039,17 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 
 		WRITE_ONCE(inet->min_ttl, val);
 		return 0;
+	case IP_MULTICAST_TTL:
+		if (sk->sk_type == SOCK_STREAM)
+			return -EINVAL;
+		if (optlen < 1)
+			return -EINVAL;
+		if (val == -1)
+			val = 1;
+		if (val < 0 || val > 255)
+			return -EINVAL;
+		WRITE_ONCE(inet->mc_ttl, val);
+		return 0;
 	}
 
 	err = 0;
@@ -1101,17 +1112,6 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 			goto e_inval;
 		inet->pmtudisc = val;
 		break;
-	case IP_MULTICAST_TTL:
-		if (sk->sk_type == SOCK_STREAM)
-			goto e_inval;
-		if (optlen < 1)
-			goto e_inval;
-		if (val == -1)
-			val = 1;
-		if (val < 0 || val > 255)
-			goto e_inval;
-		inet->mc_ttl = val;
-		break;
 	case IP_UNICAST_IF:
 	{
 		struct net_device *dev = NULL;
@@ -1592,6 +1592,9 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	case IP_MINTTL:
 		val = READ_ONCE(inet->min_ttl);
 		goto copyval;
+	case IP_MULTICAST_TTL:
+		val = READ_ONCE(inet->mc_ttl);
+		goto copyval;
 	}
 
 	if (needs_rtnl)
@@ -1649,9 +1652,6 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		}
 		break;
 	}
-	case IP_MULTICAST_TTL:
-		val = inet->mc_ttl;
-		break;
 	case IP_UNICAST_IF:
 		val = (__force int)htonl((__u32) inet->uc_index);
 		break;
@@ -1718,7 +1718,8 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 			put_cmsg(&msg, SOL_IP, IP_PKTINFO, sizeof(info), &info);
 		}
 		if (inet_test_bit(TTL, sk)) {
-			int hlim = inet->mc_ttl;
+			int hlim = READ_ONCE(inet->mc_ttl);
+
 			put_cmsg(&msg, SOL_IP, IP_TTL, sizeof(hlim), &hlim);
 		}
 		if (inet_test_bit(TOS, sk)) {
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 5820a8156c4701bb163f569d735c389d7a8e3820..3eed1670224888acf639cff06537ddf2505461bb 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1316,7 +1316,7 @@ static void set_mcast_ttl(struct sock *sk, u_char ttl)
 
 	/* setsockopt(sock, SOL_IP, IP_MULTICAST_TTL, &ttl, sizeof(ttl)); */
 	lock_sock(sk);
-	inet->mc_ttl = ttl;
+	WRITE_ONCE(inet->mc_ttl, ttl);
 #ifdef CONFIG_IP_VS_IPV6
 	if (sk->sk_family == AF_INET6) {
 		struct ipv6_pinfo *np = inet6_sk(sk);
-- 
2.42.0.459.ge4e396fd5e-goog


