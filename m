Return-Path: <netdev+bounces-290406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHiRNYwHD2qFEQYAu9opvQ
	(envelope-from <netdev+bounces-290406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:24:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB635A5B36
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 35FEE3074002
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8FA3D9DDB;
	Thu, 21 May 2026 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="evaGSkE9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6111A6812
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 12:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367825; cv=none; b=Wzb4VkNZBVcaojJCEmnmen1OOBFHFR9DuBkWwtNKNHZoEITI/2ka9DMaP4Kzg7FzLzUKRi2Pdt5G9H7VbM2JA9yj5vp+PHYfU5Nt0Dl3BoNXN9x9Z//lwSX+e5WNKWV5tvIKE7hzDWc7XsW7sxKlZri8RtbLLAy2qebwfP+X/xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367825; c=relaxed/simple;
	bh=icADDd2KOT855mztfX2cI/CHcPBzXRh4dlK5GAnzF6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1mfLLQDLCuFX/edSgr3KhGwdPyg4Wu1W8uR3nKx0PD1ynRU+u+yM6+jZROyGkSGNdw32E+B2Ccu5MxCkRP0Mai2FWyS8mjm2raUs8f6PEMzfUj9VRW9/SoSoQGe7ce3iiXA+0HciZH6SuE+68lP2c/AJB/4/rI5uojig4iVlsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=evaGSkE9; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779367825; x=1810903825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=icADDd2KOT855mztfX2cI/CHcPBzXRh4dlK5GAnzF6c=;
  b=evaGSkE9rOth+6t0RUaq8uNvoayaaBYwGnC8Z5lRUYyJVratpeyuwxwh
   FY0t2u//XUl17f7rdOfAVpQX7MtcfYTtDexHyQ88xyGHsw5nBecbTNNI5
   n1cA7NoFQcXW1uyzNwuJilqobt9ElshoPFnhhvq5Di79O/F4Q/oAHUpuY
   G6dRy3fzA0p2eQNEml3i+YSQmBfbt9dzQsSrJ5UxcZPBPquTtO3gEKU03
   mmbDug4rUdhdmReirb/3Ik2A/fmjuQwaBhkdNHlzX1oPDNk8n85YaFz38
   ZSNDge5CRZR2gnUALx/EFkyB7A+j8Z8Y4Et7CJumJXcjoxc2JkvUi2Rhx
   g==;
X-CSE-ConnectionGUID: 6gIP8oasTv2JRdt0oebLeA==
X-CSE-MsgGUID: MLd1uOG/TrCYAbsX0Io9RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80013504"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="80013504"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 05:50:25 -0700
X-CSE-ConnectionGUID: 2Ma4q3aqQNK0CPb6rQFlIQ==
X-CSE-MsgGUID: TtJa94XfQNS5ey65QWJLFw==
X-ExtLoop1: 1
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa003.fm.intel.com with ESMTP; 21 May 2026 05:50:22 -0700
Received: from gond.igk.intel.com (gond.igk.intel.com [10.123.220.52])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 6A7B828780;
	Thu, 21 May 2026 13:50:21 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	sandeep.penigalapati@intel.com,
	ananth.s@intel.com,
	alexander.duyck@gmail.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v4 05/10] Revert "ice: remove unused ice_flow_entry fields"
Date: Thu, 21 May 2026 13:49:55 +0200
Message-ID: <20260521115000.4637-6-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260521115000.4637-1-marcin.szycik@linux.intel.com>
References: <20260521115000.4637-1-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-290406-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,linux.intel.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DBB635A5B36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This reverts commit 4cd7bc7144ec2c0bb27208c3bb1f153dfd44b1c7.
These fields will be needed in the following commits.

Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v2:
* Add this patch
---
 drivers/net/ethernet/intel/ice/ice_flow.h | 3 +++
 drivers/net/ethernet/intel/ice/ice_flow.c | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flow.h b/drivers/net/ethernet/intel/ice/ice_flow.h
index bbfc7b4a432e..ff6af6589862 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.h
+++ b/drivers/net/ethernet/intel/ice/ice_flow.h
@@ -458,8 +458,11 @@ struct ice_flow_entry {
 
 	u64 id;
 	struct ice_flow_prof *prof;
+	/* Flow entry's content */
+	void *entry;
 	enum ice_flow_priority priority;
 	u16 vsi_handle;
+	u16 entry_sz;
 };
 
 #define ICE_FLOW_ENTRY_HNDL(e)	((u64)(uintptr_t)e)
diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
index 855d296aeed8..e42367853253 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.c
+++ b/drivers/net/ethernet/intel/ice/ice_flow.c
@@ -1604,6 +1604,7 @@ ice_flow_rem_entry_sync(struct ice_hw *hw, enum ice_block __always_unused blk,
 
 	list_del(&entry->l_entry);
 
+	devm_kfree(ice_hw_to_dev(hw), entry->entry);
 	devm_kfree(ice_hw_to_dev(hw), entry);
 
 	return 0;
@@ -2024,8 +2025,10 @@ ice_flow_add_entry(struct ice_hw *hw, enum ice_block blk, u64 prof_id,
 	*entry_h = ICE_FLOW_ENTRY_HNDL(e);
 
 out:
-	if (status)
+	if (status && e) {
+		devm_kfree(ice_hw_to_dev(hw), e->entry);
 		devm_kfree(ice_hw_to_dev(hw), e);
+	}
 
 	return status;
 }
-- 
2.49.0


