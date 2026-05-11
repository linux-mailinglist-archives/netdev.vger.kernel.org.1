Return-Path: <netdev+bounces-286679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDFLJhrmAWqKmAEAu9opvQ
	(envelope-from <netdev+bounces-286679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:22:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A90CD51003F
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 278F03030B81
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E6A3FE35B;
	Mon, 11 May 2026 14:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UkysdK+5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07C83ED113
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 14:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508462; cv=none; b=shzOiTrYofkepZMIQY0GitBf5yttjfXuzMez2y1kHO7M6IMtmSKImBEt+eqlMHED9/woczIYJRK3YDiy2Zwf7okuOIw+wZEAW4Yva8+YZQYuPTa2pvL3hHYRtr/LiDvTR4p1mRDY3SyVcFFyTqBM5ux3yyepXuGsx7Q06wpl1Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508462; c=relaxed/simple;
	bh=sITYQjZ0WIGE3ESLmkp3SutNMCglo4JI24ljeE+NWH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NILzlUanfuyIxPQB6wSSw2ARp/8nT/Lj3krVuGQHlaFmLUHN1LLeQNfvcGg11m+oTSneJEswY/p6f8AQJWmF2MONpYtBrWMikuDv8z47ygNBtSTE+mBJ35/41mnjA+mKHloTOW3ki1mgYNVT+grcB0CWUJ4NIA+rizNfbW1YEz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UkysdK+5; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778508460; x=1810044460;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sITYQjZ0WIGE3ESLmkp3SutNMCglo4JI24ljeE+NWH0=;
  b=UkysdK+5HV6YnViqf42w7XcaO/K6EVdZ4z6ZVPZxzc0FmpU98YuT2W6n
   J1X24OEN07GHcmd3+abMv7P1EmXBFnXQz+dH1M9dygyG2VC2KufDEvCIw
   BRdIH5eGHnCXzHHVeBoYnh97f/dt2wF4TObpV6kw/E86OVzRHYq/cQ9+S
   Gk/63oSRbKnr+Q69C6LBVBFdWX/eOjT0Z2mgjPmhhN6P3FCvKpIoQSRf8
   jxrJuJS/UV2q+Oyztni7pcafzSVFUBeYumT8UspuA0h0GTJe/+xs/TZTf
   //cYMjFirS5AEpkj3BgcD7piDOGfFrzCko9JDyQJZgnfw4uVMKPXiLnmA
   A==;
X-CSE-ConnectionGUID: B9x+xZCoSP6P9j0AZ1fCGA==
X-CSE-MsgGUID: EUewMMpJTmuboKuhpXFMpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83265227"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="83265227"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 07:07:38 -0700
X-CSE-ConnectionGUID: VGk2W6EcRlmvf7PcELwVQw==
X-CSE-MsgGUID: v9QGHKJgQLK3nOCmeIaTKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="237685834"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa007.jf.intel.com with ESMTP; 11 May 2026 07:07:36 -0700
Received: from gond.igk.intel.com (gond.igk.intel.com [10.123.220.52])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id ACBE62FC47;
	Mon, 11 May 2026 15:07:35 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	sandeep.penigalapati@intel.com,
	ananth.s@intel.com,
	alexander.duyck@gmail.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v3 09/10] ice: re-introduce ice_dealloc_flow_entry() helper
Date: Mon, 11 May 2026 15:07:08 +0200
Message-ID: <20260511130710.38801-10-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260511130710.38801-1-marcin.szycik@linux.intel.com>
References: <20260511130710.38801-1-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A90CD51003F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286679-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,linux.intel.com];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcin.szycik@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.intel.com:mid]
X-Rspamd-Action: no action

It was removed in commit ad667d626825 ("ice: remove null checks before
devm_kfree() calls"). Now it's useful again.

Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v3:
* ice_flow_acl_add_scen_entry_sync(), ice_flow_add_entry(): call
  ice_flow_acl_free_act_cntr() in unroll
v2:
* Add this patch
---
 drivers/net/ethernet/intel/ice/ice_flow.c | 61 +++++++++++++++--------
 1 file changed, 39 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
index df82cb36a58b..d3e8e7d1ec89 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.c
+++ b/drivers/net/ethernet/intel/ice/ice_flow.c
@@ -1589,6 +1589,23 @@ ice_flow_find_prof_id(struct ice_hw *hw, enum ice_block blk, u64 prof_id)
 	return NULL;
 }
 
+/**
+ * ice_dealloc_flow_entry - Deallocate flow entry memory
+ * @hw: pointer to the HW struct
+ * @entry: flow entry to be removed
+ */
+static void
+ice_dealloc_flow_entry(struct ice_hw *hw, struct ice_flow_entry *entry)
+{
+	if (!entry)
+		return;
+
+	kfree(entry->entry);
+	kfree(entry->range_buf);
+	kfree(entry->acts);
+	devm_kfree(ice_hw_to_dev(hw), entry);
+}
+
 /**
  * ice_flow_get_hw_prof - return the HW profile for a specific profile ID handle
  * @hw: pointer to the HW struct
@@ -1759,11 +1776,7 @@ static int ice_flow_rem_entry_sync(struct ice_hw *hw, enum ice_block blk,
 	}
 
 	list_del(&entry->l_entry);
-
-	kfree(entry->entry);
-	kfree(entry->range_buf);
-	kfree(entry->acts);
-	devm_kfree(ice_hw_to_dev(hw), entry);
+	ice_dealloc_flow_entry(hw, entry);
 
 	return 0;
 }
@@ -2877,6 +2890,9 @@ static int ice_flow_acl_add_scen_entry_sync(struct ice_hw *hw,
 			/* For the action memory info, update the SW's copy of
 			 * exist entry with e's action memory info
 			 */
+			if (exist->acts_cnt && exist->acts)
+				ice_flow_acl_free_act_cntr(hw, exist->acts,
+							   exist->acts_cnt);
 			kfree(exist->acts);
 			exist->acts = kzalloc_objs(*exist->acts, e->acts_cnt);
 			if (!exist->acts) {
@@ -2906,13 +2922,13 @@ static int ice_flow_acl_add_scen_entry_sync(struct ice_hw *hw,
 				goto out;
 		}
 
-		/* As we don't add the new entry to our SW DB, deallocate its
-		 * memories, and return the exist entry to the caller
+		/* As we don't add the new entry to our SW DB, free its HW
+		 * counter resources and deallocate its memory, then return
+		 * the exist entry to the caller
 		 */
-		kfree(e->entry);
-		kfree(e->range_buf);
-		kfree(e->acts);
-		devm_kfree(ice_hw_to_dev(hw), e);
+		if (e->acts_cnt && e->acts)
+			ice_flow_acl_free_act_cntr(hw, e->acts, e->acts_cnt);
+		ice_dealloc_flow_entry(hw, e);
 		*entry = exist;
 	}
 out:
@@ -2993,7 +3009,7 @@ int ice_flow_add_entry(struct ice_hw *hw, enum ice_block blk, u64 prof_id,
 
 	mutex_unlock(&hw->fl_profs_locks[blk]);
 	if (status)
-		goto out;
+		goto dealloc_entry;
 
 	e->id = entry_id;
 	e->vsi_handle = vsi_handle;
@@ -3009,15 +3025,15 @@ int ice_flow_add_entry(struct ice_hw *hw, enum ice_block blk, u64 prof_id,
 		status = ice_flow_acl_frmt_entry(hw, prof, e, (u8 *)data, acts,
 						 acts_cnt);
 		if (status)
-			goto out;
+			goto dealloc_entry;
 
 		status = ice_flow_acl_add_scen_entry(hw, prof, &e);
 		if (status)
-			goto out;
+			goto free_cntrs;
 		break;
 	default:
 		status = -EOPNOTSUPP;
-		goto out;
+		goto dealloc_entry;
 	}
 
 	if (blk != ICE_BLK_ACL) {
@@ -3029,13 +3045,14 @@ int ice_flow_add_entry(struct ice_hw *hw, enum ice_block blk, u64 prof_id,
 
 	*entry_h = ICE_FLOW_ENTRY_HNDL(e);
 
-out:
-	if (status && e) {
-		kfree(e->entry);
-		kfree(e->range_buf);
-		kfree(e->acts);
-		devm_kfree(ice_hw_to_dev(hw), e);
-	}
+	return 0;
+
+free_cntrs:
+	if (blk == ICE_BLK_ACL && e->acts_cnt && e->acts)
+		ice_flow_acl_free_act_cntr(hw, e->acts, e->acts_cnt);
+dealloc_entry:
+	if (e)
+		ice_dealloc_flow_entry(hw, e);
 
 	return status;
 }
-- 
2.49.0


