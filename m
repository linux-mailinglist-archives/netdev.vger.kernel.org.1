Return-Path: <netdev+bounces-145145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D65559CD596
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 03:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D3EE1F22296
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 02:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A4720B20;
	Fri, 15 Nov 2024 02:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kKM6N/My"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88BD13AD11
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 02:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731638651; cv=none; b=uwT98lVroqbD8OqotHqiDrZwfcHv4J9yTmmmVcPTM/O4ZPwaEDayIA7EO89e2c0tMA9ATSxWbpTjhqYIDEguxmPCxNy6WQuvucTjN1r3rs2An3AHmsPOOtVxM4VbwEX0DF99l5ekGX0/rwRejpJbKhDeftzScEqxIXFwbCKDQ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731638651; c=relaxed/simple;
	bh=OxSWWLIUP+xkl6A/4kcNUvrt7MZBic5/QiYfBI412ds=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ltTdlrLQXidfhbaRXPi2BFnZ4p/PNLAWRV+Ff2VkmhBfL8EKPtwcWT+4154N68Zmkey40PXu8Ttx4AVZSFGUxQhQ0yEbjlCSMo2cdetc/+6PQ4yVqv3Q2V9ifKG05dM6+tT3is247PBQDY9iakj6lzkJ/AeDLjx23/9PEZCmjKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kKM6N/My; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731638650; x=1763174650;
  h=from:to:cc:subject:date:message-id;
  bh=OxSWWLIUP+xkl6A/4kcNUvrt7MZBic5/QiYfBI412ds=;
  b=kKM6N/MyJ8oOnle+eQkx3eb6VpVok73YYICpM3PxDu30pFLkOUcE/MDK
   rYrNfgHSkNAW5v2Ss82rN+KEtEykYJAUSHG0WQ6hoeS9RuFdu8Y8za9H2
   PXByxTJO8DBzAXuR7MM43/SrFsGAMoaJlWvw9ZoyKAs/H9WGj6Bl+oC2B
   Sel4VIuFU6nTS8t9NhJpznOPjNPBp0BeHtHgFL1jQN0mITednrWDj49Mn
   DU8sg4W1GDnLRVAR1xathDV+LpS9NJVOHzKsDIxm3s6h58YRtlsLlWtti
   sPQvtzobEdqAzR24LxUa8x46f83bP+79n9gZh+312n7ulIwQ9fqMAdMQG
   A==;
X-CSE-ConnectionGUID: AJxmKtInQyiY/1Dmdcw/Mg==
X-CSE-MsgGUID: w9ORdI15QvyxCQ3+IcWTLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="31722670"
X-IronPort-AV: E=Sophos;i="6.12,155,1728975600"; 
   d="scan'208";a="31722670"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 18:44:09 -0800
X-CSE-ConnectionGUID: GAOiYYtBQ2WMzyanpPCy2g==
X-CSE-MsgGUID: 3AHNBOZ4RLqcJgI5djzekA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,155,1728975600"; 
   d="scan'208";a="93467477"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by orviesa004.jf.intel.com with ESMTP; 14 Nov 2024 18:16:44 -0800
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	sridhar.samudrala@intel.com,
	rlance@google.com,
	decot@google.com,
	willemb@google.com,
	joshua.a.hay@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH iwl-net] idpf: add read memory barrier when checking descriptor done bit
Date: Thu, 14 Nov 2024 18:16:18 -0800
Message-Id: <20241115021618.20565-1-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Add read memory barrier to ensure the order of operations when accessing
control queue descriptors. Specifically, we want to avoid cases where loads
can be reordered:

1. Load #1 is dispatched to read descriptor flags.
2. Load #2 is dispatched to read some other field from the descriptor.
3. Load #2 completes, accessing memory/cache at a point in time when the DD
   flag is zero.
4. NIC DMA overwrites the descriptor, now the DD flag is one.
5. Any fields loaded before step 4 are now inconsistent with the actual
   descriptor state.

Add read memory barrier between steps 1 and 2, so that load #2 is not
executed until load has completed.

Fixes: 8077c727561a ("idpf: add controlq init and reset checks")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Suggested-by: Lance Richardson <rlance@google.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_controlq.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_controlq.c b/drivers/net/ethernet/intel/idpf/idpf_controlq.c
index 4849590a5591..61c7fafa54a1 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_controlq.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_controlq.c
@@ -375,6 +375,11 @@ int idpf_ctlq_clean_sq(struct idpf_ctlq_info *cq, u16 *clean_count,
 		desc = IDPF_CTLQ_DESC(cq, ntc);
 		if (!(le16_to_cpu(desc->flags) & IDPF_CTLQ_FLAG_DD))
 			break;
+		/*
+		 * This barrier is needed to ensure that no other fields
+		 * are read until we check the DD flag.
+		 */
+		dma_rmb();
 
 		/* strip off FW internal code */
 		desc_err = le16_to_cpu(desc->ret_val) & 0xff;
@@ -562,6 +567,11 @@ int idpf_ctlq_recv(struct idpf_ctlq_info *cq, u16 *num_q_msg,
 
 		if (!(flags & IDPF_CTLQ_FLAG_DD))
 			break;
+		/*
+		 * This barrier is needed to ensure that no other fields
+		 * are read until we check the DD flag.
+		 */
+		dma_rmb();
 
 		q_msg[i].vmvf_type = (flags &
 				      (IDPF_CTLQ_FLAG_FTYPE_VM |
-- 
2.17.2


