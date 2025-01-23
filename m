Return-Path: <netdev+bounces-160502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44865A19FB2
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 09:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E83016DE91
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 08:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B5B20C006;
	Thu, 23 Jan 2025 08:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GNd3WSUE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A1020B80A
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737620343; cv=none; b=AVC/x5RMZHGqHgWSPLiTxcTJiBmNnlkAnQVo0xgsm0OWFJq1lPRSzEnzyL1imKX/h7wkd5hXwmvBawlHGmwOQ2eZcTFjuT9h2IBMWhW8/fnpKcg6ZwjzbVbuWGQufwFur2ECuInZ4edXvv0r1IFqmRzXmxiwZi+YpjHDK/vlrfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737620343; c=relaxed/simple;
	bh=e1qw4y4PLJCQfmeGcA03ZD+XvKSBFChpfjWZUn2EDtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T5e2ccAF/HbSMokHOyLU/Cdgy3eb//s2vZ9ZmNuoMomIiSyEGfx5S4fXtn+SixpWIuqNJySftS/xjrZCeTNbr3jJDnN3raNasirqpPP4C8QP09IY7gwbMNiNTl+ezEsVW1J/hztDNYRXlxG89X0B1v7a3X58UAY0otrkMTKPziA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GNd3WSUE; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737620342; x=1769156342;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e1qw4y4PLJCQfmeGcA03ZD+XvKSBFChpfjWZUn2EDtQ=;
  b=GNd3WSUEi/KqWucFtI5gAv3ALa0fRgtEmb5/Li5ePAMci0I78fc7WEWw
   6mF7CWQ5OyXvcnB+byOxyeoDJvxxDCr9KB9vMwVt2Oq+s2G04s9y41Lru
   qtYKGJr8QSqiTzGFTO4tL1lNlVq1Ek2J91aOZXcw1vrrgXiG/QQ9AxEZZ
   5w9xEL/rJcTc1wl2F5VsRSp0q1EUgdAArXmH5ptgYih7gn2ox1+w5G/Eh
   hJuaNPd1GquxHKNLMKHR/J4sTEXd8O8VsC5CrzaK0J/Z8fvyfR9tac1AN
   +OZPn6Tlf6LsAqGCLVdGpNQmieRFfSU67me2HSgzvbMOAYm7KhMxVojGZ
   g==;
X-CSE-ConnectionGUID: 4B9gfZwrTvi5P79/MPsZ4g==
X-CSE-MsgGUID: TajNjvshQyy1aajfsKev8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="37367431"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="37367431"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 00:19:01 -0800
X-CSE-ConnectionGUID: 3BCBMiajSwWA8L2gLrBW1A==
X-CSE-MsgGUID: t4F6L9C8RSG1qdHzUJ8/kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="144631774"
Received: from gklab-003-001.igk.intel.com ([10.211.3.1])
  by orviesa001.jf.intel.com with ESMTP; 23 Jan 2025 00:19:00 -0800
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-net v1] ice: fix memory leak in aRFS after reset
Date: Thu, 23 Jan 2025 09:15:39 +0100
Message-Id: <20250123081539.1814685-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix aRFS (accelerated Receive Flow Steering) structures memory leak by
adding a checker to verify if aRFS memory is already allocated while
configuring VSI. aRFS objects are allocated in two cases:
- as part of VSI initialization (at probe), and
- as part of reset handling

However, VSI reconfiguration executed during reset involves memory
allocation one more time, without prior releasing already allocated
resources. This led to the memory leak with the following signature:

[root@os-delivery ~]# cat /sys/kernel/debug/kmemleak
unreferenced object 0xff3c1ca7252e6000 (size 8192):
  comm "kworker/0:0", pid 8, jiffies 4296833052
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 0):
    [<ffffffff991ec485>] __kmalloc_cache_noprof+0x275/0x340
    [<ffffffffc0a6e06a>] ice_init_arfs+0x3a/0xe0 [ice]
    [<ffffffffc09f1027>] ice_vsi_cfg_def+0x607/0x850 [ice]
    [<ffffffffc09f244b>] ice_vsi_setup+0x5b/0x130 [ice]
    [<ffffffffc09c2131>] ice_init+0x1c1/0x460 [ice]
    [<ffffffffc09c64af>] ice_probe+0x2af/0x520 [ice]
    [<ffffffff994fbcd3>] local_pci_probe+0x43/0xa0
    [<ffffffff98f07103>] work_for_cpu_fn+0x13/0x20
    [<ffffffff98f0b6d9>] process_one_work+0x179/0x390
    [<ffffffff98f0c1e9>] worker_thread+0x239/0x340
    [<ffffffff98f14abc>] kthread+0xcc/0x100
    [<ffffffff98e45a6d>] ret_from_fork+0x2d/0x50
    [<ffffffff98e083ba>] ret_from_fork_asm+0x1a/0x30
    ...

Fixes: 28bf26724fdb ("ice: Implement aRFS")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_arfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_arfs.c b/drivers/net/ethernet/intel/ice/ice_arfs.c
index 7cee365cc7d1..405ddd17de1b 100644
--- a/drivers/net/ethernet/intel/ice/ice_arfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_arfs.c
@@ -511,7 +511,7 @@ void ice_init_arfs(struct ice_vsi *vsi)
 	struct hlist_head *arfs_fltr_list;
 	unsigned int i;
 
-	if (!vsi || vsi->type != ICE_VSI_PF)
+	if (!vsi || vsi->type != ICE_VSI_PF || ice_is_arfs_active(vsi))
 		return;
 
 	arfs_fltr_list = kcalloc(ICE_MAX_ARFS_LIST, sizeof(*arfs_fltr_list),

base-commit: 3ef16bb459c1a3af2c071cb5651877a47cd03295
-- 
2.39.3


