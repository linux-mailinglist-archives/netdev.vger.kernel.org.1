Return-Path: <netdev+bounces-33302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECA779D5B1
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02C61C20E34
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6307B19BBD;
	Tue, 12 Sep 2023 16:02:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5774E19BBB
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 16:02:29 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91D710EF
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:02:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d812e4d1256so410158276.2
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694534544; x=1695139344; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vJcyHYWzL2Tc1bltz9uxotUiAw+4tOvfxW1Zh6sc5IE=;
        b=vRybW3CLad+GsifqqykAtWGdYU2HJphwYl4M8Sdvee39bgTZbSnVfOyUFpDjLA52J6
         SyKOQwE23EScT97tDeG/CswQ3pQYRUWT9GsLeVh7AhaSxTu8I+mLJRpxoxLge/1rEbar
         7npitHByVSaw6l0RqvIDttP7ZW03h9WHsfwK4RZz/VvVSXc+KZ0/Zzg+sOlNI/x7xQBW
         Ooed88gIusZTe2KsfT60FbXtyU8LwIemSDa4H+axEm+8uNFwUvMA4kQq9pqV4KbVDsdL
         qvP2QMdGWZs7gBrBDaZntz18DghNI5K+DUjiP47FD3gtt1Sa+lMAPeMYcSZc/FpWcApX
         I6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694534544; x=1695139344;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJcyHYWzL2Tc1bltz9uxotUiAw+4tOvfxW1Zh6sc5IE=;
        b=kOITLPFizeXKL5gpliBdYR+koATzUq9Nul7tS+WRxqmitMC49aZr+6vJaLhh3TVIHE
         W+wDdLcvFp3W+26QRAoZ1B07/0+smfBsVSy3RGCWGh2U/u2eudKGRI2Ou0EH1uwdTu/V
         /oDXkYrJk08pgMjSR7IcY0+xDOGuVpNigBSLeaID4EnM7lXC43hYsClqnCTysXXPw48t
         YbkgaG1OrgjrgwvpCYr+4g7j6h3YirDNf4uoUPLeDE5wwPGHae2Z36Uq4qmbIYNuPetn
         zQn1oBkvejEVBh53dKly12oI1KMauWN/wCC0hViMzvVsVH+VSryb4yzHrmi9jrAzKG61
         aTTw==
X-Gm-Message-State: AOJu0Yx5D+UE9xbCuO0dWsBGVhsy1f7f8XFjiOQIVQou8d+gAH9PXd5n
	o+Hpjh2UXLNB4WiUyRetyDu9yv0m2Lkf6Q==
X-Google-Smtp-Source: AGHT+IHpjnJ0NfHSnvmtA4EYlMOODMW0hErDxoBNdLc7KXUJt/zUoHz76EBkoydu5/sKWBj+XKkJTjxWbiwhow==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:7485:0:b0:d78:45db:d890 with SMTP id
 p127-20020a257485000000b00d7845dbd890mr301081ybc.0.1694534543914; Tue, 12 Sep
 2023 09:02:23 -0700 (PDT)
Date: Tue, 12 Sep 2023 16:02:04 +0000
In-Reply-To: <20230912160212.3467976-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230912160212.3467976-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912160212.3467976-7-edumazet@google.com>
Subject: [PATCH net-next 06/14] ipv6: lockless IPV6_RECVERR_RFC4884 implementation
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Move np->recverr_rfc4884 to an atomic flag to fix data-races.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/ipv6.h     |  1 -
 include/net/inet_sock.h  |  1 +
 net/ipv6/datagram.c      |  2 +-
 net/ipv6/ipv6_sockglue.c | 17 ++++++++---------
 4 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 9cc278b5e4f42ce097e57ecd95a50479a947fd82..0d2b0a1b2daeaee51a03624adab5a385cc852cc7 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -256,7 +256,6 @@ struct ipv6_pinfo {
 				autoflowlabel:1,
 				autoflowlabel_set:1,
 				mc_all:1,
-				recverr_rfc4884:1,
 				rtalert_isolate:1;
 	__u8			min_hopcount;
 	__u8			tclass;
diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index b5a9dca92fb45425c032bdf08bfa88cad77926b8..8cf1f7b442348bef83cc3d9648521a01667efae7 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -269,6 +269,7 @@ enum {
 	INET_FLAGS_BIND_ADDRESS_NO_PORT = 18,
 	INET_FLAGS_DEFER_CONNECT = 19,
 	INET_FLAGS_MC6_LOOP	= 20,
+	INET_FLAGS_RECVERR6_RFC4884 = 21,
 };
 
 /* cmsg flags for inet */
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index 41ebc4e574734456357169e883c3d13e42fa66b2..e81892814935fb3934fbf0e6f9defc702ec29152 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -332,7 +332,7 @@ void ipv6_icmp_error(struct sock *sk, struct sk_buff *skb, int err,
 
 	__skb_pull(skb, payload - skb->data);
 
-	if (inet6_sk(sk)->recverr_rfc4884)
+	if (inet6_test_bit(RECVERR6_RFC4884, sk))
 		ipv6_icmp_error_rfc4884(skb, &serr->ee.ee_rfc4884);
 
 	skb_reset_transport_header(skb);
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index bbc8a009e05d3de49868e1ccf469a12bc31b8e22..b65e73ac2ccdee79aa293948d3ba9853966e1e2d 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -462,6 +462,13 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		 */
 		WRITE_ONCE(np->min_hopcount, val);
 		return 0;
+	case IPV6_RECVERR_RFC4884:
+		if (optlen < sizeof(int))
+			return -EINVAL;
+		if (val < 0 || val > 1)
+			return -EINVAL;
+		inet6_assign_bit(RECVERR6_RFC4884, sk, valbool);
+		return 0;
 	}
 	if (needs_rtnl)
 		rtnl_lock();
@@ -974,14 +981,6 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		np->rxopt.bits.recvfragsize = valbool;
 		retv = 0;
 		break;
-	case IPV6_RECVERR_RFC4884:
-		if (optlen < sizeof(int))
-			goto e_inval;
-		if (val < 0 || val > 1)
-			goto e_inval;
-		np->recverr_rfc4884 = valbool;
-		retv = 0;
-		break;
 	}
 
 unlock:
@@ -1462,7 +1461,7 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case IPV6_RECVERR_RFC4884:
-		val = np->recverr_rfc4884;
+		val = inet6_test_bit(RECVERR6_RFC4884, sk);
 		break;
 
 	default:
-- 
2.42.0.283.g2d96d420d3-goog


