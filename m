Return-Path: <netdev+bounces-268025-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PNOJMKGt2mOSAEAu9opvQ
	(envelope-from <netdev+bounces-268025-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 05:27:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CB42948EB
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 05:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE4A83004D24
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 04:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE342339866;
	Mon, 16 Mar 2026 04:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvdxzsxx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D661DDC37
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 04:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773635264; cv=none; b=b2KdxWyZaJ/efwzl3pHnYKMtCzYe1HWqfcpz7nFbbgVbsjDn2UPFSziatB19zPhh6FCvaQG/sFHwtRTarv0NLoXbNxQ/o/s40zrz97zw9jyw+Kt4fu9n5zg8e4jx4/Jb53Hnt/NSCUkmDYqP7pd6EKVAGo+ESQggByn8BMuiPiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773635264; c=relaxed/simple;
	bh=9i2xWCN02/6dWupq0qfGRAfhr3jgqrdA1Q8ElDVHmj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KMHBzwU7uMx7NRATNoxTsU/fFak5QqvNpdLD4O9+c+0O0UWZkWdqObajbDmby9H7ioPgftcG1RwHH18BdqzLOt9x9QRP38PY5fiE/GDXWU5HPDv5rnRvrifZsk6AvEmwaoDDpfaDmPzmBbt6KlfBsVWttGuwh8Q15dLWmMcM7BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvdxzsxx; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82735a41920so1478859b3a.2
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 21:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773635263; x=1774240063; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C7xj5ZZxKagQhRbiCtY39hgG05M7BNgG4UcL1mqFDwQ=;
        b=kvdxzsxxepySuOcY3WN8j+vyOkMJIolCyekYtNoLMfb3ZYkQ4KNWwckTK+rrcnOXlT
         z8B8zdRIIksMXHd/ofKz58ygDnMQX07x23hUnsI1iPrLzGS0vfy3eiGwABc4EPdOREvc
         040cLmUP/0EVPliyzWS9olEa4FqCcP+j+yqDHfiqPpDfc1Jo5XusVR1jEBpiviFAg87R
         zuldpzkDdDGjOhKsTnNN/UAwh91Ohc057GLJg3UiQsZLj9LPQdjp27PNAuOV6XhnXXDw
         nI15whRefLZRBooyg8I8Q+OLFXJp0I8WUD9IDv9/SKb+efmMdghMy6w0GzVJHLAwf+xb
         6THw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773635263; x=1774240063;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C7xj5ZZxKagQhRbiCtY39hgG05M7BNgG4UcL1mqFDwQ=;
        b=kc2gv4BS+u4Unbsl+UxsuvqfmCpwG/9HUXp9nWzwiw+oK+12ncXhlGbI3vh04duhAr
         OtYYdy3tpJgkdJnPiUpTzIwWZjsfFsEmIx9+CMGYUyK0fy4JAkYXV15qSl2Llzbf4KvH
         fGkOxUnYvUchC7TKfnf652CZJEiVE1sei29V0ItwdmHuQ5JxyVn7B3jpHlmhNb2WLJWk
         dXQzI/kA7EBjc4aCP/HiU1x6Qf/8Rw0V0WKtVVcEG6dTwRw9438qU7tQY2mSV+uGf5wq
         1CxMsZ3f+Me93PK+o7kbnOxMh/hmtTz9wfrcpYU9MxaUfQ6ONzsq2QgtJqT51b+OtRuW
         1a1g==
X-Gm-Message-State: AOJu0YzjEVh/X1JmHmfcPy5RTepG5Bq7lSqNklAOdSYsEMnnW/Pen5IG
	lHtBjcRwFMRdxXiWoEcQ9HOBD+ZkysDczubk4NxGqiNsNwPPhiXbjK6l
X-Gm-Gg: ATEYQzylj2G6rGn/8HUXFJBQDcs4vBchdHUYMyk4llklBqewIfdEc9xo+56L7J2keeQ
	/AXpXSpIreYM2f9q61+3xhPgbqlTy6N/rOjUAtqZFk//ro6VNWqxbb7Njda3i2Us30ch6cLnOS3
	jJy0B9fHnjwrQK5jzGYQBHQr9qFqT7oZ6zEnhnsmVN1jqPF38lvz8fvRO4Un86rFfZhnwZejoCz
	z7jtHEikYbL1ZZWCPacxzr4M9yS51hXyCQhxRbnn97cCDjaoTj4GNs4GdCaEVozIVU0zETCmKMh
	pPI0c2xlGQxl3BIkznE+J8YuFEtFRbNjcqPZvj2TclLoLk9nsNFeLuTBRdHQbz2/FShxgbkTFPs
	d1N8xbjxLEgzAnc1tXGunsl89cXOd+r55Esa7SD5pQEUf7KnQgnjRXC22Tu+L/L3krA3yGAeKhQ
	FtfvHhtosZHDw0PaUFZm9tVNymp+odskPWUd3YE0oETFIsg9Q9gCV4v4xOgg==
X-Received: by 2002:a05:6a00:4605:b0:829:8990:3f86 with SMTP id d2e1a72fcca58-82a198cf37fmr9979104b3a.35.1773635262976;
        Sun, 15 Mar 2026 21:27:42 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([240e:34c:5760:3860:bc29:deed:92d0:823c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0738422esm12180267b3a.55.2026.03.15.21.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 21:27:42 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Mon, 16 Mar 2026 12:26:12 +0800
Subject: [PATCH net-next v3 4/5] failover: use ndo_update_offloads for
 failover offload compute
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-offload_compute-v3-4-a5d4a07d86d3@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268025-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 71CB42948EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert net_failover to use the ndo_update_offloads callback and calls
netdev_compute_master_upper_features() to compute new offload flags
during slave registration/unregistration.

This simplifies the failover code significantly by removing the custom
feature computation logic and relying on the centralized feature update
mechanism. The callback is automatically invoked during feature updates
when upper/lower device links change.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/net_failover.c | 66 +++++-----------------------------------------
 include/net/net_failover.h |  7 -----
 2 files changed, 7 insertions(+), 66 deletions(-)

diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c
index d0361aaf25ef..85c238b88b85 100644
--- a/drivers/net/net_failover.c
+++ b/drivers/net/net_failover.c
@@ -300,6 +300,11 @@ static int net_failover_vlan_rx_kill_vid(struct net_device *dev, __be16 proto,
 	return 0;
 }
 
+static void failover_update_offloads(struct net_device *dev)
+{
+	netdev_compute_master_upper_features(dev, true);
+}
+
 static const struct net_device_ops failover_dev_ops = {
 	.ndo_open		= net_failover_open,
 	.ndo_stop		= net_failover_close,
@@ -312,6 +317,7 @@ static const struct net_device_ops failover_dev_ops = {
 	.ndo_vlan_rx_kill_vid	= net_failover_vlan_rx_kill_vid,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_features_check	= passthru_features_check,
+	.ndo_update_offloads	= failover_update_offloads,
 };
 
 #define FAILOVER_NAME "net_failover"
@@ -373,61 +379,6 @@ static rx_handler_result_t net_failover_handle_frame(struct sk_buff **pskb)
 	return RX_HANDLER_ANOTHER;
 }
 
-static void net_failover_compute_features(struct net_device *dev)
-{
-	netdev_features_t vlan_features = FAILOVER_VLAN_FEATURES &
-					  NETIF_F_ALL_FOR_ALL;
-	netdev_features_t enc_features  = FAILOVER_ENC_FEATURES;
-	unsigned short max_hard_header_len = ETH_HLEN;
-	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE |
-					IFF_XMIT_DST_RELEASE_PERM;
-	struct net_failover_info *nfo_info = netdev_priv(dev);
-	struct net_device *primary_dev, *standby_dev;
-
-	primary_dev = rcu_dereference(nfo_info->primary_dev);
-	if (primary_dev) {
-		vlan_features =
-			netdev_increment_features(vlan_features,
-						  primary_dev->vlan_features,
-						  FAILOVER_VLAN_FEATURES);
-		enc_features =
-			netdev_increment_features(enc_features,
-						  primary_dev->hw_enc_features,
-						  FAILOVER_ENC_FEATURES);
-
-		dst_release_flag &= primary_dev->priv_flags;
-		if (primary_dev->hard_header_len > max_hard_header_len)
-			max_hard_header_len = primary_dev->hard_header_len;
-	}
-
-	standby_dev = rcu_dereference(nfo_info->standby_dev);
-	if (standby_dev) {
-		vlan_features =
-			netdev_increment_features(vlan_features,
-						  standby_dev->vlan_features,
-						  FAILOVER_VLAN_FEATURES);
-		enc_features =
-			netdev_increment_features(enc_features,
-						  standby_dev->hw_enc_features,
-						  FAILOVER_ENC_FEATURES);
-
-		dst_release_flag &= standby_dev->priv_flags;
-		if (standby_dev->hard_header_len > max_hard_header_len)
-			max_hard_header_len = standby_dev->hard_header_len;
-	}
-
-	dev->vlan_features = vlan_features;
-	dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL;
-	dev->hard_header_len = max_hard_header_len;
-
-	dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
-	if (dst_release_flag == (IFF_XMIT_DST_RELEASE |
-				 IFF_XMIT_DST_RELEASE_PERM))
-		dev->priv_flags |= IFF_XMIT_DST_RELEASE;
-
-	netdev_change_features(dev);
-}
-
 static void net_failover_lower_state_changed(struct net_device *slave_dev,
 					     struct net_device *primary_dev,
 					     struct net_device *standby_dev)
@@ -550,7 +501,6 @@ static int net_failover_slave_register(struct net_device *slave_dev,
 	}
 
 	net_failover_lower_state_changed(slave_dev, primary_dev, standby_dev);
-	net_failover_compute_features(failover_dev);
 
 	call_netdevice_notifiers(NETDEV_JOIN, slave_dev);
 
@@ -621,8 +571,6 @@ static int net_failover_slave_unregister(struct net_device *slave_dev,
 
 	dev_put(slave_dev);
 
-	net_failover_compute_features(failover_dev);
-
 	netdev_info(failover_dev, "failover %s slave:%s unregistered\n",
 		    slave_is_standby ? "standby" : "primary", slave_dev->name);
 
@@ -736,7 +684,7 @@ struct failover *net_failover_create(struct net_device *standby_dev)
 	/* Don't allow failover devices to change network namespaces. */
 	failover_dev->netns_immutable = true;
 
-	failover_dev->hw_features = FAILOVER_VLAN_FEATURES |
+	failover_dev->hw_features = MASTER_UPPER_DEV_VLAN_FEATURES |
 				    NETIF_F_HW_VLAN_CTAG_TX |
 				    NETIF_F_HW_VLAN_CTAG_RX |
 				    NETIF_F_HW_VLAN_CTAG_FILTER;
diff --git a/include/net/net_failover.h b/include/net/net_failover.h
index b12a1c469d1c..f0f038d113a0 100644
--- a/include/net/net_failover.h
+++ b/include/net/net_failover.h
@@ -30,11 +30,4 @@ struct net_failover_info {
 struct failover *net_failover_create(struct net_device *standby_dev);
 void net_failover_destroy(struct failover *failover);
 
-#define FAILOVER_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
-				 NETIF_F_FRAGLIST | NETIF_F_ALL_TSO | \
-				 NETIF_F_HIGHDMA | NETIF_F_LRO)
-
-#define FAILOVER_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
-				 NETIF_F_RXCSUM | NETIF_F_ALL_TSO)
-
 #endif /* _NET_FAILOVER_H */

-- 
Git-155)


