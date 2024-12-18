Return-Path: <netdev+bounces-152782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B58B79F5C5E
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 02:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04AB316D1C8
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 01:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7021E487;
	Wed, 18 Dec 2024 01:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UQsAveae"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F4F35943
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 01:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734486287; cv=none; b=mbV+N6cp/oIipUrfauY+5rR1ygIIUNvkhKqHAo1c4HWMo7Z8spilK/nJz2bAbAGQAahkf8U0JVerW3M5I5OfthMqyJqtKK1tiqfYc8eSPxlLZq0wOzKTNCpoxgdhK7Sir01qvJNipuxqZa2Ik7dgpLqqRndWjwiisfe4mvOGCBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734486287; c=relaxed/simple;
	bh=rc5Oak5ththCfaouKkHXpJ25iMp4MsNHSLl2DDjTT1w=;
	h=From:To:Cc:Subject:Date:Message-Id; b=bhLsEyYoL17Nfw6majaQx2b45M4l8REwDZT3Jb8dlyY6NuTYzLpFTh+7thBzmP/1HI8cwR2I0AZEHPUdvU36uy437vjCBZb9FvNSGCaJgkjFwBSdQFVehZ0ibpevZbJ1IbwDSuqRBBeGb0Deqy9+Q05qD7o/5iZCK+50Y2LeX4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UQsAveae; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734486284; x=1766022284;
  h=from:to:cc:subject:date:message-id;
  bh=rc5Oak5ththCfaouKkHXpJ25iMp4MsNHSLl2DDjTT1w=;
  b=UQsAveaeCAdj1mXHjwCtGXQDf8gJ6OlInRHVB7iNcqtMti+2M0+HNkra
   LmWvGQNHP0opMZKkbOIqC9kiGFcvubyErCQSvnbnKvvzD/sOjVYTGVfrM
   gRxB/m+ThHfu7fdbXIFj5NcZfAEGhqlts5CuxnrLYKkE/fI9khJyFczsJ
   2irTIx9eey+6M/K75Sedvv2QjgKZpYxPL4+Avn2IQaqjnYHLwdq1TpYVy
   7r3GknrInMkAW4gUSEUU166FcoWqLIfZ/fOR/7X6zjtHx1ZBKW31BPIPA
   jnj1H8zQoNEEEYPcK+55T0oHryZPvK6h/6D8/3Vpy14mkEH/TE58yRarh
   A==;
X-CSE-ConnectionGUID: Gjc2SqAaTiudd2i2Et10Gw==
X-CSE-MsgGUID: pqs4BGOdQ5S1FB5WE9IJEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="35098527"
X-IronPort-AV: E=Sophos;i="6.12,243,1728975600"; 
   d="scan'208";a="35098527"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 17:44:44 -0800
X-CSE-ConnectionGUID: Q5b06jyBRSKTr0GEkOHzsg==
X-CSE-MsgGUID: yYm0AC2rSjKgPYENcCTe3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,243,1728975600"; 
   d="scan'208";a="102708481"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by orviesa004.jf.intel.com with ESMTP; 17 Dec 2024 17:44:43 -0800
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
	pabeni@redhat.com
Subject: [PATCH iwl-net] idpf: fix transaction timeouts on reset
Date: Tue, 17 Dec 2024 17:44:17 -0800
Message-Id: <20241218014417.3786-1-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Restore the call to idpf_vc_xn_shutdown() at the beginning of
idpf_vc_core_deinit() provided the function is not called on
remove. In the reset path this call is needed to prevent mailbox
transactions from timing out.

Fixes: 09d0fb5cb30e ("idpf: deinit virtchnl transaction manager after vport and vectors")
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
Testing hints:
echo 1 > /sys/class/net/<netif>/device/reset
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index d46c95f91b0d..0387794daf17 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3080,9 +3080,15 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 	if (!test_bit(IDPF_VC_CORE_INIT, adapter->flags))
 		return;
 
+	/* Avoid transaction timeouts when called during reset */
+	if (!test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
+		idpf_vc_xn_shutdown(adapter->vcxn_mngr);
+
 	idpf_deinit_task(adapter);
 	idpf_intr_rel(adapter);
-	idpf_vc_xn_shutdown(adapter->vcxn_mngr);
+
+	if (test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
+		idpf_vc_xn_shutdown(adapter->vcxn_mngr);
 
 	cancel_delayed_work_sync(&adapter->serv_task);
 	cancel_delayed_work_sync(&adapter->mbx_task);
-- 
2.17.2


