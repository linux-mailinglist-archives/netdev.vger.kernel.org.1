Return-Path: <netdev+bounces-39478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23CF7BF6EE
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 11:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D164281A14
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 09:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEC6168A2;
	Tue, 10 Oct 2023 09:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="w+Vt0yib"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B89EAFF
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 09:13:30 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EAA9F
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 02:13:27 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40566f8a093so50156355e9.3
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 02:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696929205; x=1697534005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F7tYafJmaiI9ir3H6yWSZP6c7EOa6KWx+9Z8aJrwE8w=;
        b=w+Vt0yibk7N9LqhwTbv7wimQwQ+hut9pl0KVfW11stZKiRx1qh3ukILt0Hs+m3q+xC
         4h+/xvLXEmF2si0L+j/RpI+69mem6NqpiWGuviiSAGCNhP9gfV0COgYnDTyZgPs3XzSe
         tTRlF/YRMUrHdLJQgBPlIDAZHQpkQRcljTGGGfOp3aeRed4soArIQ4BOCCZyZw39RHs+
         gdOaWUCveFwnYcKBxbogsK1DPlO1MeT8ODibLeq9GWHAkvNB/nGQ0XiViBBrc61Lvh2j
         7IQskRncAny5hs01shNOT27dPxHq9NjCAllS9WYdhjsd5FE98rPhOKBbGKEBEKSYyEYr
         oFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696929205; x=1697534005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F7tYafJmaiI9ir3H6yWSZP6c7EOa6KWx+9Z8aJrwE8w=;
        b=phQbw3YPSmzXx03vKb8WewHx/lJJUQSjsoO7i2G6PA6iJDzR42pdEVOcbUSk4DP1i7
         FypFaD6XTODA1R35jaHlD8d5eNJbl+W2W419PiHHWHBHBoO3TJInqiJl+CUJtcngyX3b
         1JCneOdKkBS3HG2ZZGMCrFzwG2XMnQwE7kSalH0ifhgoLRbYZIqMMnH5ZAEJJU94FbBj
         DMIeWjixwr9euPcp4x5XD2pyUk1LDykaseIqIvtUhVu+w1X/uYLgVrJNuRDhHK/VuW+s
         mWY8eYON8c+DzcBhxlLMUaTsNMGmyqJB0kAHbEDwmJioFECLw79zakYgmgoMOZLXNGNA
         0FYA==
X-Gm-Message-State: AOJu0YwJhGBPuiZ25PKLRThO0Dhb+/CWr3eMlP+GB+p2FRNwl8jeMrj8
	4cR7JVZjc1a7vgf1jILJeElrnJkOLqpddHNuiJI=
X-Google-Smtp-Source: AGHT+IGGdQ4UrxUiKnVE6TOb4dT1JixMTdqgVwg45vuiMNo/aMoz3NIJCcT27dEPrWHKe/kI+gIswQ==
X-Received: by 2002:a1c:6a17:0:b0:401:db82:3edf with SMTP id f23-20020a1c6a17000000b00401db823edfmr15594443wmc.39.1696929205446;
        Tue, 10 Oct 2023 02:13:25 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id p15-20020a7bcc8f000000b003fee6e170f9sm13542704wma.45.2023.10.10.02.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 02:13:24 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com
Subject: [patch net-next v2 0/3] devlink: don't take instance lock for nested handle put
Date: Tue, 10 Oct 2023 11:13:20 +0200
Message-ID: <20231010091323.195451-1-jiri@resnulli.us>
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

Patch #1 is dependency of patch #2.
Patch #2 converts the peernet2id_alloc() call so it could called without
devlink instance lock and prepares for the lock taking removal done
in patch #3.

Jiri Pirko (3):
  net: treat possible_net_t net pointer as an RCU one and add
    read_pnet_rcu()
  devlink: call peernet2id_alloc() with net pointer under RCU read lock
  devlink: don't take instance lock for nested handle put

 include/net/net_namespace.h | 15 ++++++++++++---
 net/devlink/core.c          | 20 +++++---------------
 net/devlink/netlink.c       | 12 +++++++++---
 3 files changed, 26 insertions(+), 21 deletions(-)

-- 
2.41.0


