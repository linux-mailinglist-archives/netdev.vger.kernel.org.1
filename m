Return-Path: <netdev+bounces-21131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 882537628C9
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 04:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00EA28120B
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 02:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDF7623;
	Wed, 26 Jul 2023 02:39:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000871101
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 02:39:15 +0000 (UTC)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141E8268E
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 19:39:14 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-56344354e2cso3865755eaf.1
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 19:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690339152; x=1690943952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IkWdnm6YPO2ZRalJpbu1VuuZVh2f9hSzL6ptdVb3e10=;
        b=flVEwVst4hkdRDTnkYXFZEKkVJKQ5VUCG6DiWe3QePpFZEfAEEk3B76jZn8wJ9b6g8
         2FWiK8GaUQHoc99W23gkdZqW5oC9dVzodre3ATMq4eByHpH4yMuIhsK6v5psHL32+uQf
         ZphhUt8c7hkPa52LGrZSC+EmodDn7Ck5/KzueybM8bs8/wA375eLHXoNYOUGGgO+u1lm
         Tc3D2YRpZ0LZY5zXVYmf/BfPYKj/xV6gBp/yr/XtQBA8xvy8nTD9OG+/UGdHvD6jzE5G
         Sb/Hbv3lXRLeDad91/VVI3HWGPF9UiCvD9dKMq94fL/IbD3U8AiIdQxKTpGGHs7lWSMU
         J7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690339152; x=1690943952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IkWdnm6YPO2ZRalJpbu1VuuZVh2f9hSzL6ptdVb3e10=;
        b=fKYJghdXuIhhBQmamh7JCjlMQRmCptfugRp8oHl1XJXKjsjK0zJeCAXbNGDxiCthUy
         sYxKVZh5nsGgJwZWtuIN8dUlisHILHbMXEIGyGu4JqF7avpRvg2vfkK6UiqEvyqn1lx5
         odrCk9As+EENmrF20CMOFdVeH8JEBszW3VxCQzcyNNtpYWC0nomMF761zxEM357a1ORi
         CYQSOKYYqpiZ7X2QlKaVe4El+vXXfasC6iC/SbBtia/BWsvEq8At0aBbIw5cwH6RS31e
         DMl1Q5iVaChd0xKB7Q7AFbql3+6jmFjQWl6SfGZmo6tKOB7RH/9ciLBrUQ7IHZLYxLUr
         IX7w==
X-Gm-Message-State: ABy/qLYDL2bqB8Fj2akTZFzwVFOoMm09JjqOLSHg8JASVqYrDVUwJmqI
	lLuSUoHQzhMQJMD5Zi/j874TbUv2eEWpM4/v
X-Google-Smtp-Source: APBJJlGQ/Hvf7DZWWoZJFlsxb7IY6J8Z0hn62XnhPoeb/kiHJN7zX07NNMMklTKf6gRUvM4bow+bYA==
X-Received: by 2002:a05:6358:9494:b0:139:5a46:ea7e with SMTP id i20-20020a056358949400b001395a46ea7emr686686rwb.28.1690339151943;
        Tue, 25 Jul 2023 19:39:11 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b23-20020aa78717000000b0068620bee456sm7714543pfo.209.2023.07.25.19.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 19:39:11 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Beniamino Galvani <bgalvani@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCHv4 net-next] IPv6: add extack info for IPv6 address add/delete
Date: Wed, 26 Jul 2023 10:39:05 +0800
Message-Id: <20230726023905.555509-1-liuhangbin@gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add extack info for IPv6 address add/delete, which would be useful for
users to understand the problem without having to read kernel code.

Suggested-by: Beniamino Galvani <bgalvani@redhat.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v4: Split the first long check in ipv6_add_addr(). Use
    NL_SET_ERR_MSG_MOD to set the extack message.
v3: * Update extack message. Pass extack to addrconf_f6i_alloc().
    * Return "IPv6 is disabled" for addrconf_add_dev(), as the same
      with ndisc_allow_add() does.
    * Set dup addr extack message in inet6_rtm_newaddr() instead of
      ipv6_add_addr_hash().
v2: Update extack msg for dead dev. Remove msg for NOBUFS error.
    Add extack for ipv6_add_addr_hash()
---
 include/net/ip6_route.h |  2 +-
 net/ipv6/addrconf.c     | 77 +++++++++++++++++++++++++++++------------
 net/ipv6/anycast.c      |  2 +-
 net/ipv6/route.c        |  5 +--
 4 files changed, 59 insertions(+), 27 deletions(-)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 3556595ce59a..b32539bb0fb0 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -156,7 +156,7 @@ void fib6_force_start_gc(struct net *net);
 
 struct fib6_info *addrconf_f6i_alloc(struct net *net, struct inet6_dev *idev,
 				     const struct in6_addr *addr, bool anycast,
-				     gfp_t gfp_flags);
+				     gfp_t gfp_flags, struct netlink_ext_ack *extack);
 
 struct rt6_info *ip6_dst_alloc(struct net *net, struct net_device *dev,
 			       int flags);
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 19eb4b3d26ea..f406ca5541d1 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1063,20 +1063,28 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
 	struct fib6_info *f6i = NULL;
 	int err = 0;
 
-	if (addr_type == IPV6_ADDR_ANY ||
-	    (addr_type & IPV6_ADDR_MULTICAST &&
-	     !(cfg->ifa_flags & IFA_F_MCAUTOJOIN)) ||
-	    (!(idev->dev->flags & IFF_LOOPBACK) &&
-	     !netif_is_l3_master(idev->dev) &&
-	     addr_type & IPV6_ADDR_LOOPBACK))
+	if (addr_type == IPV6_ADDR_ANY) {
+		NL_SET_ERR_MSG_MOD(extack, "Invalid address");
 		return ERR_PTR(-EADDRNOTAVAIL);
+	} else if (addr_type & IPV6_ADDR_MULTICAST &&
+		   !(cfg->ifa_flags & IFA_F_MCAUTOJOIN)) {
+		NL_SET_ERR_MSG_MOD(extack, "Cannot assign multicast address without \"IFA_F_MCAUTOJOIN\" flag");
+		return ERR_PTR(-EADDRNOTAVAIL);
+	} else if (!(idev->dev->flags & IFF_LOOPBACK) &&
+		   !netif_is_l3_master(idev->dev) &&
+		   addr_type & IPV6_ADDR_LOOPBACK) {
+		NL_SET_ERR_MSG_MOD(extack, "Cannot assign loopback address on this device");
+		return ERR_PTR(-EADDRNOTAVAIL);
+	}
 
 	if (idev->dead) {
-		err = -ENODEV;			/*XXX*/
+		NL_SET_ERR_MSG_MOD(extack, "device is going away");
+		err = -ENODEV;
 		goto out;
 	}
 
 	if (idev->cnf.disable_ipv6) {
+		NL_SET_ERR_MSG_MOD(extack, "IPv6 is disabled on this device");
 		err = -EACCES;
 		goto out;
 	}
@@ -1103,7 +1111,7 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
 		goto out;
 	}
 
-	f6i = addrconf_f6i_alloc(net, idev, cfg->pfx, false, gfp_flags);
+	f6i = addrconf_f6i_alloc(net, idev, cfg->pfx, false, gfp_flags, extack);
 	if (IS_ERR(f6i)) {
 		err = PTR_ERR(f6i);
 		f6i = NULL;
@@ -2921,30 +2929,40 @@ static int inet6_addr_add(struct net *net, int ifindex,
 
 	ASSERT_RTNL();
 
-	if (cfg->plen > 128)
+	if (cfg->plen > 128) {
+		NL_SET_ERR_MSG_MOD(extack, "Invalid prefix length");
 		return -EINVAL;
+	}
 
 	/* check the lifetime */
-	if (!cfg->valid_lft || cfg->preferred_lft > cfg->valid_lft)
+	if (!cfg->valid_lft || cfg->preferred_lft > cfg->valid_lft) {
+		NL_SET_ERR_MSG_MOD(extack, "address lifetime invalid");
 		return -EINVAL;
+	}
 
-	if (cfg->ifa_flags & IFA_F_MANAGETEMPADDR && cfg->plen != 64)
+	if (cfg->ifa_flags & IFA_F_MANAGETEMPADDR && cfg->plen != 64) {
+		NL_SET_ERR_MSG_MOD(extack, "address with \"mngtmpaddr\" flag must have a prefix length of 64");
 		return -EINVAL;
+	}
 
 	dev = __dev_get_by_index(net, ifindex);
 	if (!dev)
 		return -ENODEV;
 
 	idev = addrconf_add_dev(dev);
-	if (IS_ERR(idev))
+	if (IS_ERR(idev)) {
+		NL_SET_ERR_MSG_MOD(extack, "IPv6 is disabled on this device");
 		return PTR_ERR(idev);
+	}
 
 	if (cfg->ifa_flags & IFA_F_MCAUTOJOIN) {
 		int ret = ipv6_mc_config(net->ipv6.mc_autojoin_sk,
 					 true, cfg->pfx, ifindex);
 
-		if (ret < 0)
+		if (ret < 0) {
+			NL_SET_ERR_MSG_MOD(extack, "Multicast auto join failed");
 			return ret;
+		}
 	}
 
 	cfg->scope = ipv6_addr_scope(cfg->pfx);
@@ -3001,22 +3019,29 @@ static int inet6_addr_add(struct net *net, int ifindex,
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
+		NL_SET_ERR_MSG_MOD(extack, "Invalid prefix length");
 		return -EINVAL;
+	}
 
 	dev = __dev_get_by_index(net, ifindex);
-	if (!dev)
+	if (!dev) {
+		NL_SET_ERR_MSG_MOD(extack, "Unable to find the interface");
 		return -ENODEV;
+	}
 
 	idev = __in6_dev_get(dev);
-	if (!idev)
+	if (!idev) {
+		NL_SET_ERR_MSG_MOD(extack, "IPv6 is disabled on this device");
 		return -ENXIO;
+	}
 
 	read_lock_bh(&idev->lock);
 	list_for_each_entry(ifp, &idev->addr_list, if_list) {
@@ -3039,6 +3064,8 @@ static int inet6_addr_del(struct net *net, int ifindex, u32 ifa_flags,
 		}
 	}
 	read_unlock_bh(&idev->lock);
+
+	NL_SET_ERR_MSG_MOD(extack, "address not found");
 	return -EADDRNOTAVAIL;
 }
 
@@ -3081,7 +3108,7 @@ int addrconf_del_ifaddr(struct net *net, void __user *arg)
 
 	rtnl_lock();
 	err = inet6_addr_del(net, ireq.ifr6_ifindex, 0, &ireq.ifr6_addr,
-			     ireq.ifr6_prefixlen);
+			     ireq.ifr6_prefixlen, NULL);
 	rtnl_unlock();
 	return err;
 }
@@ -3484,7 +3511,7 @@ static int fixup_permanent_addr(struct net *net,
 		struct fib6_info *f6i, *prev;
 
 		f6i = addrconf_f6i_alloc(net, idev, &ifp->addr, false,
-					 GFP_ATOMIC);
+					 GFP_ATOMIC, NULL);
 		if (IS_ERR(f6i))
 			return PTR_ERR(f6i);
 
@@ -4694,7 +4721,7 @@ inet6_rtm_deladdr(struct sk_buff *skb, struct nlmsghdr *nlh,
 	ifa_flags &= IFA_F_MANAGETEMPADDR;
 
 	return inet6_addr_del(net, ifm->ifa_index, ifa_flags, pfx,
-			      ifm->ifa_prefixlen);
+			      ifm->ifa_prefixlen, extack);
 }
 
 static int modify_prefix_route(struct inet6_ifaddr *ifp,
@@ -4899,8 +4926,10 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	dev =  __dev_get_by_index(net, ifm->ifa_index);
-	if (!dev)
+	if (!dev) {
+		NL_SET_ERR_MSG_MOD(extack, "Unable to find the interface");
 		return -ENODEV;
+	}
 
 	if (tb[IFA_FLAGS])
 		cfg.ifa_flags = nla_get_u32(tb[IFA_FLAGS]);
@@ -4935,10 +4964,12 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	if (nlh->nlmsg_flags & NLM_F_EXCL ||
-	    !(nlh->nlmsg_flags & NLM_F_REPLACE))
+	    !(nlh->nlmsg_flags & NLM_F_REPLACE)) {
+		NL_SET_ERR_MSG_MOD(extack, "address already assigned");
 		err = -EEXIST;
-	else
+	} else {
 		err = inet6_addr_modify(net, ifa, &cfg);
+	}
 
 	in6_ifa_put(ifa);
 
diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
index dacdea7fcb62..bb17f484ee2c 100644
--- a/net/ipv6/anycast.c
+++ b/net/ipv6/anycast.c
@@ -305,7 +305,7 @@ int __ipv6_dev_ac_inc(struct inet6_dev *idev, const struct in6_addr *addr)
 	}
 
 	net = dev_net(idev->dev);
-	f6i = addrconf_f6i_alloc(net, idev, addr, true, GFP_ATOMIC);
+	f6i = addrconf_f6i_alloc(net, idev, addr, true, GFP_ATOMIC, NULL);
 	if (IS_ERR(f6i)) {
 		err = PTR_ERR(f6i);
 		goto out;
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 64e873f5895f..c90700aed3a1 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4543,7 +4543,8 @@ static int ip6_pkt_prohibit_out(struct net *net, struct sock *sk, struct sk_buff
 struct fib6_info *addrconf_f6i_alloc(struct net *net,
 				     struct inet6_dev *idev,
 				     const struct in6_addr *addr,
-				     bool anycast, gfp_t gfp_flags)
+				     bool anycast, gfp_t gfp_flags,
+				     struct netlink_ext_ack *extack)
 {
 	struct fib6_config cfg = {
 		.fc_table = l3mdev_fib_table(idev->dev) ? : RT6_TABLE_LOCAL,
@@ -4565,7 +4566,7 @@ struct fib6_info *addrconf_f6i_alloc(struct net *net,
 		cfg.fc_flags |= RTF_LOCAL;
 	}
 
-	f6i = ip6_route_info_create(&cfg, gfp_flags, NULL);
+	f6i = ip6_route_info_create(&cfg, gfp_flags, extack);
 	if (!IS_ERR(f6i)) {
 		f6i->dst_nocount = true;
 
-- 
2.38.1


