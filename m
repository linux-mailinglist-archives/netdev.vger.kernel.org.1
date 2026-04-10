Return-Path: <netdev+bounces-277291-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HcdOx2s2GkmgwgAu9opvQ
	(envelope-from <netdev+bounces-277291-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:51:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1793D399E
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00E8E303EC27
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C337539E184;
	Fri, 10 Apr 2026 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GKFOwnTS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04313382376
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775807373; cv=none; b=h6t1TozG7UbULsYEMLlKA35T+dzO7v9vygu3V+/IHge6HnHT4nH4PyZTPA2pJbXTnd9Z5gW7pEP/2nXGLArKTQ1vqKWVMXnXDkNTvZstfB0YbTm4U8l751kLRFj4BAMp3CqlVbc3lZG1MtW2HTYznLBPAXrFXKfw2ZjYKL8XCKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775807373; c=relaxed/simple;
	bh=k4iVYr4cQFswdWaUcb7d4oIndXtfp8j3uUYioC/j5M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Upl7uMVDLcYLhBMyd1ZP6ZTZEs7ok33mUqUXvLb3js+EpiTwicGoAfSIWLZ5ZsQp336L1AC7rULaVcJvum6Qgk8sSi7DGKqYmqjjdKLq7CvFo2JzZznni3SsbzEB9cerPGXkYMji5cwS/liUiivP/2knnDMeMrMZMHWgyMEFNug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GKFOwnTS; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775807372; x=1807343372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k4iVYr4cQFswdWaUcb7d4oIndXtfp8j3uUYioC/j5M4=;
  b=GKFOwnTSWlZ93lMW8DPiHtwHtGPEE6uLe5Z5LZqJAAZGUcIUlZ+DjUXp
   pdovqi7mm1wfDc3vYTMDf88hcSHNbgcCnUlBgnFL4jBUShqiM3Z6iIbM3
   +nyBGZUtEbWZInYgT63NwC2M0etmF/H8+Odw2IW+eaNvey1mLDfzRk2Qe
   l3qmNO84IaV+Cc+j8kPhQ5OjyXyzJDp/JgPNcxEBKqDmPmardskTqKt7G
   4LCBTnojnd+aEpo7kTIbBpEZEFNyHmH+GPLBRaVZpWykufhNtHhjWOFnQ
   4kSP2ligcL9b4kBE0bGriRL9UIA6uUChZly+IRP+PkvRz4lpr368tCwo2
   g==;
X-CSE-ConnectionGUID: kUJamzQ/TKS0VDM+gXOChg==
X-CSE-MsgGUID: 9Mf9ZkUUREO61vXRk0oHiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="77007930"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="77007930"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 00:49:32 -0700
X-CSE-ConnectionGUID: IWi7wY0FTW6hVjjbQHDDbg==
X-CSE-MsgGUID: X7frBN/QSRaZvfiy19Qa2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="228941880"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa008.jf.intel.com with ESMTP; 10 Apr 2026 00:49:31 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next 5/10] ice: improve Add/Update VSI error messages in ice_vsi_init()
Date: Fri, 10 Apr 2026 09:49:16 +0200
Message-ID: <20260410074921.1254213-6-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
References: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277291-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F1793D399E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The error messages emitted when Add VSI or Update VSI Admin
Queue commands fail are missing the VSI index and the last AQ
error code. Add both to match the pattern used elsewhere in
the driver for AQ-command failures, which helps narrow down
firmware issues without requiring debug logs.

Signed-off-by: Eric Joyner <eric.joyner@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 689c602..0e79d66 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1320,14 +1320,18 @@ static int ice_vsi_init(struct ice_vsi *vsi, u32 vsi_flags)
 	if (vsi_flags & ICE_VSI_FLAG_INIT) {
 		ret = ice_add_vsi(hw, vsi->idx, ctxt, NULL);
 		if (ret) {
-			dev_err(dev, "Add VSI failed, err %d\n", ret);
+			dev_err(dev, "Add VSI %d failed, err %d aq_err %s\n",
+				vsi->idx, ret,
+				libie_aq_str(hw->adminq.sq_last_status));
 			ret = -EIO;
 			goto out;
 		}
 	} else {
 		ret = ice_update_vsi(hw, vsi->idx, ctxt, NULL);
 		if (ret) {
-			dev_err(dev, "Update VSI failed, err %d\n", ret);
+			dev_err(dev, "Update VSI %d failed, err %d aq_err %s\n",
+				vsi->idx, ret,
+				libie_aq_str(hw->adminq.sq_last_status));
 			ret = -EIO;
 			goto out;
 		}
-- 
2.52.0


