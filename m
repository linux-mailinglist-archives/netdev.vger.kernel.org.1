Return-Path: <netdev+bounces-114119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 360D4941002
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 12:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DABA5281A88
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA16199230;
	Tue, 30 Jul 2024 10:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YiuQVd1Z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84796198856
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 10:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722336839; cv=none; b=tW+d9S5wLCigRH+s2wdIt1vCR7GxBevciLXpnI3HmLjjL8v8LRxdCJ3WY3h5QMeE7lqq508ULbzBgl5sX/KLXCEqvbxMlh6W1AtjmMlftv07lIlKy9ajfGjfSYrASdeAAIXVSrZ4WBPBdnDXpA6EhJEA7wEorZFy4O6e3CfbTHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722336839; c=relaxed/simple;
	bh=DVoHzPv9R/nXXO4kDVtIzZteJNPXteOZzO4wmWbPsO8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=peKhBBNoZN0Kp70RCspLv07DBD5GBbjfouTuUcvG5/K9CkTKSj0RZPLLk6j+o5Qo8GLwHqUCVWoexHiEWD1NqkRBP1+/74puSDTt1c5jO6ESuNk9PygWgTXaXC0LXs2Go8X3FgyKx2bFs5LbSKLirxF0dRHtRkKL/hp6tcqRRgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YiuQVd1Z; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722336837; x=1753872837;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DVoHzPv9R/nXXO4kDVtIzZteJNPXteOZzO4wmWbPsO8=;
  b=YiuQVd1ZymJ+fk3PJAcTR/E4usIuymTlelQr7eKgyERgC5D4JG5fldYN
   /1oVd3rYGRfLy2s/PX1CD+GdzcEbDoF5UuCc6JZOBu5Dbt7KqtsDudaci
   sWxjvuV3kkJt2x+Ww0zeM62JMLrQkqJ286CYlJ1y9Y8I6CprAuyZRr8Vg
   i8yPq116uaEnP1UYekPU59lDDHfPSRX98moWVz7msEv4SpoVzlvMpiXx4
   eWlkz0hLaZupvgbgLaa/RkLVACEWt2oxPGq/PVjEDEnHjnawa1qM+wLwQ
   DGkJZBh2m3p/vd60dKqKpiM+isMTPRqyPqc+LAeYbavbjU1MLDAikbDPn
   g==;
X-CSE-ConnectionGUID: Mpur3vudT0qFDWxoOYIN4w==
X-CSE-MsgGUID: tREh6PJVRhOAsFzTY9pluQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="24008880"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="24008880"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 03:53:56 -0700
X-CSE-ConnectionGUID: U+YjfOn3TZWfD4vHXFMS+w==
X-CSE-MsgGUID: 8pifwwIhSkmz5t0grano6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="84945670"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa002.jf.intel.com with ESMTP; 30 Jul 2024 03:53:54 -0700
Received: from rozewie.igk.intel.com (rozewie.igk.intel.com [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id C5EB828779;
	Tue, 30 Jul 2024 11:53:52 +0100 (IST)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	simon.horman@corigine.com,
	anthony.l.nguyen@intel.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH iwl-next] ice: Implement ethtool reset support
Date: Tue, 30 Jul 2024 12:51:21 +0200
Message-Id: <20240730105121.78985-1-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable ethtool reset support. Each ethtool reset
type is mapped to the CVL reset type:
ETH_RESET_MAC - ICE_RESET_CORER
ETH_RESET_ALL - ICE_RESET_GLOBR
ETH_RESET_DEDICATED - ICE_RESET_PFR

Multiple reset flags are not supported.
Calling any reset type on port representor triggers VF reset.

Command example:
GLOBR:
$ ethtool --reset enp1s0f0np0 all
CORER:
$ ethtool --reset enp1s0f0np0 mac
PFR:
$ ethtool --reset enp1s0f0np0 dedicated
VF reset:
$ ethtool --reset $port_representor mac

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 64 ++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 39d2652c3ee1..00b8ac3f1dff 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -4794,6 +4794,68 @@ static void ice_get_ts_stats(struct net_device *netdev,
 	ts_stats->lost = ptp->tx_hwtstamp_timeouts;
 }
 
+/**
+ * ice_ethtool_reset - triggers a given type of reset
+ * @dev: network interface device structure
+ * @flags: set of reset flags
+ *
+ * Note that multiple reset flags are not supported
+ */
+static int ice_ethtool_reset(struct net_device *dev, u32 *flags)
+{
+	struct ice_netdev_priv *np = netdev_priv(dev);
+	struct ice_pf *pf = np->vsi->back;
+	enum ice_reset_req reset;
+
+	switch (*flags) {
+	case ETH_RESET_MAC:
+		*flags &= ~ETH_RESET_MAC;
+		reset = ICE_RESET_CORER;
+		break;
+	case ETH_RESET_ALL:
+		*flags &= ~ETH_RESET_ALL;
+		reset = ICE_RESET_GLOBR;
+		break;
+	case ETH_RESET_DEDICATED:
+		*flags &= ~ETH_RESET_DEDICATED;
+		reset = ICE_RESET_PFR;
+		break;
+	default:
+		netdev_info(dev, "Unsupported set of ethtool flags, multiple flags are not supported");
+		return -EOPNOTSUPP;
+	}
+
+	ice_schedule_reset(pf, reset);
+
+	return 0;
+}
+
+/**
+ * ice_repr_ethtool_reset - triggers a VF reset
+ * @dev: network interface device structure
+ * @flags: set of reset flags
+ *
+ * VF associated with the given port representor will be reset
+ * Any type of reset will trigger VF reset
+ */
+static int ice_repr_ethtool_reset(struct net_device *dev, u32 *flags)
+{
+	struct ice_repr *repr = ice_netdev_to_repr(dev);
+	struct ice_vf *vf;
+
+	if (repr->type != ICE_REPR_TYPE_VF)
+		return -EOPNOTSUPP;
+
+	vf = repr->vf;
+
+	if (ice_check_vf_ready_for_cfg(vf))
+		return -EBUSY;
+
+	*flags = 0;
+
+	return ice_reset_vf(vf, ICE_VF_RESET_VFLR | ICE_VF_RESET_LOCK);
+}
+
 static const struct ethtool_ops ice_ethtool_ops = {
 	.cap_rss_ctx_supported  = true,
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
@@ -4829,6 +4891,7 @@ static const struct ethtool_ops ice_ethtool_ops = {
 	.nway_reset		= ice_nway_reset,
 	.get_pauseparam		= ice_get_pauseparam,
 	.set_pauseparam		= ice_set_pauseparam,
+	.reset			= ice_ethtool_reset,
 	.get_rxfh_key_size	= ice_get_rxfh_key_size,
 	.get_rxfh_indir_size	= ice_get_rxfh_indir_size,
 	.get_rxfh		= ice_get_rxfh,
@@ -4885,6 +4948,7 @@ static const struct ethtool_ops ice_ethtool_repr_ops = {
 	.get_strings		= ice_repr_get_strings,
 	.get_ethtool_stats      = ice_repr_get_ethtool_stats,
 	.get_sset_count		= ice_repr_get_sset_count,
+	.reset			= ice_repr_ethtool_reset,
 };
 
 /**
-- 
2.40.1


