Return-Path: <netdev+bounces-101150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F34AA8FD7AE
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 22:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F309286155
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 20:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797F215F3F8;
	Wed,  5 Jun 2024 20:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ALvo6N1+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE36A15F31F
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 20:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717620049; cv=none; b=HNTAVQVOSaZ6fjfuHaA/EKjLgXYO8VFPX9tAXBGK/f/u7LpsiCrt3Lccor39YvIR5yrWUq3ObYYgTOiAFnivfXmUa/c1q8u4vv0gFp6UlP6/c9m+DH0sODkweDE6vmL2L1Goi/D/fyX03ECj8Z5C6o9SN/SE2eygFT7/B7sOUrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717620049; c=relaxed/simple;
	bh=HBNR2tu6ZMc3N1OCuLgchIQjBgvKbqa3ViBchqerzJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NuNr3t44pEF8WGadfvzQUCBisAoWdw3vZTmcHAbFgGDz6kV6B+EDW1LeFL4eSnEUR6sFMh5nBugcpnhu/auyTGMWPLdfXa+8MPYRifrt4W0gz9JrfwODuZujL6DfPgZJ2Xxq8M+Rki2Ghv0axoIzMAWHmaCrbruXzGhS1hPfRu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ALvo6N1+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717620048; x=1749156048;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=HBNR2tu6ZMc3N1OCuLgchIQjBgvKbqa3ViBchqerzJw=;
  b=ALvo6N1+GZe/Xl9RpMvsGkT1RXNrPo/B16ysJN/FIofNLNSK8spwAGx3
   na6Y7CZW4QD4CGudbLDtdZCceEKTgMFW4kBZmVcHB+YnusUaFoO/wGq6a
   Ini4CGA8n9o8czhrLgHLEC57uq6M2pG+9Gr54qep7mBDiCSSi2Oms7H50
   +HA9PdqBgvGtW7SLwUASpq/v0vsyqxh0u2MF8efn1Ue6pyibfk0aC8HSH
   Sz46E4rwcXYrm/lrBuNtOsfLstN5nBNnxWWozv07OqHxYpRlZZ7cJm9xo
   nZ2NdOlhBDSDPlXl085VXPABQqjNVlaZjgaGx/xFYpEN2i9Styykkn5TA
   Q==;
X-CSE-ConnectionGUID: tvsVVvzGT9KQP11WmYGsQg==
X-CSE-MsgGUID: qZ/ai90aRfeLH86vWAx7ZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="18103043"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="18103043"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 13:40:45 -0700
X-CSE-ConnectionGUID: FxE5SYc+Q0eFmg3CYwNDbw==
X-CSE-MsgGUID: VksdxzpYTXmWsHrjMNylRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="37824313"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 13:40:45 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 05 Jun 2024 13:40:43 -0700
Subject: [PATCH v2 3/7] ice: move devlink locking outside the port creation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-next-2024-06-03-intel-next-batch-v2-3-39c23963fa78@intel.com>
References: <20240605-next-2024-06-03-intel-next-batch-v2-0-39c23963fa78@intel.com>
In-Reply-To: <20240605-next-2024-06-03-intel-next-batch-v2-0-39c23963fa78@intel.com>
To: netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>, 
 Jiri Pirko <jiri@resnulli.us>
X-Mailer: b4 0.13.0

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

In case of subfunction lock will be taken for whole port creation. Do
the same in VF case.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/devlink/devlink.c      | 2 --
 drivers/net/ethernet/intel/ice/devlink/devlink_port.c | 4 ++--
 drivers/net/ethernet/intel/ice/ice_eswitch.c          | 9 +++++++--
 drivers/net/ethernet/intel/ice/ice_repr.c             | 2 --
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 704e9ad5144e..f774781ab514 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -794,10 +794,8 @@ int ice_devlink_rate_init_tx_topology(struct devlink *devlink, struct ice_vsi *v
 
 	tc_node = pi->root->children[0];
 	mutex_lock(&pi->sched_lock);
-	devl_lock(devlink);
 	for (i = 0; i < tc_node->num_children; i++)
 		ice_traverse_tx_tree(devlink, tc_node->children[i], tc_node, pf);
-	devl_unlock(devlink);
 	mutex_unlock(&pi->sched_lock);
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
index 13e6790d3cae..c9fbeebf7fb9 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
@@ -407,7 +407,7 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
 	devlink_port_attrs_set(devlink_port, &attrs);
 	devlink = priv_to_devlink(pf);
 
-	err = devlink_port_register(devlink, devlink_port, vsi->idx);
+	err = devl_port_register(devlink, devlink_port, vsi->idx);
 	if (err) {
 		dev_err(dev, "Failed to create devlink port for VF %d, error %d\n",
 			vf->vf_id, err);
@@ -426,5 +426,5 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
 void ice_devlink_destroy_vf_port(struct ice_vf *vf)
 {
 	devl_rate_leaf_destroy(&vf->devlink_port);
-	devlink_port_unregister(&vf->devlink_port);
+	devl_port_unregister(&vf->devlink_port);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index b102db8b829a..7b57a6561a5a 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -423,6 +423,7 @@ static void ice_eswitch_start_reprs(struct ice_pf *pf)
 int
 ice_eswitch_attach(struct ice_pf *pf, struct ice_vf *vf)
 {
+	struct devlink *devlink = priv_to_devlink(pf);
 	struct ice_repr *repr;
 	int err;
 
@@ -437,7 +438,9 @@ ice_eswitch_attach(struct ice_pf *pf, struct ice_vf *vf)
 
 	ice_eswitch_stop_reprs(pf);
 
+	devl_lock(devlink);
 	repr = ice_repr_add_vf(vf);
+	devl_unlock(devlink);
 	if (IS_ERR(repr)) {
 		err = PTR_ERR(repr);
 		goto err_create_repr;
@@ -460,7 +463,9 @@ ice_eswitch_attach(struct ice_pf *pf, struct ice_vf *vf)
 err_xa_alloc:
 	ice_eswitch_release_repr(pf, repr);
 err_setup_repr:
+	devl_lock(devlink);
 	ice_repr_rem_vf(repr);
+	devl_unlock(devlink);
 err_create_repr:
 	if (xa_empty(&pf->eswitch.reprs))
 		ice_eswitch_disable_switchdev(pf);
@@ -484,6 +489,7 @@ void ice_eswitch_detach(struct ice_pf *pf, struct ice_vf *vf)
 		ice_eswitch_disable_switchdev(pf);
 
 	ice_eswitch_release_repr(pf, repr);
+	devl_lock(devlink);
 	ice_repr_rem_vf(repr);
 
 	if (xa_empty(&pf->eswitch.reprs)) {
@@ -491,12 +497,11 @@ void ice_eswitch_detach(struct ice_pf *pf, struct ice_vf *vf)
 		 * no point in keeping the nodes
 		 */
 		ice_devlink_rate_clear_tx_topology(ice_get_main_vsi(pf));
-		devl_lock(devlink);
 		devl_rate_nodes_destroy(devlink);
-		devl_unlock(devlink);
 	} else {
 		ice_eswitch_start_reprs(pf);
 	}
+	devl_unlock(devlink);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index fe83f305cc7d..35a6ac8c0466 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -285,9 +285,7 @@ ice_repr_reg_netdev(struct net_device *netdev)
 
 static void ice_repr_remove_node(struct devlink_port *devlink_port)
 {
-	devl_lock(devlink_port->devlink);
 	devl_rate_leaf_destroy(devlink_port);
-	devl_unlock(devlink_port->devlink);
 }
 
 /**

-- 
2.44.0.53.g0f9d4d28b7e6


