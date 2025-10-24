Return-Path: <netdev+bounces-232706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C89FC08200
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 22:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ABC71C822F8
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 20:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA602FD67A;
	Fri, 24 Oct 2025 20:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JyTq/A44"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0C42FC03E
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 20:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338879; cv=none; b=Ho1HYQT6KAMt9u9Ltm9KE8d4wTPDT2CobMfD3l+lw+ak865Gp6dsYxN/Ng0/9cFGHsKczAToi8FlZmjkHuQaXjrFYzOrKotijIjLq+pUkax5RvCOhqp4inYs4HHFF0kutfvL5PDnMG7YIoC97lYZ0FuAUhC8eC4+mcPud8fJeQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338879; c=relaxed/simple;
	bh=uxWmHIR/qb3EsourmkHbSts4cK8B6p2YhLggkabzkVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPIqm3HZNAtpSY7nHfn6rGWS48u3QGYIDWUgJ0ContgDK/4xO9TJ47naBURJlRWcrRYJvEmm4v8lfuZDnx2Gi7mdMXOOvVk4PPvT6QNnNGEcaJUHY8XO8CcFrM4K0DJ4JWoZafl2GfUAh9jxpbmvwz8WaRnL42s9fwnbrsGTqrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JyTq/A44; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761338878; x=1792874878;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uxWmHIR/qb3EsourmkHbSts4cK8B6p2YhLggkabzkVo=;
  b=JyTq/A44hm7DuRPiEvshLmpPL9r8Numx9CUb5zS8wY7g+nLRJbMCksL9
   wxbzXxhEaoYah7AEaJeusH7b3D88ZrxyJLxwajeLrraaDy/pfkdRsgiZw
   +OIUg8Z8sYHPXnCvxRYgw+X/xipho2lvk7sMybMJJEPRgYtCeSGvy7XcY
   NKhyu/iA4D5/Sf85FL/jdK7eb3oOLH4KVGMFS7SkvMgS3otM2FqNq3+5v
   nKMYbwxtVhZSJStdVFwsomQtk4EpXfu8h1Dyx6BKXoYD9eCqjP6gT28/M
   +BxkXJNojVstfVWn7DzZKdEnSl7LVo/QA2piBgc0szo8fZ5IzPJZ4ND95
   Q==;
X-CSE-ConnectionGUID: gT1S8HyARMqUbAl0r+ayJg==
X-CSE-MsgGUID: LS3ABRJXQLWnQ6qCddnwGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66139509"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="66139509"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 13:47:53 -0700
X-CSE-ConnectionGUID: lMG3qrf3R4uj6Wf2ij5cqw==
X-CSE-MsgGUID: L3u7ggZrTYCFG5gJnObv0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="188821533"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 24 Oct 2025 13:47:54 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	mschmidt@redhat.com,
	poros@redhat.com,
	horms@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 7/9] ice: extract ice_init_dev() from ice_init()
Date: Fri, 24 Oct 2025 13:47:42 -0700
Message-ID: <20251024204746.3092277-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251024204746.3092277-1-anthony.l.nguyen@intel.com>
References: <20251024204746.3092277-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Extract ice_init_dev() from ice_init(), to allow service task and IRQ
scheme teardown to be put after clearing SW constructs in the subsequent
commit.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index a4acc42fabab..9a817c3c8b99 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5023,14 +5023,10 @@ static int ice_init(struct ice_pf *pf)
 	struct device *dev = ice_pf_to_dev(pf);
 	int err;
 
-	err = ice_init_dev(pf);
-	if (err)
-		return err;
-
 	err = ice_init_pf(pf);
 	if (err) {
 		dev_err(dev, "ice_init_pf failed: %d\n", err);
-		goto unroll_dev_init;
+		return err;
 	}
 
 	if (pf->hw.mac_type == ICE_MAC_E830) {
@@ -5080,8 +5076,6 @@ static int ice_init(struct ice_pf *pf)
 	ice_dealloc_vsis(pf);
 unroll_pf_init:
 	ice_deinit_pf(pf);
-unroll_dev_init:
-	ice_deinit_dev(pf);
 	return err;
 }
 
@@ -5093,7 +5087,6 @@ static void ice_deinit(struct ice_pf *pf)
 	ice_deinit_pf_sw(pf);
 	ice_dealloc_vsis(pf);
 	ice_deinit_pf(pf);
-	ice_deinit_dev(pf);
 }
 
 /**
@@ -5323,10 +5316,14 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	}
 	pf->adapter = adapter;
 
-	err = ice_init(pf);
+	err = ice_init_dev(pf);
 	if (err)
 		goto unroll_adapter;
 
+	err = ice_init(pf);
+	if (err)
+		goto unroll_dev_init;
+
 	devl_lock(priv_to_devlink(pf));
 	err = ice_load(pf);
 	if (err)
@@ -5344,6 +5341,8 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 unroll_init:
 	devl_unlock(priv_to_devlink(pf));
 	ice_deinit(pf);
+unroll_dev_init:
+	ice_deinit_dev(pf);
 unroll_adapter:
 	ice_adapter_put(pdev);
 unroll_hw_init:
@@ -5457,6 +5456,7 @@ static void ice_remove(struct pci_dev *pdev)
 	devl_unlock(priv_to_devlink(pf));
 
 	ice_deinit(pf);
+	ice_deinit_dev(pf);
 	ice_vsi_release_all(pf);
 
 	ice_setup_mc_magic_wake(pf);
-- 
2.47.1


