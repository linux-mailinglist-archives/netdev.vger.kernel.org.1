Return-Path: <netdev+bounces-172145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B814FA5051A
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 17:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1BF1883481
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 16:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C841A5BB7;
	Wed,  5 Mar 2025 16:37:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7391A5B84
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 16:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192667; cv=none; b=tC9s3ndXrMD7jCd/EQQ+5LN6bY84WEtKWwFJ2gNt0d2eEVUuPUFrv2b9MqryzCRE9dKme/jOw96ke2u0AjNzTgT87Hxm7iOlBDYEnWOA4sD3vsqi7c9Xxo5W3n7a6aC8IUK2pVEFFsW3+FrO/eHR9SEFuh7MtXMT2lPMXWy2itA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192667; c=relaxed/simple;
	bh=muhzBXZ4cbs9n00yKNWrE9dq+3va7dNrvwETAAcDZHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rh/3eHXGZLxqPIyjsSAGXtaGzBpb8RpzoxkT9wSaOJF4z3KG59haJmjAsXoqzugTSimalyDA1KaO7JTj6eXMbbggX+9rvdyVTktc7x9QQRz+COr44n/ryeqFtStO0a6QTE+iZuxj5juXYpK/tnAZ6aYHSNYIvXZmCeMICQyQV4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-223959039f4so86898365ad.3
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 08:37:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741192665; x=1741797465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39USaMyvIxaBDm4XXvid+nR/AvELpk8a9xvvS0A+rno=;
        b=nRn+NmwWy7DB7HR7/gXL3ie+5sk2N/ywGfv4GlVysgQrL5xkk5X8TPvmI1LDP8yFJN
         ukrWqDOYr4bhD+xRzCXUYvhdDeZMbZTUOC5uUpJibrYB/4pH5FRJFqLIztP3UNu45YTv
         lROadc68n/ZGNgTRsx09WlSKnBHm5NWhOWdTxkQw3VkqiK5tDmRKamWEyM0kxPUzu8AJ
         sOpRk36ZZsmu1QBP+wBvi7ztj2+KxTlScWbSz8jbYlcA1YddIuCVPw+Pr/Tfc7GGiMy1
         Hnwx1bVdxGz5Mu9HyrEEDSELV9QGcX90ac3YCqgVvkonVKReuYEFb/FUJ5sQgRvODIlb
         /Zug==
X-Gm-Message-State: AOJu0YyjaA7MSTUyUtporKH13lPK7ZLrZazh5Vf7VUEODMkds5DqPhfW
	AMzMQSA8JnlyfZ7QB4F7QYN3wUGQUTg+ZKzRWok1u5upJYFe0bzJXx9f
X-Gm-Gg: ASbGnctWDKEUfIDhyypg+qTPMJ+DYFgMiv6mCQpl96A7u4SzDsvRR7qG+B0KPbilkaP
	W4E9gkOpFEF/NGWLVqOw4ZSpSjhv07P1BnqVS1YvWtLAq6TOc3vMuA8cPH4CME5hcWQyXVctcG/
	Y0YgqUa43y154sSb45OADol+r9EGK3DPRkXhaPMB4qYYgVL2SUV/XAxT0VnYLIGy24Ap3U5/x3U
	H0VXZ5lTadYIiigUnwG++mEGVIVrXwerv9MyVWB4uLKtY1fOGiAIicu1KRewkaxwfkiGLn1DtIW
	VIflWlrJ6TuY/Z5aojrv4FMejkdoD2xpl/6pIh/8oqFC
X-Google-Smtp-Source: AGHT+IFqpfJNifTbamgtOIIO/MS2bNJz9AMyuulEFuxOhtSVfwsZUlH589vy/XYoZ0I1jfgtKdrggg==
X-Received: by 2002:a17:902:f54b:b0:21f:85af:4bbf with SMTP id d9443c01a7336-223f1c8064amr53868305ad.20.1741192665018;
        Wed, 05 Mar 2025 08:37:45 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223f952432bsm12927735ad.212.2025.03.05.08.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 08:37:44 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v10 09/14] net: hold netdev instance lock during ndo_bpf
Date: Wed,  5 Mar 2025 08:37:27 -0800
Message-ID: <20250305163732.2766420-10-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305163732.2766420-1-sdf@fomichev.me>
References: <20250305163732.2766420-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cover the paths that come via bpf system call and XSK bind.

Cc: Saeed Mahameed <saeed@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/linux/netdevice.h |  1 +
 kernel/bpf/offload.c      |  6 ++++--
 net/core/dev.c            | 13 +++++++++++--
 net/core/dev_api.c        | 12 ++++++++++++
 net/xdp/xsk.c             |  3 +++
 net/xdp/xsk_buff_pool.c   |  2 ++
 6 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c61b12809588..ca9c09dab14e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4277,6 +4277,7 @@ struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
 
 int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 u8 dev_xdp_prog_count(struct net_device *dev);
+int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
 int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
 u8 dev_xdp_sb_prog_count(struct net_device *dev);
 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode);
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 1a4fec330eaa..a10153c3be2d 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -528,10 +528,10 @@ struct bpf_map *bpf_map_offload_map_alloc(union bpf_attr *attr)
 		return ERR_PTR(-ENOMEM);
 
 	bpf_map_init_from_attr(&offmap->map, attr);
-
 	rtnl_lock();
-	down_write(&bpf_devs_lock);
 	offmap->netdev = __dev_get_by_index(net, attr->map_ifindex);
+	netdev_lock_ops(offmap->netdev);
+	down_write(&bpf_devs_lock);
 	err = bpf_dev_offload_check(offmap->netdev);
 	if (err)
 		goto err_unlock;
@@ -548,12 +548,14 @@ struct bpf_map *bpf_map_offload_map_alloc(union bpf_attr *attr)
 
 	list_add_tail(&offmap->offloads, &ondev->maps);
 	up_write(&bpf_devs_lock);
+	netdev_unlock_ops(offmap->netdev);
 	rtnl_unlock();
 
 	return &offmap->map;
 
 err_unlock:
 	up_write(&bpf_devs_lock);
+	netdev_unlock_ops(offmap->netdev);
 	rtnl_unlock();
 	bpf_map_area_free(offmap);
 	return ERR_PTR(err);
diff --git a/net/core/dev.c b/net/core/dev.c
index 121c0449f87f..404047d4d943 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9852,7 +9852,7 @@ u8 dev_xdp_sb_prog_count(struct net_device *dev)
 	return count;
 }
 
-int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
+int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 {
 	if (!dev->netdev_ops->ndo_bpf)
 		return -EOPNOTSUPP;
@@ -9872,7 +9872,6 @@ int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 
 	return dev->netdev_ops->ndo_bpf(dev, bpf);
 }
-EXPORT_SYMBOL_GPL(dev_xdp_propagate);
 
 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode)
 {
@@ -9902,6 +9901,8 @@ static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
 	struct netdev_bpf xdp;
 	int err;
 
+	netdev_ops_assert_locked(dev);
+
 	if (dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
 	    prog && !prog->aux->xdp_has_frags) {
 		NL_SET_ERR_MSG(extack, "unable to install XDP to device using tcp-data-split");
@@ -10134,7 +10135,9 @@ static void bpf_xdp_link_release(struct bpf_link *link)
 	 * already NULL, in which case link was already auto-detached
 	 */
 	if (xdp_link->dev) {
+		netdev_lock_ops(xdp_link->dev);
 		WARN_ON(dev_xdp_detach_link(xdp_link->dev, NULL, xdp_link));
+		netdev_unlock_ops(xdp_link->dev);
 		xdp_link->dev = NULL;
 	}
 
@@ -10216,10 +10219,12 @@ static int bpf_xdp_link_update(struct bpf_link *link, struct bpf_prog *new_prog,
 		goto out_unlock;
 	}
 
+	netdev_lock_ops(xdp_link->dev);
 	mode = dev_xdp_mode(xdp_link->dev, xdp_link->flags);
 	bpf_op = dev_xdp_bpf_op(xdp_link->dev, mode);
 	err = dev_xdp_install(xdp_link->dev, mode, bpf_op, NULL,
 			      xdp_link->flags, new_prog);
+	netdev_unlock_ops(xdp_link->dev);
 	if (err)
 		goto out_unlock;
 
@@ -11005,7 +11010,9 @@ int register_netdevice(struct net_device *dev)
 	if (ret)
 		goto err_uninit_notify;
 
+	netdev_lock_ops(dev);
 	__netdev_update_features(dev);
+	netdev_unlock_ops(dev);
 
 	/*
 	 *	Default initial state at registry is that the
@@ -11945,7 +11952,9 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		/* Shutdown queueing discipline. */
 		dev_shutdown(dev);
 		dev_tcx_uninstall(dev);
+		netdev_lock_ops(dev);
 		dev_xdp_uninstall(dev);
+		netdev_unlock_ops(dev);
 		bpf_dev_bound_netdev_unregister(dev);
 		dev_memory_provider_uninstall(dev);
 
diff --git a/net/core/dev_api.c b/net/core/dev_api.c
index 7bd667b34b80..98db990ce21c 100644
--- a/net/core/dev_api.c
+++ b/net/core/dev_api.c
@@ -317,3 +317,15 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 	return ret;
 }
 EXPORT_SYMBOL(dev_set_mac_address);
+
+int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
+{
+	int ret;
+
+	netdev_lock_ops(dev);
+	ret = netif_xdp_propagate(dev, bpf);
+	netdev_unlock_ops(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_xdp_propagate);
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 84bf9f1d4bf2..f864e5d70b40 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1181,6 +1181,8 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 		goto out_release;
 	}
 
+	netdev_lock_ops(dev);
+
 	if (!xs->rx && !xs->tx) {
 		err = -EINVAL;
 		goto out_unlock;
@@ -1315,6 +1317,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 		smp_wmb();
 		WRITE_ONCE(xs->state, XSK_BOUND);
 	}
+	netdev_unlock_ops(dev);
 out_release:
 	mutex_unlock(&xs->mutex);
 	rtnl_unlock();
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index c263fb7a68dc..0e6ca568fdee 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/netdevice.h>
 #include <net/xsk_buff_pool.h>
 #include <net/xdp_sock.h>
 #include <net/xdp_sock_drv.h>
@@ -219,6 +220,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 	bpf.xsk.pool = pool;
 	bpf.xsk.queue_id = queue_id;
 
+	netdev_ops_assert_locked(netdev);
 	err = netdev->netdev_ops->ndo_bpf(netdev, &bpf);
 	if (err)
 		goto err_unreg_pool;
-- 
2.48.1


