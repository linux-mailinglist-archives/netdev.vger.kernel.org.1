Return-Path: <netdev+bounces-120639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C4195A0F6
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 17:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADAD3B22B0F
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7811509BF;
	Wed, 21 Aug 2024 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nivJkfJR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4003C14F9F3;
	Wed, 21 Aug 2024 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252845; cv=none; b=qkSQ8Al3dCC+25MKuw7dXfXPYQEep9+UFTFKyi8WKssRrQ3e7rBZ6hnLCVoc5H3nwdAi9FTWEAULmWNLCgaocPnGfD+ZFUWvaxH+RJjwbA56LpzRQrlFH2jAJ4h+7DtBcyd106emafvHeKq4fCDYvbij7q0UdqBS84z9jqj/fk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252845; c=relaxed/simple;
	bh=RoRCl78B5Ks92FPLjbrr4f1STYis5azWa+kZVz2AHyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/7y4m0mBh/wBpjVwSIabJU+bK/PbOrHONLBnbce+JuIBrgl4S50eXuqFPXexLXRBWV1Et8vY04x5VoJKnZC2G7/zxeka+koahmbUtDACXZxsbposMp8tO7Whye4yuvws26LzaZMu6XetqENFIH8p1PwXctR4Ejaif+GW6tsGvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nivJkfJR; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724252844; x=1755788844;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RoRCl78B5Ks92FPLjbrr4f1STYis5azWa+kZVz2AHyQ=;
  b=nivJkfJRwKxvOpBNeJciEte10F6tXECzw6wHiu94Fh2BpciokbO7/tou
   2E3veDiJ1WF3yBdBnyZvdDYYNhKQI0zNwcEGbxVzHO2WwauWO+PlrseKI
   fHSjd44PMsZTZ9PpUmO5T0zq6Mj19QszOb3bH44jlngWJBWhxjBRUIGSh
   QAjfz5dGXqza+EbhKReJnPuUcIYyOCZm+7lZjGcwyIXvNA5I27sbRhcay
   UUwKU9nql59kn08Ma30F1TRPE5n5Psxchz7l3h5iUZj70jHrxxzpRmyVB
   /1bdgb07Kj+Zb8/wiEIx08IW6QyjdbZTxbuG2BlIiyApwj4hV8bASyAc7
   g==;
X-CSE-ConnectionGUID: guTCYLZlS+q4WKGL4O9Oww==
X-CSE-MsgGUID: 1v9HumtmT2iPo3Q3AvpsYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22769286"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="22769286"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 08:07:24 -0700
X-CSE-ConnectionGUID: E2x1m2CUTxyWF0MvSS4K8Q==
X-CSE-MsgGUID: 19n4qB/FQ7+A2mSJrZFEfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="84291280"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa002.fm.intel.com with ESMTP; 21 Aug 2024 08:07:21 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 6/6] netdev_features: remove NETIF_F_ALL_FCOE
Date: Wed, 21 Aug 2024 17:07:00 +0200
Message-ID: <20240821150700.1760518-7-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240821150700.1760518-1-aleksander.lobakin@intel.com>
References: <20240821150700.1760518-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NETIF_F_ALL_FCOE is used only in vlan_dev.c, 2 times. Now that it's only
2 bits, open-code it and remove the definition from netdev_features.h.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/netdev_features.h | 2 --
 net/8021q/vlan_dev.c            | 5 +++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 1e9c4da181af..e41cd8af2a72 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -205,8 +205,6 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
 #define NETIF_F_ALL_TSO 	(NETIF_F_TSO | NETIF_F_TSO6 | \
 				 NETIF_F_TSO_ECN | NETIF_F_TSO_MANGLEID)
 
-#define NETIF_F_ALL_FCOE	(NETIF_F_FCOE_CRC | NETIF_F_FSO)
-
 /* List of features with software fallbacks. */
 #define NETIF_F_GSO_SOFTWARE	(NETIF_F_ALL_TSO | NETIF_F_GSO_SCTP |	     \
 				 NETIF_F_GSO_UDP_L4 | NETIF_F_GSO_FRAGLIST)
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 09b46b057ab2..458040e8a0e0 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -564,7 +564,7 @@ static int vlan_dev_init(struct net_device *dev)
 			   NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE |
 			   NETIF_F_GSO_ENCAP_ALL |
 			   NETIF_F_HIGHDMA | NETIF_F_SCTP_CRC |
-			   NETIF_F_ALL_FCOE;
+			   NETIF_F_FCOE_CRC | NETIF_F_FSO;
 
 	if (real_dev->vlan_features & NETIF_F_HW_MACSEC)
 		dev->hw_features |= NETIF_F_HW_MACSEC;
@@ -576,7 +576,8 @@ static int vlan_dev_init(struct net_device *dev)
 	if (dev->features & NETIF_F_VLAN_FEATURES)
 		netdev_warn(real_dev, "VLAN features are set incorrectly.  Q-in-Q configurations may not work correctly.\n");
 
-	dev->vlan_features = real_dev->vlan_features & ~NETIF_F_ALL_FCOE;
+	dev->vlan_features = real_dev->vlan_features &
+			     ~(NETIF_F_FCOE_CRC | NETIF_F_FSO);
 	dev->hw_enc_features = vlan_tnl_features(real_dev);
 	dev->mpls_features = real_dev->mpls_features;
 
-- 
2.46.0


