Return-Path: <netdev+bounces-178337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E3CA76A7C
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 17:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C18BD7A177D
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 15:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F042135DE;
	Mon, 31 Mar 2025 15:06:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7180DEEAA
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743433569; cv=none; b=XQRs1f9pjj/e/ebgHFWOEDvM3cMiI+8LqEvVtLgs3U20ghbyQfTWkkxcOIGGde3wCk2xMZ3l4GZnc89Mzp2mZfhgxOqWBKiKhSGafZIkfoK965a/8km6Eqmz4n2U9xXwiZMbyoKLQKn2jsFS2EciA0Wj5j/+fpg7Jpaxh7Izrc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743433569; c=relaxed/simple;
	bh=KHncWnuf/Sc/VwW6z7GPX+D2Xs845t7ZdWeh9oaEAaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khmifZ7Jbv/9ISul2E9UZORD1gE0cq3aXlDjqN+wG0dRQNBQNnSWt9gSO4e6lPvu1QPPEazVgFAeiSV3/SHlOT+lucR8Qt3afi+51LeveRn3GBNPxdWyA43ZzBBNwt7RqRpOtLBz7jaReK6V9RSRYAqjzEK1UKMjPeXH2KBwyCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224100e9a5cso83289965ad.2
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 08:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743433566; x=1744038366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWONSdK5Y4BghzZ5YDsp0NyBVnhcNSi2+zcc7IvC1V4=;
        b=R9ggGtaD071pZ+p+ghy87K9wkq6hAcJoNc+iD6OiIAj0HpxTniPzGM3r6jBAmKZ/h6
         B/uX+POykAirKe72hBT2NIN/2sV95l3l2ZQDMxeGtHVZ6TJGRcd/nmdZ8wFVrcFJFHhm
         e6PBRL0aelDkUB8P/3F2V3cfuL2LEpBV5yCzSKReQTKbSuakRdTlTdAOeEwWKaA8j80h
         3rCm1UOX/9nVtaS4oDlXAyPB7bH5ZBH5I41qGDS5YJRsr0xSbWnKMmczLQ5iZ71c96c3
         OWOoMBeIZEIq/jvxNoJXVi6kIFw20vxIR/TrTqcLZr0g5cmX639QNntQmUoHB0j9epAp
         ZCog==
X-Gm-Message-State: AOJu0YyimWftXmRJPjxsX+uyinfl9zmWpfybRSbjEm70hiqwOsdW2iao
	334QhUoZUfr1D/4ikA6c1HNFGxFuOueH04sUfg+6gUTc1Vn9wgtRdAQr
X-Gm-Gg: ASbGncsngCJaE02xEvmNM5CmtR8kuB0HOcQpCgbRQGKUVfR1Wd+iniOGPb4EXCt0PFO
	yqZwjK9LzFOW7sQspS8H1p/AOK11ZjehRI0m2KWjIKJnSnAKrOZHvjYgxjs3ElawMLZrlK2JEuW
	ssu0jl2qbQWY8vc7oRmsS5EyLqc7RfAYl5b3KPY99JUMVmpvzzlfBmMpBU9FQI8TqltJbzsuRq0
	FybMfmAFkPv+G1cpmVnIJAF1En8UwQcO9CW8GQQPpqDQfOltzUOoSQbLqdRDSE9qCkX3IGQnZH3
	+lO61OocYMopFthmA1Wn/RKZgy00RoE4cenEHAMr7w+PmOc0pDWrV5g=
X-Google-Smtp-Source: AGHT+IECqaIy3GvJqVSIFeMjBGMYvADi/OIpXl32SGw8HOk8LLHxmYyqJbYb9wlMJnC2nKhnxUzFOQ==
X-Received: by 2002:a17:903:32d1:b0:220:e63c:5aff with SMTP id d9443c01a7336-2292fa0154cmr140903695ad.47.1743433566376;
        Mon, 31 Mar 2025 08:06:06 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291eeca2cbsm70395875ad.52.2025.03.31.08.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 08:06:05 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net v4 01/11] net: switch to netif_disable_lro in inetdev_init
Date: Mon, 31 Mar 2025 08:05:53 -0700
Message-ID: <20250331150603.1906635-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331150603.1906635-1-sdf@fomichev.me>
References: <20250331150603.1906635-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cosmin reports the following deadlock:
dump_stack_lvl+0x62/0x90
print_deadlock_bug+0x274/0x3b0
__lock_acquire+0x1229/0x2470
lock_acquire+0xb7/0x2b0
__mutex_lock+0xa6/0xd20
dev_disable_lro+0x20/0x80
inetdev_init+0x12f/0x1f0
inetdev_event+0x48b/0x870
notifier_call_chain+0x38/0xf0
netif_change_net_namespace+0x72e/0x9f0
do_setlink.isra.0+0xd5/0x1220
rtnl_newlink+0x7ea/0xb50
rtnetlink_rcv_msg+0x459/0x5e0
netlink_rcv_skb+0x54/0x100
netlink_unicast+0x193/0x270
netlink_sendmsg+0x204/0x450

Switch to netif_disable_lro which assumes the caller holds the instance
lock. inetdev_init is called for blackhole device (which sw device and
doesn't grab instance lock) and from REGISTER/UNREGISTER notifiers.
We already hold the instance lock for REGISTER notifier during
netns change and we'll soon hold the lock during other paths.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reported-by: Cosmin Ratiu <cratiu@nvidia.com>
Fixes: ad7c7b2172c3 ("net: hold netdev instance lock during sysfs operations")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/net/ip.h   | 16 ++++++++--------
 net/core/dev.c     |  1 +
 net/ipv4/devinet.c |  2 +-
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 8a48ade24620..47ed6d23853d 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -667,14 +667,6 @@ static inline void ip_ipgre_mc_map(__be32 naddr, const unsigned char *broadcast,
 		memcpy(buf, &naddr, sizeof(naddr));
 }
 
-#if IS_MODULE(CONFIG_IPV6)
-#define EXPORT_IPV6_MOD(X) EXPORT_SYMBOL(X)
-#define EXPORT_IPV6_MOD_GPL(X) EXPORT_SYMBOL_GPL(X)
-#else
-#define EXPORT_IPV6_MOD(X)
-#define EXPORT_IPV6_MOD_GPL(X)
-#endif
-
 #if IS_ENABLED(CONFIG_IPV6)
 #include <linux/ipv6.h>
 #endif
@@ -694,6 +686,14 @@ static __inline__ void inet_reset_saddr(struct sock *sk)
 
 #endif
 
+#if IS_MODULE(CONFIG_IPV6)
+#define EXPORT_IPV6_MOD(X) EXPORT_SYMBOL(X)
+#define EXPORT_IPV6_MOD_GPL(X) EXPORT_SYMBOL_GPL(X)
+#else
+#define EXPORT_IPV6_MOD(X)
+#define EXPORT_IPV6_MOD_GPL(X)
+#endif
+
 static inline unsigned int ipv4_addr_hash(__be32 ip)
 {
 	return (__force unsigned int) ip;
diff --git a/net/core/dev.c b/net/core/dev.c
index be17e0660144..711a946d4bfb 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1771,6 +1771,7 @@ void netif_disable_lro(struct net_device *dev)
 		netdev_unlock_ops(lower_dev);
 	}
 }
+EXPORT_IPV6_MOD(netif_disable_lro);
 
 /**
  *	dev_disable_gro_hw - disable HW Generic Receive Offload on a device
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 754f60fb6e25..77e5705ac799 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -281,7 +281,7 @@ static struct in_device *inetdev_init(struct net_device *dev)
 	if (!in_dev->arp_parms)
 		goto out_kfree;
 	if (IPV4_DEVCONF(in_dev->cnf, FORWARDING))
-		dev_disable_lro(dev);
+		netif_disable_lro(dev);
 	/* Reference in_dev->dev */
 	netdev_hold(dev, &in_dev->dev_tracker, GFP_KERNEL);
 	/* Account for reference dev->ip_ptr (below) */
-- 
2.48.1


