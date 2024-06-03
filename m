Return-Path: <netdev+bounces-100390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C5C8FA5D1
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 00:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 196691C23D33
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 22:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A589F13FD6A;
	Mon,  3 Jun 2024 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ghJ6udum"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC71513E03E
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454305; cv=none; b=EXKl2Z4lA3/N9b/5XAjCTxluQ6v8Ehey9LekSuyBBy5JDBhdiHZOnjbKUrmBaxa6v+QcEy6K0HOTLv0s1wdD/4TIr0P+4PAzFVxV2cdSdUou2wEMO+ORG9xODDMTwV+RkhHPJupHweaFndNkMDuQlvJ2t8CrWmp/k+MCBJzELbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454305; c=relaxed/simple;
	bh=eaAmhLuouq2E/NfXqCshM6878WjbMqTcwMma2+5nw70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VJqSXCIugzVaK03sjdEGOaCF2c2zxb0JdDFRRTfUoGw0CSeMFnCL4CI030APra6djSSdRqmWYPi6Dc4rTLFzdIPIoCvxd4wWKtEJ39GyRWdQQPMFZQ3p8H8+UWSzX1jYK8IfzTPy2OCYgkGKrX4RYfmPYV8PHDSAjlmKTdBbQZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ghJ6udum; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717454304; x=1748990304;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=eaAmhLuouq2E/NfXqCshM6878WjbMqTcwMma2+5nw70=;
  b=ghJ6udumyuDdpVIOsEy8XOYOys3gvJSjAvgI1k579WYoqrGsGqhNG4nc
   UsAvtqYfptWKIwsfviW886mqOPPThkDBKmdgZS3Ib6EqJk+h9uxxz9vqP
   QI1T5J7e4J1zkmfIeP3P9iIiVDwO8QwAoSDwPNMxvm68rmC4f4KtKWnh4
   mUgaLmtBD3Pf0kvwbG0IScIF+73YVUcmRmruEn/neywtwmx/FEv++ZamY
   omLwPMExK1/Sv2BXXexenGgyQxXOc4TAhmLQaR18IvUmK9+8SZpelBpOc
   TucxL/Nv85teCcToS/PWBD4Y2ZBBq8dXv06dmkNMZUka6PBOFcf9LShoG
   w==;
X-CSE-ConnectionGUID: C4PycqwlSd24phLnKiRPWQ==
X-CSE-MsgGUID: mrD+6UbISACWm20nrck9pw==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="13780107"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="13780107"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 15:38:21 -0700
X-CSE-ConnectionGUID: G/JpgBfuRBCYQpPyw/3ZiA==
X-CSE-MsgGUID: X2lB2OicQH2DsUynn6K5BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="41471177"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 15:38:21 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 03 Jun 2024 15:38:14 -0700
Subject: [PATCH 2/9] ice: store representor ID in bridge port
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-next-2024-06-03-intel-next-batch-v1-2-e0523b28f325@intel.com>
References: <20240603-next-2024-06-03-intel-next-batch-v1-0-e0523b28f325@intel.com>
In-Reply-To: <20240603-next-2024-06-03-intel-next-batch-v1-0-e0523b28f325@intel.com>
To: David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Wojciech Drewek <wojciech.drewek@intel.com>, 
 Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>, 
 Jiri Pirko <jiri@resnulli.us>
X-Mailer: b4 0.13.0

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

It is used to get representor structure during cleaning.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch_br.c | 4 +++-
 drivers/net/ethernet/intel/ice/ice_eswitch_br.h | 1 +
 drivers/net/ethernet/intel/ice/ice_repr.c       | 7 ++-----
 drivers/net/ethernet/intel/ice/ice_repr.h       | 1 +
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
index ac5beecd028b..f5aceb32bf4d 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
@@ -896,7 +896,8 @@ ice_eswitch_br_port_deinit(struct ice_esw_br *bridge,
 	if (br_port->type == ICE_ESWITCH_BR_UPLINK_PORT && vsi->back) {
 		vsi->back->br_port = NULL;
 	} else {
-		struct ice_repr *repr = ice_repr_get_by_vsi(vsi);
+		struct ice_repr *repr =
+			ice_repr_get(vsi->back, br_port->repr_id);
 
 		if (repr)
 			repr->br_port = NULL;
@@ -937,6 +938,7 @@ ice_eswitch_br_vf_repr_port_init(struct ice_esw_br *bridge,
 	br_port->vsi = repr->src_vsi;
 	br_port->vsi_idx = br_port->vsi->idx;
 	br_port->type = ICE_ESWITCH_BR_VF_REPR_PORT;
+	br_port->repr_id = repr->id;
 	repr->br_port = br_port;
 
 	err = xa_insert(&bridge->ports, br_port->vsi_idx, br_port, GFP_KERNEL);
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.h b/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
index 85a8fadb2928..c15c7344d7f8 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
@@ -46,6 +46,7 @@ struct ice_esw_br_port {
 	enum ice_esw_br_port_type type;
 	u16 vsi_idx;
 	u16 pvid;
+	u32 repr_id;
 	struct xarray vlans;
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index d367f4c66dcd..fe83f305cc7d 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -415,12 +415,9 @@ struct ice_repr *ice_repr_add_vf(struct ice_vf *vf)
 	return ERR_PTR(err);
 }
 
-struct ice_repr *ice_repr_get_by_vsi(struct ice_vsi *vsi)
+struct ice_repr *ice_repr_get(struct ice_pf *pf, u32 id)
 {
-	if (!vsi->vf)
-		return NULL;
-
-	return xa_load(&vsi->back->eswitch.reprs, vsi->vf->repr_id);
+	return xa_load(&pf->eswitch.reprs, id);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.h b/drivers/net/ethernet/intel/ice/ice_repr.h
index cff730b15ca0..07842620d7a2 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.h
+++ b/drivers/net/ethernet/intel/ice/ice_repr.h
@@ -40,4 +40,5 @@ struct ice_repr *ice_repr_get_by_vsi(struct ice_vsi *vsi);
 void ice_repr_inc_tx_stats(struct ice_repr *repr, unsigned int len,
 			   int xmit_status);
 void ice_repr_inc_rx_stats(struct net_device *netdev, unsigned int len);
+struct ice_repr *ice_repr_get(struct ice_pf *pf, u32 id);
 #endif

-- 
2.44.0.53.g0f9d4d28b7e6


