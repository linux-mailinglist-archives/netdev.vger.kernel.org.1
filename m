Return-Path: <netdev+bounces-35653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 788627AA762
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 05:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id AFFAC282813
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 03:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19481A34;
	Fri, 22 Sep 2023 03:42:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458582116
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 03:42:36 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A948CC
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:42:35 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59bee08c13aso23326737b3.0
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695354154; x=1695958954; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G9Z/nKzvWlwT9KaXr/yM1vYWg3R0vUbwg2NkHpWMLpM=;
        b=SCCEUdc4oJwdZYO8TxFOFV4Er0Bg0pnB0rN5ZKAFHAAgc5OLmZh81YgRblxcHSU5WJ
         i39A+Abxg85NWo8gNYh4qJy3DXNU2wLkkWyARLnZ73naXzWM3NEQfvRmkRozRaTvSfNe
         CO6UdYZTI/kmm13b2b8fByRw5wrcpXa87FDgeLs2TfbQRac/nHeIzxJJKB0yR93rOnj6
         63/O6v0vH58JMwCCu7HuxPd73MRaKfyjNPq7cA9fnVofwDkU79eMUV9M6z2CeB+5zzLg
         DlFQaFj2lHLqeqeCvxXVtc/zuCqjIBmUi59BkBXRCOqIBC3qooahBmHGpt6kvw6NGhsT
         cBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695354154; x=1695958954;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9Z/nKzvWlwT9KaXr/yM1vYWg3R0vUbwg2NkHpWMLpM=;
        b=dhxlpc/lAd11L4nlOWtnxlXK8jIVIdzuBUw0+eqf5NPLTOEzZonoHTPn3oURKeZfD0
         cqOmpdoEMnOhwOVtU3/eKZp2Zg/AO52FImmx4UKcYfGuSAt9leQacjWDt26Mon2X+e28
         egOXSeLJ0RLZ32rikQAMm+hUUWHiMO1s2ueR3cagV9F+fQ9VimjmSDkaYbzrpa0LxRl1
         O7I8I1ZAkq/137u21adHWFq4mPho704LgVjDuHdWUkaiPNVpEodAC32F+L5EL0UL4o+y
         ZzRW6XDYRMxsjV7E3Xj2ieHWpNc4Ueknv7mLB9cvApgUpMxvFAczbNbLLEVEM/RwzR5k
         4PuA==
X-Gm-Message-State: AOJu0YxJ5klZPpIJ4zwU+Efb2eD5w69xW3UdGUIxi5wnqOFvw6dpAPkM
	iZrAzm3PvCu8B0+Mps7aahufLTbSu47+7Q==
X-Google-Smtp-Source: AGHT+IETLJIuo2BswbKuX1kUmTtVYgJTzVdtTC2UQhwnUmAmHXW1Chb40WYRIBTPgY/gPoNwLDmt3PzkBdPHEw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:496:0:b0:d7f:2cb6:7d88 with SMTP id
 144-20020a250496000000b00d7f2cb67d88mr104600ybe.13.1695354154542; Thu, 21 Sep
 2023 20:42:34 -0700 (PDT)
Date: Fri, 22 Sep 2023 03:42:20 +0000
In-Reply-To: <20230922034221.2471544-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230922034221.2471544-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922034221.2471544-8-edumazet@google.com>
Subject: [PATCH v2 net-next 7/8] inet: lockless IP_PKTOPTIONS implementation
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Current implementation is already lockless, because the socket
lock is released before reading socket fields.

Add missing READ_ONCE() annotations.

Note that corresponding WRITE_ONCE() are needed, the order
of the patches do not really matter.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
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
2.42.0.515.g380fc7ccd1-goog


