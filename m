Return-Path: <netdev+bounces-285591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKCiJtRU/WkYawAAu9opvQ
	(envelope-from <netdev+bounces-285591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 05:13:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A92F4F108B
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 05:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A1B73030B21
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 03:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6E32C21C5;
	Fri,  8 May 2026 03:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NGZS+pM6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF53D2571DD
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 03:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778209955; cv=none; b=EK+zwhW0tlv2AfcupMHgJUITQLeRPZjN60WAo3J0/jgW0lGVvVJavtSsHretj4onyLBcKvhj/V9mbKeJnax+oh5TLLqy0HPUfnbwKeF2sLFYhq2dSjZ2sNxw/aUCtRAtTiHMKNzSqSjMtrfRzqy9+QIhrvtzUCNyjmrPg/Q/Hqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778209955; c=relaxed/simple;
	bh=eNkuLWRPSYTLbgVnN8ZTLbezDayq2V1B+TaYvmbS3UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mw82lOxgs9tw0zF7sre+tEJ+1scI346m46wwfvJp462dkUOCCbs6FrNHiokRQOta8GyAFuvAJY/uN06QnHg7wBHCP6xmuaE5tTFc4V7C29crgixa6PXTI+DwVGNY11IR0GuY5UoqzuCJodTscIRSlGOOB/X1mpK4vUQft8AGgnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NGZS+pM6; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778209954; x=1809745954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eNkuLWRPSYTLbgVnN8ZTLbezDayq2V1B+TaYvmbS3UQ=;
  b=NGZS+pM6gDcFbB2LOj1Z15MV3dnjMoPNqHjcksds+Wp+tZoMf4UgPKX5
   Oczpxf89dN3Rus6Ks9U0o8zXnqieMkRKIFnpxiSkjZzbf/rmcmajQvr2w
   JJt0KDegKrySY8faDLTjC+iI5CWElrF0Dh+Ymz+ROvnMdB8yVCs7QngTy
   wdyW0PEZ7GP3GM08LxkTbTljY65OV7ibVtgmU1dCHODWoPxHuJTzkesxT
   +FZHXx5BvjPxYy7VO4vU+H40Pqiu2YTZuGEruSJCk0OG95gGcXLvvKynD
   tLCPpPbX7Y8kJu6nP39DV/VwxNOgvBEyahQs0U2o0od/wn9kZ7E4R+l8l
   w==;
X-CSE-ConnectionGUID: CxtXQ+onTCCktPIpBWqJAA==
X-CSE-MsgGUID: OZ+39BsEQbmaC0R9WMoFuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79027500"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="79027500"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 20:12:34 -0700
X-CSE-ConnectionGUID: 64ZNGCcPTIG3odcucKXIjw==
X-CSE-MsgGUID: LUJ9MZl+RIWFn0YYHfHPhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="241623191"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa005.fm.intel.com with ESMTP; 07 May 2026 20:12:32 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Piotr Skajewski <piotrx.skajewski@intel.com>
Subject: [PATCH iwl-next 3/8] ixgbe: prevent adding duplicate FDIR perfect filter rules
Date: Fri,  8 May 2026 05:12:21 +0200
Message-ID: <20260508031226.3601800-4-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260508031226.3601800-1-aleksandr.loktionov@intel.com>
References: <20260508031226.3601800-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1A92F4F108B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285591-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Piotr Skajewski <piotrx.skajewski@intel.com>

When the same flow specification is added twice (same 5-tuple with
different sw_idx values), ixgbe_add_ethtool_fdir_entry() silently
programs the duplicate into hardware using a second FDIR table slot.
This wastes a scarce FDIR entry and can cause confusing behaviour
when deleting rules.

Add a helper ixgbe_match_ethtool_fdir_entry() that walks the in-kernel
filter list before programming hardware.  If an entry with an
identical filter (excluding the sw_idx) already exists, the new add
request is rejected with -EEXIST.

Signed-off-by: Piotr Skajewski <piotrx.skajewski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 27 +++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index ba049b3..a2009df 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -2938,6 +2938,23 @@ static int ixgbe_flowspec_to_flow_type(struct ethtool_rx_flow_spec *fsp,
 	return 1;
 }
 
+static bool ixgbe_match_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
+					   struct ixgbe_fdir_filter *input)
+{
+	struct ixgbe_fdir_filter *rule = NULL;
+
+	hlist_for_each_entry(rule, &adapter->fdir_filter_list, fdir_node) {
+		if (rule->sw_idx == input->sw_idx)
+			continue;
+		if (!memcmp(&rule->filter, &input->filter,
+			    sizeof(rule->filter))) {
+			e_warn(drv, "FDIR filter already exists\n");
+			return true;
+		}
+	}
+	return false;
+}
+
 static int ixgbe_add_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
 					struct ethtool_rxnfc *cmd)
 {
@@ -2947,7 +2964,7 @@ static int ixgbe_add_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
 	struct ixgbe_fdir_filter *input;
 	union ixgbe_atr_input mask;
 	u8 queue;
-	int err;
+	int err = -EINVAL;
 
 	if (!(adapter->flags & IXGBE_FLAG_FDIR_PERFECT_CAPABLE))
 		return -EOPNOTSUPP;
@@ -3050,6 +3067,12 @@ static int ixgbe_add_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
 	/* apply mask and compute/store hash */
 	ixgbe_atr_compute_perfect_hash_82599(&input->filter, &mask);
 
+	/* check for a duplicate filter */
+	if (ixgbe_match_ethtool_fdir_entry(adapter, input)) {
+		err = -EEXIST;
+		goto err_out_w_lock;
+	}
+
 	/* program filters to filter memory */
 	err = ixgbe_fdir_write_perfect_filter_82599(hw,
 				&input->filter, input->sw_idx, queue);
@@ -3065,7 +3088,7 @@ static int ixgbe_add_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
 	spin_unlock(&adapter->fdir_perfect_lock);
 err_out:
 	kfree(input);
-	return -EINVAL;
+	return err;
 }
 
 static int ixgbe_del_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
-- 
2.52.0


