Return-Path: <netdev+bounces-32016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F522792120
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 10:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12A741C208E8
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 08:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0DD53B7;
	Tue,  5 Sep 2023 08:46:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964FB1FA4
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 08:46:33 +0000 (UTC)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A6AB4
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 01:46:31 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-573921661a6so1438456eaf.1
        for <netdev@vger.kernel.org>; Tue, 05 Sep 2023 01:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693903591; x=1694508391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCpGRq12QpsFK+0ZIQNmOHlikeZG/7n/SrEAJfUIdq4=;
        b=d2gJhkF2eQth6xcQ2Eog2+XWjriJ7RfZCO6nLJDqn+GyHBM4hJqMLb+8ZBmZSeIlXt
         N7FtZvikDz9DiS5Fq6PuQKUQ2N5J+F2MAGaaUQWFtTfJ23N+rQdJrlHxHV08jGq6ui7h
         bPO9T6ZPMBX533DBYGmY/m7WJqvzenCqND5NAEgr3UV4XCMDwjPWEB2Lcycj/gGd11pb
         tp+1nFsxLglwSPcftUGZIABz8lHSw27hvsAKLGcB9SzKYu3/ajywunU1YJglrrIsereV
         en1v1j8Uzdr99gbRnDZv703TN2X+GqVG86CU88Q12htTI9VTlByPdkiuFvExWAWLQkzF
         WZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693903591; x=1694508391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZCpGRq12QpsFK+0ZIQNmOHlikeZG/7n/SrEAJfUIdq4=;
        b=W1QXLVZhMyte4LRr2QOJZm5dl65OUD6enTVOCeeUCt92ZIrpaVp85QlsE3Mzp5JUQO
         SPEV7d8QwrfJIBuOd4rPKOYRW/CfR+yWDC2TUBefQ6/3HiBjR4V4sqm1/cCV3PxGkbw4
         prlchi4zna488yFADt2CymghAFhGaQp72nqj564MV6ybxSpg9eij3grkDwIo52P3uHMx
         fM+/6Cn1+dhQJlXND1XTV+22yOSa3jbLg1dFYGmJSqXPFUA/OTNOwOxIsAKc5cW0g/4F
         ZAi01Tl/AiY6/KgI5L97FxPpRpGbCxLAd3geU86sjTuuM+Yod2iuHfRrl4v7gYOpY86s
         R2ug==
X-Gm-Message-State: AOJu0YwTARoS7+SQNrA8JpHC/wT4kJGKoNTpPUdl/RZDRsBP//FTF7UB
	q3ZLLpw3/5z5B15r7skP/PU=
X-Google-Smtp-Source: AGHT+IGi9CD54TXcNEAdJD9g0XePVAJ5w0MUSTDRLtP0SsB4Kmley525qtcHG5oL77uC10jSDk02Pg==
X-Received: by 2002:a05:6358:5903:b0:139:b4c0:94d with SMTP id g3-20020a056358590300b00139b4c0094dmr13949933rwf.12.1693903590529;
        Tue, 05 Sep 2023 01:46:30 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id g12-20020aa7874c000000b00687375d9135sm8574294pfo.4.2023.09.05.01.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 01:46:29 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org
Cc: ap420073@gmail.com,
	syzbot+9bbbacfbf1e04d5221f7@syzkaller.appspotmail.com
Subject: [PATCH net] net: team: do not use dynamic lockdep key
Date: Tue,  5 Sep 2023 08:46:10 +0000
Message-Id: <20230905084610.3659354-1-ap420073@gmail.com>
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

In order to fix this problem, team interfaces use the subclass instead
of the dynamic key. So, when a new team interface is created, it doesn't
register(create) a new lockdep, but uses existed subclass key instead.
It is already used by the bonding interface for a similar case.

As the bonding interface does, the subclass variable is the same as
the 'dev->nested_level'. This variable indicates the depth in the stacked
interface graph.

The 'dev->nested_level' is protected by RTNL and RCU.
So, 'mutex_lock_nested()' for 'team->lock' requires RTNL or RCU.
In the current code, 'team->lock' is usually acquired under RTNL, there is
no problem with using 'dev->nested_level'.

The 'team_nl_team_get()' and The 'lb_stats_refresh()' functions acquire
'team->lock' without RTNL.
But these don't iterate their own ports nested so they don't need nested
lock.

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
   Please attach the output of /proc/lock_stat to the bug report
   CPU: 0 PID: 4104 Comm: ip Not tainted 6.5.0-rc7+ #45
   Call Trace:
    <TASK>
   dump_stack_lvl+0x64/0xb0
   add_lock_to_list+0x30d/0x5e0
   check_prev_add+0x73a/0x23a0
   ...
   sock_def_readable+0xfe/0x4f0
   netlink_broadcast+0x76b/0xac0
   nlmsg_notify+0x69/0x1d0
   dev_open+0xed/0x130
   ...

Reported-by: syzbot+9bbbacfbf1e04d5221f7@syzkaller.appspotmail.com
Fixes: 369f61bee0f5 ("team: fix nested locking lockdep warning")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
 drivers/net/team/team.c                  | 111 +++++++++++------------
 drivers/net/team/team_mode_loadbalance.c |   4 +-
 include/linux/if_team.h                  |  30 +++++-
 3 files changed, 85 insertions(+), 60 deletions(-)

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index e8b94580194e..ad29122a5468 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1135,8 +1135,8 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 			 struct netlink_ext_ack *extack)
 {
 	struct net_device *dev = team->dev;
-	struct team_port *port;
 	char *portname = port_dev->name;
+	struct team_port *port;
 	int err;
 
 	if (port_dev->flags & IFF_LOOPBACK) {
@@ -1203,18 +1203,31 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 
 	memcpy(port->orig.dev_addr, port_dev->dev_addr, port_dev->addr_len);
 
-	err = team_port_enter(team, port);
+	err = dev_open(port_dev, extack);
 	if (err) {
-		netdev_err(dev, "Device %s failed to enter team mode\n",
+		netdev_dbg(dev, "Device %s opening failed\n",
 			   portname);
-		goto err_port_enter;
+		goto err_dev_open;
 	}
 
-	err = dev_open(port_dev, extack);
+	err = team_upper_dev_link(team, port, extack);
 	if (err) {
-		netdev_dbg(dev, "Device %s opening failed\n",
+		netdev_err(dev, "Device %s failed to set upper link\n",
 			   portname);
-		goto err_dev_open;
+		goto err_set_upper_link;
+	}
+
+	/* lockdep subclass variable(dev->nested_level) was updated by
+	 * team_upper_dev_link().
+	 */
+	team_unlock(team);
+	team_lock(team);
+
+	err = team_port_enter(team, port);
+	if (err) {
+		netdev_err(dev, "Device %s failed to enter team mode\n",
+			   portname);
+		goto err_port_enter;
 	}
 
 	err = vlan_vids_add_by_dev(port_dev, dev);
@@ -1242,13 +1255,6 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		goto err_handler_register;
 	}
 
-	err = team_upper_dev_link(team, port, extack);
-	if (err) {
-		netdev_err(dev, "Device %s failed to set upper link\n",
-			   portname);
-		goto err_set_upper_link;
-	}
-
 	err = __team_option_inst_add_port(team, port);
 	if (err) {
 		netdev_err(dev, "Device %s failed to add per-port options\n",
@@ -1295,9 +1301,6 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 	__team_option_inst_del_port(team, port);
 
 err_option_port_add:
-	team_upper_dev_unlink(team, port);
-
-err_set_upper_link:
 	netdev_rx_handler_unregister(port_dev);
 
 err_handler_register:
@@ -1307,13 +1310,16 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 	vlan_vids_del_by_dev(port_dev, dev);
 
 err_vids_add:
+	team_port_leave(team, port);
+
+err_port_enter:
+	team_upper_dev_unlink(team, port);
+
+err_set_upper_link:
 	dev_close(port_dev);
 
 err_dev_open:
-	team_port_leave(team, port);
 	team_port_set_orig_dev_addr(port);
-
-err_port_enter:
 	dev_set_mtu(port_dev, port->orig.mtu);
 
 err_set_mtu:
@@ -1616,6 +1622,7 @@ static int team_init(struct net_device *dev)
 	int err;
 
 	team->dev = dev;
+	mutex_init(&team->lock);
 	team_set_no_mode(team);
 	team->notifier_ctx = false;
 
@@ -1643,8 +1650,6 @@ static int team_init(struct net_device *dev)
 		goto err_options_register;
 	netif_carrier_off(dev);
 
-	lockdep_register_key(&team->team_lock_key);
-	__mutex_init(&team->lock, "team->team_lock_key", &team->team_lock_key);
 	netdev_lockdep_set_classes(dev);
 
 	return 0;
@@ -1665,7 +1670,7 @@ static void team_uninit(struct net_device *dev)
 	struct team_port *port;
 	struct team_port *tmp;
 
-	mutex_lock(&team->lock);
+	team_lock(team);
 	list_for_each_entry_safe(port, tmp, &team->port_list, list)
 		team_port_del(team, port->dev);
 
@@ -1674,9 +1679,8 @@ static void team_uninit(struct net_device *dev)
 	team_mcast_rejoin_fini(team);
 	team_notify_peers_fini(team);
 	team_queue_override_fini(team);
-	mutex_unlock(&team->lock);
+	team_unlock(team);
 	netdev_change_features(dev);
-	lockdep_unregister_key(&team->team_lock_key);
 }
 
 static void team_destructor(struct net_device *dev)
@@ -1790,18 +1794,18 @@ static void team_set_rx_mode(struct net_device *dev)
 
 static int team_set_mac_address(struct net_device *dev, void *p)
 {
-	struct sockaddr *addr = p;
 	struct team *team = netdev_priv(dev);
+	struct sockaddr *addr = p;
 	struct team_port *port;
 
 	if (dev->type == ARPHRD_ETHER && !is_valid_ether_addr(addr->sa_data))
 		return -EADDRNOTAVAIL;
 	dev_addr_set(dev, addr->sa_data);
-	mutex_lock(&team->lock);
+	team_lock(team);
 	list_for_each_entry(port, &team->port_list, list)
 		if (team->ops.port_change_dev_addr)
 			team->ops.port_change_dev_addr(team, port);
-	mutex_unlock(&team->lock);
+	team_unlock(team);
 	return 0;
 }
 
@@ -1815,7 +1819,7 @@ static int team_change_mtu(struct net_device *dev, int new_mtu)
 	 * Alhough this is reader, it's guarded by team lock. It's not possible
 	 * to traverse list in reverse under rcu_read_lock
 	 */
-	mutex_lock(&team->lock);
+	team_lock(team);
 	team->port_mtu_change_allowed = true;
 	list_for_each_entry(port, &team->port_list, list) {
 		err = dev_set_mtu(port->dev, new_mtu);
@@ -1826,7 +1830,7 @@ static int team_change_mtu(struct net_device *dev, int new_mtu)
 		}
 	}
 	team->port_mtu_change_allowed = false;
-	mutex_unlock(&team->lock);
+	team_unlock(team);
 
 	dev->mtu = new_mtu;
 
@@ -1836,7 +1840,7 @@ static int team_change_mtu(struct net_device *dev, int new_mtu)
 	list_for_each_entry_continue_reverse(port, &team->port_list, list)
 		dev_set_mtu(port->dev, dev->mtu);
 	team->port_mtu_change_allowed = false;
-	mutex_unlock(&team->lock);
+	team_unlock(team);
 
 	return err;
 }
@@ -1890,20 +1894,20 @@ static int team_vlan_rx_add_vid(struct net_device *dev, __be16 proto, u16 vid)
 	 * Alhough this is reader, it's guarded by team lock. It's not possible
 	 * to traverse list in reverse under rcu_read_lock
 	 */
-	mutex_lock(&team->lock);
+	team_lock(team);
 	list_for_each_entry(port, &team->port_list, list) {
 		err = vlan_vid_add(port->dev, proto, vid);
 		if (err)
 			goto unwind;
 	}
-	mutex_unlock(&team->lock);
+	team_unlock(team);
 
 	return 0;
 
 unwind:
 	list_for_each_entry_continue_reverse(port, &team->port_list, list)
 		vlan_vid_del(port->dev, proto, vid);
-	mutex_unlock(&team->lock);
+	team_unlock(team);
 
 	return err;
 }
@@ -1913,10 +1917,10 @@ static int team_vlan_rx_kill_vid(struct net_device *dev, __be16 proto, u16 vid)
 	struct team *team = netdev_priv(dev);
 	struct team_port *port;
 
-	mutex_lock(&team->lock);
+	team_lock(team);
 	list_for_each_entry(port, &team->port_list, list)
 		vlan_vid_del(port->dev, proto, vid);
-	mutex_unlock(&team->lock);
+	team_unlock(team);
 
 	return 0;
 }
@@ -1938,9 +1942,9 @@ static void team_netpoll_cleanup(struct net_device *dev)
 {
 	struct team *team = netdev_priv(dev);
 
-	mutex_lock(&team->lock);
+	team_lock(team);
 	__team_netpoll_cleanup(team);
-	mutex_unlock(&team->lock);
+	team_unlock(team);
 }
 
 static int team_netpoll_setup(struct net_device *dev,
@@ -1950,7 +1954,7 @@ static int team_netpoll_setup(struct net_device *dev,
 	struct team_port *port;
 	int err = 0;
 
-	mutex_lock(&team->lock);
+	team_lock(team);
 	list_for_each_entry(port, &team->port_list, list) {
 		err = __team_port_enable_netpoll(port);
 		if (err) {
@@ -1958,7 +1962,7 @@ static int team_netpoll_setup(struct net_device *dev,
 			break;
 		}
 	}
-	mutex_unlock(&team->lock);
+	team_unlock(team);
 	return err;
 }
 #endif
@@ -1969,9 +1973,9 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
 	struct team *team = netdev_priv(dev);
 	int err;
 
-	mutex_lock(&team->lock);
+	team_lock(team);
 	err = team_port_add(team, port_dev, extack);
-	mutex_unlock(&team->lock);
+	team_unlock(team);
 
 	if (!err)
 		netdev_change_features(dev);
@@ -1984,19 +1988,12 @@ static int team_del_slave(struct net_device *dev, struct net_device *port_dev)
 	struct team *team = netdev_priv(dev);
 	int err;
 
-	mutex_lock(&team->lock);
+	team_lock(team);
 	err = team_port_del(team, port_dev);
-	mutex_unlock(&team->lock);
-
-	if (err)
-		return err;
+	team_unlock(team);
 
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
@@ -2316,13 +2313,13 @@ static struct team *team_nl_team_get(struct genl_info *info)
 	}
 
 	team = netdev_priv(dev);
-	mutex_lock(&team->lock);
+	__team_lock(team);
 	return team;
 }
 
 static void team_nl_team_put(struct team *team)
 {
-	mutex_unlock(&team->lock);
+	team_unlock(team);
 	dev_put(team->dev);
 }
 
@@ -2984,9 +2981,9 @@ static void team_port_change_check(struct team_port *port, bool linkup)
 {
 	struct team *team = port->team;
 
-	mutex_lock(&team->lock);
+	team_lock(team);
 	__team_port_change_check(port, linkup);
-	mutex_unlock(&team->lock);
+	team_unlock(team);
 }
 
 
diff --git a/drivers/net/team/team_mode_loadbalance.c b/drivers/net/team/team_mode_loadbalance.c
index 00f8989c29c0..7bcc9d37447a 100644
--- a/drivers/net/team/team_mode_loadbalance.c
+++ b/drivers/net/team/team_mode_loadbalance.c
@@ -478,7 +478,7 @@ static void lb_stats_refresh(struct work_struct *work)
 	team = lb_priv_ex->team;
 	lb_priv = get_lb_priv(team);
 
-	if (!mutex_trylock(&team->lock)) {
+	if (!team_trylock(team)) {
 		schedule_delayed_work(&lb_priv_ex->stats.refresh_dw, 0);
 		return;
 	}
@@ -515,7 +515,7 @@ static void lb_stats_refresh(struct work_struct *work)
 	schedule_delayed_work(&lb_priv_ex->stats.refresh_dw,
 			      (lb_priv_ex->stats.refresh_interval * HZ) / 10);
 
-	mutex_unlock(&team->lock);
+	team_unlock(team);
 }
 
 static void lb_stats_refresh_interval_get(struct team *team,
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index 1b9b15a492fa..12d4447fc8ab 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -221,10 +221,38 @@ struct team {
 		atomic_t count_pending;
 		struct delayed_work dw;
 	} mcast_rejoin;
-	struct lock_class_key team_lock_key;
 	long mode_priv[TEAM_MODE_PRIV_LONGS];
 };
 
+static inline void __team_lock(struct team *team)
+{
+	mutex_lock(&team->lock);
+}
+
+static inline int team_trylock(struct team *team)
+{
+	return mutex_trylock(&team->lock);
+}
+
+#ifdef CONFIG_LOCKDEP
+static inline void team_lock(struct team *team)
+{
+	ASSERT_RTNL();
+	mutex_lock_nested(&team->lock, team->dev->nested_level);
+}
+
+#else
+static inline void team_lock(struct team *team)
+{
+	__team_lock(team);
+}
+#endif
+
+static inline void team_unlock(struct team *team)
+{
+	mutex_unlock(&team->lock);
+}
+
 static inline int team_dev_queue_xmit(struct team *team, struct team_port *port,
 				      struct sk_buff *skb)
 {
-- 
2.34.1


