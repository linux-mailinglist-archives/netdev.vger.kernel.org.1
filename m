Return-Path: <netdev+bounces-55264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BA780A05A
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 11:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 605EFB20C90
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 10:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F5A14AA9;
	Fri,  8 Dec 2023 10:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gRkhpBBH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1259171F
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 02:12:49 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db5404fdfb2so1631757276.1
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 02:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702030369; x=1702635169; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UUqZXnB/irf4Fnh3bN9N300R3Y48UdOVF/XACTNPiM0=;
        b=gRkhpBBHkHv2c69l4Hk+HWbhuOJPDwfgzssgocKQkW+lAWS0IZfj5jkyOoOXFOFBrT
         FkSYMrAXWszJU7+JAei1MXAseCFl8z4BlZHoeQ8FLE2zZk96hZhHMLiqkZxD46rUMTY8
         7Lzi3ZI0QGaUmkckNwuKYCxvmfKd78ynZivw7E1VAWQIocFqsHAOR9Sh1FVINvh1rXTX
         FA6fT/FXficxL7bBFUAH9XNbaIOLMjIKH0MRb0sFvxqq0WFCsbnIivMk/iJoOKjk6AG0
         FKnCxU40AFKQ2WZBLOZ8bgeQVx5mWkWIsEWfnpdBEhQCplFZ1EUIhpEmhAiV0RPfHCaL
         jxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702030369; x=1702635169;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUqZXnB/irf4Fnh3bN9N300R3Y48UdOVF/XACTNPiM0=;
        b=J6iUUqD2DylPP2uAKg66Af+2GomFBD6zdz2UcL+uaaR1dZrWAQnXnVsWRKxvmQQjK4
         nzPVrUk9HHxsjrIL8Vgv7nA0qA/GqWMiF5o3Z4orSIVumLKubRMcDajNG3jXxl5rMCPP
         NZSaEn+DYC+gHOQu9vOr1XKzJ4ddzc9F59ky6Rc0pJP64cvAYgMaWb8AsidlmoJuPuQS
         oAYWjypC0ELy6wTi7VPgVYhxRZ+DC6eyznQCgXJpuwadvi9BkPg17oWTG9mcskhxAf7m
         9/uNbhcaZ4CaE5SOnevVyZ7x5Thcc2lQFvcJ3z5QLlEttRSdgrcnPGfNycXMLla/6Ps6
         bxdA==
X-Gm-Message-State: AOJu0Ywk36O6u+HnQ6YBUBLCzHgyYgZGov+8VXZE7jGP3TWbFnjf7wje
	v4RlKcNc4AKUgLkTDGO9hNeLj+zmPdBu6w==
X-Google-Smtp-Source: AGHT+IE6hWC9M4bNTJfaAYa6io63PHXBvN9fL9+jBstYp1zGUC9peypbkXhAsD2rst9+26eZGePhpJbsJ1KDlA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:9d10:0:b0:ca3:3341:6315 with SMTP id
 i16-20020a259d10000000b00ca333416315mr9324ybp.0.1702030369015; Fri, 08 Dec
 2023 02:12:49 -0800 (PST)
Date: Fri,  8 Dec 2023 10:12:44 +0000
In-Reply-To: <20231208101244.1019034-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208101244.1019034-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208101244.1019034-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] ipv6: annotate data-races around np->ucast_oif
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

np->ucast_oif is read locklessly in some contexts.

Make all accesses to this field lockless, adding appropriate
annotations.

This also makes setsockopt( IPV6_UNICAST_IF ) lockless.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/datagram.c      |  2 +-
 net/ipv6/icmp.c          |  4 +--
 net/ipv6/ipv6_sockglue.c | 58 ++++++++++++++++++----------------------
 net/ipv6/ping.c          |  4 +--
 net/ipv6/raw.c           |  2 +-
 net/ipv6/udp.c           |  2 +-
 net/l2tp/l2tp_ip6.c      |  2 +-
 7 files changed, 34 insertions(+), 40 deletions(-)

diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index 1804bd6f46840f39deb3ceeb7835cd167e1ec86c..fff78496803da6158d8b6e70255a56f183e26a80 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -62,7 +62,7 @@ static void ip6_datagram_flow_key_init(struct flowi6 *fl6,
 		if (ipv6_addr_is_multicast(&fl6->daddr))
 			oif = READ_ONCE(np->mcast_oif);
 		else
-			oif = np->ucast_oif;
+			oif = READ_ONCE(np->ucast_oif);
 	}
 
 	fl6->flowi6_oif = oif;
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index f84a465c9759b6c3d43a80a65dac32d516219c60..1635da07285f263509a68624369a2746f3deb076 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -586,7 +586,7 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 	if (!fl6.flowi6_oif && ipv6_addr_is_multicast(&fl6.daddr))
 		fl6.flowi6_oif = READ_ONCE(np->mcast_oif);
 	else if (!fl6.flowi6_oif)
-		fl6.flowi6_oif = np->ucast_oif;
+		fl6.flowi6_oif = READ_ONCE(np->ucast_oif);
 
 	ipcm6_init_sk(&ipc6, sk);
 	ipc6.sockc.mark = mark;
@@ -772,7 +772,7 @@ static enum skb_drop_reason icmpv6_echo_reply(struct sk_buff *skb)
 	if (!fl6.flowi6_oif && ipv6_addr_is_multicast(&fl6.daddr))
 		fl6.flowi6_oif = READ_ONCE(np->mcast_oif);
 	else if (!fl6.flowi6_oif)
-		fl6.flowi6_oif = np->ucast_oif;
+		fl6.flowi6_oif = READ_ONCE(np->ucast_oif);
 
 	if (ip6_dst_lookup(net, sk, &dst, &fl6))
 		goto out;
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index fe7e96e69960c013e84b48242e309525f7f618da..9e8ebda170f14f7fd5faf370507bb3a8d1c75931 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -537,6 +537,31 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		}
 		WRITE_ONCE(np->mcast_oif, val);
 		return 0;
+	case IPV6_UNICAST_IF:
+	{
+		struct net_device *dev;
+		int ifindex;
+
+		if (optlen != sizeof(int))
+			return -EINVAL;
+
+		ifindex = (__force int)ntohl((__force __be32)val);
+		if (!ifindex) {
+			WRITE_ONCE(np->ucast_oif, 0);
+			return 0;
+		}
+
+		dev = dev_get_by_index(net, ifindex);
+		if (!dev)
+			return -EADDRNOTAVAIL;
+		dev_put(dev);
+
+		if (READ_ONCE(sk->sk_bound_dev_if))
+			return -EINVAL;
+
+		WRITE_ONCE(np->ucast_oif, ifindex);
+		return 0;
+	}
 	}
 	if (needs_rtnl)
 		rtnl_lock();
@@ -857,37 +882,6 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		break;
 	}
 
-
-	case IPV6_UNICAST_IF:
-	{
-		struct net_device *dev = NULL;
-		int ifindex;
-
-		if (optlen != sizeof(int))
-			goto e_inval;
-
-		ifindex = (__force int)ntohl((__force __be32)val);
-		if (ifindex == 0) {
-			np->ucast_oif = 0;
-			retv = 0;
-			break;
-		}
-
-		dev = dev_get_by_index(net, ifindex);
-		retv = -EADDRNOTAVAIL;
-		if (!dev)
-			break;
-		dev_put(dev);
-
-		retv = -EINVAL;
-		if (sk->sk_bound_dev_if)
-			break;
-
-		np->ucast_oif = ifindex;
-		retv = 0;
-		break;
-	}
-
 	case IPV6_ADD_MEMBERSHIP:
 	case IPV6_DROP_MEMBERSHIP:
 	{
@@ -1369,7 +1363,7 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case IPV6_UNICAST_IF:
-		val = (__force int)htonl((__u32) np->ucast_oif);
+		val = (__force int)htonl((__u32) READ_ONCE(np->ucast_oif));
 		break;
 
 	case IPV6_MTU_DISCOVER:
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index 465e8d0040671f689e0e5e1f24c024c356ce0fd1..ef2059c889554aaae237ed2cddca0b5402c77bbb 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -109,7 +109,7 @@ static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	if (!oif && ipv6_addr_is_multicast(daddr))
 		oif = READ_ONCE(np->mcast_oif);
 	else if (!oif)
-		oif = np->ucast_oif;
+		oif = READ_ONCE(np->ucast_oif);
 
 	addr_type = ipv6_addr_type(daddr);
 	if ((__ipv6_addr_needs_scope_id(addr_type) && !oif) ||
@@ -159,7 +159,7 @@ static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	if (!fl6.flowi6_oif && ipv6_addr_is_multicast(&fl6.daddr))
 		fl6.flowi6_oif = READ_ONCE(np->mcast_oif);
 	else if (!fl6.flowi6_oif)
-		fl6.flowi6_oif = np->ucast_oif;
+		fl6.flowi6_oif = READ_ONCE(np->ucast_oif);
 
 	pfh.icmph.type = user_icmph.icmp6_type;
 	pfh.icmph.code = user_icmph.icmp6_code;
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 59a1e269a82c1af6eb73570ef7a43e0f0f61ab80..03dbb874c363bfa796631c1c3cc49895aae56c5a 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -878,7 +878,7 @@ static int rawv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	if (!fl6.flowi6_oif && ipv6_addr_is_multicast(&fl6.daddr))
 		fl6.flowi6_oif = READ_ONCE(np->mcast_oif);
 	else if (!fl6.flowi6_oif)
-		fl6.flowi6_oif = np->ucast_oif;
+		fl6.flowi6_oif = READ_ONCE(np->ucast_oif);
 	security_sk_classify_flow(sk, flowi6_to_flowi_common(&fl6));
 
 	if (hdrincl)
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 0b7c755faa77b1ddd4feb5dea185f6dd7be45091..594e3f23c12909fe6f245bf31057278169cd85c5 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1544,7 +1544,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		fl6->flowi6_oif = READ_ONCE(np->mcast_oif);
 		connected = false;
 	} else if (!fl6->flowi6_oif)
-		fl6->flowi6_oif = np->ucast_oif;
+		fl6->flowi6_oif = READ_ONCE(np->ucast_oif);
 
 	security_sk_classify_flow(sk, flowi6_to_flowi_common(fl6));
 
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index 17301f9dd228db80be1bdc3cb858ac41d5268e36..dd3153966173db09d42de02fa3ad4d44d05620f4 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -601,7 +601,7 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	if (!fl6.flowi6_oif && ipv6_addr_is_multicast(&fl6.daddr))
 		fl6.flowi6_oif = READ_ONCE(np->mcast_oif);
 	else if (!fl6.flowi6_oif)
-		fl6.flowi6_oif = np->ucast_oif;
+		fl6.flowi6_oif = READ_ONCE(np->ucast_oif);
 
 	security_sk_classify_flow(sk, flowi6_to_flowi_common(&fl6));
 
-- 
2.43.0.472.g3155946c3a-goog


