Return-Path: <netdev+bounces-26281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3CB77761D
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 12:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8961D28209F
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073C71FB53;
	Thu, 10 Aug 2023 10:39:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84331EA7B
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:39:48 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FFA26B7
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:39:41 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-569e7aec37bso10710377b3.2
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691663981; x=1692268781;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/kPJK9Vm6/M48dUQnjFp/aY8rehMLxhOfbp68rmraTM=;
        b=G1yd+t070oxjHWLHmubNuezp+73ng8JZV4Y+k8dCJWEixFqBBmFSta41foJ56sUa/j
         4HuZu31naYFGtq7XepNbIp+SuHDKuXa8EduoERxZwQHFGWYEubLpacYuHQaIOxRIXWql
         Q2MZesvbLNxUP9F/XBroRzfosj0gF30bwA902xfIbpyIosf30m27sRBziPyp1DJxdYTr
         lHTpRdZUqtwzZtucZOT2ODGuk28SJsKy8r24iKK0gwwfzBjvcuB2cIBMfjdxg/Yz91bd
         +hlcBB8e58jfvHGbZAGdyPScTipR0oj4030FbS71QV1t9YPu0lldBHhJ6gv4TBsV6pF8
         VtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691663981; x=1692268781;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/kPJK9Vm6/M48dUQnjFp/aY8rehMLxhOfbp68rmraTM=;
        b=bX46InKDrJ1KnDqLWuXL3XUnQHpKXeFn5RP3BASne0iGwMusjdutkGYi+IEHD7auxH
         uatfPm1n9ww7DwXgpL1uBFobWVlZrvPSMWJqcpkiCr71dByT1pzsW7zmIAKCnVLM02d2
         1H4eTTB/aflcgGHsPs4EVFLCAMgrUDtxYskIWZathvQpPaGiVZwFgURJkwdqiduN1BrA
         wyYdTbSd23gumL4YOSyc3v2G8dsG5gj8CHt48Pub3j1n/UAB7MJhhVNTGdFdxC8SvKZK
         Oc8mFmGFWP0e4ULy/RZMSfuMXnZqVA/BES2zzeNE5XFDD3z385C3hFwu+acmKMyBJXPF
         4MRw==
X-Gm-Message-State: AOJu0YzLuViDhuqzDPnAqF4acUJaTrO/2fyC+JS55+VYaF3Tu+Dc/RQ7
	py/ud7mntMu/LY2UML4hK0OcCclqw3fzGQ==
X-Google-Smtp-Source: AGHT+IFUoSyik0ysEX4he4GFG8Ab4FjnvZEY/Z5KjOSYkWP8qLl9GmqdDRx9bhmSNfaeFrl0D7VctPaTKhcfrg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:d304:0:b0:d4c:5b69:e95c with SMTP id
 e4-20020a25d304000000b00d4c5b69e95cmr29629ybf.1.1691663981319; Thu, 10 Aug
 2023 03:39:41 -0700 (PDT)
Date: Thu, 10 Aug 2023 10:39:14 +0000
In-Reply-To: <20230810103927.1705940-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230810103927.1705940-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230810103927.1705940-3-edumazet@google.com>
Subject: [PATCH net-next 02/15] inet: set/get simple options locklessly
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

Now we have inet->inet_flags, we can set following options
without having to hold the socket lock:

IP_PKTINFO, IP_RECVTTL, IP_RECVTOS, IP_RECVOPTS, IP_RETOPTS,
IP_PASSSEC, IP_RECVORIGDSTADDR, IP_RECVFRAGSIZE.

ip_sock_set_pktinfo() no longer hold the socket lock.

Similarly we can get the following options whithout holding
the socket lock:

IP_PKTINFO, IP_RECVTTL, IP_RECVTOS, IP_RECVOPTS, IP_RETOPTS,
IP_PASSSEC, IP_RECVORIGDSTADDR, IP_CHECKSUM, IP_RECVFRAGSIZE.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ip_sockglue.c | 118 ++++++++++++++++++++++-------------------
 1 file changed, 62 insertions(+), 56 deletions(-)

diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 66f55f3db5ec88e1c771847444eba1d554aca8dc..69b87518348aa5697edc6d88679384f00681f539 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -636,9 +636,7 @@ EXPORT_SYMBOL(ip_sock_set_mtu_discover);
 
 void ip_sock_set_pktinfo(struct sock *sk)
 {
-	lock_sock(sk);
 	inet_set_bit(PKTINFO, sk);
-	release_sock(sk);
 }
 EXPORT_SYMBOL(ip_sock_set_pktinfo);
 
@@ -952,6 +950,36 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 	if (ip_mroute_opt(optname))
 		return ip_mroute_setsockopt(sk, optname, optval, optlen);
 
+	/* Handle options that can be set without locking the socket. */
+	switch (optname) {
+	case IP_PKTINFO:
+		inet_assign_bit(PKTINFO, sk, val);
+		return 0;
+	case IP_RECVTTL:
+		inet_assign_bit(TTL, sk, val);
+		return 0;
+	case IP_RECVTOS:
+		inet_assign_bit(TOS, sk, val);
+		return 0;
+	case IP_RECVOPTS:
+		inet_assign_bit(RECVOPTS, sk, val);
+		return 0;
+	case IP_RETOPTS:
+		inet_assign_bit(RETOPTS, sk, val);
+		return 0;
+	case IP_PASSSEC:
+		inet_assign_bit(PASSSEC, sk, val);
+		return 0;
+	case IP_RECVORIGDSTADDR:
+		inet_assign_bit(ORIGDSTADDR, sk, val);
+		return 0;
+	case IP_RECVFRAGSIZE:
+		if (sk->sk_type != SOCK_RAW && sk->sk_type != SOCK_DGRAM)
+			return -EINVAL;
+		inet_assign_bit(RECVFRAGSIZE, sk, val);
+		return 0;
+	}
+
 	err = 0;
 	if (needs_rtnl)
 		rtnl_lock();
@@ -991,27 +1019,6 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 			kfree_rcu(old, rcu);
 		break;
 	}
-	case IP_PKTINFO:
-		inet_assign_bit(PKTINFO, sk, val);
-		break;
-	case IP_RECVTTL:
-		inet_assign_bit(TTL, sk, val);
-		break;
-	case IP_RECVTOS:
-		inet_assign_bit(TOS, sk, val);
-		break;
-	case IP_RECVOPTS:
-		inet_assign_bit(RECVOPTS, sk, val);
-		break;
-	case IP_RETOPTS:
-		inet_assign_bit(RETOPTS, sk, val);
-		break;
-	case IP_PASSSEC:
-		inet_assign_bit(PASSSEC, sk, val);
-		break;
-	case IP_RECVORIGDSTADDR:
-		inet_assign_bit(ORIGDSTADDR, sk, val);
-		break;
 	case IP_CHECKSUM:
 		if (val) {
 			if (!(inet_test_bit(CHECKSUM, sk))) {
@@ -1025,11 +1032,6 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 			}
 		}
 		break;
-	case IP_RECVFRAGSIZE:
-		if (sk->sk_type != SOCK_RAW && sk->sk_type != SOCK_DGRAM)
-			goto e_inval;
-		inet_assign_bit(RECVFRAGSIZE, sk, val);
-		break;
 	case IP_TOS:	/* This sets both TOS and Precedence */
 		__ip_sock_set_tos(sk, val);
 		break;
@@ -1544,6 +1546,37 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	if (len < 0)
 		return -EINVAL;
 
+	/* Handle options that can be read without locking the socket. */
+	switch (optname) {
+	case IP_PKTINFO:
+		val = inet_test_bit(PKTINFO, sk);
+		goto copyval;
+	case IP_RECVTTL:
+		val = inet_test_bit(TTL, sk);
+		goto copyval;
+	case IP_RECVTOS:
+		val = inet_test_bit(TOS, sk);
+		goto copyval;
+	case IP_RECVOPTS:
+		val = inet_test_bit(RECVOPTS, sk);
+		goto copyval;
+	case IP_RETOPTS:
+		val = inet_test_bit(RETOPTS, sk);
+		goto copyval;
+	case IP_PASSSEC:
+		val = inet_test_bit(PASSSEC, sk);
+		goto copyval;
+	case IP_RECVORIGDSTADDR:
+		val = inet_test_bit(ORIGDSTADDR, sk);
+		goto copyval;
+	case IP_CHECKSUM:
+		val = inet_test_bit(CHECKSUM, sk);
+		goto copyval;
+	case IP_RECVFRAGSIZE:
+		val = inet_test_bit(RECVFRAGSIZE, sk);
+		goto copyval;
+	}
+
 	if (needs_rtnl)
 		rtnl_lock();
 	sockopt_lock_sock(sk);
@@ -1578,33 +1611,6 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 			return -EFAULT;
 		return 0;
 	}
-	case IP_PKTINFO:
-		val = inet_test_bit(PKTINFO, sk);
-		break;
-	case IP_RECVTTL:
-		val = inet_test_bit(TTL, sk);
-		break;
-	case IP_RECVTOS:
-		val = inet_test_bit(TOS, sk);
-		break;
-	case IP_RECVOPTS:
-		val = inet_test_bit(RECVOPTS, sk);
-		break;
-	case IP_RETOPTS:
-		val = inet_test_bit(RETOPTS, sk);
-		break;
-	case IP_PASSSEC:
-		val = inet_test_bit(PASSSEC, sk);
-		break;
-	case IP_RECVORIGDSTADDR:
-		val = inet_test_bit(ORIGDSTADDR, sk);
-		break;
-	case IP_CHECKSUM:
-		val = inet_test_bit(CHECKSUM, sk);
-		break;
-	case IP_RECVFRAGSIZE:
-		val = inet_test_bit(RECVFRAGSIZE, sk);
-		break;
 	case IP_TOS:
 		val = inet->tos;
 		break;
@@ -1754,7 +1760,7 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		return -ENOPROTOOPT;
 	}
 	sockopt_release_sock(sk);
-
+copyval:
 	if (len < sizeof(int) && len > 0 && val >= 0 && val <= 255) {
 		unsigned char ucval = (unsigned char)val;
 		len = 1;
-- 
2.41.0.640.ga95def55d0-goog


