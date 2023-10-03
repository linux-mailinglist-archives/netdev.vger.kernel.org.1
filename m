Return-Path: <netdev+bounces-37586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275B17B62AA
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 09:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 851CE28131A
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 07:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE48D29D;
	Tue,  3 Oct 2023 07:43:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787686AB4
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 07:43:56 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88631A9
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 00:43:52 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9ae75ece209so94127266b.3
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 00:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696319031; x=1696923831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6jWS09yPlmT/nxTJiXs7+fTMrLXImEC8p6wRCenFi3s=;
        b=Pcck7986B9rIOPzARRdbeiTyFiDiSc7lzZ+QNMagnMlhrFutGhq8HnYjtUMOIzsM5+
         pp4FHsbqkgYVuYlwDk++wb+wQK6x1ppmCrpTzzpt7rKgGigH4b2a893UHsGhTLET+X8f
         ZR8DUbIL0dqpr0VfCBf12Bb91/o5jP31Kg4+ptP9KzeCSJj22SUiqv80214QC5ITxnJu
         KZXtQxJR5oeMVWrYSBf/DdUGpuJdH6W8djrd1b2tSCvFMS3RG7qwFucRh0rYVPj3WV+J
         mSRFWXP82zZhZjtBQ9YTJ3PYit5XpUskvcVGjmwh9ZS03DP5nLcByJwgKrjhZJQYHNhY
         I8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696319031; x=1696923831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6jWS09yPlmT/nxTJiXs7+fTMrLXImEC8p6wRCenFi3s=;
        b=NyHnf6sNJJSmQz9ZozQRCg4n7HGL9GI/V5fYo1trnNPvD2aetVYyMZLdBwq9p3HYnn
         D3zM4TSpkeKsECj9PqNPL2s+ZsPHhZIc0QjdS6E1ar+Q2PaAa3hyFDgKmwZwZYrqAy+x
         IP5mbs/rQ5fHpLrtOpF2MpcOzAFUPSVc6VZ/7arIaZnPuh2mzX/S86R6RQhKBwndBLVn
         Jvjq0B/TMxO1EEnawjtacLoFTCUQTm1DRrbPdNo/10l4/hx1eTBJwqGaQyHUIniYrAs7
         Gr+NsGs64hplbDt15fQ5ovN/eChORFUftzzjaDAALJ5Xq+6yUMASnsSoCNGF3K8V7DNw
         Z5uQ==
X-Gm-Message-State: AOJu0Yx3Cry/D0XbRX5MoMBwbttp4+9sMoX1owMNnx70ZpWGLfQssVBe
	GcHG+XZA/1IRkEPnD4VMCQY05blc2P9t5HVXwWM=
X-Google-Smtp-Source: AGHT+IGmgs1Xo8p0meTQV2USFmUoO2+WUqOiHJmQ72/t7YVNv26ah696b6E8XDDOWMRcI5w0qdTQzw==
X-Received: by 2002:a17:906:10ce:b0:9ae:4843:66ee with SMTP id v14-20020a17090610ce00b009ae484366eemr13191087ejv.36.1696319030772;
        Tue, 03 Oct 2023 00:43:50 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id op13-20020a170906bced00b0098921e1b064sm584921ejb.181.2023.10.03.00.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 00:43:50 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	gal@nvidia.com
Subject: [patch net-next] devlink: don't take instance lock for nested handle put
Date: Tue,  3 Oct 2023 09:43:49 +0200
Message-ID: <20231003074349.1435667-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Lockdep reports following issue:

WARNING: possible circular locking dependency detected
------------------------------------------------------
devlink/8191 is trying to acquire lock:
ffff88813f32c250 (&devlink->lock_key#14){+.+.}-{3:3}, at: devlink_rel_devlink_handle_put+0x11e/0x2d0

                           but task is already holding lock:
ffffffff8511eca8 (rtnl_mutex){+.+.}-{3:3}, at: unregister_netdev+0xe/0x20

                           which lock already depends on the new lock.

                           the existing dependency chain (in reverse order) is:

                           -> #3 (rtnl_mutex){+.+.}-{3:3}:
       lock_acquire+0x1c3/0x500
       __mutex_lock+0x14c/0x1b20
       register_netdevice_notifier_net+0x13/0x30
       mlx5_lag_add_mdev+0x51c/0xa00 [mlx5_core]
       mlx5_load+0x222/0xc70 [mlx5_core]
       mlx5_init_one_devl_locked+0x4a0/0x1310 [mlx5_core]
       mlx5_init_one+0x3b/0x60 [mlx5_core]
       probe_one+0x786/0xd00 [mlx5_core]
       local_pci_probe+0xd7/0x180
       pci_device_probe+0x231/0x720
       really_probe+0x1e4/0xb60
       __driver_probe_device+0x261/0x470
       driver_probe_device+0x49/0x130
       __driver_attach+0x215/0x4c0
       bus_for_each_dev+0xf0/0x170
       bus_add_driver+0x21d/0x590
       driver_register+0x133/0x460
       vdpa_match_remove+0x89/0xc0 [vdpa]
       do_one_initcall+0xc4/0x360
       do_init_module+0x22d/0x760
       load_module+0x51d7/0x6750
       init_module_from_file+0xd2/0x130
       idempotent_init_module+0x326/0x5a0
       __x64_sys_finit_module+0xc1/0x130
       do_syscall_64+0x3d/0x90
       entry_SYSCALL_64_after_hwframe+0x46/0xb0

                           -> #2 (mlx5_intf_mutex){+.+.}-{3:3}:
       lock_acquire+0x1c3/0x500
       __mutex_lock+0x14c/0x1b20
       mlx5_register_device+0x3e/0xd0 [mlx5_core]
       mlx5_init_one_devl_locked+0x8fa/0x1310 [mlx5_core]
       mlx5_devlink_reload_up+0x147/0x170 [mlx5_core]
       devlink_reload+0x203/0x380
       devlink_nl_cmd_reload+0xb84/0x10e0
       genl_family_rcv_msg_doit+0x1cc/0x2a0
       genl_rcv_msg+0x3c9/0x670
       netlink_rcv_skb+0x12c/0x360
       genl_rcv+0x24/0x40
       netlink_unicast+0x435/0x6f0
       netlink_sendmsg+0x7a0/0xc70
       sock_sendmsg+0xc5/0x190
       __sys_sendto+0x1c8/0x290
       __x64_sys_sendto+0xdc/0x1b0
       do_syscall_64+0x3d/0x90
       entry_SYSCALL_64_after_hwframe+0x46/0xb0

                           -> #1 (&dev->lock_key#8){+.+.}-{3:3}:
       lock_acquire+0x1c3/0x500
       __mutex_lock+0x14c/0x1b20
       mlx5_init_one_devl_locked+0x45/0x1310 [mlx5_core]
       mlx5_devlink_reload_up+0x147/0x170 [mlx5_core]
       devlink_reload+0x203/0x380
       devlink_nl_cmd_reload+0xb84/0x10e0
       genl_family_rcv_msg_doit+0x1cc/0x2a0
       genl_rcv_msg+0x3c9/0x670
       netlink_rcv_skb+0x12c/0x360
       genl_rcv+0x24/0x40
       netlink_unicast+0x435/0x6f0
       netlink_sendmsg+0x7a0/0xc70
       sock_sendmsg+0xc5/0x190
       __sys_sendto+0x1c8/0x290
       __x64_sys_sendto+0xdc/0x1b0
       do_syscall_64+0x3d/0x90
       entry_SYSCALL_64_after_hwframe+0x46/0xb0

                           -> #0 (&devlink->lock_key#14){+.+.}-{3:3}:
       check_prev_add+0x1af/0x2300
       __lock_acquire+0x31d7/0x4eb0
       lock_acquire+0x1c3/0x500
       __mutex_lock+0x14c/0x1b20
       devlink_rel_devlink_handle_put+0x11e/0x2d0
       devlink_nl_port_fill+0xddf/0x1b00
       devlink_port_notify+0xb5/0x220
       __devlink_port_type_set+0x151/0x510
       devlink_port_netdevice_event+0x17c/0x220
       notifier_call_chain+0x97/0x240
       unregister_netdevice_many_notify+0x876/0x1790
       unregister_netdevice_queue+0x274/0x350
       unregister_netdev+0x18/0x20
       mlx5e_vport_rep_unload+0xc5/0x1c0 [mlx5_core]
       __esw_offloads_unload_rep+0xd8/0x130 [mlx5_core]
       mlx5_esw_offloads_rep_unload+0x52/0x70 [mlx5_core]
       mlx5_esw_offloads_unload_rep+0x85/0xc0 [mlx5_core]
       mlx5_eswitch_unload_sf_vport+0x41/0x90 [mlx5_core]
       mlx5_devlink_sf_port_del+0x120/0x280 [mlx5_core]
       genl_family_rcv_msg_doit+0x1cc/0x2a0
       genl_rcv_msg+0x3c9/0x670
       netlink_rcv_skb+0x12c/0x360
       genl_rcv+0x24/0x40
       netlink_unicast+0x435/0x6f0
       netlink_sendmsg+0x7a0/0xc70
       sock_sendmsg+0xc5/0x190
       __sys_sendto+0x1c8/0x290
       __x64_sys_sendto+0xdc/0x1b0
       do_syscall_64+0x3d/0x90
       entry_SYSCALL_64_after_hwframe+0x46/0xb0

                           other info that might help us debug this:

Chain exists of:
                             &devlink->lock_key#14 --> mlx5_intf_mutex --> rtnl_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(rtnl_mutex);
                               lock(mlx5_intf_mutex);
                               lock(rtnl_mutex);
  lock(&devlink->lock_key#14);

Problem is taking the devlink instance lock of nested instance when RTNL
is already held.

To fix this, don't take the devlink instance lock when putting nested
handle. Instead, rely on devlink reference to access relevant pointers
within devlink structure. Also, make sure that the device does
not disappear by taking a reference in devlink_alloc_ns().

Fixes: c137743bce02 ("devlink: introduce object and nested devlink relationship infra")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/core.c    | 20 +++++---------------
 net/devlink/netlink.c |  6 +++---
 2 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index bcbbb952569f..655903ddbdfd 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -183,9 +183,8 @@ static struct devlink_rel *devlink_rel_find(unsigned long rel_index)
 		       DEVLINK_REL_IN_USE);
 }
 
-static struct devlink *devlink_rel_devlink_get_lock(u32 rel_index)
+static struct devlink *devlink_rel_devlink_get(u32 rel_index)
 {
-	struct devlink *devlink;
 	struct devlink_rel *rel;
 	u32 devlink_index;
 
@@ -198,16 +197,7 @@ static struct devlink *devlink_rel_devlink_get_lock(u32 rel_index)
 	xa_unlock(&devlink_rels);
 	if (!rel)
 		return NULL;
-	devlink = devlinks_xa_get(devlink_index);
-	if (!devlink)
-		return NULL;
-	devl_lock(devlink);
-	if (!devl_is_registered(devlink)) {
-		devl_unlock(devlink);
-		devlink_put(devlink);
-		return NULL;
-	}
-	return devlink;
+	return devlinks_xa_get(devlink_index);
 }
 
 int devlink_rel_devlink_handle_put(struct sk_buff *msg, struct devlink *devlink,
@@ -218,11 +208,10 @@ int devlink_rel_devlink_handle_put(struct sk_buff *msg, struct devlink *devlink,
 	struct devlink *rel_devlink;
 	int err;
 
-	rel_devlink = devlink_rel_devlink_get_lock(rel_index);
+	rel_devlink = devlink_rel_devlink_get(rel_index);
 	if (!rel_devlink)
 		return 0;
 	err = devlink_nl_put_nested_handle(msg, net, rel_devlink, attrtype);
-	devl_unlock(rel_devlink);
 	devlink_put(rel_devlink);
 	if (!err && msg_updated)
 		*msg_updated = true;
@@ -310,6 +299,7 @@ static void devlink_release(struct work_struct *work)
 
 	mutex_destroy(&devlink->lock);
 	lockdep_unregister_key(&devlink->lock_key);
+	put_device(devlink->dev);
 	kfree(devlink);
 }
 
@@ -425,7 +415,7 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 	if (ret < 0)
 		goto err_xa_alloc;
 
-	devlink->dev = dev;
+	devlink->dev = get_device(dev);
 	devlink->ops = ops;
 	xa_init_flags(&devlink->ports, XA_FLAGS_ALLOC);
 	xa_init_flags(&devlink->params, XA_FLAGS_ALLOC);
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 499304d9de49..2685c8fcf124 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -85,6 +85,7 @@ static const struct nla_policy devlink_nl_policy[DEVLINK_ATTR_MAX + 1] = {
 int devlink_nl_put_nested_handle(struct sk_buff *msg, struct net *net,
 				 struct devlink *devlink, int attrtype)
 {
+	struct net *devl_net = devlink_net(devlink);
 	struct nlattr *nested_attr;
 
 	nested_attr = nla_nest_start(msg, attrtype);
@@ -92,9 +93,8 @@ int devlink_nl_put_nested_handle(struct sk_buff *msg, struct net *net,
 		return -EMSGSIZE;
 	if (devlink_nl_put_handle(msg, devlink))
 		goto nla_put_failure;
-	if (!net_eq(net, devlink_net(devlink))) {
-		int id = peernet2id_alloc(net, devlink_net(devlink),
-					  GFP_KERNEL);
+	if (!net_eq(net, devl_net)) {
+		int id = peernet2id_alloc(net, devl_net, GFP_KERNEL);
 
 		if (nla_put_s32(msg, DEVLINK_ATTR_NETNS_ID, id))
 			return -EMSGSIZE;
-- 
2.41.0


