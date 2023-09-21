Return-Path: <netdev+bounces-35486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3EB7A9B3C
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 20:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD990282359
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 18:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CC44734D;
	Thu, 21 Sep 2023 17:49:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7777C18B14
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:49:23 +0000 (UTC)
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5B18848F
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:38:58 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id af79cd13be357-7740829f2bfso98517685a.0
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695317938; x=1695922738; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GZcl8dkKLaXNSNXGbbeqaXAT2s+m+/IKC5s13djBtlo=;
        b=Fbn53/jBHz0eS3jWWa9XvCi44VQoIg3/Ll3gUOn0Q5MbiUvuu2ZhZZawenYwx8bjdA
         V9ydFjgFDJYEKLBmXicrsrt+16xuu+a/esqgbE2u3TAlD+99IIlZNMgnKLrUWVqoMJvh
         CRU8kMZIQvu53wCNbdWGqKG2TLVXVUZhIY0wJev2LaMFzj0P96XaTjINg7hXcrV+IYDs
         oldh/uxUvuNhu/R5M+eE5HR3ISHke6MTxqsPsjOMelMaYgyi3gWjMhgLMbUybOD9OyCo
         EVhmeTY55OJPfSXplVjFiKLtgcrBu7+SzC+ZziRVEqK26e5u+XEAZEZZc9szt3SMJsNE
         acWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317938; x=1695922738;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GZcl8dkKLaXNSNXGbbeqaXAT2s+m+/IKC5s13djBtlo=;
        b=idm+MPOKTAIqo41dCfW7DIM0Pso1RpYidSri2Suu3XH1SnTCAZQj6Ke4896tKcX+AV
         cZAz7SEMo5OEoECx4vVLMHI12sg0GxHU/+pATN35Xf+wnr4b/VaP433PRUcRQDtuq8lo
         YbY7nZGCnbDyzsg1XxXVnm0bYxRc2kazs0eWxkEgGiksz78EpKbeatqmDrc8kWWNBKWT
         AJ17GpTaG7NBOHDdlFfYb/GU5DIIT4CZJXL+33/wRwFbaRd37lx8Z1X9xwFhauvjE2O2
         M1R+TslwluKIaQRgDFVtQIM9iRXB2MfCVMPqgHEZ1gI7sP7+zsxw6L2yR4iiEC7Ue5hP
         SCsA==
X-Gm-Message-State: AOJu0YzX8cm6Lk6OM6qCS0bV/mOAZtQt0lZokEuPNark2anSN5Vlruw1
	cb7l9pG8bV/qYw6pH9XLAqImJaBEvqywnw==
X-Google-Smtp-Source: AGHT+IFQpG++YB1/GUIwdYGbotjqbrFfY+j1Gg+lSicA69GQcKn8HpIeiixUKvzqAlEZ0nU4sgnfX4T0D3X3AQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:8b48:0:b0:59b:ea2e:23e5 with SMTP id
 e8-20020a818b48000000b0059bea2e23e5mr82989ywk.7.1695303037989; Thu, 21 Sep
 2023 06:30:37 -0700 (PDT)
Date: Thu, 21 Sep 2023 13:30:20 +0000
In-Reply-To: <20230921133021.1995349-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230921133021.1995349-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230921133021.1995349-8-edumazet@google.com>
Subject: [PATCH net-next 7/8] inet: lockless IP_PKTOPTIONS implementation
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Current implementation is already lockless, because the socket
lock is released before reading socket fields.

Add missing READ_ONCE() annotations.

Note that corresponding WRITE_ONCE() are needed, the order
of the patches do not really matter.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ip_sockglue.c | 76 ++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 39 deletions(-)

diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 58995526c6e965d613b8cdea61b84916d608a6fb..1ee01ff64171c94b6b244589518a53ce807a212d 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1633,6 +1633,43 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 			return -ENOTCONN;
 		goto copyval;
 	}
+	case IP_PKTOPTIONS:
+	{
+		struct msghdr msg;
+
+		if (sk->sk_type != SOCK_STREAM)
+			return -ENOPROTOOPT;
+
+		if (optval.is_kernel) {
+			msg.msg_control_is_user = false;
+			msg.msg_control = optval.kernel;
+		} else {
+			msg.msg_control_is_user = true;
+			msg.msg_control_user = optval.user;
+		}
+		msg.msg_controllen = len;
+		msg.msg_flags = in_compat_syscall() ? MSG_CMSG_COMPAT : 0;
+
+		if (inet_test_bit(PKTINFO, sk)) {
+			struct in_pktinfo info;
+
+			info.ipi_addr.s_addr = READ_ONCE(inet->inet_rcv_saddr);
+			info.ipi_spec_dst.s_addr = READ_ONCE(inet->inet_rcv_saddr);
+			info.ipi_ifindex = READ_ONCE(inet->mc_index);
+			put_cmsg(&msg, SOL_IP, IP_PKTINFO, sizeof(info), &info);
+		}
+		if (inet_test_bit(TTL, sk)) {
+			int hlim = READ_ONCE(inet->mc_ttl);
+
+			put_cmsg(&msg, SOL_IP, IP_TTL, sizeof(hlim), &hlim);
+		}
+		if (inet_test_bit(TOS, sk)) {
+			int tos = READ_ONCE(inet->rcv_tos);
+			put_cmsg(&msg, SOL_IP, IP_TOS, sizeof(tos), &tos);
+		}
+		len -= msg.msg_controllen;
+		return copy_to_sockptr(optlen, &len, sizeof(int));
+	}
 	case IP_UNICAST_IF:
 		val = (__force int)htonl((__u32) READ_ONCE(inet->uc_index));
 		goto copyval;
@@ -1678,45 +1715,6 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		else
 			err = ip_get_mcast_msfilter(sk, optval, optlen, len);
 		goto out;
-	case IP_PKTOPTIONS:
-	{
-		struct msghdr msg;
-
-		sockopt_release_sock(sk);
-
-		if (sk->sk_type != SOCK_STREAM)
-			return -ENOPROTOOPT;
-
-		if (optval.is_kernel) {
-			msg.msg_control_is_user = false;
-			msg.msg_control = optval.kernel;
-		} else {
-			msg.msg_control_is_user = true;
-			msg.msg_control_user = optval.user;
-		}
-		msg.msg_controllen = len;
-		msg.msg_flags = in_compat_syscall() ? MSG_CMSG_COMPAT : 0;
-
-		if (inet_test_bit(PKTINFO, sk)) {
-			struct in_pktinfo info;
-
-			info.ipi_addr.s_addr = inet->inet_rcv_saddr;
-			info.ipi_spec_dst.s_addr = inet->inet_rcv_saddr;
-			info.ipi_ifindex = inet->mc_index;
-			put_cmsg(&msg, SOL_IP, IP_PKTINFO, sizeof(info), &info);
-		}
-		if (inet_test_bit(TTL, sk)) {
-			int hlim = READ_ONCE(inet->mc_ttl);
-
-			put_cmsg(&msg, SOL_IP, IP_TTL, sizeof(hlim), &hlim);
-		}
-		if (inet_test_bit(TOS, sk)) {
-			int tos = inet->rcv_tos;
-			put_cmsg(&msg, SOL_IP, IP_TOS, sizeof(tos), &tos);
-		}
-		len -= msg.msg_controllen;
-		return copy_to_sockptr(optlen, &len, sizeof(int));
-	}
 	case IP_LOCAL_PORT_RANGE:
 		val = inet->local_port_range.hi << 16 | inet->local_port_range.lo;
 		break;
-- 
2.42.0.459.ge4e396fd5e-goog


