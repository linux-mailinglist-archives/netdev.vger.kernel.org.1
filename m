Return-Path: <netdev+bounces-247512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F439CFB6E8
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 01:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 844B130B6C0C
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 00:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F591D9346;
	Wed,  7 Jan 2026 00:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nl++eLsf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F011684B0
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 00:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767744424; cv=none; b=qvcHEdcQDls06stMlNHjPB1hkL0mtwM8hlYaJx4HJkHb5KwZL0jW4+NQlwIKJ5ZGQKRxBbp40pRa/z+WTs/CyjYApl0+SUstqD9fbT+sbqeT3HlLiG1K/HvPjrPYrX4vv2AJVACNjXxGJXVk0bLpwe1IJF/mkafQqrMGuHp7eEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767744424; c=relaxed/simple;
	bh=Lm56B2rmvMsHnsQi8V7z6Qn/NcbFLDCq6+Dl4CHTciY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHa3t0652wMMEFpXVM41LWhonKebxe3Q6GupKlACtP5lX27wYS2ZYbj8/dXImMm2tuMsskwSgo9Yq8qn9RQZ1igX/23paNs7j1HKmCZLwnNXjlkuSCsqwvlDS9KjhIJuqdR5gHRK9tqrEjd1w88twK3YcmGoQv2WrGCcaIlv9eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nl++eLsf; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767744423; x=1799280423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lm56B2rmvMsHnsQi8V7z6Qn/NcbFLDCq6+Dl4CHTciY=;
  b=nl++eLsfoDQa24Ac6U5hu5XXkCv8WFCgWJSQvvKQ7/FYOdqNMLNso7S9
   PJN1elkAyIDp/tuBlCQK38NuTx1ITzWx1dHraMI4mCjRrQRRSf56DXePU
   Tu8tj8+MJcBbVzoBE204u5d/tQDMdyA9VWC3F+Y8Slk4kx+tAFRxFBpEw
   jO5lRnVymyIQJ8IzyS+dx6Epz974TIlHpm1g1dbP9lxzLr4ircWD/8E5Y
   XBME3Xm4xLjjdT3E5MAIrOVO1J7BRy/d6TOpbqEfwnaMZvNTZiTfJLVUs
   b2BG5YuUyI9QQZpSolFzCrPNIgXCQxx8rzyZixkJ52Clnc3sxhw2MoIKC
   A==;
X-CSE-ConnectionGUID: 1LHZzrtRSLyy1Rwu1lLvzA==
X-CSE-MsgGUID: L4qE2MMxT2eMuJ11ErC0oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="69161678"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="69161678"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 16:06:55 -0800
X-CSE-ConnectionGUID: AyWFqLLSTH6aI+PEFc68VA==
X-CSE-MsgGUID: HFaxBJe2Qgaw0OQzz1V5AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="207841209"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 06 Jan 2026 16:06:55 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Sreedevi Joshi <sreedevi.joshi@intel.com>,
	anthony.l.nguyen@intel.com,
	willemb@google.com,
	Madhu Chittim <madhu.chittim@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 11/13] idpf: Fix error handling in idpf_vport_open()
Date: Tue,  6 Jan 2026 16:06:43 -0800
Message-ID: <20260107000648.1861994-12-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260107000648.1861994-1-anthony.l.nguyen@intel.com>
References: <20260107000648.1861994-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sreedevi Joshi <sreedevi.joshi@intel.com>

Fix error handling to properly cleanup interrupts when
idpf_vport_queue_ids_init() or idpf_rx_bufs_init_all() fail. Jump to
'intr_deinit' instead of 'queues_rel' to ensure interrupts are cleaned up
before releasing other resources.

Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 003bab3ce5ae..131a8121839b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1524,14 +1524,14 @@ static int idpf_vport_open(struct idpf_vport *vport, bool rtnl)
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to initialize queue registers for vport %u: %d\n",
 			vport->vport_id, err);
-		goto queues_rel;
+		goto intr_deinit;
 	}
 
 	err = idpf_rx_bufs_init_all(vport);
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to initialize RX buffers for vport %u: %d\n",
 			vport->vport_id, err);
-		goto queues_rel;
+		goto intr_deinit;
 	}
 
 	idpf_rx_init_buf_tail(vport);
-- 
2.47.1


