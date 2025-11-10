Return-Path: <netdev+bounces-237293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05551C48816
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 19:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA3A3B7243
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 18:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388173277A9;
	Mon, 10 Nov 2025 18:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bBzIgnOD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A434D326D70
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762798525; cv=none; b=liLrvxK6IjKaddOW9qJKGO8ULWtQt+TvfI+m1GPvPasTqb5p1NKyTs7ZSp7EugtpBQd6+YcMDFqPC9HcERKGwJW39eMUrEdYBIgLwckOI5JwbcIh6xEZD5BLzDcEqpSSwVg6N4iKu8XFzFLGFOuz/XaYkn3XGLJDu7dneci17mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762798525; c=relaxed/simple;
	bh=Sh6c7b6Hi90RoX/bOeWbivnnXi5ySOfBIpzuddrreJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Z0fG974ByDRNPzOont50oKyBaI3qeZQyAaz3gEIa8wVXjYZZkGMFzAqEoHKZpG+MxQDrQQlUyxWHcH1gC/8SVI51TpAdTy1ll/ehvZiMxlBeZQ4kat8CceGPf9MQVWuzdGRsTjozH/e7I5NUzwWMHR1mwI9BCCkuRk66NpirtRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bBzIgnOD; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762798524; x=1794334524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Sh6c7b6Hi90RoX/bOeWbivnnXi5ySOfBIpzuddrreJs=;
  b=bBzIgnODlji5d/a5FpwgqxpFVRMXYpY2meTuEd6CGCppWsgXjZ+NI5Q6
   MBdveVaHQ5YYHYVUXdytTZrTljdcUkZUgzmv6fXPvLoWmGpIwqQrIH01j
   VVoetlY0M69AEAEcqXKWCR36WfXsc8JXRN1vDsIn9ijTDL2fFEL+VemEi
   +KlQfGgpXU6N2fkpEU3HNwPE83dqZYI4jWMWfx4jKBPv/iisUPS1MbSJ4
   om6rEmtNxB7gn0eki4TEbJGk6WwKTpK9pN6L+WM9nfQxpPAfYOxZBPzCW
   FhWBrcZDTYyP22mYyZbbC8q0WA55YwVNWtZ5D0SP+CkWE6p8xC4evwjbJ
   Q==;
X-CSE-ConnectionGUID: 7K3uGJBqT4yRal5WkQtGjQ==
X-CSE-MsgGUID: u3a30mptTq+4PuAJ+bZ92Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="87485213"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="87485213"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 10:15:22 -0800
X-CSE-ConnectionGUID: yYps9khsRfiJx6ucmP3LYA==
X-CSE-MsgGUID: GPqX35rWQVitbrLOI3Rx1A==
X-ExtLoop1: 1
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by fmviesa003.fm.intel.com with ESMTP; 10 Nov 2025 10:15:21 -0800
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Aleksandr.Loktionov@intel.com,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	decot@google.com,
	willemb@google.com,
	joshua.a.hay@intel.com,
	madhu.chittim@intel.com,
	aleksander.lobakin@intel.com,
	larysa.zaremba@intel.com,
	iamvivekkumar@google.com
Subject: [PATCH iwl-net 4/4] idpf: fix memory leak in idpf_vc_core_deinit()
Date: Mon, 10 Nov 2025 10:08:23 -0800
Message-Id: <20251110180823.18008-5-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20251110180823.18008-1-emil.s.tantilov@intel.com>
References: <20251110180823.18008-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Make sure to free hw->lan_regs. Reported by kmemleak during reset:

unreferenced object 0xff1b913d02a936c0 (size 96):
  comm "kworker/u258:14", pid 2174, jiffies 4294958305
  hex dump (first 32 bytes):
    00 00 00 c0 a8 ba 2d ff 00 00 00 00 00 00 00 00  ......-.........
    00 00 40 08 00 00 00 00 00 00 25 b3 a8 ba 2d ff  ..@.......%...-.
  backtrace (crc 36063c4f):
    __kmalloc_noprof+0x48f/0x890
    idpf_vc_core_init+0x6ce/0x9b0 [idpf]
    idpf_vc_event_task+0x1fb/0x350 [idpf]
    process_one_work+0x226/0x6d0
    worker_thread+0x19e/0x340
    kthread+0x10f/0x250
    ret_from_fork+0x251/0x2b0
    ret_from_fork_asm+0x1a/0x30

Fixes: 6aa53e861c1a ("idpf: implement get LAN MMIO memory regions")
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Joshua Hay <joshua.a.hay@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index fc03d55bc9b9..ca302df9ff40 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3570,6 +3570,7 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
  */
 void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 {
+	struct idpf_hw *hw = &adapter->hw;
 	bool remove_in_prog;
 
 	if (!test_bit(IDPF_VC_CORE_INIT, adapter->flags))
@@ -3593,6 +3594,9 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 
 	idpf_vport_params_buf_rel(adapter);
 
+	kfree(hw->lan_regs);
+	hw->lan_regs = NULL;
+
 	kfree(adapter->vports);
 	adapter->vports = NULL;
 
-- 
2.37.3


