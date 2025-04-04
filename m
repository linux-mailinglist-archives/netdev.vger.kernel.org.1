Return-Path: <netdev+bounces-179289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E82EA7BB3B
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 12:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95B637A77CF
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 10:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13051BEF87;
	Fri,  4 Apr 2025 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kbBVfJOd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C955E33997
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743764078; cv=none; b=qvr8pgsmOP5Z/G3cqrMkfX/yodhehe2vahAvo5wB9wL3pAW5/aoA+v6Avfk+uf0IgKlhzDTeIrtlYLJMN7MhS4dPeLcpB73iMk+GaOOOq3FiPA/mZVTlU+41aO1eKZ4/E232IeDAP4TXaPs7ywIyxwhkOKslsdmu2aqGeqv4GIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743764078; c=relaxed/simple;
	bh=0pDCvWu4Ref5zXee9U/DUkQNZtb/fGPhcUajvIgaxfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YUn92L1LLPQuxeux2z9/6yGDxxF56YUHQ34dFCQlD9oho3sA0soYwKppU1ybr2upHVnyBFTvdhpYns8thJlfEyokl9Zf4pude6nUfXjKXZWur9IWdDXN96LylIrfcbdswmhDg4hhNkzkm95/ZLp6rUhV0SC5XAiSgWoeA5txw+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kbBVfJOd; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743764077; x=1775300077;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0pDCvWu4Ref5zXee9U/DUkQNZtb/fGPhcUajvIgaxfI=;
  b=kbBVfJOdCL2jIIVASINfKc+3YEZuCEI7uxrEaUIn9dQttTrT4w4nE9Li
   7dCGaq03nSp3l6s9mSCWYelCwzUEE4JLraM7aMKP1YTcC5pAtAnLB7Omo
   Uqnn9mGHmhhO2dq48RGlbi63lXsTue6mghCaT9kZ9MvW1q5OATZjyF94G
   Y5E4h/i2yyHLKM2asTdrR6AHcFFwxp/aEc0lUrSEI8eB5d2oXW4TM+VNH
   XgEz+mBd+TTIWf4V8cv05HLQOAhroZQ2xeE+ilg8N9Y/8nhZ6owbWJ2HJ
   wdEjUwhTyMdIXHh22fwAyXm+wS8AO+LH4N4WINMUVBNG/qyLw9m2K3h1S
   w==;
X-CSE-ConnectionGUID: 5MuSdQQNSbKpqIwLFBuyPw==
X-CSE-MsgGUID: l0zWVlDtT4qMxXfzz7Q6Xw==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="55391684"
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="55391684"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 03:54:36 -0700
X-CSE-ConnectionGUID: H/OlWP3fQweo78IyIL7C6g==
X-CSE-MsgGUID: 5nxmmvAXQv6CGO3opJoNTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="132484684"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by orviesa005.jf.intel.com with ESMTP; 04 Apr 2025 03:54:34 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-net v1] idpf: fix potential memory leak on kcalloc() failure
Date: Fri,  4 Apr 2025 12:54:21 +0200
Message-ID: <20250404105421.1257835-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of failing on rss_data->rss_key allocation the function is
freeing vport without freeing earlier allocated q_vector_idxs. Fix it.

Move from freeing in error branch to goto scheme.

Fixes: 95af467d9a4e ("idpf: configure resources for RX queues")
Reviewed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Suggested-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index aa755dedb41d..329ba53e86fd 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1132,11 +1132,9 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 
 	num_max_q = max(max_q->max_txq, max_q->max_rxq);
 	vport->q_vector_idxs = kcalloc(num_max_q, sizeof(u16), GFP_KERNEL);
-	if (!vport->q_vector_idxs) {
-		kfree(vport);
+	if (!vport->q_vector_idxs)
+		goto free_vport;
 
-		return NULL;
-	}
 	idpf_vport_init(vport, max_q);
 
 	/* This alloc is done separate from the LUT because it's not strictly
@@ -1146,11 +1144,9 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 	 */
 	rss_data = &adapter->vport_config[idx]->user_config.rss_data;
 	rss_data->rss_key = kzalloc(rss_data->rss_key_size, GFP_KERNEL);
-	if (!rss_data->rss_key) {
-		kfree(vport);
+	if (!rss_data->rss_key)
+		goto free_vector_idxs;
 
-		return NULL;
-	}
 	/* Initialize default rss key */
 	netdev_rss_key_fill((void *)rss_data->rss_key, rss_data->rss_key_size);
 
@@ -1163,6 +1159,13 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 	adapter->next_vport = idpf_get_free_slot(adapter);
 
 	return vport;
+
+free_vector_idxs:
+	kfree(vport->q_vector_idxs);
+free_vport:
+	kfree(vport);
+
+	return NULL;
 }
 
 /**
-- 
2.42.0


