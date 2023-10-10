Return-Path: <netdev+bounces-39481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190907BF6F0
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 11:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01B091C20DFC
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 09:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0979C168A3;
	Tue, 10 Oct 2023 09:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="zCbdJseT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E54171C1
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 09:13:33 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9CAB8
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 02:13:31 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40651a72807so52482615e9.1
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 02:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696929210; x=1697534010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiB5+NW7sALQftMmoRCmb37TPgU7wc4j33TX6f8hqLU=;
        b=zCbdJseTn1xaR9XsYhMBtgyrs/0Yt0TeM1TCNY59MrgZrZ/E/cupPmRiodFFqG/YDh
         hvmyYWjCDOkXkDAM06HMFhBzzVA2VQ26+B/wFxhhlsk2CiyMpWw1MXkqw2ZL0W45TEwF
         9a0f06JfFDZVviAjw/Sh6+t3xhZXq3fqfN7CBQe83bAcgxJQ3sNFO7H9PvYbCcTx63gt
         13+zLhhSK/r7fZsmqTBAnpavVU32y98OCuDJgySwPHpfS25fzO2p0qLjCMz0PyshuGMe
         86zAe+xYfFOXdBzo5YC0KOXQVYJ27GRMNHvyHW1HzTnrwOS2US2wqMu67RkpHvKfdLBc
         If3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696929210; x=1697534010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tiB5+NW7sALQftMmoRCmb37TPgU7wc4j33TX6f8hqLU=;
        b=NOj63axBsEgkbV6AsIXkRVNMEJoejvsynUcB1nDjg7ex+frVzx0aNydiRm4uQPPly9
         cq+N2Rub8vMwjTdMfryGPX27rTcQHRdY3FwcNiHPnqxPcmv/8tWmOSYo3k2/iFFaA4t1
         Q3ZTStkqz6I5nu5RBD6wXpEN3Ag6aGo05504mxrXIWijB1Qm+euwJMi+AsViC58seWlq
         GuwRucpoPnvp1SWAUx53v0JYm6yXj6rqBx+akEsK+vuk/4ZO/7U8Tyxh4llHU7XIr0tw
         PoxrM842dTLEuqGZXrtYhPNC4yVxDFhvJZYu4k1/RaDNS77U80ZbQlqHE2K12d+aUr7T
         2Mfw==
X-Gm-Message-State: AOJu0Yxgo77WhTODpcNsz/4mmpFcSogAeupeuHlgHjHilN6FOTr7bjlY
	KiNuaKA2+4vog7x+WxEHKpGFh7wa8cLT6Nk5b8Y=
X-Google-Smtp-Source: AGHT+IF4isO3M/8pyGOFiTQqguQNF7WzO6aCi43X39eYoC9tObp58D7awRfZD4T5AsQI/bDnyiWHjg==
X-Received: by 2002:a05:600c:2259:b0:403:bb3:28c9 with SMTP id a25-20020a05600c225900b004030bb328c9mr15838175wmm.38.1696929210095;
        Tue, 10 Oct 2023 02:13:30 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id hn8-20020a05600ca38800b00405959bbf4fsm13476907wmb.19.2023.10.10.02.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 02:13:29 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com
Subject: [patch net-next v2 3/3] devlink: don't take instance lock for nested handle put
Date: Tue, 10 Oct 2023 11:13:23 +0200
Message-ID: <20231010091323.195451-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231010091323.195451-1-jiri@resnulli.us>
References: <20231010091323.195451-1-jiri@resnulli.us>
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
v1->v2:
- push netns part into separate patch
---
 net/devlink/core.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

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
-- 
2.41.0


