Return-Path: <netdev+bounces-146803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449419D5F34
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 13:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BBE7282DD7
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 12:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B329B1DF969;
	Fri, 22 Nov 2024 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="La76uv8t"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10731DF989
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 12:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732279616; cv=none; b=C7S/DEYazCVrZ8onWl19ieT2GcKcf47rYG8bvmGYGZ5G2hoZc59mJI45YJ3A6xIEESFQvZwvMnitwfbdWlfb4xgi4dA6oVy5GCYP4GS2Bq7S3Lnc5me9+d/uKv3VHrETDDMwqVarZmndY8HgkwCVWg+0xuPoRpmPfgg3MHc5Bzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732279616; c=relaxed/simple;
	bh=yvSMM6KMScxa/lLEsxxshorzTDmjaupIGau2oY4cgn0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d6PS+YUgVYPYefL2VKs2+4v+wnhve9ILCjt05T4nAEMoIN72m0diJk88N2Zjl+3hTeTSIIrDKkxsgsPw32EM8lb4JQ1Pns37819Hvl374y7gY/fCdPQBz2we92SA/5GvSiovZPF4fEl28kVieIhsUfhqFELPRJv+wBkNQzGwuC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=La76uv8t; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732279615; x=1763815615;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yvSMM6KMScxa/lLEsxxshorzTDmjaupIGau2oY4cgn0=;
  b=La76uv8tlXUyAg6mzMhrqgilJXFzP0u/Y5BZF7nzWVXAB9DAUJqBMs1n
   QiG7dtHRFJEnXtZ+46ikyC0J+NglcOzsH4La20Oh848i0qyqE9BnkTRSI
   KaQa2TIBedBOUtJxlMgCQdYU9So+M4FsTs2sayi0B/+i9jTYQ6xEv8S9L
   BTJcoDkYJX0F1TZfmPmtVArvgutP+8nnuDZhQVGFdesDGtzaLZ5pHze6b
   vDaOxvBDm+l4xjbgG5eAmu60P4NJXJoeTkxcp7QF9SZjTTGVuQ/ehSbC4
   3oFRfhL2KuaKg6CYyWPFPxQkeiXcjWh4J9rfSmVLojJOsdEq8wPzY8OOX
   g==;
X-CSE-ConnectionGUID: v1xiOzoKQCqGIhk+mjhSeA==
X-CSE-MsgGUID: V62UDumzSISbgD/G1lYrEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32585219"
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="32585219"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 04:46:54 -0800
X-CSE-ConnectionGUID: 2f6oPqMeR4y23dnEGaEBXg==
X-CSE-MsgGUID: y7FSIJ20R8aQc8Z9vlwBUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="90371100"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by fmviesa007.fm.intel.com with ESMTP; 22 Nov 2024 04:46:53 -0800
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next] ixgbe: Enable XDP support when SRIOV is enabled
Date: Fri, 22 Nov 2024 13:13:18 +0100
Message-Id: <20241122121317.2117826-1-martyna.szapar-mudlaw@linux.intel.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the check that prevents XDP support when SRIOV is enabled.
There is no reason to completely forbid the user from using XDP
with SRIOV.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>

---

Added CC netdev

---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 459a539cf8db..a07e28107a42 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10637,9 +10637,6 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 	bool need_reset;
 	int num_queues;
 
-	if (adapter->flags & IXGBE_FLAG_SRIOV_ENABLED)
-		return -EINVAL;
-
 	if (adapter->flags & IXGBE_FLAG_DCB_ENABLED)
 		return -EINVAL;
 
-- 
2.36.1


