Return-Path: <netdev+bounces-26294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205BB77762C
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 12:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF33B2816B5
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162A4214FB;
	Thu, 10 Aug 2023 10:40:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7373D71
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:40:04 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF4D2719
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:40:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d6349e1d4c2so798127276.2
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691664002; x=1692268802;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UyELD65IEYejZ6Krhj/YgGFlULL/un+9MMUGmFvMQ4o=;
        b=5F9yUHYFbXvUgVCSkycUoaQ6R3r+dSrHvQ+ZGURwCtJnNtDTxFJtcO/gLMCcm72wsF
         7ql5BnEbrQCMPuMACTIkAqwJtkg1gCEQVX82uXP7aSvO+DA9f7U5smQB6ld4hW6O6Hnz
         rjibIcEy3eUUbwk6sireYReW9JMK9wR24YmXhcf8IFhm+r8BOHCZCUM+COHSdK3Q7J45
         WMyJ1+VkYhcUIoGtZEpIwRbbW0w2LuAhHWqNqnC3Vev+MJQtM3orvXCZ5nbDXZqS0wJs
         +ijsfKmiv7X8bk4T5r+bd2rvkyXL6ZzdnsXHGJYmpVGYDRu8PW9TvNqcCxWOQlCDF7Cf
         /vYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691664002; x=1692268802;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UyELD65IEYejZ6Krhj/YgGFlULL/un+9MMUGmFvMQ4o=;
        b=kC5v2F6AYSNV+xfXlAwZBpZmD29quQmha0QBQNukXHQ4XyuV5LYojPne7kxiKN7qLv
         mahFg5/7QfFVAyrI5IPvtjz+gPXD3qw5TVclMvPWZSD/UmKfLJf991JyVnYzgyHxtQbs
         dj/74fqPv2zIAoq8DPM6N4Rj4K+glcObSBbZ9hc01zaG86fjeGVLGg0XfhHdK6pUOh9e
         Zw2o8opwhYpBx5W0dqtXZ+4mg20Ez1LnwdSJ5rVRqi/XyvhqFlth9P90XHVXxS6deIli
         GvRQKFcVLTnrBvNcARKmatI3Mrm7SVvPglTljtBVtqDbUQFNIlPu/LGg6DPEChMMB1e+
         Xdbw==
X-Gm-Message-State: AOJu0YxP1gDVFJRbzKFvAlSvuaAiAmiRoVjoFwqx4AeOqTvToM+e5QpF
	Le8gJ+eFVAnovAkwPdNLl2ndeAO/kHE3LQ==
X-Google-Smtp-Source: AGHT+IFdw5ZxrOzaZqw9AmwOTyM85XHlD6VYqiWbT1wwBUps+PJ0EUEmrHhCWds2rY7Bm9F81jy9wZJqOIoVRw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:25c7:0:b0:d4d:564d:8fbf with SMTP id
 l190-20020a2525c7000000b00d4d564d8fbfmr29264ybl.13.1691664002388; Thu, 10 Aug
 2023 03:40:02 -0700 (PDT)
Date: Thu, 10 Aug 2023 10:39:26 +0000
In-Reply-To: <20230810103927.1705940-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230810103927.1705940-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230810103927.1705940-15-edumazet@google.com>
Subject: [PATCH net-next 14/15] inet: implement lockless IP_TTL
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

ip_select_ttl() is racy, because it reads inet->uc_ttl
without proper locking.

Add READ_ONCE()/WRITE_ONCE() annotations while
allowing IP_TTL socket option to be set/read without
holding the socket lock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ip_output.c   |  2 +-
 net/ipv4/ip_sockglue.c | 27 ++++++++++++---------------
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 8f396eada1b6e61ab174473e9859bc62a10a0d1c..ce6257860a4019d01e28d57d3ce4981fe79d0a0e 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -133,7 +133,7 @@ EXPORT_SYMBOL_GPL(ip_local_out);
 static inline int ip_select_ttl(const struct inet_sock *inet,
 				const struct dst_entry *dst)
 {
-	int ttl = inet->uc_ttl;
+	int ttl = READ_ONCE(inet->uc_ttl);
 
 	if (ttl < 0)
 		ttl = ip4_dst_hoplimit(dst);
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index cfa65a0b0900f2f77bfd800f105ea079e2afff7c..dbb2d2342ebf0c1f1366ee6b6b2158a6118b2659 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1023,6 +1023,13 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 	case IP_BIND_ADDRESS_NO_PORT:
 		inet_assign_bit(BIND_ADDRESS_NO_PORT, sk, val);
 		return 0;
+	case IP_TTL:
+		if (optlen < 1)
+			return -EINVAL;
+		if (val != -1 && (val < 1 || val > 255))
+			return -EINVAL;
+		WRITE_ONCE(inet->uc_ttl, val);
+		return 0;
 	}
 
 	err = 0;
@@ -1080,13 +1087,6 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 	case IP_TOS:	/* This sets both TOS and Precedence */
 		__ip_sock_set_tos(sk, val);
 		break;
-	case IP_TTL:
-		if (optlen < 1)
-			goto e_inval;
-		if (val != -1 && (val < 1 || val > 255))
-			goto e_inval;
-		inet->uc_ttl = val;
-		break;
 	case IP_MTU_DISCOVER:
 		if (val < IP_PMTUDISC_DONT || val > IP_PMTUDISC_OMIT)
 			goto e_inval;
@@ -1590,6 +1590,11 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	case IP_BIND_ADDRESS_NO_PORT:
 		val = inet_test_bit(BIND_ADDRESS_NO_PORT, sk);
 		goto copyval;
+	case IP_TTL:
+		val = READ_ONCE(inet->uc_ttl);
+		if (val < 0)
+			val = READ_ONCE(sock_net(sk)->ipv4.sysctl_ip_default_ttl);
+		goto copyval;
 	}
 
 	if (needs_rtnl)
@@ -1629,14 +1634,6 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	case IP_TOS:
 		val = inet->tos;
 		break;
-	case IP_TTL:
-	{
-		struct net *net = sock_net(sk);
-		val = (inet->uc_ttl == -1 ?
-		       READ_ONCE(net->ipv4.sysctl_ip_default_ttl) :
-		       inet->uc_ttl);
-		break;
-	}
 	case IP_MTU_DISCOVER:
 		val = inet->pmtudisc;
 		break;
-- 
2.41.0.640.ga95def55d0-goog


