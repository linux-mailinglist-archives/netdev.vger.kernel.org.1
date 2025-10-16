Return-Path: <netdev+bounces-229889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BE0BE1D28
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 08:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B49B6351EED
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 06:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FD82F1FE8;
	Thu, 16 Oct 2025 06:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PQEqKfXR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1AA2F1FDB
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 06:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760597651; cv=none; b=ok8GWNuhpBuRcqo9I5q9fswSX4hq5ogCv929IIiCiqTK4hLc4EG65Ed7uZMiCERW0OB80C1GGScoTKoS39UHyiKgIzOBA1eD9fqfwMqQp7dVbW69cLdHeY28on0OJzdtcONA25+0Rinp/kDAb5Ao0huJFGrbz6u/UFPes2k0mV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760597651; c=relaxed/simple;
	bh=y9g7++ThMeSMQPh1ylrPaNSSi2JtgH52izVD4ZWgxXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WxRAPDVbDLh8wb8TKtH3okCyvMSru+atxOqJu/8NqD4gRVc7ONUeub97rl0f4M8/Dmll8p7IL+7mee1lOlf5lHMIbCy+laJcf3Lj3fXo7yO4Uz6FbtcO4HwD5meMJLZAk9SBZYtSCnVfWf/UH8I8J4rJt2wMo/EXjduUbzGweNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PQEqKfXR; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760597649; x=1792133649;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y9g7++ThMeSMQPh1ylrPaNSSi2JtgH52izVD4ZWgxXk=;
  b=PQEqKfXRu3hGcUI3YUYnCaLte8mD36rTsUyff9Y4lePB/rBpkbBa4p7u
   YubSLyumijUxY13eE018wp+gpHCIaP1HyPnGJi72THAMT0+4iOIgh/Xsj
   r2gF7bnhqhhe9TIy7ifUQ0xe/uZNDDZ6NSLRaeYesPnVKhUSfLV5PbMSz
   x7QcCP6V9C6Q3E7Kz/wmYjYNtyJLDpnOlyaa2DN3rJqV+PoRzIgOPyote
   HZut19xdwntnOxBXq4BWjMtkiwyerQNED3unM400jXeZrnj1200huTAN5
   E5rq7jP4E3Y1XkEAH8B4hqOcLKCXiuwYXPTS80lFdgD+Q7P8I9/tCA2u7
   Q==;
X-CSE-ConnectionGUID: ZCSr+9XaTcuW+wy4c7q2GQ==
X-CSE-MsgGUID: WffLNjaqQTyRtRlb7ozSMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="62492419"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="62492419"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 23:54:06 -0700
X-CSE-ConnectionGUID: I6iY64mQTWC/a991+Jt4HQ==
X-CSE-MsgGUID: 8onTWFUhRnez5NMIY1Nqsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="181582344"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by orviesa010.jf.intel.com with ESMTP; 15 Oct 2025 23:54:05 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-next v1] ice: lower default irq/queue counts on high-core systems
Date: Thu, 16 Oct 2025 08:22:50 +0200
Message-ID: <20251016062250.1461903-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some high-core systems loading ice driver with default values can
lead to queue/irq exhaustion. It will result in no additional resources
for SR-IOV.

In most cases there is no performance reason for more than 64 queues.
Limit the default value to 64. Still, using ethtool the number of
queues can be changed up to num_online_cpus().

This change affects only the default queue amount on systems with more
than 64 cores.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h     | 20 ++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_irq.c |  6 ++++--
 drivers/net/ethernet/intel/ice/ice_lib.c |  8 ++++----
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 3d4d8b88631b..354ec2950ff3 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -1133,4 +1133,24 @@ static inline struct ice_hw *ice_get_primary_hw(struct ice_pf *pf)
 	else
 		return &pf->adapter->ctrl_pf->hw;
 }
+
+/**
+ * ice_capped_num_cpus - normalize the number of CPUs to a reasonable limit
+ *
+ * This function returns the number of online CPUs, but caps it at suitable
+ * default to prevent excessive resource allocation on systems with very high
+ * CPU counts.
+ *
+ * Note: suitable default is currently at 64, which is reflected in default_cpus
+ * constant. In most cases there is no much benefit for more than 64 and it is a
+ * power of 2 number.
+ *
+ * Return: number of online CPUs, capped at suitable default.
+ */
+static inline u16 ice_capped_num_cpus(void)
+{
+	const int default_cpus = 64;
+
+	return min(num_online_cpus(), default_cpus);
+}
 #endif /* _ICE_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_irq.c b/drivers/net/ethernet/intel/ice/ice_irq.c
index 30801fd375f0..df4d847ca858 100644
--- a/drivers/net/ethernet/intel/ice/ice_irq.c
+++ b/drivers/net/ethernet/intel/ice/ice_irq.c
@@ -106,9 +106,11 @@ static struct ice_irq_entry *ice_get_irq_res(struct ice_pf *pf,
 #define ICE_RDMA_AEQ_MSIX 1
 static int ice_get_default_msix_amount(struct ice_pf *pf)
 {
-	return ICE_MIN_LAN_OICR_MSIX + num_online_cpus() +
+	u16 cpus = ice_capped_num_cpus();
+
+	return ICE_MIN_LAN_OICR_MSIX + cpus +
 	       (test_bit(ICE_FLAG_FD_ENA, pf->flags) ? ICE_FDIR_MSIX : 0) +
-	       (ice_is_rdma_ena(pf) ? num_online_cpus() + ICE_RDMA_AEQ_MSIX : 0);
+	       (ice_is_rdma_ena(pf) ? cpus + ICE_RDMA_AEQ_MSIX : 0);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index bac481e8140d..3c5f8a4b6c6d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -159,12 +159,12 @@ static void ice_vsi_set_num_desc(struct ice_vsi *vsi)
 
 static u16 ice_get_rxq_count(struct ice_pf *pf)
 {
-	return min(ice_get_avail_rxq_count(pf), num_online_cpus());
+	return min(ice_get_avail_rxq_count(pf), ice_capped_num_cpus());
 }
 
 static u16 ice_get_txq_count(struct ice_pf *pf)
 {
-	return min(ice_get_avail_txq_count(pf), num_online_cpus());
+	return min(ice_get_avail_txq_count(pf), ice_capped_num_cpus());
 }
 
 /**
@@ -907,13 +907,13 @@ static void ice_vsi_set_rss_params(struct ice_vsi *vsi)
 		if (vsi->type == ICE_VSI_CHNL)
 			vsi->rss_size = min_t(u16, vsi->num_rxq, max_rss_size);
 		else
-			vsi->rss_size = min_t(u16, num_online_cpus(),
+			vsi->rss_size = min_t(u16, ice_capped_num_cpus(),
 					      max_rss_size);
 		vsi->rss_lut_type = ICE_LUT_PF;
 		break;
 	case ICE_VSI_SF:
 		vsi->rss_table_size = ICE_LUT_VSI_SIZE;
-		vsi->rss_size = min_t(u16, num_online_cpus(), max_rss_size);
+		vsi->rss_size = min_t(u16, ice_capped_num_cpus(), max_rss_size);
 		vsi->rss_lut_type = ICE_LUT_VSI;
 		break;
 	case ICE_VSI_VF:
-- 
2.49.0


