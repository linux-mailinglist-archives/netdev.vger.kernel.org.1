Return-Path: <netdev+bounces-33310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F01F79D5C9
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06988281E53
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B761DA56;
	Tue, 12 Sep 2023 16:02:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072971DA44
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 16:02:35 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F50310FC
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:02:33 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-591138c0978so65078537b3.1
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694534553; x=1695139353; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w1d+7L0GJ1f3PrDqlZdBo+lriVdUW9jcUN5yNbRadEw=;
        b=EGOSm5gs0/RuxxSgrLjTqLXb+OTpCdyRUBfWW3/oRVpZ+ClapeyVyRLRJRCxZLsMjP
         SGIhp+nObMvzijmtpVahwIfiUTNM6F3MDrCNm5yth8ft4GntqMMIekdETaulERvGaHBw
         zyQ40k1w+wBlWhOVrUJGU88p2SE/vey6s3cHCbbPeBGlDp1JXGfljO5jLCQFHlktAka2
         GzH6BNqEStrQLSS0CqnvtJ8mcxrIAAV5KQ90KI7BC7ySoPyYRK0/f7IVMN6yRDedgv6x
         9irtdxvXWiWQ8QbF7qJ96wOmmEVyV1isRt7HnTZdrf+0f4uxadMOs8PAT3RlJm///k0f
         INmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694534553; x=1695139353;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w1d+7L0GJ1f3PrDqlZdBo+lriVdUW9jcUN5yNbRadEw=;
        b=GmQ1czaek9ptNKqcruQ/TbW25SCEgjOgCXZGTrYZ3Wk9G3pOdVitMH2blDx7mqppuG
         grm2kpAD+oRlVYbe5EBO+OIod4GJWzTAEGerjlptyJsPgZtXssVXurIzWTpEMVoHv5Ib
         0RjAZ/XgYaaEkyz1mooUNptW+6uoRQRcXmF9O/S3iS4LwYa4aXMlsPe8+2/gN5gtCg3M
         snvDhm5v3TeRTYRIgcq8tmVpKdks8U/lI1udiL9pMkoirTJ9tD4vZRdQ/XcGKfWhDssg
         3NdtyuahcNnliQJ8tdh6RoC74USqid0LEiSmHrCdF5Nd34TQUWS7pDi+dERHc6ewC1oF
         Xg/Q==
X-Gm-Message-State: AOJu0YzfLSzLA0ppFAC3woyw+m+jMDNWkfqEMyC9vCeSB03AvkeXBJnV
	FngCrJs3pmcgvGdw/Jv2DBpSh6PhKIEtzA==
X-Google-Smtp-Source: AGHT+IFA8PDWu+dsuyRIQ9gZY88IEW9n0JtsIFtZFFndXULnm7sQKxGkbS+om2e2w3HFPHG+R3HxZQhMDgKwWg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:98d:b0:d7a:bd65:18ba with SMTP
 id bv13-20020a056902098d00b00d7abd6518bamr326348ybb.3.1694534553077; Tue, 12
 Sep 2023 09:02:33 -0700 (PDT)
Date: Tue, 12 Sep 2023 16:02:10 +0000
In-Reply-To: <20230912160212.3467976-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230912160212.3467976-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912160212.3467976-13-edumazet@google.com>
Subject: [PATCH net-next 12/14] ipv6: lockless IPV6_ROUTER_ALERT_ISOLATE implementation
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Reads from np->rtalert_isolate are racy.

Move this flag to inet->inet_flags to fix data-races.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/ipv6.h     |  3 +--
 include/net/inet_sock.h  |  1 +
 net/ipv6/ip6_output.c    |  3 +--
 net/ipv6/ipv6_sockglue.c | 13 ++++++-------
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index e62413371ea40cbd9f13aa6ac6b6be41a6831237..f288a35f157f73ded445639c30f3365047fd9ddc 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -246,11 +246,10 @@ struct ipv6_pinfo {
 	__u16			sndflow:1,
 				pmtudisc:3,
 				padding:1,	/* 1 bit hole */
-				srcprefs:3,	/* 001: prefer temporary address
+				srcprefs:3;	/* 001: prefer temporary address
 						 * 010: prefer public address
 						 * 100: prefer care-of address
 						 */
-				rtalert_isolate:1;
 	__u8			min_hopcount;
 	__u8			tclass;
 	__be32			rcv_flowinfo;
diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 5d61c7dc6577827740254f0e9aa288065f1bda7f..befee0f66c0555f3ac4524fd8f7780ff21c04aaa 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -276,6 +276,7 @@ enum {
 	INET_FLAGS_DONTFRAG	= 25,
 	INET_FLAGS_RECVERR6	= 26,
 	INET_FLAGS_REPFLOW	= 27,
+	INET_FLAGS_RTALERT_ISOLATE = 28,
 };
 
 /* cmsg flags for inet */
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 8851fe5d45a0781c8b78c995c2c4c6c81e10cd52..f87d8491d7e273f167b7b144a7e134783e1b80f6 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -368,9 +368,8 @@ static int ip6_call_ra_chain(struct sk_buff *skb, int sel)
 		if (sk && ra->sel == sel &&
 		    (!sk->sk_bound_dev_if ||
 		     sk->sk_bound_dev_if == skb->dev->ifindex)) {
-			struct ipv6_pinfo *np = inet6_sk(sk);
 
-			if (np && np->rtalert_isolate &&
+			if (inet6_test_bit(RTALERT_ISOLATE, sk) &&
 			    !net_eq(sock_net(sk), dev_net(skb->dev))) {
 				continue;
 			}
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index ec10b45c49c15f9655466a529046f741f8b9fc69..c22a492e05360b68ef6868707e363f2ce84a4c35 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -488,6 +488,11 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		if (!val)
 			skb_errqueue_purge(&sk->sk_error_queue);
 		return 0;
+	case IPV6_ROUTER_ALERT_ISOLATE:
+		if (optlen < sizeof(int))
+			return -EINVAL;
+		inet6_assign_bit(RTALERT_ISOLATE, sk, valbool);
+		return 0;
 	}
 	if (needs_rtnl)
 		rtnl_lock();
@@ -936,12 +941,6 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 			goto e_inval;
 		retv = ip6_ra_control(sk, val);
 		break;
-	case IPV6_ROUTER_ALERT_ISOLATE:
-		if (optlen < sizeof(int))
-			goto e_inval;
-		np->rtalert_isolate = valbool;
-		retv = 0;
-		break;
 	case IPV6_MTU_DISCOVER:
 		if (optlen < sizeof(int))
 			goto e_inval;
@@ -1452,7 +1451,7 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case IPV6_ROUTER_ALERT_ISOLATE:
-		val = np->rtalert_isolate;
+		val = inet6_test_bit(RTALERT_ISOLATE, sk);
 		break;
 
 	case IPV6_RECVERR_RFC4884:
-- 
2.42.0.283.g2d96d420d3-goog


