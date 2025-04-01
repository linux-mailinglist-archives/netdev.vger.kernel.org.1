Return-Path: <netdev+bounces-178652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E331A7808A
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 18:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C46767A3D5A
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B96420E01B;
	Tue,  1 Apr 2025 16:35:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06BD20D51D
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 16:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525301; cv=none; b=mRJxB4SGOJdgRf4IZKXvqNPBhmioRWfg2z53bkpdusXl4aqrzW6vT0VJm9LQb4cyDjpeGi0L2MLFOgQJQwqyR7XbW7SbXEjLmnvI4BqraRASeyKDXnjGgKptCutUGCrA75oXif7Lct9QWp8e30AzR0ii8NCvdCZ3SOPxi2mPf+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525301; c=relaxed/simple;
	bh=LITO/GEar54V17mAAupd9TzAHAWqOewaekZQUdLCRy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ER9nBAXfIFGTY1W2nDVPNTXHkAOnLfb/FtrxXh7EhBCmHyQZW4W5YkfylsxaMtg53yL2y8Tf5abSk3d+uIGqgjqcvLovi14IBOyhfkxRVkOq3JtI145YFel/Js9witx4whabJROQYORT8+2MuWOTx0ApEjVNJm7xg2hZ3Xtt7hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22548a28d0cso155918975ad.3
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 09:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743525298; x=1744130098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlQr57FXa2KFohs3JTa1N4rbU/iSP3wM0AqQfwH4+j0=;
        b=tijZ7jcQnTRAMpTjUy5RttzbpnZBA1MuQsIKp7FVLICXJhkZ8bUd1ER3VKaW8PxpsM
         YrH7ZeIAF/vtCDBlOk6VIw/gaPIV+YXyhJ1EBgV48hF2OXzOYIikCt9DtEvy7lil4Wrr
         T9WfW7evtOW9xPsySJBzWbyAoJWfHMab+mla6QNCmYOlkroqMad1NvGg7kJhs5iVkPBs
         0kn0+sLduaBq+RG5egWGHMNWmctjvrmwYKxrX9o8v1YMugC2vUcvzZcARw/N82LuWt8q
         /izbsOfrwRyIdRQhuUKYNxymHBqUCanxRU9FNrYN1BIsnkR3aesfNkOqOqkG786S3cmS
         o0Nw==
X-Gm-Message-State: AOJu0YzoCu6wuNngNdevVI7zhmQbxeUFNZiv475KWUUfn6nKKptjfgbj
	W+S3K9UEgZopBEdxUgMmhryt7fv3ZDuP6ll/pTcrw85Zas43EOTXANPvi+N5QQ==
X-Gm-Gg: ASbGncv+2PWQx7LXzmol2KkiJBiYcE0J46VdSYWsay736p1TtEcb//5w6dt2YSlIWT2
	UWIKpROsKBuX8Wk4kEDUpaHWw5unC6UBPWM87Jwy+0hoC5vB0LkawqtlhQIhDdg7vSp+Dd41OwU
	J5XXIkp69kobmyN9Z3TpGcZDZr9/oXTXkQTzErsXJ8C9LGNIEgJLUZ1dnUqUXUtysfboInDkkpj
	xVfMEvYY6aQtc3ZNeZafweqVo8N8MMgR8K9l4ts/rU3IlCUMsLy+jQNvRsTlTM8rxEZkpb3ONKP
	nJqXnrf9jnG7Eht8s848pa1fX0UwuTxelQUZcLcwW6Gg
X-Google-Smtp-Source: AGHT+IH7uWGjeVBZWAqEfP+/U/Nt/AKQ5WNL/GEfAPzCZ2nkM126f8yRD3xJO4Af8mE46JXTlKwmdA==
X-Received: by 2002:a05:6a00:2da1:b0:736:4b85:ee05 with SMTP id d2e1a72fcca58-739803c5d57mr20633411b3a.11.1743525298458;
        Tue, 01 Apr 2025 09:34:58 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7398cd1cc3dsm5866122b3a.80.2025.04.01.09.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 09:34:58 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net v5 03/11] net: use netif_disable_lro in ipv6_add_dev
Date: Tue,  1 Apr 2025 09:34:44 -0700
Message-ID: <20250401163452.622454-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250401163452.622454-1-sdf@fomichev.me>
References: <20250401163452.622454-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipv6_add_dev might call dev_disable_lro which unconditionally grabs
instance lock, so it will deadlock during NETDEV_REGISTER. Switch
to netif_disable_lro.

Make sure all callers hold the instance lock as well.

Cc: Cosmin Ratiu <cratiu@nvidia.com>
Fixes: ad7c7b2172c3 ("net: hold netdev instance lock during sysfs operations")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/net/ip.h    | 16 ++++++++--------
 net/core/dev.c      |  1 +
 net/ipv6/addrconf.c | 15 +++++++++++++--
 3 files changed, 22 insertions(+), 10 deletions(-)

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
index 0ebe8d6597f2..e59eb173900d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1771,6 +1771,7 @@ void netif_disable_lro(struct net_device *dev)
 		netdev_unlock_ops(lower_dev);
 	}
 }
+EXPORT_IPV6_MOD(netif_disable_lro);
 
 /**
  *	dev_disable_gro_hw - disable HW Generic Receive Offload on a device
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index ac8cc1076536..35477d494573 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -80,6 +80,7 @@
 #include <net/netlink.h>
 #include <net/pkt_sched.h>
 #include <net/l3mdev.h>
+#include <net/netdev_lock.h>
 #include <linux/if_tunnel.h>
 #include <linux/rtnetlink.h>
 #include <linux/netconf.h>
@@ -377,6 +378,7 @@ static struct inet6_dev *ipv6_add_dev(struct net_device *dev)
 	int err = -ENOMEM;
 
 	ASSERT_RTNL();
+	netdev_ops_assert_locked(dev);
 
 	if (dev->mtu < IPV6_MIN_MTU && dev != blackhole_netdev)
 		return ERR_PTR(-EINVAL);
@@ -402,7 +404,7 @@ static struct inet6_dev *ipv6_add_dev(struct net_device *dev)
 		return ERR_PTR(err);
 	}
 	if (ndev->cnf.forwarding)
-		dev_disable_lro(dev);
+		netif_disable_lro(dev);
 	/* We refer to the device */
 	netdev_hold(dev, &ndev->dev_tracker, GFP_KERNEL);
 
@@ -3152,10 +3154,12 @@ int addrconf_add_ifaddr(struct net *net, void __user *arg)
 
 	rtnl_net_lock(net);
 	dev = __dev_get_by_index(net, ireq.ifr6_ifindex);
+	netdev_lock_ops(dev);
 	if (dev)
 		err = inet6_addr_add(net, dev, &cfg, 0, 0, NULL);
 	else
 		err = -ENODEV;
+	netdev_unlock_ops(dev);
 	rtnl_net_unlock(net);
 	return err;
 }
@@ -5026,9 +5030,10 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (!dev) {
 		NL_SET_ERR_MSG_MOD(extack, "Unable to find the interface");
 		err = -ENODEV;
-		goto unlock;
+		goto unlock_rtnl;
 	}
 
+	netdev_lock_ops(dev);
 	idev = ipv6_find_idev(dev);
 	if (IS_ERR(idev)) {
 		err = PTR_ERR(idev);
@@ -5065,6 +5070,8 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	in6_ifa_put(ifa);
 unlock:
+	netdev_unlock_ops(dev);
+unlock_rtnl:
 	rtnl_net_unlock(net);
 
 	return err;
@@ -6503,7 +6510,9 @@ static int addrconf_sysctl_addr_gen_mode(const struct ctl_table *ctl, int write,
 
 			if (idev->cnf.addr_gen_mode != new_val) {
 				WRITE_ONCE(idev->cnf.addr_gen_mode, new_val);
+				netdev_lock_ops(idev->dev);
 				addrconf_init_auto_addrs(idev->dev);
+				netdev_unlock_ops(idev->dev);
 			}
 		} else if (&net->ipv6.devconf_all->addr_gen_mode == ctl->data) {
 			struct net_device *dev;
@@ -6515,7 +6524,9 @@ static int addrconf_sysctl_addr_gen_mode(const struct ctl_table *ctl, int write,
 				    idev->cnf.addr_gen_mode != new_val) {
 					WRITE_ONCE(idev->cnf.addr_gen_mode,
 						  new_val);
+					netdev_lock_ops(idev->dev);
 					addrconf_init_auto_addrs(idev->dev);
+					netdev_unlock_ops(idev->dev);
 				}
 			}
 		}
-- 
2.49.0


