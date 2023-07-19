Return-Path: <netdev+bounces-19060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D02875977B
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 15:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F1F2815EF
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD3213FFB;
	Wed, 19 Jul 2023 13:56:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E74A13FE0
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 13:56:54 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C7812C
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 06:56:52 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6686708c986so6971840b3a.0
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 06:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689775011; x=1692367011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YV3UT1dAJ+GOM9yuA7l20bMunb7lM7dydQKDUove2FA=;
        b=OM/d0jyHYVnKl9qnhd3CY/ocqOBAwD1GRPdibW34LJ/LUY71yKJoxl4I7cTsITl+lo
         S8tq8dxPxrKt6TlC+xF209Y212pLpkypDWMlfGdH4UkHKRrRMhNTdbZGHvNfQ8yAEjG1
         kXZekq4CnZ1gqjxWQp0eNxc7o4R+/HCi0FTiXF0Dj2sUeWRsFXlguQmozfI6YOvyG/rj
         xVNNratBQrDcFFSHgFLGlmOWqxRHdsNLX1xis3UoT5QL2TYjv400kxzHPB3XfB/INVYN
         /9tOV/Q35rmvWw4J9MqHBE2wEoYFbRj1JgEB4hE3aOeUicPiqeaCpAoK1LNd9oFk6nuX
         X4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689775011; x=1692367011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YV3UT1dAJ+GOM9yuA7l20bMunb7lM7dydQKDUove2FA=;
        b=HsI5SAFBU26YzBdX9sVFZAsQs0WSJhh/zPeR97lFy/lRwbSJxwcyPoAxNbVMKF2+hp
         WSO86RcSwh0HU/BCDopwkAQgAhi+Ix8o6fxQTt5w6yQAjC4rNstsiP758NBKd8QwrFlp
         lzUnRkWjNYtGT5vY45e1dQXKGCVes0ptmMWuKj2tcacDdvQ2/vD09NU7k4LIhXe86Yts
         sJl5If/Dd4hcs+4SqPG11BF/2Emns3HKsta/hEwY3N4Yy06AhkKFUL4CHLARUxZnEKEW
         Zsng81kbI9NhOv1tzS/7jQ4FyxIinIJ0dn52lyNeqrnocJq/RlzIOxcWRWoFIBxekIZK
         63qQ==
X-Gm-Message-State: ABy/qLZxAUykz5JFkofaufBArFEYjM9a24Tz9Iq0ygk8LbI3mRtYlT7u
	r8LODlphoB7EmDo8ihQosVngQls8GZDx2oqc
X-Google-Smtp-Source: APBJJlH7Kqe1MhH3up8F2AIqLq+QB8jgx3INEyGKgYn9nvYTcXuXOhRDZnQKIz62RV7lHIwbixVPXw==
X-Received: by 2002:a05:6a20:9383:b0:12e:4d86:c017 with SMTP id x3-20020a056a20938300b0012e4d86c017mr21817071pzh.10.1689775011173;
        Wed, 19 Jul 2023 06:56:51 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id a2-20020a63bd02000000b0055c656ef91asm3538091pgf.77.2023.07.19.06.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 06:56:50 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Beniamino Galvani <bgalvani@redhat.com>
Subject: [PATCHv2 net-next] IPv6: add extack info for inet6_addr_add/del
Date: Wed, 19 Jul 2023 21:56:44 +0800
Message-Id: <20230719135644.3011570-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add extack info for inet6_addr_add(), ipv6_add_addr() and
inet6_addr_del(), which would be useful for users to understand the
problem without having to read kernel code.

Suggested-by: Beniamino Galvani <bgalvani@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---

BTW, please feel free to add comments if you think the extack message
is not describe properly.

v2: Update extack msg for dead dev. Remove msg for NOBUFS error.
    Add extack for ipv6_add_addr_hash()
---
 net/ipv6/addrconf.c | 71 +++++++++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 21 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index e5213e598a04..4e0836d90e65 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1027,7 +1027,8 @@ static bool ipv6_chk_same_addr(struct net *net, const struct in6_addr *addr,
 	return false;
 }
 
-static int ipv6_add_addr_hash(struct net_device *dev, struct inet6_ifaddr *ifa)
+static int ipv6_add_addr_hash(struct net_device *dev, struct inet6_ifaddr *ifa,
+			      struct netlink_ext_ack *extack)
 {
 	struct net *net = dev_net(dev);
 	unsigned int hash = inet6_addr_hash(net, &ifa->addr);
@@ -1037,7 +1038,7 @@ static int ipv6_add_addr_hash(struct net_device *dev, struct inet6_ifaddr *ifa)
 
 	/* Ignore adding duplicate addresses on an interface */
 	if (ipv6_chk_same_addr(net, &ifa->addr, dev, hash)) {
-		netdev_dbg(dev, "ipv6_add_addr: already assigned\n");
+		NL_SET_ERR_MSG(extack, "ipv6_add_addr: already assigned");
 		err = -EEXIST;
 	} else {
 		hlist_add_head_rcu(&ifa->addr_lst, &net->ipv6.inet6_addr_lst[hash]);
@@ -1066,15 +1067,19 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
 	     !(cfg->ifa_flags & IFA_F_MCAUTOJOIN)) ||
 	    (!(idev->dev->flags & IFF_LOOPBACK) &&
 	     !netif_is_l3_master(idev->dev) &&
-	     addr_type & IPV6_ADDR_LOOPBACK))
+	     addr_type & IPV6_ADDR_LOOPBACK)) {
+		NL_SET_ERR_MSG(extack, "Cannot assign requested address");
 		return ERR_PTR(-EADDRNOTAVAIL);
+	}
 
 	if (idev->dead) {
-		err = -ENODEV;			/*XXX*/
+		NL_SET_ERR_MSG(extack, "Device marked as dead");
+		err = -ENODEV;
 		goto out;
 	}
 
 	if (idev->cnf.disable_ipv6) {
+		NL_SET_ERR_MSG(extack, "IPv6 is disabled on this device");
 		err = -EACCES;
 		goto out;
 	}
@@ -1103,6 +1108,7 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
 
 	f6i = addrconf_f6i_alloc(net, idev, cfg->pfx, false, gfp_flags);
 	if (IS_ERR(f6i)) {
+		NL_SET_ERR_MSG(extack, "Dest allocate failed");
 		err = PTR_ERR(f6i);
 		f6i = NULL;
 		goto out;
@@ -1140,7 +1146,7 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
 
 	rcu_read_lock();
 
-	err = ipv6_add_addr_hash(idev->dev, ifa);
+	err = ipv6_add_addr_hash(idev->dev, ifa, extack);
 	if (err < 0) {
 		rcu_read_unlock();
 		goto out;
@@ -2488,18 +2494,22 @@ static void addrconf_add_mroute(struct net_device *dev)
 	ip6_route_add(&cfg, GFP_KERNEL, NULL);
 }
 
-static struct inet6_dev *addrconf_add_dev(struct net_device *dev)
+static struct inet6_dev *addrconf_add_dev(struct net_device *dev, struct netlink_ext_ack *extack)
 {
 	struct inet6_dev *idev;
 
 	ASSERT_RTNL();
 
 	idev = ipv6_find_idev(dev);
-	if (IS_ERR(idev))
+	if (IS_ERR(idev)) {
+		NL_SET_ERR_MSG(extack, "No such device");
 		return idev;
+	}
 
-	if (idev->cnf.disable_ipv6)
+	if (idev->cnf.disable_ipv6) {
+		NL_SET_ERR_MSG(extack, "IPv6 is disabled on this device");
 		return ERR_PTR(-EACCES);
+	}
 
 	/* Add default multicast route */
 	if (!(dev->flags & IFF_LOOPBACK) && !netif_is_l3_master(dev))
@@ -2919,21 +2929,29 @@ static int inet6_addr_add(struct net *net, int ifindex,
 
 	ASSERT_RTNL();
 
-	if (cfg->plen > 128)
+	if (cfg->plen > 128) {
+		NL_SET_ERR_MSG(extack, "IPv6 address prefix length larger than 128");
 		return -EINVAL;
+	}
 
 	/* check the lifetime */
-	if (!cfg->valid_lft || cfg->preferred_lft > cfg->valid_lft)
+	if (!cfg->valid_lft || cfg->preferred_lft > cfg->valid_lft) {
+		NL_SET_ERR_MSG(extack, "IPv6 address lifetime invalid");
 		return -EINVAL;
+	}
 
-	if (cfg->ifa_flags & IFA_F_MANAGETEMPADDR && cfg->plen != 64)
+	if (cfg->ifa_flags & IFA_F_MANAGETEMPADDR && cfg->plen != 64) {
+		NL_SET_ERR_MSG(extack, "IPv6 address with mngtmpaddr flag must have prefix length 64");
 		return -EINVAL;
+	}
 
 	dev = __dev_get_by_index(net, ifindex);
-	if (!dev)
+	if (!dev) {
+		NL_SET_ERR_MSG(extack, "Unable to find the interface");
 		return -ENODEV;
+	}
 
-	idev = addrconf_add_dev(dev);
+	idev = addrconf_add_dev(dev, extack);
 	if (IS_ERR(idev))
 		return PTR_ERR(idev);
 
@@ -2941,8 +2959,10 @@ static int inet6_addr_add(struct net *net, int ifindex,
 		int ret = ipv6_mc_config(net->ipv6.mc_autojoin_sk,
 					 true, cfg->pfx, ifindex);
 
-		if (ret < 0)
+		if (ret < 0) {
+			NL_SET_ERR_MSG(extack, "Multicast auto join failed");
 			return ret;
+		}
 	}
 
 	cfg->scope = ipv6_addr_scope(cfg->pfx);
@@ -2999,22 +3019,29 @@ static int inet6_addr_add(struct net *net, int ifindex,
 }
 
 static int inet6_addr_del(struct net *net, int ifindex, u32 ifa_flags,
-			  const struct in6_addr *pfx, unsigned int plen)
+			  const struct in6_addr *pfx, unsigned int plen,
+			  struct netlink_ext_ack *extack)
 {
 	struct inet6_ifaddr *ifp;
 	struct inet6_dev *idev;
 	struct net_device *dev;
 
-	if (plen > 128)
+	if (plen > 128) {
+		NL_SET_ERR_MSG(extack, "IPv6 address prefix length larger than 128");
 		return -EINVAL;
+	}
 
 	dev = __dev_get_by_index(net, ifindex);
-	if (!dev)
+	if (!dev) {
+		NL_SET_ERR_MSG(extack, "Unable to find the interface");
 		return -ENODEV;
+	}
 
 	idev = __in6_dev_get(dev);
-	if (!idev)
+	if (!idev) {
+		NL_SET_ERR_MSG(extack, "No such address on the device");
 		return -ENXIO;
+	}
 
 	read_lock_bh(&idev->lock);
 	list_for_each_entry(ifp, &idev->addr_list, if_list) {
@@ -3037,6 +3064,8 @@ static int inet6_addr_del(struct net *net, int ifindex, u32 ifa_flags,
 		}
 	}
 	read_unlock_bh(&idev->lock);
+
+	NL_SET_ERR_MSG(extack, "IPv6 address not found");
 	return -EADDRNOTAVAIL;
 }
 
@@ -3079,7 +3108,7 @@ int addrconf_del_ifaddr(struct net *net, void __user *arg)
 
 	rtnl_lock();
 	err = inet6_addr_del(net, ireq.ifr6_ifindex, 0, &ireq.ifr6_addr,
-			     ireq.ifr6_prefixlen);
+			     ireq.ifr6_prefixlen, NULL);
 	rtnl_unlock();
 	return err;
 }
@@ -3378,7 +3407,7 @@ static void addrconf_dev_config(struct net_device *dev)
 		return;
 	}
 
-	idev = addrconf_add_dev(dev);
+	idev = addrconf_add_dev(dev, NULL);
 	if (IS_ERR(idev))
 		return;
 
@@ -4692,7 +4721,7 @@ inet6_rtm_deladdr(struct sk_buff *skb, struct nlmsghdr *nlh,
 	ifa_flags &= IFA_F_MANAGETEMPADDR;
 
 	return inet6_addr_del(net, ifm->ifa_index, ifa_flags, pfx,
-			      ifm->ifa_prefixlen);
+			      ifm->ifa_prefixlen, extack);
 }
 
 static int modify_prefix_route(struct inet6_ifaddr *ifp,
-- 
2.38.1


