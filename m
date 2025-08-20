Return-Path: <netdev+bounces-215181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F98CB2D791
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 11:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B300F7B5CE7
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 09:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28EF2D9EDF;
	Wed, 20 Aug 2025 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DTVN/8Dn"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EC12DD608
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680870; cv=none; b=TdJALxnB4gFCyz7dca+3jUaaannlpnL20bA+YUHnIcsfHhv3XmrtwVTO/UjTgc0bWUZB8GW5f+EqNfKZ6fAfl8ks3TALUvnrYajjlToHnEDmqkE8v9PBa54g8TvH0RYPg2NnP/51b6Qgi++xxSCtY8QPvuO9CgYPQ5ZCMEOlsos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680870; c=relaxed/simple;
	bh=a0QWFpdloHAbd+dm1DvOmKtG4IUalmOMMoLeNd1sdyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i0xmAh4GbXd8wVd3cnqkHqicaQIozCOEXTqexnkaT+WNTL5CEesftTSynePsRCZGxmWQNXS99w69c0VrC62wOTW0tBpMLey2MwWHlrIlxN1v+WWdatlG91mSI57crwPHsqPI+7qarOzskIjxoLIOwiUJrcv9k6ZNbtDeG78uM04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DTVN/8Dn; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C889E1A0D4A;
	Wed, 20 Aug 2025 09:07:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A254E606A0;
	Wed, 20 Aug 2025 09:07:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9BCCA1C22D3CC;
	Wed, 20 Aug 2025 11:07:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755680865; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=d2nlQytmRPz+rrqLknu+wIj3RHowV5aTGQHOfNp9su8=;
	b=DTVN/8DnNMNUMQFBvjwKmDgMFoiLxoRbVqc0bdemiN7j6b5l4csIhDkPEU0McvQDsePRg6
	aYca1SL6PRAe5VfP+E8Vi+XmI3HVJtN5ad6KTyvpgx4t6id7C3d1LXFqOOdk22Ha+GKTsC
	zmP419D2dPu1jSf1HuFLUrU5o5ewQPuxtnZwbxBSNzCEz7WzhGsejuvrhs26tW9d8davDo
	fhMm8KGEMvMW7vkik33JnMMvslZjgsurEbh0vHl86N5EkN3IixbAD2J8V+qvXM701q+ktw
	aK3/zBANobg+r7AATeHiwHR3MgUWpQgBJGc4mIRibfvfdMo5NHHmxnvYFQQ73A==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 20 Aug 2025 11:07:32 +0200
Subject: [PATCH ethtool v3 1/3] update UAPI header copies
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-b4-feature_poe_pw_budget-v3-1-c3d57362c086@bootlin.com>
References: <20250820-b4-feature_poe_pw_budget-v3-0-c3d57362c086@bootlin.com>
In-Reply-To: <20250820-b4-feature_poe_pw_budget-v3-0-c3d57362c086@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>
Cc: Dent Project <dentproject@linuxfoundation.org>, 
 Kyle Swenson <kyle.swenson@est.tech>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-Last-TLS-Session-Version: TLSv1.3

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Update to kernel commit c04fdca8a98a.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 uapi/linux/ethtool.h                   |  4 +-
 uapi/linux/ethtool_netlink.h           |  2 -
 uapi/linux/ethtool_netlink_generated.h | 83 ++++++++++++++++++++++++++++++++++
 uapi/linux/if_link.h                   |  2 +
 uapi/linux/neighbour.h                 |  5 ++
 5 files changed, 92 insertions(+), 4 deletions(-)

diff --git a/uapi/linux/ethtool.h b/uapi/linux/ethtool.h
index 253df22..4a4b77b 100644
--- a/uapi/linux/ethtool.h
+++ b/uapi/linux/ethtool.h
@@ -2312,7 +2312,7 @@ enum {
 	IPV6_USER_FLOW	= 0x0e, /* spec only (usr_ip6_spec; nfc only) */
 	IPV4_FLOW	= 0x10, /* hash only */
 	IPV6_FLOW	= 0x11, /* hash only */
-	ETHER_FLOW	= 0x12, /* spec only (ether_spec) */
+	ETHER_FLOW	= 0x12, /* hash or spec (ether_spec) */
 
 	/* Used for GTP-U IPv4 and IPv6.
 	 * The format of GTP packets only includes
@@ -2369,7 +2369,7 @@ enum {
 /* Flag to enable RSS spreading of traffic matching rule (nfc only) */
 #define	FLOW_RSS	0x20000000
 
-/* L3-L4 network traffic flow hash options */
+/* L2-L4 network traffic flow hash options */
 #define	RXH_L2DA	(1 << 1)
 #define	RXH_VLAN	(1 << 2)
 #define	RXH_L3_PROTO	(1 << 3)
diff --git a/uapi/linux/ethtool_netlink.h b/uapi/linux/ethtool_netlink.h
index 0e9520f..041e768 100644
--- a/uapi/linux/ethtool_netlink.h
+++ b/uapi/linux/ethtool_netlink.h
@@ -208,6 +208,4 @@ enum {
 	ETHTOOL_A_STATS_PHY_MAX = (__ETHTOOL_A_STATS_PHY_CNT - 1)
 };
 
-#define ETHTOOL_MCGRP_MONITOR_NAME "monitor"
-
 #endif /* _LINUX_ETHTOOL_NETLINK_H_ */
diff --git a/uapi/linux/ethtool_netlink_generated.h b/uapi/linux/ethtool_netlink_generated.h
index fcc2986..98d12b0 100644
--- a/uapi/linux/ethtool_netlink_generated.h
+++ b/uapi/linux/ethtool_netlink_generated.h
@@ -49,6 +49,34 @@ enum hwtstamp_source {
 	HWTSTAMP_SOURCE_PHYLIB,
 };
 
+/**
+ * enum ethtool_pse_event - PSE event list for the PSE controller
+ * @ETHTOOL_PSE_EVENT_OVER_CURRENT: PSE output current is too high
+ * @ETHTOOL_PSE_EVENT_OVER_TEMP: PSE in over temperature state
+ * @ETHTOOL_C33_PSE_EVENT_DETECTION: detection process occur on the PSE. IEEE
+ *   802.3-2022 33.2.5 and 145.2.6 PSE detection of PDs. IEEE 802.3-202
+ *   30.9.1.1.5 aPSEPowerDetectionStatus
+ * @ETHTOOL_C33_PSE_EVENT_CLASSIFICATION: classification process occur on the
+ *   PSE. IEEE 802.3-2022 33.2.6 and 145.2.8 classification of PDs mutual
+ *   identification. IEEE 802.3-2022 30.9.1.1.8 aPSEPowerClassification.
+ * @ETHTOOL_C33_PSE_EVENT_DISCONNECTION: PD has been disconnected on the PSE.
+ *   IEEE 802.3-2022 33.3.8 and 145.3.9 PD Maintain Power Signature. IEEE
+ *   802.3-2022 33.5.1.2.9 MPS Absent. IEEE 802.3-2022 30.9.1.1.20
+ *   aPSEMPSAbsentCounter.
+ * @ETHTOOL_PSE_EVENT_OVER_BUDGET: PSE turned off due to over budget situation
+ * @ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR: PSE faced an error managing the
+ *   power control from software
+ */
+enum ethtool_pse_event {
+	ETHTOOL_PSE_EVENT_OVER_CURRENT = 1,
+	ETHTOOL_PSE_EVENT_OVER_TEMP = 2,
+	ETHTOOL_C33_PSE_EVENT_DETECTION = 4,
+	ETHTOOL_C33_PSE_EVENT_CLASSIFICATION = 8,
+	ETHTOOL_C33_PSE_EVENT_DISCONNECTION = 16,
+	ETHTOOL_PSE_EVENT_OVER_BUDGET = 32,
+	ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR = 64,
+};
+
 enum {
 	ETHTOOL_A_HEADER_UNSPEC,
 	ETHTOOL_A_HEADER_DEV_INDEX,
@@ -642,11 +670,47 @@ enum {
 	ETHTOOL_A_C33_PSE_EXT_SUBSTATE,
 	ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT,
 	ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES,
+	ETHTOOL_A_PSE_PW_D_ID,
+	ETHTOOL_A_PSE_PRIO_MAX,
+	ETHTOOL_A_PSE_PRIO,
 
 	__ETHTOOL_A_PSE_CNT,
 	ETHTOOL_A_PSE_MAX = (__ETHTOOL_A_PSE_CNT - 1)
 };
 
+enum {
+	ETHTOOL_A_FLOW_ETHER = 1,
+	ETHTOOL_A_FLOW_IP4,
+	ETHTOOL_A_FLOW_IP6,
+	ETHTOOL_A_FLOW_TCP4,
+	ETHTOOL_A_FLOW_TCP6,
+	ETHTOOL_A_FLOW_UDP4,
+	ETHTOOL_A_FLOW_UDP6,
+	ETHTOOL_A_FLOW_SCTP4,
+	ETHTOOL_A_FLOW_SCTP6,
+	ETHTOOL_A_FLOW_AH4,
+	ETHTOOL_A_FLOW_AH6,
+	ETHTOOL_A_FLOW_ESP4,
+	ETHTOOL_A_FLOW_ESP6,
+	ETHTOOL_A_FLOW_AH_ESP4,
+	ETHTOOL_A_FLOW_AH_ESP6,
+	ETHTOOL_A_FLOW_GTPU4,
+	ETHTOOL_A_FLOW_GTPU6,
+	ETHTOOL_A_FLOW_GTPC4,
+	ETHTOOL_A_FLOW_GTPC6,
+	ETHTOOL_A_FLOW_GTPC_TEID4,
+	ETHTOOL_A_FLOW_GTPC_TEID6,
+	ETHTOOL_A_FLOW_GTPU_EH4,
+	ETHTOOL_A_FLOW_GTPU_EH6,
+	ETHTOOL_A_FLOW_GTPU_UL4,
+	ETHTOOL_A_FLOW_GTPU_UL6,
+	ETHTOOL_A_FLOW_GTPU_DL4,
+	ETHTOOL_A_FLOW_GTPU_DL6,
+
+	__ETHTOOL_A_FLOW_CNT,
+	ETHTOOL_A_FLOW_MAX = (__ETHTOOL_A_FLOW_CNT - 1)
+};
+
 enum {
 	ETHTOOL_A_RSS_UNSPEC,
 	ETHTOOL_A_RSS_HEADER,
@@ -656,6 +720,7 @@ enum {
 	ETHTOOL_A_RSS_HKEY,
 	ETHTOOL_A_RSS_INPUT_XFRM,
 	ETHTOOL_A_RSS_START_CONTEXT,
+	ETHTOOL_A_RSS_FLOW_HASH,
 
 	__ETHTOOL_A_RSS_CNT,
 	ETHTOOL_A_RSS_MAX = (__ETHTOOL_A_RSS_CNT - 1)
@@ -718,6 +783,14 @@ enum {
 	ETHTOOL_A_TSCONFIG_MAX = (__ETHTOOL_A_TSCONFIG_CNT - 1)
 };
 
+enum {
+	ETHTOOL_A_PSE_NTF_HEADER = 1,
+	ETHTOOL_A_PSE_NTF_EVENTS,
+
+	__ETHTOOL_A_PSE_NTF_CNT,
+	ETHTOOL_A_PSE_NTF_MAX = (__ETHTOOL_A_PSE_NTF_CNT - 1)
+};
+
 enum {
 	ETHTOOL_MSG_USER_NONE = 0,
 	ETHTOOL_MSG_STRSET_GET = 1,
@@ -767,6 +840,9 @@ enum {
 	ETHTOOL_MSG_PHY_GET,
 	ETHTOOL_MSG_TSCONFIG_GET,
 	ETHTOOL_MSG_TSCONFIG_SET,
+	ETHTOOL_MSG_RSS_SET,
+	ETHTOOL_MSG_RSS_CREATE_ACT,
+	ETHTOOL_MSG_RSS_DELETE_ACT,
 
 	__ETHTOOL_MSG_USER_CNT,
 	ETHTOOL_MSG_USER_MAX = (__ETHTOOL_MSG_USER_CNT - 1)
@@ -822,9 +898,16 @@ enum {
 	ETHTOOL_MSG_PHY_NTF,
 	ETHTOOL_MSG_TSCONFIG_GET_REPLY,
 	ETHTOOL_MSG_TSCONFIG_SET_REPLY,
+	ETHTOOL_MSG_PSE_NTF,
+	ETHTOOL_MSG_RSS_NTF,
+	ETHTOOL_MSG_RSS_CREATE_ACT_REPLY,
+	ETHTOOL_MSG_RSS_CREATE_NTF,
+	ETHTOOL_MSG_RSS_DELETE_NTF,
 
 	__ETHTOOL_MSG_KERNEL_CNT,
 	ETHTOOL_MSG_KERNEL_MAX = (__ETHTOOL_MSG_KERNEL_CNT - 1)
 };
 
+#define ETHTOOL_MCGRP_MONITOR_NAME	"monitor"
+
 #endif /* _LINUX_ETHTOOL_NETLINK_GENERATED_H */
diff --git a/uapi/linux/if_link.h b/uapi/linux/if_link.h
index bb94d88..b450757 100644
--- a/uapi/linux/if_link.h
+++ b/uapi/linux/if_link.h
@@ -1396,6 +1396,7 @@ enum {
 	IFLA_VXLAN_LOCALBYPASS,
 	IFLA_VXLAN_LABEL_POLICY, /* IPv6 flow label policy; ifla_vxlan_label_policy */
 	IFLA_VXLAN_RESERVED_BITS,
+	IFLA_VXLAN_MC_ROUTE,
 	__IFLA_VXLAN_MAX
 };
 #define IFLA_VXLAN_MAX	(__IFLA_VXLAN_MAX - 1)
@@ -1532,6 +1533,7 @@ enum {
 	IFLA_BOND_MISSED_MAX,
 	IFLA_BOND_NS_IP6_TARGET,
 	IFLA_BOND_COUPLED_CONTROL,
+	IFLA_BOND_BROADCAST_NEIGH,
 	__IFLA_BOND_MAX,
 };
 
diff --git a/uapi/linux/neighbour.h b/uapi/linux/neighbour.h
index 5e67a7e..1401f57 100644
--- a/uapi/linux/neighbour.h
+++ b/uapi/linux/neighbour.h
@@ -54,6 +54,7 @@ enum {
 /* Extended flags under NDA_FLAGS_EXT: */
 #define NTF_EXT_MANAGED		(1 << 0)
 #define NTF_EXT_LOCKED		(1 << 1)
+#define NTF_EXT_EXT_VALIDATED	(1 << 2)
 
 /*
  *	Neighbor Cache Entry States.
@@ -92,6 +93,10 @@ enum {
  * bridge in response to a host trying to communicate via a locked bridge port
  * with MAB enabled. Their purpose is to notify user space that a host requires
  * authentication.
+ *
+ * NTF_EXT_EXT_VALIDATED flagged neighbor entries were externally validated by
+ * a user space control plane. The kernel will not remove or invalidate them,
+ * but it can probe them and notify user space when they become reachable.
  */
 
 struct nda_cacheinfo {

-- 
2.43.0


