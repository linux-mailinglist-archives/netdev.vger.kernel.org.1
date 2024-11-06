Return-Path: <netdev+bounces-142503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E239BF5DB
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 19:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863BD283F45
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 18:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BC8209F38;
	Wed,  6 Nov 2024 18:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KWN9SHia"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C72F20899B
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 18:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730919536; cv=none; b=fL1RT9+c3KXAt1k6IYIK3kN269b4EQS85OsU43m5a4/nHgglh+3PhqwfZXm/67JbnB0uDIs5HdgFLWAcloRJup62hnac23mCKuu4cw0ab+qPgu3vgy/lUjSslVkTCsmAR66rIIGs+62WDw6+M7v2q5XtVnE+zT5Grrb+cACI/JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730919536; c=relaxed/simple;
	bh=BSTanTvgy8F9pAWrlA1C77KF0dadSQNV5HSq+b3Q1QA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lRwvEvdl6VZzM7ZZ29hMCeo6FXWxlCaK8gQGlND/7zMVAcYItrZ9Q2JpgyfkS7aKS0E30xrCS6chTUezzy+mLzf43R5y8J/ss7JYb1dJpUq3CqoB6k0tAiAXFeg73a/ri+28tDB5ZKTod1+VlyPc5XeYCDr8i55SeEmdwb/4/fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KWN9SHia; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730919534; x=1762455534;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BSTanTvgy8F9pAWrlA1C77KF0dadSQNV5HSq+b3Q1QA=;
  b=KWN9SHiac9GeCA7rU/IQyl977X/4E+NBdC8hUmVpU4jipE+fpOH/fvNn
   aulTPGepAaCkzsq8g1ujuN+Q/94BWMGAfSSFzfyohYHP1CoGa/rbCfm7n
   0pWHePO38mGAp/E4RDDVCp6jsNU1Uu7ZtTchn5r/qsnP7FLApcmdqaTCN
   BObKD1qkOhDEOLk+Y/KC2aiDTrRXI9LpcKaQjbFLEWQJ+LRpb0XTx+7Xz
   J1pL7wwYlF12jQlcik4CNnm/7CfDNvtC4P7dHxYvBTepxvFtgTrQSfy4/
   sS6M08gg2XKKBfbjw7InSG+nRy8yLQiqiF/F41+RwkVsR2pmwQfX13yE3
   g==;
X-CSE-ConnectionGUID: v38Gb5oES1mTyVHldej0cw==
X-CSE-MsgGUID: nzf7TSc3TcOtXcv0V6aMeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="30959477"
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="30959477"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 10:58:51 -0800
X-CSE-ConnectionGUID: ZR5yPnz3QxqLoS0eu4ZYZA==
X-CSE-MsgGUID: 1a109r1QQcCjJYWYVWOQkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="89813799"
Received: from timelab-spr11.ch.intel.com ([143.182.136.151])
  by orviesa004.jf.intel.com with ESMTP; 06 Nov 2024 10:56:41 -0800
From: Christopher S M Hall <christopher.s.hall@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: david.zage@intel.com,
	vinicius.gomes@intel.com,
	netdev@vger.kernel.org,
	rodrigo.cadore@l-acoustics.com,
	vinschen@redhat.com
Subject: [PATCH iwl-net v3 5/6] igc: Cleanup PTP module if probe fails
Date: Wed,  6 Nov 2024 18:47:21 +0000
Message-Id: <20241106184722.17230-6-christopher.s.hall@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241106184722.17230-1-christopher.s.hall@intel.com>
References: <20241106184722.17230-1-christopher.s.hall@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure that the PTP module is cleaned up if the igc_probe() fails by
calling igc_ptp_stop() on exit.

Fixes: d89f88419f99 ("igc: Add skeletal frame for Intel(R) 2.5G Ethernet Controller support")
Signed-off-by: Christopher S M Hall <christopher.s.hall@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 6e70bca15db1..cc89b72c85af 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7169,6 +7169,7 @@ static int igc_probe(struct pci_dev *pdev,
 
 err_register:
 	igc_release_hw_control(adapter);
+	igc_ptp_stop(adapter);
 err_eeprom:
 	if (!igc_check_reset_block(hw))
 		igc_reset_phy(hw);
-- 
2.34.1


