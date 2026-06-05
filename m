Return-Path: <netdev+bounces-295499-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hLZrKRoZImreSQEAu9opvQ
	(envelope-from <netdev+bounces-295499-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 02:32:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EE56441FF
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 02:32:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fpN5Entl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295499-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295499-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB32B30819CC
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 00:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891E426E6E2;
	Fri,  5 Jun 2026 00:29:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9A626738C
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 00:29:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780619387; cv=none; b=D8a2VxCesD66O8XS4c0zqwLCHY8nj0QJv2MHI2pmpyFG/h8s95raa2sM26cmFNjlDEQxhtFSNkFAswOR9iqsRY2NbDHxIunIMEKdmJ0xvKyz0OYR6isv2ymoIxNGUP2S2tbTWsqqxsIqRB54bBokCExQJ2G2lMDy9MksfkyNlVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780619387; c=relaxed/simple;
	bh=iQP2yrksL3O9WjKCPWQJ0a/XlPOsd5HSsMlMi3I9qio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWIJvuR8Tx9Jlh16B8LM1408SyAumtZWSRvCjleNy+6MpcMfTircz/7rtBicQyKg7pJ5DcPMoo6AUIjrHAcVX4LNcv+Qj3JsDVeyxYc19UVkecrfZp8AUq7rT3Gh0l1c1OeXaR2yMor7tOl42bwo2LDbbEoEFhCnCdFUsYnIkDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpN5Entl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6173C1F00893;
	Fri,  5 Jun 2026 00:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780619386;
	bh=JmfSo0+zUo9v4FM0JN3eoTXVNWb6KIAmAS48NPkdJE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fpN5Entlfv2wLZ5ZEFn7sP/cVQYJwaUC67ORkAzs8WqO9odH9RvEgRhR/s96HbkxC
	 NdujiuBZIZFwRs2K7GCB3P+xVBd357aZS4h5vz/d34NZIeuYLggI9X6AHfIsTj9+gx
	 xlTqeTACfB2j8uulMUeNf0fLTLPF2jxhTU5KthZwnFOh74vF+TiUL76GPv8tonlbdv
	 E3fCQ7lo5WBxWCdZfbWaiFKij2bcDxg08KIY8ZLLj8MKdXJl8g1sL7qMR/ZG5ATvWp
	 FcPgPZtIaIDKjpW2BXEA+EuKqrS2TqV5nUgrzr2FDz+LLfdrnqiDqYzf46YfvqXUdc
	 fYGu1cT8pbcHg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	hkallweit1@gmail.com,
	maxime.chevallier@bootlin.com,
	joshwash@google.com,
	tariqt@nvidia.com,
	alexanderduyck@fb.com,
	willemb@google.com,
	jacob.e.keller@intel.com,
	kory.maincent@bootlin.com,
	sdf.kernel@gmail.com,
	jakub@cloudflare.com,
	nb@tipi-net.de,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 11/12] net: ethtool: optionally skip rtnl_lock on IOCTL path
Date: Thu,  4 Jun 2026 17:29:11 -0700
Message-ID: <20260605002912.3456868-12-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605002912.3456868-1-kuba@kernel.org>
References: <20260605002912.3456868-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295499-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:joshwash@google.com,m:tariqt@nvidia.com,m:alexanderduyck@fb.com,m:willemb@google.com,m:jacob.e.keller@intel.com,m:kory.maincent@bootlin.com,m:sdf.kernel@gmail.com,m:jakub@cloudflare.com,m:nb@tipi-net.de,m:kuba@kernel.org,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,gmail.com,bootlin.com,nvidia.com,fb.com,intel.com,cloudflare.com,tipi-net.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21EE56441FF

Convert the IOCTL path similarly to how we converted Netlink.
The device lookup gets a little hairy. We could take rtnl_lock
unconditionally and drop it before calling the driver (this would
avoid the reference + liveness check). But I think being able
to make progress even if rtnl is dead-locked is quite useful.

First extra concern is handling features. List all the cmds which
modify features and always take rtnl_lock. We could fold this list
into ethtool_ioctl_needs_rtnl() but seems cleaner to keep
ethtool_ioctl_needs_rtnl() driver-related. If a driver changed
features and we were not holding rtnl_lock - warn about it.
It can only happen on buggy ops locked drivers (buggy because
they should have set appropriate "I need rtnl for op X" bit).

Second wrinkle is the PHY ID hack which drops the locks while
sleeping. Convert its static "busy" variable which used to
be protected by rtnl_lock to a field in struct ethtool_netdev_state.
This feature is about identifying an adapter or a port within
a system, so being able to blink multiple LEDs at the same
time is likely not very useful in practice. But it's the simplest
fix, we can add a mutex if someone thinks a system should only
be ID'ing one port at a time.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/ethtool.h |   2 +
 net/ethtool/ioctl.c     | 106 ++++++++++++++++++++++++++++++----------
 2 files changed, 82 insertions(+), 26 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 74c8109b0cf3..da29017c757f 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1375,6 +1375,7 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
  *			within RTNL.
  * @rss_indir_user_size: Number of user provided entries for the default
  *			 (context 0) indirection table.
+ * @phys_id_busy:	Loop blinking the device LED is running.
  * @wol_enabled:	Wake-on-LAN is enabled
  * @module_fw_flash_in_progress: Module firmware flashing is in progress.
  */
@@ -1382,6 +1383,7 @@ struct ethtool_netdev_state {
 	struct xarray		rss_ctx;
 	struct mutex		rss_lock;
 	u32			rss_indir_user_size;
+	unsigned		phys_id_busy:1;
 	unsigned		wol_enabled:1;
 	unsigned		module_fw_flash_in_progress:1;
 };
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index c32c099845e3..a7bff829b758 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -544,7 +544,7 @@ static int ethtool_get_link_ksettings(struct net_device *dev,
 	int err = 0;
 	struct ethtool_link_ksettings link_ksettings;
 
-	ASSERT_RTNL();
+	netdev_assert_locked_ops_compat(dev);
 	if (!dev->ethtool_ops->get_link_ksettings)
 		return -EOPNOTSUPP;
 
@@ -601,7 +601,7 @@ static int ethtool_set_link_ksettings(struct net_device *dev,
 	struct ethtool_link_ksettings link_ksettings = {};
 	int err;
 
-	ASSERT_RTNL();
+	netdev_assert_locked_ops_compat(dev);
 
 	if (!dev->ethtool_ops->set_link_ksettings)
 		return -EOPNOTSUPP;
@@ -675,7 +675,7 @@ static int ethtool_get_settings(struct net_device *dev, void __user *useraddr)
 	struct ethtool_cmd cmd;
 	int err;
 
-	ASSERT_RTNL();
+	netdev_assert_locked_ops_compat(dev);
 	if (!dev->ethtool_ops->get_link_ksettings)
 		return -EOPNOTSUPP;
 
@@ -711,7 +711,7 @@ static int ethtool_set_settings(struct net_device *dev, void __user *useraddr)
 	struct ethtool_cmd cmd;
 	int ret;
 
-	ASSERT_RTNL();
+	netdev_assert_locked_ops_compat(dev);
 
 	if (copy_from_user(&cmd, useraddr, sizeof(cmd)))
 		return -EFAULT;
@@ -2452,10 +2452,10 @@ void ethtool_puts(u8 **data, const char *str)
 }
 EXPORT_SYMBOL(ethtool_puts);
 
-static int ethtool_phys_id(struct net_device *dev, void __user *useraddr)
+static int ethtool_phys_id(struct net_device *dev, void __user *useraddr,
+			   bool has_rtnl_lock)
 {
 	struct ethtool_value id;
-	static bool busy;
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	netdevice_tracker dev_tracker;
 	int rc;
@@ -2463,7 +2463,7 @@ static int ethtool_phys_id(struct net_device *dev, void __user *useraddr)
 	if (!ops->set_phys_id)
 		return -EOPNOTSUPP;
 
-	if (busy)
+	if (dev->ethtool->phys_id_busy)
 		return -EBUSY;
 
 	if (copy_from_user(&id, useraddr, sizeof(id)))
@@ -2473,13 +2473,14 @@ static int ethtool_phys_id(struct net_device *dev, void __user *useraddr)
 	if (rc < 0)
 		return rc;
 
-	/* Drop the RTNL lock while waiting, but prevent reentry or
+	/* Drop the locks while waiting, but prevent reentry or
 	 * removal of the device.
 	 */
-	busy = true;
+	dev->ethtool->phys_id_busy = true;
 	netdev_hold(dev, &dev_tracker, GFP_KERNEL);
 	netdev_unlock_ops(dev);
-	rtnl_unlock();
+	if (has_rtnl_lock)
+		rtnl_unlock();
 
 	if (rc == 0) {
 		/* Driver will handle this itself */
@@ -2492,22 +2493,25 @@ static int ethtool_phys_id(struct net_device *dev, void __user *useraddr)
 		u64 i = 0;
 
 		do {
-			rtnl_lock();
+			if (has_rtnl_lock)
+				rtnl_lock();
 			netdev_lock_ops(dev);
 			rc = ops->set_phys_id(dev,
 				    (i++ & 1) ? ETHTOOL_ID_OFF : ETHTOOL_ID_ON);
 			netdev_unlock_ops(dev);
-			rtnl_unlock();
+			if (has_rtnl_lock)
+				rtnl_unlock();
 			if (rc)
 				break;
 			schedule_timeout_interruptible(interval);
 		} while (!signal_pending(current) && (!id.data || i < count));
 	}
 
-	rtnl_lock();
+	if (has_rtnl_lock)
+		rtnl_lock();
 	netdev_lock_ops(dev);
 	netdev_put(dev, &dev_tracker);
-	busy = false;
+	dev->ethtool->phys_id_busy = false;
 
 	(void) ops->set_phys_id(dev, ETHTOOL_ID_INACTIVE);
 	return rc;
@@ -3260,7 +3264,8 @@ static int ethtool_set_fecparam(struct net_device *dev, void __user *useraddr)
 static int
 dev_ethtool_locked(struct net *net, struct net_device *dev,
 		   void __user *useraddr,
-		   u32 ethcmd, struct ethtool_devlink_compat *devlink_state)
+		   u32 ethcmd, struct ethtool_devlink_compat *devlink_state,
+		   bool has_rtnl_lock)
 {
 	u32 sub_cmd;
 	int rc;
@@ -3316,6 +3321,8 @@ dev_ethtool_locked(struct net *net, struct net_device *dev,
 			return -EPERM;
 	}
 
+	netdev_assert_locked_ops_compat(dev);
+
 	if (dev->dev.parent)
 		pm_runtime_get_sync(dev->dev.parent);
 
@@ -3403,7 +3410,7 @@ dev_ethtool_locked(struct net *net, struct net_device *dev,
 		rc = ethtool_get_strings(dev, useraddr);
 		break;
 	case ETHTOOL_PHYS_ID:
-		rc = ethtool_phys_id(dev, useraddr);
+		rc = ethtool_phys_id(dev, useraddr, has_rtnl_lock);
 		break;
 	case ETHTOOL_GSTATS:
 		rc = ethtool_get_stats(dev, useraddr);
@@ -3550,8 +3557,20 @@ dev_ethtool_locked(struct net *net, struct net_device *dev,
 	if (dev->ethtool_ops->complete)
 		dev->ethtool_ops->complete(dev);
 
-	if (old_features != dev->features)
-		netdev_features_change(dev);
+	switch (ethcmd) {
+	case ETHTOOL_PHYS_ID:
+		/* Don't check features if operation drops the locks.
+		 * Someone else may have changed features in parallel.
+		 */
+		break;
+	default:
+		if (old_features != dev->features) {
+			if (has_rtnl_lock)
+				netdev_features_change(dev);
+			else
+				netdev_WARN(dev, "ethtool cmd %u changed features without rtnl_lock", ethcmd);
+		}
+	}
 out:
 	if (dev->dev.parent)
 		pm_runtime_put(dev->dev.parent);
@@ -3559,25 +3578,60 @@ dev_ethtool_locked(struct net *net, struct net_device *dev,
 	return rc;
 }
 
+/* Commands that may toggle dev->features in net/ethtool/ioctl.c and so
+ * call into __netdev_update_features(), which still requires rtnl_lock.
+ * Driver-decided SET commands that may chain into rtnl-only helpers are
+ * covered by ethtool_ioctl_needs_rtnl()/ETHTOOL_OP_NEEDS_RTNL_*.
+ */
+static bool ethtool_cmd_changes_features(u32 ethcmd)
+{
+	switch (ethcmd) {
+	case ETHTOOL_SFEATURES:
+	case ETHTOOL_SFLAGS:
+	case ETHTOOL_STXCSUM:
+	case ETHTOOL_SRXCSUM:
+	case ETHTOOL_SSG:
+	case ETHTOOL_STSO:
+	case ETHTOOL_SGSO:
+	case ETHTOOL_SGRO:
+		return true;
+	}
+	return false;
+}
+
 static int
 __dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
 	      u32 ethcmd, struct ethtool_devlink_compat *devlink_state)
 {
+	netdevice_tracker dev_tracker;
 	struct net_device *dev;
+	bool need_rtnl;
 	int rc;
 
-	rtnl_lock();
-	dev = __dev_get_by_name(net, ifr->ifr_name);
-	if (!dev) {
+	dev = netdev_get_by_name(net, ifr->ifr_name, &dev_tracker, GFP_KERNEL);
+	if (!dev)
+		return -ENODEV;
+
+	need_rtnl = !netdev_need_ops_lock(dev) ||
+		    ethtool_cmd_changes_features(ethcmd) ||
+		    ethtool_ioctl_needs_rtnl(dev, ethcmd);
+	if (need_rtnl)
+		rtnl_lock();
+	netdev_lock_ops(dev);
+	if (dev->reg_state > NETREG_REGISTERED ||
+	    dev->moving_ns || !net_eq(dev_net(dev), net)) {
 		rc = -ENODEV;
-		goto exit_rtnl_unlock;
+		goto exit_ops_unlock;
 	}
 
-	netdev_lock_ops(dev);
-	rc = dev_ethtool_locked(net, dev, useraddr, ethcmd, devlink_state);
+	rc = dev_ethtool_locked(net, dev, useraddr, ethcmd, devlink_state,
+				need_rtnl);
+
+exit_ops_unlock:
 	netdev_unlock_ops(dev);
-exit_rtnl_unlock:
-	rtnl_unlock();
+	if (need_rtnl)
+		rtnl_unlock();
+	netdev_put(dev, &dev_tracker);
 
 	return rc;
 }
-- 
2.54.0


