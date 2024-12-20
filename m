Return-Path: <netdev+bounces-153543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCB09F8A01
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 03:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23711891FEF
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 02:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425DA17578;
	Fri, 20 Dec 2024 02:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ADyDzkSM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D554F9EC
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 02:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734660603; cv=none; b=C3RqBlzcbBbLNd2vnd2fbrB1IQJRQHvfXQuT4EdRCFdsbJ7dYZeVOrsUrF1m1wV3qSWCX6l/vwU70Rk7AR91db1ixqLNa74vMrSFGx6zKrCOEO9KlsbEVdMZrudoiZQtwtGVIs6whTWMcw72sVII68e+CmmdPAyx+34LA1va5/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734660603; c=relaxed/simple;
	bh=zeN4QCvtvaNWkOgM6yi3udrMDEAwBJzTCF0k4+EYssw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=rAa9jfiARgUHA9YOht8nRJDZwJJEpy1i/n8YVvC4U/9/QzCxNkKl3kqz7mcNOwvcRNBIfztBrzVAMkvJIm7oE9+dfXWvJNgq0WZ3zYj+cqJbFHQEWJ9XARyavqitdwiNWzb7H6rnVTcWoBJyqhaq2/nR9A11NR6uUc8gMgzxz0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ADyDzkSM; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734660601; x=1766196601;
  h=from:to:cc:subject:date:message-id;
  bh=zeN4QCvtvaNWkOgM6yi3udrMDEAwBJzTCF0k4+EYssw=;
  b=ADyDzkSMrni0q2dzD3FgrAThMrsgIgR9fo7FqLzCJ/e4DvARQ7RuGecx
   jwGe5Sn2K2Czv1heWF0SKkJEhqCBqux+uRDMEOxtk3iB7OhJ78s1+RMy4
   KU4OxsBmkIcdOnkw7W7yLzNmLx/Y30rr08URaNMBroL3GVRwykX70Hy3W
   niNXSooE/oGwCZ5l+7NGKAAor15K8Q8yREc/rLDIBuUcoRLlz2oGLdT45
   wZC2O6q7t1gKG5t6JvCPW7Jg9OkNGE4tlPRQApYFjriWjr9+Ako386HeL
   Ajcr+uLY3quZaJF2WOykIW7PjLw8tph4yb/iZsJBc/s59ac9cos4qnJ+8
   A==;
X-CSE-ConnectionGUID: Z9oAZPz/TiO7HOPm44d2Gg==
X-CSE-MsgGUID: p/O8KJlRTFGCZKDYoHKPuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="46584554"
X-IronPort-AV: E=Sophos;i="6.12,249,1728975600"; 
   d="scan'208";a="46584554"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 18:09:59 -0800
X-CSE-ConnectionGUID: N2nHVguGTTqbiqtgjxiErA==
X-CSE-MsgGUID: VS2EUpFaT2WyQgtGRPtdtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,249,1728975600"; 
   d="scan'208";a="98177588"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by fmviesa006.fm.intel.com with ESMTP; 19 Dec 2024 18:09:58 -0800
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	larysa.zaremba@intel.com,
	decot@google.com,
	willemb@google.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	aleksander.lobakin@intel.com
Subject: [PATCH iwl-net v2] idpf: fix transaction timeouts on reset
Date: Thu, 19 Dec 2024 18:09:32 -0800
Message-Id: <20241220020932.32545-1-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Restore the call to idpf_vc_xn_shutdown() at the beginning of
idpf_vc_core_deinit() provided the function is not called on remove.
In the reset path the mailbox is destroyed, leading to all transactions
timing out.

Fixes: 09d0fb5cb30e ("idpf: deinit virtchnl transaction manager after vport and vectors")
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
Changelog:
v2:
- Assigned the current state of REMOVE_IN_PROG flag to a boolean
  variable, to be checked instead of reading the flag twice.
- Updated the description to clarify the reason for the timeouts on
  reset is due to the mailbox being destroyed.

v1:
https://lore.kernel.org/intel-wired-lan/20241218014417.3786-1-emil.s.tantilov@intel.com/

Testing hints:
echo 1 > /sys/class/net/<netif>/device/reset
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index d46c95f91b0d..7639d520b806 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3077,12 +3077,21 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
  */
 void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 {
+	bool remove_in_prog;
+
 	if (!test_bit(IDPF_VC_CORE_INIT, adapter->flags))
 		return;
 
+	/* Avoid transaction timeouts when called during reset */
+	remove_in_prog = test_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
+	if (!remove_in_prog)
+		idpf_vc_xn_shutdown(adapter->vcxn_mngr);
+
 	idpf_deinit_task(adapter);
 	idpf_intr_rel(adapter);
-	idpf_vc_xn_shutdown(adapter->vcxn_mngr);
+
+	if (remove_in_prog)
+		idpf_vc_xn_shutdown(adapter->vcxn_mngr);
 
 	cancel_delayed_work_sync(&adapter->serv_task);
 	cancel_delayed_work_sync(&adapter->mbx_task);
-- 
2.17.2


