Return-Path: <netdev+bounces-295496-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6Qh3NekYImrZSQEAu9opvQ
	(envelope-from <netdev+bounces-295496-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 02:31:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4196A6441F3
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 02:31:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WGhLwYaV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295496-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295496-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1249D306E1B7
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 00:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDB7229B38;
	Fri,  5 Jun 2026 00:29:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5B824466C
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 00:29:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780619384; cv=none; b=Kx388G8I9qnAD4ft4NNwaBC1loIBRyBpgO/0YBjvvx7PcmsC9eW3upr5taid1V4DAexE45qRRK6gURNToN6nIaHdq7kS24y58ykr007VMpdSucxsZPH4mNNFpOgvDmUxFqz9WNfBAaGhZyMwsNeDi9JJ8pKcdlzc9owvnJ+tkdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780619384; c=relaxed/simple;
	bh=wsriAPQIQA3Iyr5ClZtLcMWlC5kJRh0Aj4pXB7VaOhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eh+swq+vnrB/c6h0WE9GI61j0BYc3yxyKSVfiL3d31GhYYnX4rDDoM5Vcse5gVIO8yHdpAY/0a0EqD7DLbSYn92c+WJiKYKeoIMITDks4xQ5YhByoTDIlKRFv3cgZF/yYiNreEYUW9REFEm/EAYd4G/ebuXe3Cu2jvnTPc/in4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGhLwYaV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99891F0089A;
	Fri,  5 Jun 2026 00:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780619383;
	bh=Xlzellw7mDXZC9YJ25DqoY7zzBYGqPoqOQNlysyAOHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WGhLwYaVqyjwy1yYnJg9QhHCY5HBics8oiyYzSru/4NLWWLr1dkA7oEUBTz6mlZpV
	 MOvTe+7Vdkp/LTRYYPBT0aNN78wyGgOKGeyyHsPZ29RU23A5/HIWbpPGeKjwS5L5x5
	 5X6jNC34ct+oJxcxA/8RzsfgeOcgQnbdJxHDxjbvqDJLIw08uW3iXZeLJ/+4igMunx
	 vYPuDzmSIWKc1TikFMwJdrZ4LaDZ/LqCIHPimB/Gj6H5NsoCNAxm6mqOoTY56bzVOZ
	 oBRAP8vv9ZXW4VOIEOi4fOnJ1ARuf4wl+Ro53lXx9Vf/f6nw4wMpjTNNr8PCn35tNI
	 5kYTBI5y4Qd9Q==
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
Subject: [PATCH net-next v2 08/12] net: ethtool: optionally skip rtnl_lock in ethnl_act_module_fw_flash()
Date: Thu,  4 Jun 2026 17:29:08 -0700
Message-ID: <20260605002912.3456868-9-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295496-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:joshwash@google.com,m:tariqt@nvidia.com,m:alexanderduyck@fb.com,m:willemb@google.com,m:jacob.e.keller@intel.com,m:kory.maincent@bootlin.com,m:sdf.kernel@gmail.com,m:jakub@cloudflare.com,m:nb@tipi-net.de,m:kuba@kernel.org,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
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
X-Rspamd-Queue-Id: 4196A6441F3

Module firmware flashing reads SFF-8024 identifier bytes via
.get_module_eeprom_by_page(). Other than that it modifies
a bit in the netdev->ethtool struct. Both should be ops-locked
at this point.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netdevice.h | 2 +-
 net/ethtool/module.c      | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 403b6d1c67f8..9b876cd930d7 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2584,7 +2584,7 @@ struct net_device {
 	 *	@up, @moving_ns, @nd_net, @xdp_features
 	 *
 	 * Ops protects:
-	 *	@cfg, @cfg_pending, @hwprov
+	 *	@cfg, @cfg_pending, @ethtool, @hwprov
 	 *
 	 * Double ops protects:
 	 *	@real_num_rx_queues, @real_num_tx_queues
diff --git a/net/ethtool/module.c b/net/ethtool/module.c
index c3388e6d7ec8..9cf670e089f2 100644
--- a/net/ethtool/module.c
+++ b/net/ethtool/module.c
@@ -429,8 +429,7 @@ int ethnl_act_module_fw_flash(struct sk_buff *skb, struct genl_info *info)
 		return ret;
 	dev = req_info.dev;
 
-	rtnl_lock();
-	netdev_lock_ops(dev);
+	netdev_lock_ops_compat(dev);
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
 		goto out_unlock;
@@ -445,8 +444,7 @@ int ethnl_act_module_fw_flash(struct sk_buff *skb, struct genl_info *info)
 	ethnl_ops_complete(dev);
 
 out_unlock:
-	netdev_unlock_ops(dev);
-	rtnl_unlock();
+	netdev_unlock_ops_compat(dev);
 	ethnl_parse_header_dev_put(&req_info);
 	return ret;
 }
-- 
2.54.0


