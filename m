Return-Path: <netdev+bounces-268026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mdD6K2uHt2msSAEAu9opvQ
	(envelope-from <netdev+bounces-268026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 05:30:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D37A29491B
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 05:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 909B230247D3
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 04:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F282DCBF4;
	Mon, 16 Mar 2026 04:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hO9jI0uR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EEE339866
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 04:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773635276; cv=none; b=sniy4xIa7rmqXcWnliVLe6gIsx+3KRcJ0CcgGpDVJM0cnmJ5py36fPn3WuvPLUOdA2iF+6AKjtNf+2YpHC4dGdhPkXQPE4duyP7VV1mXcvt0OdK9Dz1h7QD9w5lyI8o2nNqp9YqSIqg6DSDaXXVSrgIc4pDYV+2ZIeoON1Fwq9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773635276; c=relaxed/simple;
	bh=Pwe+hISXxf7UnQW3PsrYTHnib7m2N5HUUsdGQZrsYtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uda2VT+TvVolkNM2IlYPagOJ6r4Dd2fQ41NHeWVYcW7u0GPqEX3M99Cv5woa3/hgHPyV/PHReMmrWAojMYdac9Vk+3B0htnbJxNIFSLBY+6zEGHek/imr2Ykj5QEHrgu86wzbwdLEG9q8ax8RQupXRpGLwt9bIc6PoewM2hMAKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hO9jI0uR; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-827270d50d4so3922968b3a.3
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 21:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773635275; x=1774240075; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AJCl7LHn28MJC1H9+y+noJgdFBK7VWHZCxMkHXcBrlc=;
        b=hO9jI0uR0s6EaCERseJJIoZtPDTsTQ9fFS9RSWq5ep4fhI3Oxe4Cx/eQwg/1vFlLvy
         SktrLB/bRodrnTv11slCZwT3obP0cjQmTSSE9apq4PbtnIdgm0cP3nXOLFDbLjRiJE7s
         pzXTgMugJITD3HZqfgxg0YfRzCG9AGgrgs9HZhEE+mYZElZx5qTFmh1gEUqYbOovAWJ4
         ge8FqVr8fWrPAsGsZn9fFnzEXbDtLacL0BxNMOAyqniXm4uhh6uVe+al3E6HrHMK/eVf
         q/IAI4Zd2eiKkTBI1ITr+rvuXgScCyXO7yK7vzKlau8iwlJcI+lmXltdYc9R1MW0GdCM
         xmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773635275; x=1774240075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AJCl7LHn28MJC1H9+y+noJgdFBK7VWHZCxMkHXcBrlc=;
        b=EkJRmoP+Zqbix/h2mA1A3JsXaRqk/19jUjPGn8JxHx+f+gSef0ahI1tynzweAeMQVa
         2gBo9qeyyOHEe2S5hRATZjm25TzHFFe6o/mdPahOm3fmT0t0ya1DovBDXfO3yX9ncQ2y
         kQUsi2FbdkcFZzuRhyfPEeZotiUuXi2xLrnZJSEtYkgyrXwcFcBjO/c4fa2V1+swI/CI
         05xHuLSszjLpLqPNh5ad/jQ3bntp6KdEn4CHtlEBej16N1cw2qCH7ogwt319hxYN6pCx
         o/5GFKGkvS2qEiot7htcz3hSZDkgbCcQYRIeijUDBa2H/6BPuN7ZFGWMN0gH8AS7DztH
         uMkw==
X-Gm-Message-State: AOJu0YxfVy7v4hlJo3K/t28Uqv9ifSKgn7jUzuc3qHnm9ueFoRT0T7xr
	tZFoddvAmOM4AkBuIpVEvHNJg9DwZfqOART98/KguLsPp7hyT0DsH+6XQ0bGtcIcC+Tq4Q==
X-Gm-Gg: ATEYQzzBjgf1Iy30ryJMOONpzMaRimoGDzvzZpP+Vk8U5h2yJydsZhvy/4sXz+mqbOz
	zW8F+YokGXb6hQgIpqKgyqzJZFot7mosrxO17K6hOwd0Hl/FioW2DIhp4G2BLdaKPUvp4kdLRHr
	qWf4skwogFHmPCtgb8t1A58b5kd3tntkU2hQ5KHGPdOc8qC96KPgP+TmteSrN9R7VbzNwOvJj0i
	8w1TKSMxqmFTQ8Eseb0uVwPg2bcIbL+L2RcYXqIlvp7uvmh9KVcZqtK1NWKTQRa3MWAPCHuaj68
	fphV6ySTmiM6o0100yxe3K5KQOoLVIS3Q3SW9EUMlL0uJV6VtAtgotcx7lhZc7Amxx3GL57qp4/
	hW/YwDiEmChKXWcVgego1MQ6z6z/2917UQFmcLgkPVBXuJxh/3vaKhQlB3/UhcVRwhbJ65K/+cZ
	tzylgaGlk60bcju+PEgA92UPL5/UgWe9ithMw5Avb0nhyN/K6qe/y4tF3W9w==
X-Received: by 2002:a05:6a00:929f:b0:829:822e:cdc9 with SMTP id d2e1a72fcca58-82a1970498amr10804962b3a.2.1773635275161;
        Sun, 15 Mar 2026 21:27:55 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([240e:34c:5760:3860:bc29:deed:92d0:823c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0738422esm12180267b3a.55.2026.03.15.21.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 21:27:54 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Mon, 16 Mar 2026 12:26:13 +0800
Subject: [PATCH net-next v3 5/5] net: no need to disable LRO specifically
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-offload_compute-v3-5-a5d4a07d86d3@gmail.com>
References: <20260316-offload_compute-v3-0-a5d4a07d86d3@gmail.com>
In-Reply-To: <20260316-offload_compute-v3-0-a5d4a07d86d3@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, Nikolay Aleksandrov <razor@blackwall.org>, 
 Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
 Sabrina Dubroca <sd@queasysnail.net>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bridge@lists.linux.dev, Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268026-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D37A29491B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In commit "net: use ndo_update_offloads to set offload features for
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
index ea6bb20f9348..f4f6ae02f7ca 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2221,9 +2221,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	}
 #endif
 
-	if (!(bond_dev->features & NETIF_F_LRO))
-		dev_disable_lro(slave_dev);
-
 	res = netdev_rx_handler_register(slave_dev, bond_handle_frame,
 					 new_slave);
 	if (res) {
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index affbcc6fc130..4f18205dd30d 100644
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


