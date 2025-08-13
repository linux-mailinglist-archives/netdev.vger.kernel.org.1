Return-Path: <netdev+bounces-213398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 126C3B24D98
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 17:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8721AA39B8
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79ECC267714;
	Wed, 13 Aug 2025 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H2YMXzU5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D593D1F4CAE
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099205; cv=none; b=uExMn1tHUXACmbVsC/UpI3MhUbxbL6unTZat3Q9SX1ygtCL54CBSm63CsK8N3MUihKMEMl9roieF0hIo/yCFQNMgDTjkCNR0corTJUy5d27xDf7t8bhkRHUKt+5ZnjYGtB8iwAiN1eld1uD5VWZ5ZmCAd5LaVVjReOOeUzkX0jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099205; c=relaxed/simple;
	bh=Lfsr4ccnl0Hj8Ai02iL8Y7K6ZbjNWef0+nt5altBcx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lg5yH8/pFTGavU4h9U8kWQ2mxHdRv02JXgtzpRNJlCAxMaKfGu30ZAN7ZNDCpLS/SffbXYaOOjOlTASAgbxzzPMC/eYSt0yF0zZa9W6kIPo1S4k5k6ZARTEFEP4TLdGNVz8zrIcfDYcsUyEeGe1PlBmYZDZP2OrSsoj8tjju3C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H2YMXzU5; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755099205; x=1786635205;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Lfsr4ccnl0Hj8Ai02iL8Y7K6ZbjNWef0+nt5altBcx4=;
  b=H2YMXzU5Q1bEPrukKVZmyhiPJQ3YRIoCR86aOSvjtDftPjo3fMWQjOU5
   xTc1WABpG813rF63CAqsmFlrtpnXp4LExwJ0264sedfqsoRbtXT7POanz
   8JGDpq+kUER4iljIQ//xBgZ3T8ZUf4Fpi7KLftt+mCqZC0MdPLW6iGggn
   /0dz0wlyhIJfCezGZ3aQoBZK/ROmi602W7Q3ISw6j5yKEKiPWpwSjA9oe
   8sR7rcN2a5gs8DV2k1x153781rNHz1MeRBR4umF+rZaOGejjtLZL5qEdd
   1RtnbJYTi3MO3u1ohYXdaGlhi0yrFV625mztvYMUh/iCLiDrmDUhcsfm6
   Q==;
X-CSE-ConnectionGUID: 39xm7BcsQdWfnrsAplCBgg==
X-CSE-MsgGUID: jg64/EiXT+O+GfSSwy8gwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="68474324"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="68474324"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 08:33:24 -0700
X-CSE-ConnectionGUID: uUYy7rc4SWaeoTzt73/wxg==
X-CSE-MsgGUID: 8pT3Hq+iQ6GzT87dw4RtFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="165997685"
Received: from host59.igk.intel.com ([10.123.220.59])
  by fmviesa007.fm.intel.com with ESMTP; 13 Aug 2025 08:33:21 -0700
From: Anton Nadezhdin <anton.nadezhdin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Milena Olech <milena.olech@intel.com>,
	Anton Nadezhdin <anton.nadezhdin@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-net] idpf: cleanup remaining SKBs in PTP flows
Date: Wed, 13 Aug 2025 13:33:04 -0400
Message-ID: <20250813173304.46027-1-anton.nadezhdin@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Milena Olech <milena.olech@intel.com>

When the driver requests Tx timestamp value, one of the first steps is
to clone SKB using skb_get. It increases the reference counter for that
SKB to prevent unexpected freeing by another component.
However, there may be a case where the index is requested, SKB is
assigned and never consumed by PTP flows - for example due to reset during
running PTP apps.

Add a check in release timestamping function to verify if the SKB
assigned to Tx timestamp latch was freed, and release remaining SKBs.

Fixes: 4901e83a94ef ("idpf: add Tx timestamp capabilities negotiation")
Signed-off-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_ptp.c          | 3 +++
 drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
index ee21f2ff0cad..63a41e688733 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
@@ -855,6 +855,9 @@ static void idpf_ptp_release_vport_tstamp(struct idpf_vport *vport)
 	head = &vport->tx_tstamp_caps->latches_in_use;
 	list_for_each_entry_safe(ptp_tx_tstamp, tmp, head, list_member) {
 		list_del(&ptp_tx_tstamp->list_member);
+		if (ptp_tx_tstamp->skb)
+			consume_skb(ptp_tx_tstamp->skb);
+
 		kfree(ptp_tx_tstamp);
 	}
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
index 4f1fb0cefe51..688a6f4e0acc 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
@@ -517,6 +517,7 @@ idpf_ptp_get_tstamp_value(struct idpf_vport *vport,
 	shhwtstamps.hwtstamp = ns_to_ktime(tstamp);
 	skb_tstamp_tx(ptp_tx_tstamp->skb, &shhwtstamps);
 	consume_skb(ptp_tx_tstamp->skb);
+	ptp_tx_tstamp->skb = NULL;
 
 	list_add(&ptp_tx_tstamp->list_member,
 		 &tx_tstamp_caps->latches_free);

base-commit: 94f1d1440652b6145cbaa026f376ae4e7fb95843
-- 
2.42.0


