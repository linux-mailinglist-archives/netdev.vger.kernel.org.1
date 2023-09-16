Return-Path: <netdev+bounces-34288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB307A3094
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 15:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 369B81C20C57
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 13:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3022513FF0;
	Sat, 16 Sep 2023 13:11:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12344134D8
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 13:11:30 +0000 (UTC)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D41DD
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 06:11:28 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5774b3de210so2265842a12.0
        for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 06:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694869888; x=1695474688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A+6V7zyIWBSyuKBXwovspmEjzeuP9h+Xekl4hJdv+74=;
        b=ap8sQNPZSMd//P17yvfaTx1Xr7TRnWXhrVAttM2F0gZG8zaNwHeW/WyoCccDr1OC9X
         PwLyGiaZDkygYr4Lz1P7WHQ6aS6Ji6lbC7l+FQL/hNCWgjXZ+K8G0myzb9mDVbRTTJEW
         yy4ei9PnR3nuiUtk+p4g6bSuj05FuhdGV5ciCmUR3HGyRfktcK75hlyrVWE0ULqT1wHg
         aikKB/s2DrVTGOr6MR+hIuvOo4hjSiiRVeL1YTv/wT+IjKUU4iUbPVQwQy58qIqClDA9
         BH/3M4u6JdyjavBAU66ltCj7zluCvjfjB4ekTJyXJmM05K3agcY+apffQUFDipORy2Yk
         sm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694869888; x=1695474688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+6V7zyIWBSyuKBXwovspmEjzeuP9h+Xekl4hJdv+74=;
        b=VNH75igokw+JwvaGfiE8ueM9jTgMPyoVCkk2LEfmvMNaGWG3CoReeOTES7/ehekI7w
         xyvW9fFUMZTXoNgTrCW8//8NTPHhnOJTv7PF0BSlGuWqHt1QsVb+b15q5AlAC+irEvvG
         ajnBm5HKBrzk06Yi1tV1WmqnPWmKrAT+kqxNmAnWDRRWwHzfze5f3mzFKKkwBCkgZiO3
         v6mFJ04ueC5LXs9jWlWNbozgUZxH19XF54CSZOhvi7ARyGG9Hxx15q4R2JzlgRLP7hBQ
         SwaYkmwJwxpUkJP0Vz2Ta9lB0LPwUV0caOMiUkE+dA2sT5MrYjzz6ucYDgmTUVxePF7c
         ZO7w==
X-Gm-Message-State: AOJu0YzTFzMvXAvluuvaNyUiEqu4zbbhyvxXIJCSOHR0FyGJHL9Jsq5A
	NScR725Dcw9aiLfXn1CXN4Q=
X-Google-Smtp-Source: AGHT+IHEcZx6bXK/Hu+O9AVEorrv8wi2FpcSwgK/2zuAw+V+3P/XpHexrgk+K6putsrmd0JCUH8CJA==
X-Received: by 2002:a05:6a21:3b46:b0:14c:6397:ac6e with SMTP id zy6-20020a056a213b4600b0014c6397ac6emr3863149pzb.23.1694869888038;
        Sat, 16 Sep 2023 06:11:28 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id f93-20020a17090a706600b0026fa1931f66sm4864187pjk.9.2023.09.16.06.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 06:11:26 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org
Cc: ap420073@gmail.com,
	syzbot+9bbbacfbf1e04d5221f7@syzkaller.appspotmail.com,
	syzbot+1c71587a1a09de7fbde3@syzkaller.appspotmail.com
Subject: [PATCH net v2] net: team: get rid of team->lock in team module
Date: Sat, 16 Sep 2023 13:11:15 +0000
Message-Id: <20230916131115.488756-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The purpose of team->lock is to protect the private data of the team
interface. But RTNL already protects it all well.
The precise purpose of the team->lock is to reduce contention of
RTNL due to GENL operations such as getting the team port list, and
configuration dump.

team interface has used a dynamic lockdep key to avoid false-positive
lockdep deadlock detection. Virtual interfaces such as team usually
have their own lock for protecting private data.
These interfaces can be nested.
team0
  |
team1

Each interface's lock is actually different(team0->lock and team1->lock).
So,
mutex_lock(&team0->lock);
mutex_lock(&team1->lock);
mutex_unlock(&team1->lock);
mutex_unlock(&team0->lock);
The above case is absolutely safe. But lockdep warns about deadlock.
Because the lockdep understands these two locks are same. This is a
false-positive lockdep warning.

So, in order to avoid this problem, the team interfaces started to use
dynamic lockdep key. The false-positive problem was fixed, but it
introduced a new problem.

When the new team virtual interface is created, it registers a dynamic
lockdep key(creates dynamic lockdep key) and uses it. But there is the
limitation of the number of lockdep keys.
So, If so many team interfaces are created, it consumes all lockdep keys.
Then, the lockdep stops to work and warns about it.

So, in order to fix this issue, It just removes team->lock and uses
RTNL instead.

The previous approach to fix this issue was to use the subclass lockdep
key instead of the dynamic lockdep key. It requires RTNL before acquiring
a nested lock because the subclass variable(dev->nested_lock) is
protected by RTNL.
However, the coverage of team->lock is too wide so sometimes it should
use a subclass variable before initialization.
So, it can't work well in the port initialization and unregister logic.

This approach is just removing the team->lock clearly.
So there is no special locking scenario in the team module.
Also, It may convert RTNL to RCU for the read-most operations such as
GENL dump but not yet adopted.

Reproducer:
   for i in {0..1000}
   do
           ip link add team$i type team
           ip link add dummy$i master team$i type dummy
           ip link set dummy$i up
           ip link set team$i up
   done

Splat looks like:
   BUG: MAX_LOCKDEP_ENTRIES too low!
   turning off the locking correctness validator.
   CPU: 1 PID: 7255 Comm: teamd Not tainted 6.6.0-rc1+ #63
   Call Trace:
    <TASK>
    dump_stack_lvl+0x64/0xb0
    add_lock_to_list+0x30d/0x5e0
    check_prev_add+0x73a/0x23a0
    __lock_acquire+0x326f/0x4e00
    ? __pfx___lock_acquire+0x10/0x10
    ? __pfx_netdev_warn+0x10/0x10
    lock_acquire+0x1b4/0x520
    ? linkwatch_fire_event+0x68/0x1b0
    ? __pfx_lock_acquire+0x10/0x10
    ? __team_port_change_send+0x2b3/0x4c0
    ? __pfx___team_port_change_send+0x10/0x10
    _raw_spin_lock_irqsave+0x47/0x90
    ? linkwatch_fire_event+0x68/0x1b0
    linkwatch_fire_event+0x68/0x1b0
    netif_carrier_on+0x74/0xd0
    team_add_slave+0x123a/0x1e80
    ? __pfx_team_add_slave+0x10/0x10
    ? mutex_is_locked+0x17/0x50
    ? rtnl_is_locked+0x15/0x20
    ? netdev_master_upper_dev_get+0x13/0x100
    do_setlink+0x73f/0x31f0
    ...

Reported-by: syzbot+9bbbacfbf1e04d5221f7@syzkaller.appspotmail.com
Reported-by: syzbot+1c71587a1a09de7fbde3@syzkaller.appspotmail.com
Fixes: 369f61bee0f5 ("team: fix nested locking lockdep warning")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v2:
 - v1 was reverted, 39285e124edb ("net: team: do not use dynamic lockdep key")
 - Remove team->lock completely instead of using subclass lockdep key.

 drivers/net/team/team.c                   | 62 +++++++----------------
 drivers/net/team/team_mode_activebackup.c |  2 +-
 drivers/net/team/team_mode_loadbalance.c  | 10 ++--
 include/linux/if_team.h                   |  2 -
 4 files changed, 24 insertions(+), 52 deletions(-)

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index e8b94580194e..741c93db5bc0 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -928,8 +928,7 @@ static bool team_port_find(const struct team *team,
 /*
  * Enable/disable port by adding to enabled port hashlist and setting
  * port->index (Might be racy so reader could see incorrect ifindex when
- * processing a flying packet, but that is not a problem). Write guarded
- * by team->lock.
+ * processing a flying packet, but that is not a problem).
  */
 static void team_port_enable(struct team *team,
 			     struct team_port *port)
@@ -1643,8 +1642,6 @@ static int team_init(struct net_device *dev)
 		goto err_options_register;
 	netif_carrier_off(dev);
 
-	lockdep_register_key(&team->team_lock_key);
-	__mutex_init(&team->lock, "team->team_lock_key", &team->team_lock_key);
 	netdev_lockdep_set_classes(dev);
 
 	return 0;
@@ -1665,7 +1662,6 @@ static void team_uninit(struct net_device *dev)
 	struct team_port *port;
 	struct team_port *tmp;
 
-	mutex_lock(&team->lock);
 	list_for_each_entry_safe(port, tmp, &team->port_list, list)
 		team_port_del(team, port->dev);
 
@@ -1674,9 +1670,7 @@ static void team_uninit(struct net_device *dev)
 	team_mcast_rejoin_fini(team);
 	team_notify_peers_fini(team);
 	team_queue_override_fini(team);
-	mutex_unlock(&team->lock);
 	netdev_change_features(dev);
-	lockdep_unregister_key(&team->team_lock_key);
 }
 
 static void team_destructor(struct net_device *dev)
@@ -1797,11 +1791,9 @@ static int team_set_mac_address(struct net_device *dev, void *p)
 	if (dev->type == ARPHRD_ETHER && !is_valid_ether_addr(addr->sa_data))
 		return -EADDRNOTAVAIL;
 	dev_addr_set(dev, addr->sa_data);
-	mutex_lock(&team->lock);
 	list_for_each_entry(port, &team->port_list, list)
 		if (team->ops.port_change_dev_addr)
 			team->ops.port_change_dev_addr(team, port);
-	mutex_unlock(&team->lock);
 	return 0;
 }
 
@@ -1815,7 +1807,6 @@ static int team_change_mtu(struct net_device *dev, int new_mtu)
 	 * Alhough this is reader, it's guarded by team lock. It's not possible
 	 * to traverse list in reverse under rcu_read_lock
 	 */
-	mutex_lock(&team->lock);
 	team->port_mtu_change_allowed = true;
 	list_for_each_entry(port, &team->port_list, list) {
 		err = dev_set_mtu(port->dev, new_mtu);
@@ -1826,7 +1817,6 @@ static int team_change_mtu(struct net_device *dev, int new_mtu)
 		}
 	}
 	team->port_mtu_change_allowed = false;
-	mutex_unlock(&team->lock);
 
 	dev->mtu = new_mtu;
 
@@ -1836,7 +1826,6 @@ static int team_change_mtu(struct net_device *dev, int new_mtu)
 	list_for_each_entry_continue_reverse(port, &team->port_list, list)
 		dev_set_mtu(port->dev, dev->mtu);
 	team->port_mtu_change_allowed = false;
-	mutex_unlock(&team->lock);
 
 	return err;
 }
@@ -1890,20 +1879,17 @@ static int team_vlan_rx_add_vid(struct net_device *dev, __be16 proto, u16 vid)
 	 * Alhough this is reader, it's guarded by team lock. It's not possible
 	 * to traverse list in reverse under rcu_read_lock
 	 */
-	mutex_lock(&team->lock);
 	list_for_each_entry(port, &team->port_list, list) {
 		err = vlan_vid_add(port->dev, proto, vid);
 		if (err)
 			goto unwind;
 	}
-	mutex_unlock(&team->lock);
 
 	return 0;
 
 unwind:
 	list_for_each_entry_continue_reverse(port, &team->port_list, list)
 		vlan_vid_del(port->dev, proto, vid);
-	mutex_unlock(&team->lock);
 
 	return err;
 }
@@ -1913,10 +1899,8 @@ static int team_vlan_rx_kill_vid(struct net_device *dev, __be16 proto, u16 vid)
 	struct team *team = netdev_priv(dev);
 	struct team_port *port;
 
-	mutex_lock(&team->lock);
 	list_for_each_entry(port, &team->port_list, list)
 		vlan_vid_del(port->dev, proto, vid);
-	mutex_unlock(&team->lock);
 
 	return 0;
 }
@@ -1938,9 +1922,7 @@ static void team_netpoll_cleanup(struct net_device *dev)
 {
 	struct team *team = netdev_priv(dev);
 
-	mutex_lock(&team->lock);
 	__team_netpoll_cleanup(team);
-	mutex_unlock(&team->lock);
 }
 
 static int team_netpoll_setup(struct net_device *dev,
@@ -1950,7 +1932,6 @@ static int team_netpoll_setup(struct net_device *dev,
 	struct team_port *port;
 	int err = 0;
 
-	mutex_lock(&team->lock);
 	list_for_each_entry(port, &team->port_list, list) {
 		err = __team_port_enable_netpoll(port);
 		if (err) {
@@ -1958,7 +1939,6 @@ static int team_netpoll_setup(struct net_device *dev,
 			break;
 		}
 	}
-	mutex_unlock(&team->lock);
 	return err;
 }
 #endif
@@ -1969,9 +1949,7 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
 	struct team *team = netdev_priv(dev);
 	int err;
 
-	mutex_lock(&team->lock);
 	err = team_port_add(team, port_dev, extack);
-	mutex_unlock(&team->lock);
 
 	if (!err)
 		netdev_change_features(dev);
@@ -1984,19 +1962,10 @@ static int team_del_slave(struct net_device *dev, struct net_device *port_dev)
 	struct team *team = netdev_priv(dev);
 	int err;
 
-	mutex_lock(&team->lock);
 	err = team_port_del(team, port_dev);
-	mutex_unlock(&team->lock);
 
-	if (err)
-		return err;
-
-	if (netif_is_team_master(port_dev)) {
-		lockdep_unregister_key(&team->team_lock_key);
-		lockdep_register_key(&team->team_lock_key);
-		lockdep_set_class(&team->lock, &team->team_lock_key);
-	}
-	netdev_change_features(dev);
+	if (!err)
+		netdev_change_features(dev);
 
 	return err;
 }
@@ -2316,13 +2285,11 @@ static struct team *team_nl_team_get(struct genl_info *info)
 	}
 
 	team = netdev_priv(dev);
-	mutex_lock(&team->lock);
 	return team;
 }
 
 static void team_nl_team_put(struct team *team)
 {
-	mutex_unlock(&team->lock);
 	dev_put(team->dev);
 }
 
@@ -2512,9 +2479,13 @@ static int team_nl_cmd_options_get(struct sk_buff *skb, struct genl_info *info)
 	int err;
 	LIST_HEAD(sel_opt_inst_list);
 
+	rtnl_lock();
+
 	team = team_nl_team_get(info);
-	if (!team)
-		return -EINVAL;
+	if (!team) {
+		err = -EINVAL;
+		goto rtnl_unlock;
+	}
 
 	list_for_each_entry(opt_inst, &team->option_inst_list, list)
 		list_add_tail(&opt_inst->tmp_list, &sel_opt_inst_list);
@@ -2524,6 +2495,8 @@ static int team_nl_cmd_options_get(struct sk_buff *skb, struct genl_info *info)
 
 	team_nl_team_put(team);
 
+rtnl_unlock:
+	rtnl_unlock();
 	return err;
 }
 
@@ -2800,15 +2773,20 @@ static int team_nl_cmd_port_list_get(struct sk_buff *skb,
 	struct team *team;
 	int err;
 
+	rtnl_lock();
 	team = team_nl_team_get(info);
-	if (!team)
-		return -EINVAL;
+	if (!team) {
+		err = -EINVAL;
+		goto rtnl_unlock;
+	}
 
 	err = team_nl_send_port_list_get(team, info->snd_portid, info->snd_seq,
 					 NLM_F_ACK, team_nl_send_unicast, NULL);
 
 	team_nl_team_put(team);
 
+rtnl_unlock:
+	rtnl_unlock();
 	return err;
 }
 
@@ -2982,11 +2960,7 @@ static void __team_port_change_port_removed(struct team_port *port)
 
 static void team_port_change_check(struct team_port *port, bool linkup)
 {
-	struct team *team = port->team;
-
-	mutex_lock(&team->lock);
 	__team_port_change_check(port, linkup);
-	mutex_unlock(&team->lock);
 }
 
 
diff --git a/drivers/net/team/team_mode_activebackup.c b/drivers/net/team/team_mode_activebackup.c
index e0f599e2a51d..1776c7500588 100644
--- a/drivers/net/team/team_mode_activebackup.c
+++ b/drivers/net/team/team_mode_activebackup.c
@@ -68,7 +68,7 @@ static void ab_active_port_get(struct team *team, struct team_gsetter_ctx *ctx)
 	struct team_port *active_port;
 
 	active_port = rcu_dereference_protected(ab_priv(team)->active_port,
-						lockdep_is_held(&team->lock));
+						lockdep_rtnl_is_held());
 	if (active_port)
 		ctx->data.u32_val = active_port->dev->ifindex;
 	else
diff --git a/drivers/net/team/team_mode_loadbalance.c b/drivers/net/team/team_mode_loadbalance.c
index 00f8989c29c0..64a22866fabf 100644
--- a/drivers/net/team/team_mode_loadbalance.c
+++ b/drivers/net/team/team_mode_loadbalance.c
@@ -302,7 +302,7 @@ static int lb_bpf_func_set(struct team *team, struct team_gsetter_ctx *ctx)
 		/* Clear old filter data */
 		__fprog_destroy(lb_priv->ex->orig_fprog);
 		orig_fp = rcu_dereference_protected(lb_priv->fp,
-						lockdep_is_held(&team->lock));
+						    lockdep_rtnl_is_held());
 	}
 
 	rcu_assign_pointer(lb_priv->fp, fp);
@@ -325,7 +325,7 @@ static void lb_bpf_func_free(struct team *team)
 
 	__fprog_destroy(lb_priv->ex->orig_fprog);
 	fp = rcu_dereference_protected(lb_priv->fp,
-				       lockdep_is_held(&team->lock));
+				       lockdep_rtnl_is_held());
 	bpf_prog_destroy(fp);
 }
 
@@ -336,7 +336,7 @@ static void lb_tx_method_get(struct team *team, struct team_gsetter_ctx *ctx)
 	char *name;
 
 	func = rcu_dereference_protected(lb_priv->select_tx_port_func,
-					 lockdep_is_held(&team->lock));
+					 lockdep_rtnl_is_held());
 	name = lb_select_tx_port_get_name(func);
 	BUG_ON(!name);
 	ctx->data.str_val = name;
@@ -478,7 +478,7 @@ static void lb_stats_refresh(struct work_struct *work)
 	team = lb_priv_ex->team;
 	lb_priv = get_lb_priv(team);
 
-	if (!mutex_trylock(&team->lock)) {
+	if (!rtnl_trylock()) {
 		schedule_delayed_work(&lb_priv_ex->stats.refresh_dw, 0);
 		return;
 	}
@@ -515,7 +515,7 @@ static void lb_stats_refresh(struct work_struct *work)
 	schedule_delayed_work(&lb_priv_ex->stats.refresh_dw,
 			      (lb_priv_ex->stats.refresh_interval * HZ) / 10);
 
-	mutex_unlock(&team->lock);
+	rtnl_unlock();
 }
 
 static void lb_stats_refresh_interval_get(struct team *team,
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index 1b9b15a492fa..cfd5ad577e5c 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -189,8 +189,6 @@ struct team {
 	struct net_device *dev; /* associated netdevice */
 	struct team_pcpu_stats __percpu *pcpu_stats;
 
-	struct mutex lock; /* used for overall locking, e.g. port lists write */
-
 	/*
 	 * List of enabled ports and their count
 	 */
-- 
2.34.1


