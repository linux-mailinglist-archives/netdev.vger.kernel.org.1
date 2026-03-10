Return-Path: <netdev+bounces-265913-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDrEKrjMr2nWcAIAu9opvQ
	(envelope-from <netdev+bounces-265913-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:48:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2578C2469C2
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 251E830B55DE
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 07:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3067F36212D;
	Tue, 10 Mar 2026 07:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+RGhi4f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57C4361670
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773128822; cv=none; b=nqZ9YIm6st9LbzqRWywx5S1t5+aVkhurqk0ddXIuzTL2f1SOwP8gCiq6eZv7YgChnVmJw+w322cBaYz8GJrhqGeosX4tiGrKcv372PTzcr5fihkzITW7TlZOeELUPh5FE8FARbOr1v31tqz4cNi0hdM5WsrxnAjMomzGumZt0hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773128822; c=relaxed/simple;
	bh=ckIN5ASkuNOY9pUfpsVNZbSyJ16scvuiSr26ig8bsBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lLiAmcaIXZmV/d31y/7FstpLwgt21WwV5V32u1OaSJjIp5UdaIaHyHcSEJb/89EhJ9noU8XIVGLHVqn9lvrhw6nlrfgnhT/LITct6g2Vhca8epLO+0p6OgUI8yDjV7QgxuY337YDzogl9c43sBv7ZhcJgTXIokPhDjJFBNaMM8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+RGhi4f; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3599019ae92so4992088a91.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 00:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773128820; x=1773733620; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=djyy+9DJ7NGUH5/yQnciZZwbkw5XEWCb6BieiKG0OKc=;
        b=P+RGhi4fJv0WuGJifLYhB3BxBwXFLt5xBL5YYWH6dBHzWt+sixle3rMvsmTVptqP0C
         no+jzpzltm6GldEddudb84pYSUqs+4AlhWgZ18t5QD07ALcUbmeYCQS7wMsSSYtxGIEt
         zxFJ17TFlJ4lj8850XF+E2D9B4l0RLcJYHddcMRuisajbFMfY+J7k/Np1oxUYLEoeI18
         roTcNXkDSwIx0SPC1hgcUZr3TF9W9wzJvp0lTKmNlH7e5QYKuAP7ItfUQT2lVjLVEhQV
         ZS1gj0W/nS1cn/kMvXMh40ewEP4OGvs/Up3MLkHbTQsu3LzsrwhWGsMhiIgRHHgSHQwH
         lKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773128820; x=1773733620;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=djyy+9DJ7NGUH5/yQnciZZwbkw5XEWCb6BieiKG0OKc=;
        b=guG7TI4PcrV5JlNDoMBaVtO0aMyDjt89Y3OzfUgaYf5Q9ldVPPwrcX/Kt3KILilM/5
         dii7u6by8Tn/btSlkwVMIxGZnr64zR91FxLftvvfLK+XwkR6QcSM0RFaxRVsscKGq2bM
         +ad1xEQHeW4wzvHcsFafaZ1M3i6BQkM6Mo7yGcZaptFSZRaFxqMQh+Dpu9hxwvt+rw14
         h5Nr3j3kJqUeqJVtCbGZFkKKK5+6U0sx/NfsWMyQtv6+I7Ajk7KRqmRa50FhtCIcP4iU
         lldVsOIgpW8ogWKjsJdY4CyXKhpjPVQy0Q/ao8kdfX922IZiMB5Cq2C28GOHi0kROtZd
         2bUQ==
X-Gm-Message-State: AOJu0YyUseJ5pEPDTB0jL32Yrun0u+zeZPVf7BsR4cDE/olByopBXVWs
	q1oM3LwRWG0EUFHt2XnxRSTZvqn0NsvkmXg4KCzf0kN1w0FhXHQsWkVN
X-Gm-Gg: ATEYQzy0T+EOIw/H6OPtix5yckSmImvqkRNmjTKXMi8aG3svORpF8u682NaY9wi0Jca
	dnZfRTzYqRH4MOFZkb/KhZZvc2kyAOQhMJX8lOVywOqTC5cE0W9E75vCHQD0jJuoUQnP3sXq3KV
	FWupG4W/j5ANPOV77Wt+czk9lfk+T6AOABy7sPFRR/0ArPWRs0G8egm3ym7k4WxV5aLZDTr8xvS
	El82UBYdy+JS668yQCJCritsN83Bis9MZk5SyWjzHsXv4gvkQ8UrN38T1sUoxwtFVTQy8sGCFtp
	yaVs+/3HYKQCAhIgu9ggVaY7ASNRxreAaRe+erRQSZdW8MY9J8dVzjK8Inmpt4oN7NBSr/8t4SJ
	3BblTJfMcX0mAcDTiKyCfxKde5pHF3Y9iSmiE1FQCMbDZEHy1AqdLgjL1GcJ1DtO5Oeq1GdB0Hd
	RhmtFk8xmYA3Ds6xU3frYiyNclK3mKivD7tZOPe0iGZsD29veVZEw/SKXDruCnc/roL1YppyRYT
	GdI9SsO7VJDsoI8CzuUhWtU4HFYpItXZjrcTEPOxJE=
X-Received: by 2002:a17:90b:3a4b:b0:359:7fe6:7e5 with SMTP id 98e67ed59e1d1-359be30aee2mr10825721a91.24.1773128819911;
        Tue, 10 Mar 2026 00:46:59 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359bc7ef38csm7260607a91.2.2026.03.10.00.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 00:46:59 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Tue, 10 Mar 2026 15:45:06 +0800
Subject: [PATCH net-next 2/3] failover: use ndo_set_features for failover
 offload compute
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-offload_compute-v1-2-3df79c09ea65@gmail.com>
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
X-Rspamd-Queue-Id: 2578C2469C2
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
	TAGGED_FROM(0.00)[bounces-265913-lists,netdev=lfdr.de];
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

Convert net_failover to use the ndo_set_features callback and calls
netdev_compute_master_upper_features() to compute new offload flags
during slave registration/unregistration.

This simplifies the failover code significantly by removing the custom
feature computation logic and relying on the centralized feature update
mechanism. The callback is automatically invoked during feature updates
when upper/lower device links change.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/net_failover.c | 67 ++++++----------------------------------------
 include/net/net_failover.h |  7 -----
 2 files changed, 8 insertions(+), 66 deletions(-)

diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c
index d0361aaf25ef..10041a271bf5 100644
--- a/drivers/net/net_failover.c
+++ b/drivers/net/net_failover.c
@@ -300,6 +300,12 @@ static int net_failover_vlan_rx_kill_vid(struct net_device *dev, __be16 proto,
 	return 0;
 }
 
+static int net_failover_set_features(struct net_device *dev, netdev_features_t features)
+{
+	netdev_compute_master_upper_features(dev, true);
+	return 0;
+}
+
 static const struct net_device_ops failover_dev_ops = {
 	.ndo_open		= net_failover_open,
 	.ndo_stop		= net_failover_close,
@@ -312,6 +318,7 @@ static const struct net_device_ops failover_dev_ops = {
 	.ndo_vlan_rx_kill_vid	= net_failover_vlan_rx_kill_vid,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_features_check	= passthru_features_check,
+	.ndo_set_features	= net_failover_set_features,
 };
 
 #define FAILOVER_NAME "net_failover"
@@ -373,61 +380,6 @@ static rx_handler_result_t net_failover_handle_frame(struct sk_buff **pskb)
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
@@ -550,7 +502,6 @@ static int net_failover_slave_register(struct net_device *slave_dev,
 	}
 
 	net_failover_lower_state_changed(slave_dev, primary_dev, standby_dev);
-	net_failover_compute_features(failover_dev);
 
 	call_netdevice_notifiers(NETDEV_JOIN, slave_dev);
 
@@ -621,8 +572,6 @@ static int net_failover_slave_unregister(struct net_device *slave_dev,
 
 	dev_put(slave_dev);
 
-	net_failover_compute_features(failover_dev);
-
 	netdev_info(failover_dev, "failover %s slave:%s unregistered\n",
 		    slave_is_standby ? "standby" : "primary", slave_dev->name);
 
@@ -736,7 +685,7 @@ struct failover *net_failover_create(struct net_device *standby_dev)
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


