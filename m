Return-Path: <netdev+bounces-281634-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EC6oCllE8Gn2QwEAu9opvQ
	(envelope-from <netdev+bounces-281634-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:23:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E40247D884
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B084F302EAB8
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 05:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A2533CEA9;
	Tue, 28 Apr 2026 05:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hm4gxTD4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0324B31065B
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 05:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353801; cv=none; b=u+6Agzk1qktnJpwKEHIy50sfkL1sgdgDJCNgXldLL6Z9mhYVH5rzNeM264zrUmftr3Ww5+f6yIoL8FPJPOFf3+0E/n9rQ7zNU8zEBR8gtvSfU2d3C3DYZl72G1wnO7ypGeT1MO77GVcReVktkgpCHKpLzaxZftIvP9+5/NP8OEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353801; c=relaxed/simple;
	bh=Vx5pzlCxxf8TEgkmxIvhz4r+rrQNgUnGqOn9i16lhiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HIozx62OIt9sjDW5h7+r36kHwAqqet+vaInzYU4dgSaK7ufRehTXQMU2GnnONLDD8AILfH6gd64Y7SpTKoulFL6By+5A2FnLKEjj6tEgQ78AOnKDUG8o7mOVCziQ7XSiawm6PPT3dbnVxWtPzFeWgWHhUJmC2yPD+YsoEACpxbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hm4gxTD4; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777353800; x=1808889800;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Vx5pzlCxxf8TEgkmxIvhz4r+rrQNgUnGqOn9i16lhiE=;
  b=Hm4gxTD4wdM7rPXH3/X56syKDUo7H9Skfw5x+3p+2L7ilFUmFDNH0SX+
   wb0qIt7espNZuafUsz5Ok+17WxlpMXUIK6G8Wa/m9Hrt/PxDa+JPELgPF
   Z0kJ4efYCSM5wWh1pJxdtI9nZ8CKFahKcbxpTY868zYc/r2luzKly+b3q
   bBzpkVqM5rrMg5Rikd/NKlfneaEcnLNtzwA7EwewMHjunTyibPVRc15bQ
   ++wcFCIzwNsBs15aB2JMVA0Wfha1RjuleKvHiMuuG2baywt7ZiuFNuJkg
   vLSJdKjhE1RlJLUjOcvaDwLyVepkHkAySKhq+5OkVbJ6WRhiPUKEDfIdX
   g==;
X-CSE-ConnectionGUID: +ARnTbpGQj+N6FYmq3cdsw==
X-CSE-MsgGUID: vI7YqI4VQECak55T1+AlnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="100910524"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="100910524"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:23:15 -0700
X-CSE-ConnectionGUID: jum/WWM5RvuWBLpB8ljI5g==
X-CSE-MsgGUID: YqsF8gTmT+6qNIiNd/BAEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="237800200"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:23:15 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 27 Apr 2026 22:22:15 -0700
Subject: [PATCH net 03/11] iavf: wait for PF confirmation before removing
 VLAN filters
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-jk-iwl-net-petr-oros-fixes-v1-3-cdcb48303fd8@intel.com>
References: <20260427-jk-iwl-net-petr-oros-fixes-v1-0-cdcb48303fd8@intel.com>
In-Reply-To: <20260427-jk-iwl-net-petr-oros-fixes-v1-0-cdcb48303fd8@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Petr Oros <poros@redhat.com>, Rafal Romanowski <rafal.romanowski@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=7285;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=5u+ZITj0q0f8iSlX/Dq1KRdO583HwL60Rms4ooKzo2U=;
 b=kA0DAAoWapZdPm8PKOgByyZiAGnwREChRGfAlV4JqI2OzmWw4pSpR0po0xcdF4CEZiMDsLkZb
 Ih1BAAWCgAdFiEEIEBUqdczkFYq7EMeapZdPm8PKOgFAmnwREAACgkQapZdPm8PKOi1IwEAyBVv
 7HqLNSDkXWnAt0aGkYUI1LfomRbYAnguTYDNYWkBAODCtBlH8s9WidL5H1N5MjXaoAUqpQUx4rh
 HOyiKNNcK
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: 8E40247D884
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281634-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Petr Oros <poros@redhat.com>

The VLAN filter DELETE path was asymmetric with the ADD path: ADD
waits for PF confirmation (ADD -> ADDING -> ACTIVE), but DELETE
immediately frees the filter struct after sending the DEL message
without waiting for the PF response.

This is problematic because:
 - If the PF rejects the DEL, the filter remains in HW but the driver
   has already freed the tracking structure, losing sync.
 - Race conditions between DEL pending and other operations
   (add, reset) cannot be properly resolved if the filter struct
   is already gone.

Add IAVF_VLAN_REMOVING state to make the DELETE path symmetric:

  REMOVE -> REMOVING (send DEL) -> PF confirms -> kfree
                                -> PF rejects  -> ACTIVE

In iavf_del_vlans(), transition filters from REMOVE to REMOVING
instead of immediately freeing them. The new DEL completion handler
in iavf_virtchnl_completion() frees filters on success or reverts
them to ACTIVE on error.

Update iavf_add_vlan() to handle the REMOVING state: if a DEL is
pending and the user re-adds the same VLAN, queue it for ADD so
it gets re-programmed after the PF processes the DEL.

The !VLAN_FILTERING_ALLOWED early-exit path still frees filters
directly since no PF message is sent in that case.

Also update iavf_del_vlan() to skip filters already in REMOVING
state: DEL has been sent to PF and the completion handler will
free the filter when PF confirms. Without this guard, the sequence
DEL(pending) -> user-del -> second DEL could cause the PF to return
an error for the second DEL (filter already gone), causing the
completion handler to incorrectly revert a deleted filter back to
ACTIVE.

Fixes: 968996c070ef ("iavf: Fix VLAN_V2 addition/rejection")
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h          |  1 +
 drivers/net/ethernet/intel/iavf/iavf_main.c     | 13 +++++----
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 37 +++++++++++++++++--------
 3 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 5765715914d6..050f8241ef5e 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -161,6 +161,7 @@ enum iavf_vlan_state_t {
 	IAVF_VLAN_ADDING,	/* ADD sent to PF, waiting for response */
 	IAVF_VLAN_ACTIVE,	/* PF confirmed, filter is in HW */
 	IAVF_VLAN_REMOVE,	/* filter queued for DEL from PF */
+	IAVF_VLAN_REMOVING,	/* DEL sent to PF, waiting for response */
 };
 
 struct iavf_vlan_filter {
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index ca29038c0016..d2914c511e1e 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -757,10 +757,10 @@ iavf_vlan_filter *iavf_add_vlan(struct iavf_adapter *adapter,
 		adapter->num_vlan_filters++;
 		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ADD_VLAN_FILTER);
 	} else if (f->state == IAVF_VLAN_REMOVE) {
-		/* Re-add the filter since we cannot tell whether the
-		 * pending delete has already been processed by the PF.
-		 * A duplicate add is harmless.
-		 */
+		/* DEL not yet sent to PF, cancel it */
+		f->state = IAVF_VLAN_ACTIVE;
+	} else if (f->state == IAVF_VLAN_REMOVING) {
+		/* DEL already sent to PF, re-add after completion */
 		f->state = IAVF_VLAN_ADD;
 		iavf_schedule_aq_request(adapter,
 					 IAVF_FLAG_AQ_ADD_VLAN_FILTER);
@@ -791,11 +791,14 @@ static void iavf_del_vlan(struct iavf_adapter *adapter, struct iavf_vlan vlan)
 			list_del(&f->list);
 			kfree(f);
 			adapter->num_vlan_filters--;
-		} else {
+		} else if (f->state != IAVF_VLAN_REMOVING) {
 			f->state = IAVF_VLAN_REMOVE;
 			iavf_schedule_aq_request(adapter,
 						 IAVF_FLAG_AQ_DEL_VLAN_FILTER);
 		}
+		/* If REMOVING, DEL is already sent to PF; completion
+		 * handler will free the filter when PF confirms.
+		 */
 	}
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 4f197d908124..93ca79c3e3b5 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -948,12 +948,10 @@ void iavf_del_vlans(struct iavf_adapter *adapter)
 
 		vvfl->vsi_id = adapter->vsi_res->vsi_id;
 		vvfl->num_elements = count;
-		list_for_each_entry_safe(f, ftmp, &adapter->vlan_filter_list, list) {
+		list_for_each_entry(f, &adapter->vlan_filter_list, list) {
 			if (f->state == IAVF_VLAN_REMOVE) {
 				vvfl->vlan_id[i] = f->vlan.vid;
-				list_del(&f->list);
-				kfree(f);
-				adapter->num_vlan_filters--;
+				f->state = IAVF_VLAN_REMOVING;
 				i++;
 				if (i == count)
 					break;
@@ -990,7 +988,7 @@ void iavf_del_vlans(struct iavf_adapter *adapter)
 
 		vvfl_v2->vport_id = adapter->vsi_res->vsi_id;
 		vvfl_v2->num_elements = count;
-		list_for_each_entry_safe(f, ftmp, &adapter->vlan_filter_list, list) {
+		list_for_each_entry(f, &adapter->vlan_filter_list, list) {
 			if (f->state == IAVF_VLAN_REMOVE) {
 				struct virtchnl_vlan_supported_caps *filtering_support =
 					&adapter->vlan_v2_caps.filtering.filtering_support;
@@ -1005,9 +1003,7 @@ void iavf_del_vlans(struct iavf_adapter *adapter)
 				vlan->tci = f->vlan.vid;
 				vlan->tpid = f->vlan.tpid;
 
-				list_del(&f->list);
-				kfree(f);
-				adapter->num_vlan_filters--;
+				f->state = IAVF_VLAN_REMOVING;
 				i++;
 				if (i == count)
 					break;
@@ -2370,10 +2366,6 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 			ether_addr_copy(adapter->hw.mac.addr, netdev->dev_addr);
 			wake_up(&adapter->vc_waitqueue);
 			break;
-		case VIRTCHNL_OP_DEL_VLAN:
-			dev_err(&adapter->pdev->dev, "Failed to delete VLAN filter, error %s\n",
-				iavf_stat_str(&adapter->hw, v_retval));
-			break;
 		case VIRTCHNL_OP_DEL_ETH_ADDR:
 			dev_err(&adapter->pdev->dev, "Failed to delete MAC filter, error %s\n",
 				iavf_stat_str(&adapter->hw, v_retval));
@@ -2895,6 +2887,27 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		spin_unlock_bh(&adapter->mac_vlan_list_lock);
 		}
 		break;
+	case VIRTCHNL_OP_DEL_VLAN:
+	case VIRTCHNL_OP_DEL_VLAN_V2: {
+		struct iavf_vlan_filter *f, *ftmp;
+
+		spin_lock_bh(&adapter->mac_vlan_list_lock);
+		list_for_each_entry_safe(f, ftmp, &adapter->vlan_filter_list,
+					 list) {
+			if (f->state == IAVF_VLAN_REMOVING) {
+				if (v_retval) {
+					/* PF rejected DEL, keep filter */
+					f->state = IAVF_VLAN_ACTIVE;
+				} else {
+					list_del(&f->list);
+					kfree(f);
+					adapter->num_vlan_filters--;
+				}
+			}
+		}
+		spin_unlock_bh(&adapter->mac_vlan_list_lock);
+		}
+		break;
 	case VIRTCHNL_OP_ENABLE_VLAN_STRIPPING:
 		/* PF enabled vlan strip on this VF.
 		 * Update netdev->features if needed to be in sync with ethtool.

-- 
2.54.0.rc2.531.gaf818d63126a


