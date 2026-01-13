Return-Path: <netdev+bounces-249611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CF3D1B869
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 23:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45CD0305BCC8
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 22:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA9B352F85;
	Tue, 13 Jan 2026 22:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hvDdG3Ar"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332AF354ADF
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 22:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768341756; cv=none; b=daeahdt9AmBRvMkVReY0etVYuOTgCWgdmmJh8ay81Ij//PvAijE7cpYHIxK9ncrHeJ5CA9tRw0OijiuAxjtk8S2W4PkJ4IaAiVsjF6WZl66ZxuXQs/OAlR0MQ5ACQrPBHsUudzQralqJW5+d0GtJ+8jvW4Wdz16S+3QqpWoWne4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768341756; c=relaxed/simple;
	bh=O30zNuUgcXWpAZnP8awUzRYoPOQwiv79rAPaCfxgXHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mx2usiGCzIOiT8tpHCyqDou0vGMumTc9i/pfrri2XnN+wfxUh8Pzw805He9t3pKh6P7mbkZ1MPaPGH9dknZ8W2wREATG+yMXl8e6WwbT+5YribrVS8S5MB91GkpVx8gQaWBftnUMzqFjYm7kOsEJwYocBpZTsWRyPiNNnI7FNr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hvDdG3Ar; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768341756; x=1799877756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O30zNuUgcXWpAZnP8awUzRYoPOQwiv79rAPaCfxgXHQ=;
  b=hvDdG3Ar6+Hx42sL93ixWTkuXwdDzDn5+QWgCRUt4aVPSdSGb5mAYa1i
   6wKRgFBkqcPrYh3buWHgJjvnpnpEHMN3tRobFeldMVVgUKsnDuE4m1Lo6
   o34PfYORb3sMshCQXvdsMF3MrnfW2iQ/Q00qeMlDaPFpOhihAsLEFVn92
   yyOQ6ckrXDVWuaWlagcjTr8saEEh/OXdANrVFomdYaa/BlYyYZ1N9Q5So
   duTYSRBVmqc61tLWmfZRZAOtb/x14fmljzHlQxLk4hKHNyPbLi5onQO8Z
   YQoDmE055mBgPH2e8aB/E9zF64L5XDTQKN29z8vssM2k/cmPTWUG3QhBI
   w==;
X-CSE-ConnectionGUID: uSQmuG2NQgCT5opPHrQdng==
X-CSE-MsgGUID: T0ZIbJCzR9enWFvdlVLrfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69558700"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="69558700"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 14:02:30 -0800
X-CSE-ConnectionGUID: aj/DVSmGTEOHLFSI6BXs/g==
X-CSE-MsgGUID: xtLdutRgRD6ClxnIiBTAvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="204388190"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 13 Jan 2026 14:02:29 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Chwee-Lin Choong <chwee.lin.choong@intel.com>,
	anthony.l.nguyen@intel.com,
	vinicius.gomes@intel.com,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	faizal.abdul.rahim@linux.intel.com,
	richardcochran@gmail.com,
	Zdenek Bouska <zdenek.bouska@siemens.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Simon Horman <horms@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: [PATCH net 6/6] igc: Reduce TSN TX packet buffer from 7KB to 5KB per queue
Date: Tue, 13 Jan 2026 14:02:19 -0800
Message-ID: <20260113220220.1034638-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260113220220.1034638-1-anthony.l.nguyen@intel.com>
References: <20260113220220.1034638-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chwee-Lin Choong <chwee.lin.choong@intel.com>

The previous 7 KB per queue caused TX unit hangs under heavy
timestamping load. Reducing to 5 KB avoids these hangs and matches
the TSN recommendation in I225/I226 SW User Manual Section 7.5.4.

The 8 KB "freed" by this change is currently unused. This reduction
is not expected to impact throughput, as the i226 is PCIe-limited
for small TSN packets rather than TX-buffer-limited.

Fixes: 0d58cdc902da ("igc: optimize TX packet buffer utilization for TSN mode")
Reported-by: Zdenek Bouska <zdenek.bouska@siemens.com>
Closes: https://lore.kernel.org/netdev/AS1PR10MB5675DBFE7CE5F2A9336ABFA4EBEAA@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM/
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 498ba1522ca4..9482ab11f050 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -443,9 +443,10 @@
 #define IGC_TXPBSIZE_DEFAULT ( \
 	IGC_TXPB0SIZE(20) | IGC_TXPB1SIZE(0) | IGC_TXPB2SIZE(0) | \
 	IGC_TXPB3SIZE(0) | IGC_OS2BMCPBSIZE(4))
+/* TSN value following I225/I226 SW User Manual Section 7.5.4 */
 #define IGC_TXPBSIZE_TSN ( \
-	IGC_TXPB0SIZE(7) | IGC_TXPB1SIZE(7) | IGC_TXPB2SIZE(7) | \
-	IGC_TXPB3SIZE(7) | IGC_OS2BMCPBSIZE(4))
+	IGC_TXPB0SIZE(5) | IGC_TXPB1SIZE(5) | IGC_TXPB2SIZE(5) | \
+	IGC_TXPB3SIZE(5) | IGC_OS2BMCPBSIZE(4))
 
 #define IGC_DTXMXPKTSZ_TSN	0x19 /* 1600 bytes of max TX DMA packet size */
 #define IGC_DTXMXPKTSZ_DEFAULT	0x98 /* 9728-byte Jumbo frames */
-- 
2.47.1


