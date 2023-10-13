Return-Path: <netdev+bounces-40687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4427C8567
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 14:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3CC1C210BA
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 12:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403BA14A8A;
	Fri, 13 Oct 2023 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="irkWmS2N"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ABB15493
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 12:10:41 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0152BBE
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 05:10:39 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40566f89f6eso24129685e9.3
        for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 05:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697199038; x=1697803838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2j6BiR1mkOIoFw5Np4OYyng//tCf04KW2VcDcYcacv4=;
        b=irkWmS2NyEF5b7qLmj2u8jWjrSx4bqMORlV+IDIe0rQdqDSwVvKgno+0M1tpFRj3iT
         bEgAca/Sa2QpGb0jAe2JHFsE5RIn+woW43faPBSyXmnEJgeOWj/WlGY4qI4U79KYU+we
         WA9a7DDIQVgDLAr9WdcrsOhKHWzt1i7JXeJSnIq6THCqKd/9O+RHpjGGnw3ZVlph5hsF
         ERck8C4JkVXTdGYg7qScVloNaijlvktben7RNNKf455NmoUIGyrit6X5bESdyrOXYvhl
         OpptFrMlOeubwTbdKuAiwaNieDOxaYtkwR5hvXsgU4gpkqhs4Jfsk1CCEythLC0p47j1
         7uYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697199038; x=1697803838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2j6BiR1mkOIoFw5Np4OYyng//tCf04KW2VcDcYcacv4=;
        b=hNhRJomYXHhDWUYTZuAb/lAAwO0eV+46ULEzpU7oQ3nHC2Y2kkeK1y2Nipg8RmEIm7
         6K+G7ULuvmdrFcXdpxvx6XAdd0E9vhGidrdR2NHRkAQHAvX8W1yUHs5Ix+yKUBIdKKBn
         DuGeFBto8wJXl5Wh+FXkhq7WWxUe5bMz/3KACp8MQl0hmQv6PJNh9bEh5c3EZoLkZQMc
         HdDgPriAKt0+6BLvAnLk8iERIQV9JkRvAiGjUAqyMao5G2psshVln7Yc3XLQZOmIj7Sr
         Tr57QdY5aUlkcRly2XnezxWyXxdj0uFe/VH0x5Cx+aaHh/zCyWQ1v5MjAhvUe0ryE70R
         peDA==
X-Gm-Message-State: AOJu0Ywh+aqzwbsn3GbaDZ+3ydTIVsAgZPLQCX4SZohTi7gt2wWh+42g
	YfeTGHJ5VXQFo1wX1ET8687TDbzWn09fSbSy5tM=
X-Google-Smtp-Source: AGHT+IGYIZKBnBBeb/Qw0MR5ty0fk2W6VMsxjrr40nBdQq31jaW37p/M8KCAR+9vLye6cAl4rsInsg==
X-Received: by 2002:a05:6000:1e91:b0:32d:83b7:bdb9 with SMTP id dd17-20020a0560001e9100b0032d83b7bdb9mr5982595wrb.21.1697199038451;
        Fri, 13 Oct 2023 05:10:38 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id j9-20020a5d4649000000b0031fb91f23e9sm20756844wrs.43.2023.10.13.05.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 05:10:37 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com
Subject: [patch net-next v3 4/7] devlink: don't take instance lock for nested handle put
Date: Fri, 13 Oct 2023 14:10:26 +0200
Message-ID: <20231013121029.353351-5-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013121029.353351-1-jiri@resnulli.us>
References: <20231013121029.353351-1-jiri@resnulli.us>
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
handle. Instead, rely on the preparations done by previous two patches
to be able to access device pointer and obtain netns id without devlink
instance lock held.

Fixes: c137743bce02 ("devlink: introduce object and nested devlink relationship infra")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- push device reference part into separate patch
- adjusted the patch description
v1->v2:
- push netns part into separate patch
---
 net/devlink/core.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index c47c9e6c744f..655903ddbdfd 100644
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
-- 
2.41.0


