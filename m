Return-Path: <netdev+bounces-294941-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y57GFs6mIGo96QAAu9opvQ
	(envelope-from <netdev+bounces-294941-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:12:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDF563B83A
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:12:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Z9T9NIA8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294941-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294941-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F9B53070F0A
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 22:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A539426EB7;
	Wed,  3 Jun 2026 22:08:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CB041C31A
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 22:08:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780524530; cv=none; b=oskTOIh2VOziBgdiY8MDj8g//MhVanx2yDqnwfJPrUZY5Jn88dgafOQbKngE1TuMf4LG7Em7umxssdQnW4lwTC4z38TOl+nXPSXvgREyg1HXWtgDS24t9AQ82EQFk8T+ie5+4Wkhpfz8s8RYUbksot/6Jqx/c+rdlbvERd9Qi8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780524530; c=relaxed/simple;
	bh=m3UVH8lIwWwSowT4FGqra6o+dI7pu0mTxdH1SkHbVRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/wWrDKVrie+8FVSB5CWlc0WxaPZEj3Zuw2b0ziJ5EscSVwL0jkf5BDXtr0W4KquGLzDa0mrcbjzcfQaL4xpvsL/jWk9Nbjt4z3yUidhLrZwJmVh1tUJDV743OD6vYya2A1zjSMWcWamjsejHJkTq/62JrzaD098vzWxqWzDKhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z9T9NIA8; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780524524; x=1812060524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m3UVH8lIwWwSowT4FGqra6o+dI7pu0mTxdH1SkHbVRE=;
  b=Z9T9NIA8wVg+nXT6UICMWdj/VhYHklNcWdaYmLzuFeiAAledYjy9WTTp
   FaZjvoU54O+E5srtoIivyEbAVnIN/tgxo0TWI0mBFWT3jOcEhCDd33jIe
   seFIf6CLIDjCMxL9WEN7pfolwfaILVCAqRxlAcX/JbgYuE3QBYvKsuLEM
   cgzaUblhPaNACRY56V0wMW0tWY2A8OXD/YtaZQCvvV/wG7aSJBLbHC0ut
   vBmKnu/ElagIMuieV3DMOCmrFFJaI4MXYIgJ9FSW30gAyaUKN5UmShJTq
   k8vfLa/RVsZdhWpvq8yqC7KolLFZR4xzI3zwMhL/o4z56bjsGttE7JKf0
   Q==;
X-CSE-ConnectionGUID: 2Iz+JsfvQQWHrTM7VNLa3w==
X-CSE-MsgGUID: Rp+OmucfSZCVZNYuH1FXgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="98920950"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="98920950"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 15:08:37 -0700
X-CSE-ConnectionGUID: /6ZR+laWQkuaGQOOztLd0A==
X-CSE-MsgGUID: cQzlHhU1TBGchj0GGjWsag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="282458908"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 03 Jun 2026 15:08:37 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com,
	sandeep.penigalapati@intel.com,
	ananth.s@intel.com,
	alexander.duyck@gmail.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net-next 09/10] ice: re-introduce ice_dealloc_flow_entry() helper
Date: Wed,  3 Jun 2026 15:08:25 -0700
Message-ID: <20260603220828.829969-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260603220828.829969-1-anthony.l.nguyen@intel.com>
References: <20260603220828.829969-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294941-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[linux.intel.com,intel.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:marcin.szycik@linux.intel.com,m:anthony.l.nguyen@intel.com,m:aleksandr.loktionov@intel.com,m:sandeep.penigalapati@intel.com,m:ananth.s@intel.com,m:alexander.duyck@gmail.com,m:przemyslaw.kitszel@intel.com,m:alexander.nowlin@intel.com,m:andrew@lunn.ch,m:alexanderduyck@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ADDF563B83A

From: Marcin Szycik <marcin.szycik@linux.intel.com>

It was removed in commit ad667d626825 ("ice: remove null checks before
devm_kfree() calls"). Now it's useful again.

Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
2.47.1


