Return-Path: <netdev+bounces-199267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB13ADF962
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 00:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05E94A2405
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBE627EFF2;
	Wed, 18 Jun 2025 22:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TSG9hM9/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE3927F737
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 22:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750285510; cv=none; b=FyHvrLvTOQyfz438Niq4Ni6DwOLtVxsjtAeOdTedwrwq+CSxuN2W0WlaT01UGToGN8GIo5xPt0y5x0u+3DeT1q+DMtqmPJ+1CH0v9SYV6MLEcNzFBqVkKXgJTs/eYER23r9SWhRoerAWOb9AiPxQknOb4Z+CGhBvCfLQg9cJthg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750285510; c=relaxed/simple;
	bh=zUZHmZmw6lY/vlzhJ9yLe5OVqlfvZktLRz2vwpEcRl4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OpCNsvRFZKitTpRNjtALo2aZtfHqNErOnz20cRq5WBJlXn65A49UjVJauN4j1OOwKJfdxZynoKP7sFr+y/0tjJSW902ad76oiCkAVN5EZne/JCbKripEkzkd3netodo29snr9iZvNs2CH32H8fNn7s6OJs+vHrv3PZAmYao7yu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TSG9hM9/; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750285509; x=1781821509;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=zUZHmZmw6lY/vlzhJ9yLe5OVqlfvZktLRz2vwpEcRl4=;
  b=TSG9hM9/5Ne5bZtipFWSl4a5gtUCdLwqO/vlVEmzZhh4UJzq3WTplPI8
   gjyaDWb/lZDzcBhXDe9Yd1AqWcjLJYfh380Cn1fiO0puM2yWkuCowUqnY
   z3awmuGntPiYQ8hnLw829fgttJVT3C2UWFgi3wcGuGlx4BekQmvArsJRU
   Ity7cPWuIwIVYoMGOQp3pu0UwNAyRmh7udDvAFFdH/gaxFKY7myyLvokZ
   2Ie3Jx3eLJZ8gZYIw65my+FFMV0XceKwVYGgwV/UNdgGaFtCv6011ntME
   eosJhbG8HjsBu3U5NRRSKspJhpwtnGdxVYa30oEjHOUQmJpHK7EbdKccz
   Q==;
X-CSE-ConnectionGUID: gSDUDZUDQwmO9xpABFyrMg==
X-CSE-MsgGUID: LxUTlaROTuexmMzjJVmrNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52447741"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="52447741"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 15:25:05 -0700
X-CSE-ConnectionGUID: aWr4bGGJQZC/O/irigi/bg==
X-CSE-MsgGUID: 6u20SeATScKTjJtyswVBuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="149870021"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 15:25:04 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 18 Jun 2025 15:24:41 -0700
Subject: [PATCH iwl-next 6/8] ice: use pci_iov_vf_id() to get VF ID
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-e810-live-migration-jk-migration-prep-v1-6-72a37485453e@intel.com>
References: <20250618-e810-live-migration-jk-migration-prep-v1-0-72a37485453e@intel.com>
In-Reply-To: <20250618-e810-live-migration-jk-migration-prep-v1-0-72a37485453e@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org, 
 Madhu Chittim <madhu.chittim@intel.com>, Yahui Cao <yahui.cao@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Mailer: b4 0.14.2

The ice_sriov_set_msix_vec_count() obtains the VF device ID in a strange
way by iterating over the possible VF IDs and calling
pci_iov_virtfn_devfn to calculate the device and function combos and
compare them to the pdev->devfn.

This is unnecessary. The pci_iov_vf_id() helper already exists which does
the reverse calculation of pci_iov_virtfn_devfn(), which is much simpler
and avoids the loop construction. Use this instead.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 8d77c387357bbba27fbcec4bb2019274d2a2eb99..4c0955be2ad20c3902cf891a66f857585fcab98b 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -952,17 +952,11 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
 	if (msix_vec_count < ICE_MIN_INTR_PER_VF)
 		return -EINVAL;
 
-	/* Transition of PCI VF function number to function_id */
-	for (id = 0; id < pci_num_vf(pdev); id++) {
-		if (vf_dev->devfn == pci_iov_virtfn_devfn(pdev, id))
-			break;
-	}
-
-	if (id == pci_num_vf(pdev))
-		return -ENOENT;
+	id = pci_iov_vf_id(vf_dev);
+	if (id < 0)
+		return id;
 
 	vf = ice_get_vf_by_id(pf, id);
-
 	if (!vf)
 		return -ENOENT;
 

-- 
2.48.1.397.gec9d649cc640


