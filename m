Return-Path: <netdev+bounces-245237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AE3CC970C
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 20:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0EC23033587
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 19:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A5C2C11D5;
	Wed, 17 Dec 2025 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mHWQK98y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B024F2F6907
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 19:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766001006; cv=none; b=B9zOCnbdINl+O4EgQUogO+FVBM2bHdMoCJqkrOdS0oyMAWJNrS7JBarcuipeRhLNhZMbvLbEojIPZAPYhQy8kulq+x1vZJ0kAceudzUgMX075JFUeCFSWyJVm30nT/8zEt45+rCZjGVVtybfrkBZfIEboNBJEZIgBtPEtInIkqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766001006; c=relaxed/simple;
	bh=8+LMSFy8gKb1Gy0xiWDQ5E66KC9CwAY4G+f5ES/gbr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZi//UA5tAXi7w+PDDb2bj62++qtAEeduDD2WzmRNSIGPm6VbHYEBz0Wo51Qt+6Y4sl/L3Yqc22boWg4ZnYKZOfsU/XPyMECKqNfAhTndr2P/+fUll0TqfnILp7HBNOiXucrbwbwS0aJSJxstSXV6Ve08o0yH7unRxxFki6yo/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mHWQK98y; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766001005; x=1797537005;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8+LMSFy8gKb1Gy0xiWDQ5E66KC9CwAY4G+f5ES/gbr0=;
  b=mHWQK98yE17q9/TFXoXnUALbEoKSD7qx5LdPSax9oQnq/I3koOECYotX
   aeJFf2ESpgD0ilRprDqBs5WcNIVMTcjBgNKh9NaJgpg7YZxiegVuUrth8
   98GZ/MtgifddSQkKx07A8iVwV30l+pez2mrqakIr1Dyl+kMbHLe27vTiJ
   8tXk7Dln7QNlqAd4KK1kKjD7HdDiW+Hb5BiPnxdF51GCKSWM34ObVVW+A
   Yy4sGDZst+EhZ1DnfvrfC+RCKFysqGi3cFkBMEGYPZBWge/i6B1TVMVQD
   OYBYSHa9mfZ/aX3KbQ+bjCGA/Wjl6rFCtQ+g0W0Ppn4rvcojwDVJtSA3a
   w==;
X-CSE-ConnectionGUID: 0SnkYqc5RlmofIIS16BYhA==
X-CSE-MsgGUID: E/2cD1bwSeCVpXrVPBqCvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="67841440"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="67841440"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 11:50:02 -0800
X-CSE-ConnectionGUID: aqBXnwzyTYaYtkj97jvqSQ==
X-CSE-MsgGUID: WY2DjFE+RT2YJcN7/dm4pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="202898046"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 17 Dec 2025 11:50:02 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	anthony.l.nguyen@intel.com,
	joshua.a.hay@intel.com,
	tatyana.e.nikolova@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Krishneil Singh <krishneil.k.singh@intel.com>
Subject: [PATCH net 4/6] idpf: fix LAN memory regions command on some NVMs
Date: Wed, 17 Dec 2025 11:49:43 -0800
Message-ID: <20251217194947.2992495-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251217194947.2992495-1-anthony.l.nguyen@intel.com>
References: <20251217194947.2992495-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Larysa Zaremba <larysa.zaremba@intel.com>

IPU SDK versions 1.9 through 2.0.5 require send buffer to contain a single
empty memory region. Set number of regions to 1 and use appropriate send
buffer size to satisfy this requirement.

Fixes: 6aa53e861c1a ("idpf: implement get LAN MMIO memory regions")
Suggested-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 44cd4b466c48..5bbe7d9294c1 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -1016,6 +1016,9 @@ static int idpf_send_get_lan_memory_regions(struct idpf_adapter *adapter)
 	struct idpf_vc_xn_params xn_params = {
 		.vc_op = VIRTCHNL2_OP_GET_LAN_MEMORY_REGIONS,
 		.recv_buf.iov_len = IDPF_CTLQ_MAX_BUF_LEN,
+		.send_buf.iov_len =
+			sizeof(struct virtchnl2_get_lan_memory_regions) +
+			sizeof(struct virtchnl2_mem_region),
 		.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
 	};
 	int num_regions, size;
@@ -1028,6 +1031,8 @@ static int idpf_send_get_lan_memory_regions(struct idpf_adapter *adapter)
 		return -ENOMEM;
 
 	xn_params.recv_buf.iov_base = rcvd_regions;
+	rcvd_regions->num_memory_regions = cpu_to_le16(1);
+	xn_params.send_buf.iov_base = rcvd_regions;
 	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
 	if (reply_sz < 0)
 		return reply_sz;
-- 
2.47.1


