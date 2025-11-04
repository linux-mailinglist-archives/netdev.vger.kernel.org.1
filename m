Return-Path: <netdev+bounces-235320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06F1C2EB03
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 02:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B543AA753
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 01:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C931B13AA2D;
	Tue,  4 Nov 2025 01:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kot97uhb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B1E28DB3
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 01:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762218440; cv=none; b=YRWAK5qMPBLQvneSlwS8U7zMwO3Cvs0fEIz6V13vS5a9K/aw+4E/tMT8bOMMI8fM5TeVCq2sPAQ9rX4/VDSIlqdPzPfMIFZ5c/9DkRlQzL4Nf4arsC7VVWuSLCfHCLeRa4FwBtiu+Ewd3U1JKnE/iYil75yWZCCpRa0oYGSQKz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762218440; c=relaxed/simple;
	bh=sMqd4Rn5l7ALgH1SAW9CMNd5nCCrcLFQbpHnvsaYy2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sp1FoI4ylPLn8WBZxUHccO5VsiLGG0Y1wHoJdDt8yS5KYKJOuNuuSXptoFjw+qx40I+84RfvUDvQ9cv1DCkVfqdp1qgL6MsQywVXzDcgn64JRHTUftSTRehsk6WSqIRxb2yJcBhiOIx3KbvQkiSdeUs1GEbN6xy2VBdlx8NEHTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kot97uhb; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762218439; x=1793754439;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=sMqd4Rn5l7ALgH1SAW9CMNd5nCCrcLFQbpHnvsaYy2c=;
  b=kot97uhb4KMXLEsuB6g/y+BvLzmi4YxF5yBmfW6YTTn/xGR+q/8ZZyBu
   Njfsuq8SDpEtgOjsqS+6uGocl18m67zLT/qnZ2oho0hVRWxFDD/HIIlBi
   FGEnJmmSkqX0TzyJpxW9p60QFtYHx7Eja3u3gmSg2XT/MKv/MsVRanduI
   U5fJRuSlIAhCSwp0yixrvZcQ1whtWWSV+N8kL/QfSH4Ng5qQ18nA1X3nu
   joe827Zj42lbBm8kcTYJAsye0aThCtsYueLqOPPevk51RfKZ/Ycf/QR5L
   +eJ6w4e/eR6gHuEcH7HJvEagEH+7ONotQ5opicuZe+LAmAppKh9FckCGm
   A==;
X-CSE-ConnectionGUID: 0pXsTGMNTEiDywpphNZINQ==
X-CSE-MsgGUID: yN3ucfGPTAuiHqnBvm5g0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="75656559"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="75656559"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 17:07:18 -0800
X-CSE-ConnectionGUID: m/aHYovERleg59XGjwdrWA==
X-CSE-MsgGUID: 3XBi+V4pTsuMIQnfvUSlHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="217828752"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.90]) ([10.166.28.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 17:07:15 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 03 Nov 2025 17:06:46 -0800
Subject: [PATCH iwl-next 1/9] ice: initialize ring_stats->syncp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-jk-refactor-queue-stats-v1-1-164d2ed859b6@intel.com>
References: <20251103-jk-refactor-queue-stats-v1-0-164d2ed859b6@intel.com>
In-Reply-To: <20251103-jk-refactor-queue-stats-v1-0-164d2ed859b6@intel.com>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.15-dev-f4b34
X-Developer-Signature: v=1; a=openpgp-sha256; l=1312;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=sMqd4Rn5l7ALgH1SAW9CMNd5nCCrcLFQbpHnvsaYy2c=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhkzOwAM3u4/+PnpYkOfuI6bYSXtkDihrrM4PEpygyaP01
 WaGpPz8jlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACay7CsjQ7P5k2m35gQf/Lv4
 Uec0mQ9HCkU93pmVZ2/XFpl/I/LEB0mGf2oPM1c/m/7Q3nGJc5W3V/K1fWdDrbnD8iM5VXZcEt1
 QyQAA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

The u64_stats_sync structure is empty on 64-bit systems. However, on 32-bit
systems it contains a seqcount_t which needs to be initialized. While the
memory is zero-initialized, a lack of u64_stats_init means that lockdep
won't get initialized properly. Fix this by adding u64_stats_init() calls
to the rings just after allocation.

Fixes: 2b245cb29421 ("ice: Implement transmit and NAPI support")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index bac481e8140d..e7265e877703 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -398,7 +398,10 @@ static int ice_vsi_alloc_ring_stats(struct ice_vsi *vsi)
 			if (!ring_stats)
 				goto err_out;
 
+			u64_stats_init(&ring_stats->syncp);
+
 			WRITE_ONCE(tx_ring_stats[i], ring_stats);
+
 		}
 
 		ring->ring_stats = ring_stats;
@@ -417,6 +420,8 @@ static int ice_vsi_alloc_ring_stats(struct ice_vsi *vsi)
 			if (!ring_stats)
 				goto err_out;
 
+			u64_stats_init(&ring_stats->syncp);
+
 			WRITE_ONCE(rx_ring_stats[i], ring_stats);
 		}
 

-- 
2.51.0.rc1.197.g6d975e95c9d7


