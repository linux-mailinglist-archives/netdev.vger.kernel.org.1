Return-Path: <netdev+bounces-295498-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cGYkCAsZImrdSQEAu9opvQ
	(envelope-from <netdev+bounces-295498-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 02:32:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2656441FC
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 02:32:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ns+f9Wka;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295498-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295498-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FF92307B74D
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 00:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D9226B2D2;
	Fri,  5 Jun 2026 00:29:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F79F2309AA
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 00:29:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780619386; cv=none; b=hGt/cSaxOTcMuYAhJ9JadEBM2efIa6+Yzg9PB23D1mXkWT9nExg7H82tchBn2RMo4h/yNmdomaLzB5V5l9/PBedt4ct9prkSap1Lf0D+Wj71r8ebnyrxaoMD3xc2rd6KQIUvoirONSBYZlFDyJglBYJKGQSxTkN+Zg8IZrQScB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780619386; c=relaxed/simple;
	bh=YH7bDyeZIJ88VKCWkU5vuTB3+Dt/3gjncusbscBI4qY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rkfk8pmWFjCEpyREInD1zEuNO/B8xulBVfiHBeLoP/F0oE4htgdVP5HDYhgdquhBCdsac7oBj3kCh16SC8ZA2Kzi3Nvw4edsi3h78ZVkxbG19cXt8D5xdiPz0Ep/g35DqcHUOKUHHylJIGjRCkOnIOt0j6w57U5RFfUSYSuCDdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ns+f9Wka; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EEC1F00899;
	Fri,  5 Jun 2026 00:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780619385;
	bh=ktro6ofBNZEe9KX0vsrKUmrMdNm2K7SlNe7mgp7BtTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ns+f9WkanT5mrXTgWykeaiyZN3Ggf/Ui5SXpisty4lWN1WlSG6ILomsezwTi2+/uS
	 YGBl43f/IfhTdGYFNeFYyOsROmWE3i1vk+ITUOyuy+zGvb79diZaSvo6KQnwxnNo+K
	 BD9xzK1M3BK5q9RT3euurjdpdXTQfB9RolutDHHjZ4t/L6+So2b2VU2/+QYJwWrmJT
	 U9+Rf5eWVqF95VkX6T0HWU7Pt0z2yb4gUxY7ckmT0LmuszUtPYBr9zV11q4UOifXDj
	 WlNfBbetLhhV3QLdzHEQWOIbjdpXrdlf6+vbXHObG8CQwtph1vFEif+UXNMzUhJp+A
	 ux1YJ1AadpzBw==
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
Subject: [PATCH net-next v2 10/12] net: ethtool: ioctl: concentrate the locking
Date: Thu,  4 Jun 2026 17:29:10 -0700
Message-ID: <20260605002912.3456868-11-kuba@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-295498-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C2656441FC

Add another layer of helper functions to make upcoming locking
changes easier. Otherwise we'd need a pretty complex goto
structure. netdev instance lock is now taken slightly sooner
but that should not be an issue since rtnl_lock is already held,
anyway.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/ioctl.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index a4b0cbae4063..c32c099845e3 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -3258,18 +3258,14 @@ static int ethtool_set_fecparam(struct net_device *dev, void __user *useraddr)
 /* The main entry point in this file.  Called from net/core/dev_ioctl.c */
 
 static int
-__dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
-	      u32 ethcmd, struct ethtool_devlink_compat *devlink_state)
+dev_ethtool_locked(struct net *net, struct net_device *dev,
+		   void __user *useraddr,
+		   u32 ethcmd, struct ethtool_devlink_compat *devlink_state)
 {
-	struct net_device *dev;
 	u32 sub_cmd;
 	int rc;
 	netdev_features_t old_features;
 
-	dev = __dev_get_by_name(net, ifr->ifr_name);
-	if (!dev)
-		return -ENODEV;
-
 	if (ethcmd == ETHTOOL_PERQUEUE) {
 		if (copy_from_user(&sub_cmd, useraddr + sizeof(ethcmd), sizeof(sub_cmd)))
 			return -EFAULT;
@@ -3320,7 +3316,6 @@ __dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
 			return -EPERM;
 	}
 
-	netdev_lock_ops(dev);
 	if (dev->dev.parent)
 		pm_runtime_get_sync(dev->dev.parent);
 
@@ -3560,7 +3555,29 @@ __dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
 out:
 	if (dev->dev.parent)
 		pm_runtime_put(dev->dev.parent);
+
+	return rc;
+}
+
+static int
+__dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
+	      u32 ethcmd, struct ethtool_devlink_compat *devlink_state)
+{
+	struct net_device *dev;
+	int rc;
+
+	rtnl_lock();
+	dev = __dev_get_by_name(net, ifr->ifr_name);
+	if (!dev) {
+		rc = -ENODEV;
+		goto exit_rtnl_unlock;
+	}
+
+	netdev_lock_ops(dev);
+	rc = dev_ethtool_locked(net, dev, useraddr, ethcmd, devlink_state);
 	netdev_unlock_ops(dev);
+exit_rtnl_unlock:
+	rtnl_unlock();
 
 	return rc;
 }
@@ -3588,9 +3605,7 @@ int dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr)
 		break;
 	}
 
-	rtnl_lock();
 	rc = __dev_ethtool(net, ifr, useraddr, ethcmd, state);
-	rtnl_unlock();
 	if (rc)
 		goto exit_free;
 
-- 
2.54.0


