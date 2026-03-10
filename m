Return-Path: <netdev+bounces-265915-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCNGEPPMr2nWcAIAu9opvQ
	(envelope-from <netdev+bounces-265915-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:49:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9AB2469DF
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D246E304B8F1
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 07:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B1A363C5F;
	Tue, 10 Mar 2026 07:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gow9+562"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A385362123
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773128828; cv=none; b=tJrHJv3SuR7XDTuuYwutaTfQoeNnqUpW6dPWfNipIoM+OBEUUHSdnMAl9kuWoyyDwsQvgyUiNCUnjLMqbwJ4G5Wvo8eM3tWjlFLORQ4jOmr7KDk2csOhDKN+XjtZLn7qIjL2zG/yYeSoCkiEjJx+pIKahJF3DZNYRwyo+8iwHWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773128828; c=relaxed/simple;
	bh=bXnDNSFidNz36SeGMTKr9aEsO9Td+iPTz2QUPB6xp3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ed3OHTWTrrFWnuX1luCunFXup8WF/P/XkdiATzGMy9p1EpyYnjgM/RZH7nApxjv0IVec2Hrwg0JYtQ2lIGg/v7IJEyHaOi1f3qTJc2fY4rz3MqmeZgEVRJQLUVp0+Jki8h1XczWE20N8UV04LicqZUAeT0yjABjT7415S8bSVss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gow9+562; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-359f8502ea8so65537a91.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 00:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773128826; x=1773733626; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3MrEEXv7Xy2jJrXRIKwxLssaRaTIm50HmDgCOhNMffI=;
        b=Gow9+562BFRpy9U2GY8TssgH+Gaw7cOuYfzpcHt/I9pTfBraDfXUoMpUslObZ9eBQG
         YUGImjaSUqlb9txAuu/rxdFyx5Kl4B+xQLu6gr9T6oMvmiw5dS2HULs3moEFFbASS6aT
         /CBAEwLpm/3xJsJZRGwT4zIdAGPo4+Mreu0zucrYPQszeGNQHm3Gdt9y6MfDNTToR6KE
         oKLqlF3kuP8zYPf99UQE70vYW15bpnWp6ODajaOg1ma+MEGtjXUfGTAzU5TnuCMd6Cmd
         XKCNBIun0VDfKe8rTVNNMFPa1yxSOBES4x7JwuRHRiBbbwCZ4voHn2rpFy2UUd+A8FTp
         GV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773128826; x=1773733626;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3MrEEXv7Xy2jJrXRIKwxLssaRaTIm50HmDgCOhNMffI=;
        b=WfLrbYV02OfhQ9Qtu6w9PlOfxcu6awhqaBkqJEnXATfpczQH8jn5DX76JCtcenLJVo
         JaR1gR8X/N+K1TE+sUigX9y2d6/13nWNsba0gz3kdfPUjyKK1X97KjJLh53jeUGFWWaD
         LhSigYOub4rL5AmCrl9SzD+8p2HiFlb6JGO5tbAWyaIGFKJd8MmrNBYPWYRpdKm8yt3S
         gBev5MZOKr3VKnKXeOXTcJZKZ9r4uhzMYbl4+BnpyT7r7xPLYaksgBqGNWYJHTOsAyV8
         xo0WoQfTDZJw1jCKiiKDZMPP9EZFsVOSaexP7oPlmJD/uBYOz2GRJBUpO4K2vYfh+TPb
         VdKg==
X-Gm-Message-State: AOJu0YxD3FwYthAae06lD4XgABOVlnJWFPIQpb9CY33X1W1zDSTOgUYn
	iksRwEXIWJJBTATqWUWFDoy5R4RzKPoqa8XXZCiAYtYqRYVzhN621Qgh
X-Gm-Gg: ATEYQzyjKKhl8WBOAmLketoNcM66/V0JAonXX6nb1Sy6YXBig/6ekvyMoyvHnj+bJ1+
	3ZV0ofyl1H50Aiqnim256dI1YBIF8Omjs7MagiPQedWKUqATGxHnFw2uDwR6XXt4YgaFjXPZa/N
	m67Khpm9+EyvoEkis/v+skXMcjXcZCljNJkyhtjNe2x6kX1lSD5VtI8H37B65bb3By3puroz0Mq
	xxMEkTMyOuZBovA66Mwv5qX11ZpvgmGl1yPV3Aph8D6opm028DUvPBiSbEp+S3n4/ZogC6SphdO
	HnPWceJ1HhoBhyOy0PNIP8SsLIlUfs19v+Cnzjf8cn20911aEinR/9PNqnHAMYFqPhq4HyuuFi4
	WZSstR09E7Lv09JMwFoG+snsBsF+TsmpNDtuCeIcLZrjMJM9UPxBJ6X8uMDeGAYWF9FA4C9F5hC
	L5tCqebnX2qjBbB00D8BYwTBDYQEtlU3ACulb/U9KObaIKpZ/3PtbTtpuQqi6Ft1erlOihnZqht
	tNeP3WhbhGTcoxSbBYDOfcIJxYateG1Ly2C4CIMSqI=
X-Received: by 2002:a17:90b:5252:b0:359:9bad:13d9 with SMTP id 98e67ed59e1d1-359be29eea6mr12832642a91.15.1773128826073;
        Tue, 10 Mar 2026 00:47:06 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359bc7ef38csm7260607a91.2.2026.03.10.00.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 00:47:05 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Tue, 10 Mar 2026 15:45:07 +0800
Subject: [PATCH net-next 3/3] net: no need to disable LRO specifically
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-offload_compute-v1-3-3df79c09ea65@gmail.com>
References: <20260310-offload_compute-v1-0-3df79c09ea65@gmail.com>
In-Reply-To: <20260310-offload_compute-v1-0-3df79c09ea65@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, Nikolay Aleksandrov <razor@blackwall.org>, 
 Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bridge@lists.linux.dev, Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: AE9AB2469DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265915-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

In commit "net: use ndo_set_features to set offload features for
bonding/bridge/team" we called netdev_change_features() in
__netdev_upper_dev_link(), which will disable LRO automatically on lower
device if upper device doesn't have LRO enabled. So we don't need to
dev_disable_lro() again after netdev_upper_dev_link().

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 3 ---
 drivers/net/team/team_core.c    | 3 ---
 net/8021q/vlan.c                | 2 --
 net/bridge/br_if.c              | 2 --
 net/hsr/hsr_slave.c             | 1 -
 5 files changed, 11 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 4d32b06079ee..5b117acb1138 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2177,9 +2177,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	}
 #endif
 
-	if (!(bond_dev->features & NETIF_F_LRO))
-		dev_disable_lro(slave_dev);
-
 	res = netdev_rx_handler_register(slave_dev, bond_handle_frame,
 					 new_slave);
 	if (res) {
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 4906ea3717b1..73d4f68a7ccd 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1191,9 +1191,6 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		goto err_enable_netpoll;
 	}
 
-	if (!(dev->features & NETIF_F_LRO))
-		dev_disable_lro(port_dev);
-
 	err = netdev_rx_handler_register(port_dev, team_handle_frame,
 					 port);
 	if (err) {
diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index 2b74ed56eb16..fda3a80e9340 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -193,8 +193,6 @@ int register_vlan_dev(struct net_device *dev, struct netlink_ext_ack *extack)
 	vlan_group_set_device(grp, vlan->vlan_proto, vlan_id, dev);
 	grp->nr_vlan_devs++;
 
-	netdev_update_features(dev);
-
 	return 0;
 
 out_unregister_netdev:
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 030248bc94c5..0aa653a1e651 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -620,8 +620,6 @@ int br_add_if(struct net_bridge *br, struct net_device *dev,
 	if (err)
 		goto err5;
 
-	dev_disable_lro(dev);
-
 	list_add_rcu(&p->list, &br->port_list);
 
 	nbp_update_port_count(br);
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index 44f83c8c56a7..4b6ab185392b 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -169,7 +169,6 @@ static int hsr_portdev_setup(struct hsr_priv *hsr, struct net_device *dev,
 	res = netdev_rx_handler_register(dev, hsr_handle_frame, port);
 	if (res)
 		goto fail_rx_handler;
-	dev_disable_lro(dev);
 
 	return 0;
 

-- 
Git-155)


