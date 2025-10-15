Return-Path: <netdev+bounces-229739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B1CBE0774
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 21:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5020A507E05
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 19:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D633112D8;
	Wed, 15 Oct 2025 19:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z790gWBO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77A930EF63;
	Wed, 15 Oct 2025 19:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556804; cv=none; b=i2txyTn5jxT+RUUUwFbiITEsZVm0dJbWE7J8X9pOw7+D8TL+6WyoWZZ0x5lWr+IP30Bl+zRjvdUqJBdI+XtaZ2nM8/aEj0zqMOl0ILU8Wj1kbOVUU8RZLcfKgddjkzGAeHms1zCe0SZXZC4ZNsDI98eBm/DCMbqT4oLfnWW9S1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556804; c=relaxed/simple;
	bh=cCUtNqdWL/6aCq2+recY45GdXecsiPSTqnnahyOepj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s+lntkYMRd+NTOmEklnl7wv8MUuykjAywI1/nuee1BtAS2L5Bggj9pkzheXz6EDF23940eamIgLg2DXr+svKUaXrANRxXUG+f5H1TLZajKyOHZqXFwktaEn1seYZFyCUSgyFlmwOiTP1t6tsjq9n2O4wxM6RFTZ+qfZOZphHz8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z790gWBO; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760556802; x=1792092802;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=cCUtNqdWL/6aCq2+recY45GdXecsiPSTqnnahyOepj4=;
  b=Z790gWBOe1cH3GZsIMgYXYNttGJBWZd4i9gLifz00WIiDChjyaoK7cNK
   bTu2+47CzMsln/navOGaBK322pku48MAsWQBKgmf8t0wBUSwiuJFnlXHj
   LYdiscB984Zu0z+jXTYvpQxGs+ha+hkr6DBgPRejzKuJv19Qw0t9EiG8o
   sA/AlbdZIKqSGwnUR5iZQi9qb+AVur5QF/BeHclThlDd2haFHhTArKuJg
   PyA9IWVZUGA2G6E8JkG6YwUcP/tg9hA2XPXaKQ861hTpGtvsUncmr0KP2
   DnMewYYU7fvZiR3pultNK06jHrSqAFmOz7qUnY+FZAiIBCTNmQ2wNVbIJ
   g==;
X-CSE-ConnectionGUID: X3ZjmqcaRbCV08B6rbtF8g==
X-CSE-MsgGUID: G8cPv5w/TGK3FF3MjeGHLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="74083513"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="74083513"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:33:15 -0700
X-CSE-ConnectionGUID: WvMHTkQTS6KNHRzuxEpGEw==
X-CSE-MsgGUID: JZvJY3WTQDKeoy2IwDu8jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="182044892"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:33:14 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 15 Oct 2025 12:32:03 -0700
Subject: [PATCH net-next 07/14] iavf: add RSS support for GTP protocol via
 ethtool
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-jk-iwl-next-2025-10-15-v1-7-79c70b9ddab8@intel.com>
References: <20251015-jk-iwl-next-2025-10-15-v1-0-79c70b9ddab8@intel.com>
In-Reply-To: <20251015-jk-iwl-next-2025-10-15-v1-0-79c70b9ddab8@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>, 
 Rafal Romanowski <rafal.romanowski@intel.com>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=13743;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=Q++Q2ZzYPwo/4s+suHd2x6Xa6gpSbCl3n6V+9xc04WU=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhoz3375/WWkot7z8bcPDqRmCSU9ze7o+aRe+4fJcdmjWr
 YY5+zI0O0pZGMS4GGTFFFkUHEJWXjeeEKb1xlkOZg4rE8gQBi5OAZjIqpmMDCf/RwpMvF0uVBAf
 v5Z1946mRYlTpqy+xqMkv397HktR93dGhvX2bSoh9l6Zq14FWAr+M/mjU30m5cQGJh5tt8qKXxd
 /8AAA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Extend the iavf driver to support Receive Side Scaling (RSS)
configuration for GTP (GPRS Tunneling Protocol) flows using ethtool.

The implementation introduces new RSS flow segment headers and hash field
definitions for various GTP encapsulations, including:

  - GTPC
  - GTPU (IP, Extension Header, Uplink, Downlink)
  - TEID-based hashing

The ethtool interface is updated to parse and apply these new flow types
and hash fields, enabling fine-grained traffic distribution for GTP-based
mobile workloads.

This enhancement improves performance and scalability for virtualized
network functions (VNFs) and user plane functions (UPFs) in 5G and LTE
deployments.

Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_adv_rss.h |  31 +++++++
 drivers/net/ethernet/intel/iavf/iavf_adv_rss.c | 119 ++++++++++++++++++++-----
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c |  89 ++++++++++++++++++
 3 files changed, 216 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_adv_rss.h b/drivers/net/ethernet/intel/iavf/iavf_adv_rss.h
index e31eb2afebea..74cc9e0d528c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_adv_rss.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_adv_rss.h
@@ -22,6 +22,12 @@ enum iavf_adv_rss_flow_seg_hdr {
 	IAVF_ADV_RSS_FLOW_SEG_HDR_TCP	= 0x00000004,
 	IAVF_ADV_RSS_FLOW_SEG_HDR_UDP	= 0x00000008,
 	IAVF_ADV_RSS_FLOW_SEG_HDR_SCTP	= 0x00000010,
+	IAVF_ADV_RSS_FLOW_SEG_HDR_GTPC		= 0x00000400,
+	IAVF_ADV_RSS_FLOW_SEG_HDR_GTPC_TEID	= 0x00000800,
+	IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_IP	= 0x00001000,
+	IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_EH	= 0x00002000,
+	IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_DWN	= 0x00004000,
+	IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_UP	= 0x00008000,
 };
 
 #define IAVF_ADV_RSS_FLOW_SEG_HDR_L3		\
@@ -33,6 +39,14 @@ enum iavf_adv_rss_flow_seg_hdr {
 	 IAVF_ADV_RSS_FLOW_SEG_HDR_UDP |	\
 	 IAVF_ADV_RSS_FLOW_SEG_HDR_SCTP)
 
+#define IAVF_ADV_RSS_FLOW_SEG_HDR_GTP		\
+	(IAVF_ADV_RSS_FLOW_SEG_HDR_GTPC |	\
+	 IAVF_ADV_RSS_FLOW_SEG_HDR_GTPC_TEID |	\
+	 IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_IP |	\
+	 IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_EH |	\
+	 IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_DWN |	\
+	 IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_UP)
+
 enum iavf_adv_rss_flow_field {
 	/* L3 */
 	IAVF_ADV_RSS_FLOW_FIELD_IDX_IPV4_SA,
@@ -46,6 +60,17 @@ enum iavf_adv_rss_flow_field {
 	IAVF_ADV_RSS_FLOW_FIELD_IDX_UDP_DST_PORT,
 	IAVF_ADV_RSS_FLOW_FIELD_IDX_SCTP_SRC_PORT,
 	IAVF_ADV_RSS_FLOW_FIELD_IDX_SCTP_DST_PORT,
+	/* GTPC_TEID */
+	IAVF_ADV_RSS_FLOW_FIELD_IDX_GTPC_TEID,
+	/* GTPU_IP */
+	IAVF_ADV_RSS_FLOW_FIELD_IDX_GTPU_IP_TEID,
+	/* GTPU_EH */
+	IAVF_ADV_RSS_FLOW_FIELD_IDX_GTPU_EH_TEID,
+	IAVF_ADV_RSS_FLOW_FIELD_IDX_GTPU_EH_QFI,
+	/* GTPU_UP */
+	IAVF_ADV_RSS_FLOW_FIELD_IDX_GTPU_UP_TEID,
+	/* GTPU_DWN */
+	IAVF_ADV_RSS_FLOW_FIELD_IDX_GTPU_DWN_TEID,
 
 	/* The total number of enums must not exceed 64 */
 	IAVF_ADV_RSS_FLOW_FIELD_IDX_MAX
@@ -72,6 +97,12 @@ enum iavf_adv_rss_flow_field {
 	BIT_ULL(IAVF_ADV_RSS_FLOW_FIELD_IDX_SCTP_SRC_PORT)
 #define IAVF_ADV_RSS_HASH_FLD_SCTP_DST_PORT	\
 	BIT_ULL(IAVF_ADV_RSS_FLOW_FIELD_IDX_SCTP_DST_PORT)
+#define IAVF_ADV_RSS_HASH_FLD_GTPC_TEID	BIT_ULL(IAVF_ADV_RSS_FLOW_FIELD_IDX_GTPC_TEID)
+#define IAVF_ADV_RSS_HASH_FLD_GTPU_IP_TEID BIT_ULL(IAVF_ADV_RSS_FLOW_FIELD_IDX_GTPU_IP_TEID)
+#define IAVF_ADV_RSS_HASH_FLD_GTPU_EH_TEID BIT_ULL(IAVF_ADV_RSS_FLOW_FIELD_IDX_GTPU_EH_TEID)
+#define IAVF_ADV_RSS_HASH_FLD_GTPU_UP_TEID BIT_ULL(IAVF_ADV_RSS_FLOW_FIELD_IDX_GTPU_UP_TEID)
+#define IAVF_ADV_RSS_HASH_FLD_GTPU_DWN_TEID \
+	BIT_ULL(IAVF_ADV_RSS_FLOW_FIELD_IDX_GTPU_DWN_TEID)
 
 /* bookkeeping of advanced RSS configuration */
 struct iavf_adv_rss {
diff --git a/drivers/net/ethernet/intel/iavf/iavf_adv_rss.c b/drivers/net/ethernet/intel/iavf/iavf_adv_rss.c
index a9e1da35e248..4d12dfe1b481 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_adv_rss.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_adv_rss.c
@@ -90,6 +90,55 @@ iavf_fill_adv_rss_sctp_hdr(struct virtchnl_proto_hdr *hdr, u64 hash_flds)
 		VIRTCHNL_ADD_PROTO_HDR_FIELD_BIT(hdr, SCTP, DST_PORT);
 }
 
+/**
+ * iavf_fill_adv_rss_gtp_hdr - Fill GTP-related RSS protocol headers
+ * @proto_hdrs: pointer to the virtchnl protocol headers structure to populate
+ * @packet_hdrs: bitmask of packet header types to configure
+ * @hash_flds: RSS hash field configuration
+ *
+ * This function populates the virtchnl protocol header structure with
+ * appropriate GTP-related header types based on the specified packet_hdrs.
+ * It supports GTPC, GTPU with extension headers, and uplink/downlink PDU
+ * types. For certain GTPU types, it also appends an IPv4 header to enable
+ * hashing on the destination IP address.
+ *
+ * Return: 0 on success or -EOPNOTSUPP if the packet_hdrs value is unsupported.
+ */
+static int
+iavf_fill_adv_rss_gtp_hdr(struct virtchnl_proto_hdrs *proto_hdrs,
+			  u32 packet_hdrs, u64 hash_flds)
+{
+	struct virtchnl_proto_hdr *hdr;
+
+	hdr = &proto_hdrs->proto_hdr[proto_hdrs->count - 1];
+
+	switch (packet_hdrs & IAVF_ADV_RSS_FLOW_SEG_HDR_GTP) {
+	case IAVF_ADV_RSS_FLOW_SEG_HDR_GTPC_TEID:
+	case IAVF_ADV_RSS_FLOW_SEG_HDR_GTPC:
+		VIRTCHNL_SET_PROTO_HDR_TYPE(hdr, GTPC);
+		break;
+	case IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_EH:
+		VIRTCHNL_SET_PROTO_HDR_TYPE(hdr, GTPU_EH);
+		break;
+	case IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_UP:
+		VIRTCHNL_SET_PROTO_HDR_TYPE(hdr, GTPU_EH_PDU_UP);
+		hdr = &proto_hdrs->proto_hdr[proto_hdrs->count++];
+		iavf_fill_adv_rss_ip4_hdr(hdr, IAVF_ADV_RSS_HASH_FLD_IPV4_DA);
+		break;
+	case IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_DWN:
+		VIRTCHNL_SET_PROTO_HDR_TYPE(hdr, GTPU_EH_PDU_DWN);
+		fallthrough;
+	case IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_IP:
+		hdr = &proto_hdrs->proto_hdr[proto_hdrs->count++];
+		iavf_fill_adv_rss_ip4_hdr(hdr, IAVF_ADV_RSS_HASH_FLD_IPV4_DA);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 /**
  * iavf_fill_adv_rss_cfg_msg - fill the RSS configuration into virtchnl message
  * @rss_cfg: the virtchnl message to be filled with RSS configuration setting
@@ -103,6 +152,8 @@ int
 iavf_fill_adv_rss_cfg_msg(struct virtchnl_rss_cfg *rss_cfg,
 			  u32 packet_hdrs, u64 hash_flds, bool symm)
 {
+	const u32 packet_l3_hdrs = packet_hdrs & IAVF_ADV_RSS_FLOW_SEG_HDR_L3;
+	const u32 packet_l4_hdrs = packet_hdrs & IAVF_ADV_RSS_FLOW_SEG_HDR_L4;
 	struct virtchnl_proto_hdrs *proto_hdrs = &rss_cfg->proto_hdrs;
 	struct virtchnl_proto_hdr *hdr;
 
@@ -113,31 +164,41 @@ iavf_fill_adv_rss_cfg_msg(struct virtchnl_rss_cfg *rss_cfg,
 
 	proto_hdrs->tunnel_level = 0;	/* always outer layer */
 
-	hdr = &proto_hdrs->proto_hdr[proto_hdrs->count++];
-	switch (packet_hdrs & IAVF_ADV_RSS_FLOW_SEG_HDR_L3) {
-	case IAVF_ADV_RSS_FLOW_SEG_HDR_IPV4:
-		iavf_fill_adv_rss_ip4_hdr(hdr, hash_flds);
-		break;
-	case IAVF_ADV_RSS_FLOW_SEG_HDR_IPV6:
-		iavf_fill_adv_rss_ip6_hdr(hdr, hash_flds);
-		break;
-	default:
-		return -EINVAL;
+	if (packet_l3_hdrs) {
+		hdr = &proto_hdrs->proto_hdr[proto_hdrs->count++];
+		switch (packet_l3_hdrs) {
+		case IAVF_ADV_RSS_FLOW_SEG_HDR_IPV4:
+			iavf_fill_adv_rss_ip4_hdr(hdr, hash_flds);
+			break;
+		case IAVF_ADV_RSS_FLOW_SEG_HDR_IPV6:
+			iavf_fill_adv_rss_ip6_hdr(hdr, hash_flds);
+			break;
+		default:
+			return -EINVAL;
+		}
 	}
 
-	hdr = &proto_hdrs->proto_hdr[proto_hdrs->count++];
-	switch (packet_hdrs & IAVF_ADV_RSS_FLOW_SEG_HDR_L4) {
-	case IAVF_ADV_RSS_FLOW_SEG_HDR_TCP:
-		iavf_fill_adv_rss_tcp_hdr(hdr, hash_flds);
-		break;
-	case IAVF_ADV_RSS_FLOW_SEG_HDR_UDP:
-		iavf_fill_adv_rss_udp_hdr(hdr, hash_flds);
-		break;
-	case IAVF_ADV_RSS_FLOW_SEG_HDR_SCTP:
-		iavf_fill_adv_rss_sctp_hdr(hdr, hash_flds);
-		break;
-	default:
-		return -EINVAL;
+	if (packet_l4_hdrs) {
+		hdr = &proto_hdrs->proto_hdr[proto_hdrs->count++];
+		switch (packet_l4_hdrs) {
+		case IAVF_ADV_RSS_FLOW_SEG_HDR_TCP:
+			iavf_fill_adv_rss_tcp_hdr(hdr, hash_flds);
+			break;
+		case IAVF_ADV_RSS_FLOW_SEG_HDR_UDP:
+			iavf_fill_adv_rss_udp_hdr(hdr, hash_flds);
+			break;
+		case IAVF_ADV_RSS_FLOW_SEG_HDR_SCTP:
+			iavf_fill_adv_rss_sctp_hdr(hdr, hash_flds);
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	if (packet_hdrs & IAVF_ADV_RSS_FLOW_SEG_HDR_GTP) {
+		hdr = &proto_hdrs->proto_hdr[proto_hdrs->count++];
+		if (iavf_fill_adv_rss_gtp_hdr(proto_hdrs, packet_hdrs, hash_flds))
+			return -EINVAL;
 	}
 
 	return 0;
@@ -186,6 +247,8 @@ iavf_print_adv_rss_cfg(struct iavf_adapter *adapter, struct iavf_adv_rss *rss,
 		proto = "UDP";
 	else if (packet_hdrs & IAVF_ADV_RSS_FLOW_SEG_HDR_SCTP)
 		proto = "SCTP";
+	else if (packet_hdrs & IAVF_ADV_RSS_FLOW_SEG_HDR_GTP)
+		proto = "GTP";
 	else
 		return;
 
@@ -211,6 +274,16 @@ iavf_print_adv_rss_cfg(struct iavf_adapter *adapter, struct iavf_adv_rss *rss,
 			 IAVF_ADV_RSS_HASH_FLD_UDP_DST_PORT |
 			 IAVF_ADV_RSS_HASH_FLD_SCTP_DST_PORT))
 		strcat(hash_opt, "dst port,");
+	if (hash_flds & IAVF_ADV_RSS_HASH_FLD_GTPC_TEID)
+		strcat(hash_opt, "gtp-c,");
+	if (hash_flds & IAVF_ADV_RSS_HASH_FLD_GTPU_IP_TEID)
+		strcat(hash_opt, "gtp-u ip,");
+	if (hash_flds & IAVF_ADV_RSS_HASH_FLD_GTPU_EH_TEID)
+		strcat(hash_opt, "gtp-u ext,");
+	if (hash_flds & IAVF_ADV_RSS_HASH_FLD_GTPU_UP_TEID)
+		strcat(hash_opt, "gtp-u ul,");
+	if (hash_flds & IAVF_ADV_RSS_HASH_FLD_GTPU_DWN_TEID)
+		strcat(hash_opt, "gtp-u dl,");
 
 	if (!action)
 		action = "";
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 05d72be3fe80..a3f8ced23266 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1336,6 +1336,56 @@ static u32 iavf_adv_rss_parse_hdrs(const struct ethtool_rxfh_fields *cmd)
 		hdrs |= IAVF_ADV_RSS_FLOW_SEG_HDR_SCTP |
 			IAVF_ADV_RSS_FLOW_SEG_HDR_IPV6;
 		break;
+	case GTPU_V4_FLOW:
+		hdrs |= IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_IP |
+			IAVF_ADV_RSS_FLOW_SEG_HDR_IPV4;
+		break;
+	case GTPC_V4_FLOW:
+		hdrs |= IAVF_ADV_RSS_FLOW_SEG_HDR_GTPC |
+			IAVF_ADV_RSS_FLOW_SEG_HDR_UDP |
+			IAVF_ADV_RSS_FLOW_SEG_HDR_IPV4;
+		break;
+	case GTPC_TEID_V4_FLOW:
+		hdrs |= IAVF_ADV_RSS_FLOW_SEG_HDR_GTPC_TEID |
+			IAVF_ADV_RSS_FLOW_SEG_HDR_UDP |
+			IAVF_ADV_RSS_FLOW_SEG_HDR_IPV4;
+		break;
+	case GTPU_EH_V4_FLOW:
+		hdrs |= IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_EH |
+			IAVF_ADV_RSS_FLOW_SEG_HDR_IPV4;
+		break;
+	case GTPU_UL_V4_FLOW:
+		hdrs |= IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_UP |
+			IAVF_ADV_RSS_FLOW_SEG_HDR_IPV4;
+		break;
+	case GTPU_DL_V4_FLOW:
+		hdrs |= IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_DWN |
+			IAVF_ADV_RSS_FLOW_SEG_HDR_IPV4;
+		break;
+	case GTPU_V6_FLOW:
+		hdrs |= IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_IP |
+			IAVF_ADV_RSS_FLOW_SEG_HDR_IPV6;
+		break;
+	case GTPC_V6_FLOW:
+		hdrs |= IAVF_ADV_RSS_FLOW_SEG_HDR_GTPC |
+			IAVF_ADV_RSS_FLOW_SEG_HDR_IPV6;
+		break;
+	case GTPC_TEID_V6_FLOW:
+		hdrs |= IAVF_ADV_RSS_FLOW_SEG_HDR_GTPC_TEID |
+			IAVF_ADV_RSS_FLOW_SEG_HDR_IPV6;
+		break;
+	case GTPU_EH_V6_FLOW:
+		hdrs |= IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_EH |
+			IAVF_ADV_RSS_FLOW_SEG_HDR_IPV6;
+		break;
+	case GTPU_UL_V6_FLOW:
+		hdrs |= IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_UP |
+			IAVF_ADV_RSS_FLOW_SEG_HDR_IPV6;
+		break;
+	case GTPU_DL_V6_FLOW:
+		hdrs |= IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_DWN |
+			IAVF_ADV_RSS_FLOW_SEG_HDR_IPV6;
+		break;
 	default:
 		break;
 	}
@@ -1353,6 +1403,12 @@ iavf_adv_rss_parse_hash_flds(const struct ethtool_rxfh_fields *cmd, bool symm)
 		case TCP_V4_FLOW:
 		case UDP_V4_FLOW:
 		case SCTP_V4_FLOW:
+		case GTPU_V4_FLOW:
+		case GTPC_V4_FLOW:
+		case GTPC_TEID_V4_FLOW:
+		case GTPU_EH_V4_FLOW:
+		case GTPU_UL_V4_FLOW:
+		case GTPU_DL_V4_FLOW:
 			if (cmd->data & RXH_IP_SRC)
 				hfld |= IAVF_ADV_RSS_HASH_FLD_IPV4_SA;
 			if (cmd->data & RXH_IP_DST)
@@ -1361,6 +1417,12 @@ iavf_adv_rss_parse_hash_flds(const struct ethtool_rxfh_fields *cmd, bool symm)
 		case TCP_V6_FLOW:
 		case UDP_V6_FLOW:
 		case SCTP_V6_FLOW:
+		case GTPU_V6_FLOW:
+		case GTPC_V6_FLOW:
+		case GTPC_TEID_V6_FLOW:
+		case GTPU_EH_V6_FLOW:
+		case GTPU_UL_V6_FLOW:
+		case GTPU_DL_V6_FLOW:
 			if (cmd->data & RXH_IP_SRC)
 				hfld |= IAVF_ADV_RSS_HASH_FLD_IPV6_SA;
 			if (cmd->data & RXH_IP_DST)
@@ -1382,6 +1444,7 @@ iavf_adv_rss_parse_hash_flds(const struct ethtool_rxfh_fields *cmd, bool symm)
 			break;
 		case UDP_V4_FLOW:
 		case UDP_V6_FLOW:
+		case GTPC_V4_FLOW:
 			if (cmd->data & RXH_L4_B_0_1)
 				hfld |= IAVF_ADV_RSS_HASH_FLD_UDP_SRC_PORT;
 			if (cmd->data & RXH_L4_B_2_3)
@@ -1398,6 +1461,32 @@ iavf_adv_rss_parse_hash_flds(const struct ethtool_rxfh_fields *cmd, bool symm)
 			break;
 		}
 	}
+	if (cmd->data & RXH_GTP_TEID) {
+		switch (cmd->flow_type) {
+		case GTPC_TEID_V4_FLOW:
+		case GTPC_TEID_V6_FLOW:
+			hfld |= IAVF_ADV_RSS_HASH_FLD_GTPC_TEID;
+			break;
+		case GTPU_V4_FLOW:
+		case GTPU_V6_FLOW:
+			hfld |= IAVF_ADV_RSS_HASH_FLD_GTPU_IP_TEID;
+			break;
+		case GTPU_EH_V4_FLOW:
+		case GTPU_EH_V6_FLOW:
+			hfld |= IAVF_ADV_RSS_HASH_FLD_GTPU_EH_TEID;
+			break;
+		case GTPU_UL_V4_FLOW:
+		case GTPU_UL_V6_FLOW:
+			hfld |= IAVF_ADV_RSS_HASH_FLD_GTPU_UP_TEID;
+			break;
+		case GTPU_DL_V4_FLOW:
+		case GTPU_DL_V6_FLOW:
+			hfld |= IAVF_ADV_RSS_HASH_FLD_GTPU_DWN_TEID;
+			break;
+		default:
+			break;
+		}
+	}
 
 	return hfld;
 }

-- 
2.51.0.rc1.197.g6d975e95c9d7


