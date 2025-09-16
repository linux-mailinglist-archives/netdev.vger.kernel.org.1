Return-Path: <netdev+bounces-223527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C21B5966C
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3687A4E4FA1
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F35313267;
	Tue, 16 Sep 2025 12:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gockighc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC91312803;
	Tue, 16 Sep 2025 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758026607; cv=none; b=P1dR3NMkpJ/kznK/AvVMfV+ikY+fOv6goyWSwR4a5Vw/aSbGZTNg7v325SycHc5kg5ZEpTYQz69S6N2V57vm4bFJ9IpIPb0RIx3F6kOnGyYfjke6pjE0JZ1/P1+aN0T0rJMF2O31/2RXIPZbIBAVgX1P2ngDMwt2DxT6KHycg2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758026607; c=relaxed/simple;
	bh=UBeaTW5bPgKgCAO9klClr9Ovr3SEB93RRpqtB4yjVRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a99FkHoW/u5tNwPlfmnUrqKdyoJI0376qR5x6T5dVte1JB+I0UX1awgrVo3+VVxknunw4PE8eAg8vkj3oSjTHOEHNajPMXwTQPYsGczp9NvSc2TQEs8S1vj0KefDkITEDP0ium1IPp59nQNPQveeA8fE7zQYOzUbr11569ebLrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gockighc; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758026606; x=1789562606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UBeaTW5bPgKgCAO9klClr9Ovr3SEB93RRpqtB4yjVRA=;
  b=gockighckGQa46zUxAHdMOPszgta1Avh0pLeG9Yahmt/o4KFWMrxW277
   RgIaymePREtSLWe/BCUr76+X/xJo6bduS9GfIr3mWiKu7dD/miLEhF4OI
   LDR+Zn1KMfH7BYkMR9PKMtcXcg6+plG4anreTLH9yxEqkGh74ZOIJhziw
   VZY73MG/5DQR2EweULvZlXmjfhNSIiMw2CNH5DH/Q6A0lQLm+LDlcIrMl
   UEoW5930vcn23cOVXM93fTdVkoauZykqI07r0NhkWkrmUdXG7eP3Oeuwg
   LdwMtmuUqw1c9qTONTgjYEO6EnWvhLnS4fB5FqPfKkzcexezogEKcYliG
   g==;
X-CSE-ConnectionGUID: IWtEQECOQN6MOlLXY6R66g==
X-CSE-MsgGUID: whqci1nvRCKslJoY9ZWSeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="85742011"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="85742011"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 05:43:26 -0700
X-CSE-ConnectionGUID: 1I3pkkqbR1KtjIWI0Xbl7w==
X-CSE-MsgGUID: Bhr4bVh4QiOryoEics6rsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174043173"
Received: from gklab-kleszczy-dev.igk.intel.com ([10.102.25.215])
  by orviesa006.jf.intel.com with ESMTP; 16 Sep 2025 05:43:23 -0700
From: Konrad Leszczynski <konrad.leszczynski@intel.com>
To: davem@davemloft.net,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cezary.rojewski@intel.com,
	sebastian.basierski@intel.com,
	Karol Jurczenia <karol.jurczenia@intel.com>,
	Konrad Leszczynski <konrad.leszczynski@intel.com>
Subject: [PATCH net-next v3 2/3] net: stmmac: add TC flower filter support for IP EtherType
Date: Tue, 16 Sep 2025 14:48:07 +0200
Message-Id: <20250916124808.218514-3-konrad.leszczynski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916124808.218514-1-konrad.leszczynski@intel.com>
References: <20250916124808.218514-1-konrad.leszczynski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Jurczenia <karol.jurczenia@intel.com>

Add missing Traffic Control (TC) offload for flower filters matching the
IP EtherType (ETH_P_IP).

Reviewed-by: Konrad Leszczynski <konrad.leszczynski@intel.com>
Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Karol Jurczenia <karol.jurczenia@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 78d6b3737a26..77f900a328aa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -206,6 +206,7 @@ enum stmmac_rfs_type {
 	STMMAC_RFS_T_VLAN,
 	STMMAC_RFS_T_LLDP,
 	STMMAC_RFS_T_1588,
+	STMMAC_RFS_T_IP,
 	STMMAC_RFS_T_MAX,
 };
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 694d6ee14381..c5577652d6ed 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -239,6 +239,7 @@ static int tc_rfs_init(struct stmmac_priv *priv)
 	priv->rfs_entries_max[STMMAC_RFS_T_VLAN] = 8;
 	priv->rfs_entries_max[STMMAC_RFS_T_LLDP] = 1;
 	priv->rfs_entries_max[STMMAC_RFS_T_1588] = 1;
+	priv->rfs_entries_max[STMMAC_RFS_T_IP] = 32;
 
 	for (i = 0; i < STMMAC_RFS_T_MAX; i++)
 		priv->rfs_entries_total += priv->rfs_entries_max[i];
@@ -777,6 +778,17 @@ static int tc_add_ethtype_flow(struct stmmac_priv *priv,
 			stmmac_rx_queue_routing(priv, priv->hw,
 						PACKET_PTPQ, tc);
 			break;
+		case ETH_P_IP:
+			if (priv->rfs_entries_cnt[STMMAC_RFS_T_IP] >=
+			    priv->rfs_entries_max[STMMAC_RFS_T_IP])
+				return -ENOENT;
+
+			entry->type = STMMAC_RFS_T_IP;
+			priv->rfs_entries_cnt[STMMAC_RFS_T_IP]++;
+
+			stmmac_rx_queue_routing(priv, priv->hw,
+						PACKET_UPQ, tc);
+			break;
 		default:
 			netdev_err(priv->dev, "EthType(0x%x) is not supported", etype);
 			return -EINVAL;
@@ -800,7 +812,7 @@ static int tc_del_ethtype_flow(struct stmmac_priv *priv,
 
 	if (!entry || !entry->in_use ||
 	    entry->type < STMMAC_RFS_T_LLDP ||
-	    entry->type > STMMAC_RFS_T_1588)
+	    entry->type > STMMAC_RFS_T_IP)
 		return -ENOENT;
 
 	switch (entry->etype) {
@@ -814,6 +826,11 @@ static int tc_del_ethtype_flow(struct stmmac_priv *priv,
 					PACKET_PTPQ, 0);
 		priv->rfs_entries_cnt[STMMAC_RFS_T_1588]--;
 		break;
+	case ETH_P_IP:
+		stmmac_rx_queue_routing(priv, priv->hw,
+					PACKET_UPQ, 0);
+		priv->rfs_entries_cnt[STMMAC_RFS_T_IP]--;
+		break;
 	default:
 		netdev_err(priv->dev, "EthType(0x%x) is not supported",
 			   entry->etype);
-- 
2.34.1


