Return-Path: <netdev+bounces-166476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FF6A361D8
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D462A7A2948
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E412676FB;
	Fri, 14 Feb 2025 15:34:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FAA266F10
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547293; cv=none; b=kWub87pgnakmN9ip1EaCesXbhSbalfJln+PBWq1H1e+y0dxeZ+1woJDkPJUTP424WwNz853ZzY6muqvOme02xyhIkc+T0yGX+BTbpX6cQJiyWlmXAUvBzd2SPwmz2x4l0l1hh3fx4ZuivjesbmrxngtoCnCS5IWgvYg368iOMok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547293; c=relaxed/simple;
	bh=/IGtQjuNYxVdJHujh4F7x+ZdvPDMWzjUoEdVlQjU7Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewtzqTqwoj+u+oCH5bv8tFaKQe/Lx2+dnQT7gu1/iWmvAm3uO3B7bLQHegENjlpSssJOiztgOKsI9UW3jAD/jLwdlA5Czz77t2XuwxGdlUTf16/hyEKdsiG1YI7YbCCXGgukiWF22t96fZzymtLVbWKmIUnjwzbB2PlM6izYWC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220d398bea9so31596895ad.3
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 07:34:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739547291; x=1740152091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxV59gmkTRhdeN3A9aeHLy40L9Og5hNZl6VQdphU2Bw=;
        b=iJ+kI5mB+LZzGcjVCcMmv253fl9DhRV9NrTfI2D+bLizJmHxZ2t+EGK58Sl4/JwvwQ
         pgLE3Xbp5j5ZFk17gKk2gdljztD6w58Kz/cO5+1tBu3M84vilMuyeAk7N6NPSc7Bn/4L
         JddcNduuZvmzxCK9NQ5JjJN7b+Pox54Vk41CUKCzxH9fXbdfJS/8ptLA3Zqhzdb0UBrU
         usgB9IYup2KtLp9C9VevZJ/4SfuARUmPdC6pN481nBIInZolzWtjG3hmGz7eUKPjC08K
         dEEFHr3O8c3pGjqwreMzzJH37oHC98LwdySZP1Tb65zcYj6aAuFnOBtQrZGoUK3gdmmE
         RjlA==
X-Gm-Message-State: AOJu0YwB+PMSJIr6an49ht+HOcHISHE9OUlOMKT3UQutaCv+eQ3e/+d+
	/jKFseKhBVlM5/FCNIfiiU6MU9Rnm+3S6Wp+dt9lM36acqXLM8PnBwEJ
X-Gm-Gg: ASbGncvyMkYvl/WGFW+2RjXQAGogxkaEr8rJ7wPL8RkJ2/cCN1cAK7QgPrMRi0FUYLp
	Kp/Uk8gyGOFQDGakVXUp5BmiiiKs1cC3/4ufFIDEZuT5p7NMVMib8ynF5p5i0rKhVoS1+6yeD62
	CznPKq2hCmozb71pKq5JOih0czf07NZc1QJXoRzSLrYRd4DG6xZiSGNwjfPDQNMkxvUFCCbpQ3g
	TchdimUS6+JNPOd7WCpUDSDJcqL7IqZmGRUxox5qgff6VUQMUE2fo1r8IA2KmtXfsaY27KjkHwM
	vTs8FOeSfKrwRHQ=
X-Google-Smtp-Source: AGHT+IG/Hts96yM1hlv7hJdcTrUom9LcdHuDEqjUtqEttFuyfuAw+W530UFZuTS/0/q0rPVS5j1KPA==
X-Received: by 2002:a05:6a00:841:b0:730:957d:a80f with SMTP id d2e1a72fcca58-7322c3752famr18426321b3a.2.1739547290520;
        Fri, 14 Feb 2025 07:34:50 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7324273f896sm3271032b3a.117.2025.02.14.07.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:34:50 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v2 07/11] net: hold netdev instance lock during ndo_bpf
Date: Fri, 14 Feb 2025 07:34:36 -0800
Message-ID: <20250214153440.1994910-8-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214153440.1994910-1-sdf@fomichev.me>
References: <20250214153440.1994910-1-sdf@fomichev.me>
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
 kernel/bpf/offload.c      |  7 ++++++-
 net/core/dev.c            | 13 +++++++++++--
 net/core/dev_api.c        | 12 ++++++++++++
 net/xdp/xsk.c             |  3 +++
 net/xdp/xsk_buff_pool.c   |  2 ++
 6 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ccd41f2fc3db..53fc0d02abc8 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4221,6 +4221,7 @@ struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
 
 int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 u8 dev_xdp_prog_count(struct net_device *dev);
+int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
 int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
 u8 dev_xdp_sb_prog_count(struct net_device *dev);
 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode);
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 1a4fec330eaa..a9d370c1b135 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -122,6 +122,7 @@ static int bpf_map_offload_ndo(struct bpf_offloaded_map *offmap,
 {
 	struct netdev_bpf data = {};
 	struct net_device *netdev;
+	int ret;
 
 	ASSERT_RTNL();
 
@@ -130,7 +131,11 @@ static int bpf_map_offload_ndo(struct bpf_offloaded_map *offmap,
 	/* Caller must make sure netdev is valid */
 	netdev = offmap->netdev;
 
-	return netdev->netdev_ops->ndo_bpf(netdev, &data);
+	netdev_lock_ops(netdev);
+	ret = netdev->netdev_ops->ndo_bpf(netdev, &data);
+	netdev_unlock_ops(netdev);
+
+	return ret;
 }
 
 static void __bpf_map_offload_destroy(struct bpf_offloaded_map *offmap)
diff --git a/net/core/dev.c b/net/core/dev.c
index 949b2f29b4ca..e4b701d99bd0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9639,7 +9639,7 @@ u8 dev_xdp_sb_prog_count(struct net_device *dev)
 	return count;
 }
 
-int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
+int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 {
 	if (!dev->netdev_ops->ndo_bpf)
 		return -EOPNOTSUPP;
@@ -9659,7 +9659,6 @@ int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 
 	return dev->netdev_ops->ndo_bpf(dev, bpf);
 }
-EXPORT_SYMBOL_GPL(dev_xdp_propagate);
 
 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode)
 {
@@ -9689,6 +9688,8 @@ static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
 	struct netdev_bpf xdp;
 	int err;
 
+	netdev_ops_assert_locked(dev);
+
 	if (dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
 	    prog && !prog->aux->xdp_has_frags) {
 		NL_SET_ERR_MSG(extack, "unable to install XDP to device using tcp-data-split");
@@ -9921,7 +9922,9 @@ static void bpf_xdp_link_release(struct bpf_link *link)
 	 * already NULL, in which case link was already auto-detached
 	 */
 	if (xdp_link->dev) {
+		netdev_lock_ops(xdp_link->dev);
 		WARN_ON(dev_xdp_detach_link(xdp_link->dev, NULL, xdp_link));
+		netdev_unlock_ops(xdp_link->dev);
 		xdp_link->dev = NULL;
 	}
 
@@ -10003,10 +10006,12 @@ static int bpf_xdp_link_update(struct bpf_link *link, struct bpf_prog *new_prog,
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
 
@@ -10792,7 +10797,9 @@ int register_netdevice(struct net_device *dev)
 	if (ret)
 		goto err_uninit_notify;
 
+	netdev_lock_ops(dev);
 	__netdev_update_features(dev);
+	netdev_unlock_ops(dev);
 
 	/*
 	 *	Default initial state at registry is that the
@@ -11745,7 +11752,9 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		/* Shutdown queueing discipline. */
 		dev_shutdown(dev);
 		dev_tcx_uninstall(dev);
+		netdev_lock_ops(dev);
 		dev_xdp_uninstall(dev);
+		netdev_unlock_ops(dev);
 		bpf_dev_bound_netdev_unregister(dev);
 		dev_memory_provider_uninstall(dev);
 
diff --git a/net/core/dev_api.c b/net/core/dev_api.c
index 87a62022ef1c..0db20ed086d3 100644
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
index 89d2bef96469..277c97c58c09 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1178,6 +1178,8 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 		goto out_release;
 	}
 
+	netdev_lock_ops(dev);
+
 	if (!xs->rx && !xs->tx) {
 		err = -EINVAL;
 		goto out_unlock;
@@ -1312,6 +1314,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
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


