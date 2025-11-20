Return-Path: <netdev+bounces-240542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 337E5C762E0
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 21:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5E3B4E2044
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 20:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52043307491;
	Thu, 20 Nov 2025 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nCa2LFG9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BDC3064A3
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763670081; cv=none; b=d52OaKYTKZcJ2xdcVUhLcQf5ZOCqbInwC52rNItc6d1tHEYgbDPx0WWXfU5eXw06mP4S/Msru7pFdqGYx0P3HkT6fj4ZwoJnR1IgjWCF6LQtqf/u+SxhF0RDdRQjugf/CEPOaRh1uNIPnLyX4dIDE7VTIT1hp3QvpTb4wYK30Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763670081; c=relaxed/simple;
	bh=QZXlHpYH5voD/+Ke49KI0FXvZ/9bAA/7qfaoDA6BEdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d4i7viHO4YrHpFLhrP/rXTfbj7r2dl2xUvESYA151BIkzVY8AQ3MsDJ6Wae1omTykfMakhiJTPZYykK0ghbybYwcKG3UvuLFaorK05VIGaPB52xQhoZpIvFNVGyjlcezipowmsTerZU9ToBPXgr46NSv21fiwsTVjtcV+We2UcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nCa2LFG9; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763670080; x=1795206080;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=QZXlHpYH5voD/+Ke49KI0FXvZ/9bAA/7qfaoDA6BEdo=;
  b=nCa2LFG9YmlhoZSWrvi7G/wRAi8kivU2VSpDbENehG4aC/YBR2lBwUxk
   lp3Yj+7kAvsOIKfvafrBHZ+3CUIHyGDYzSqUuVLL4IQDNcsbmh5e6ae8a
   BA/TkB3cIPgVa4Fz+PhkbrEVoxJcrwkAUw5Z2pRe/HCg1bTYW9a2BJaBO
   88evfQDYdb5kattzamsmesHO3CZMV52S7fSb4z5AoIE8xaE4Q0p/RFOfS
   uodPA5GUD3POy/wSyH6dMdSOK/XIFJHvv2MnacImiixRUljJhl7rDr/M0
   0JxHXtkP0WCWJlMkIVOBOv7fz7BWCnpeQnLwml8SB8EU8a5XZp9M7AGzM
   A==;
X-CSE-ConnectionGUID: t9es5t7kRZ+9oxm1/KC13A==
X-CSE-MsgGUID: 074dU+NuROSN/57RLcz3oQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="65688932"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="65688932"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 12:21:16 -0800
X-CSE-ConnectionGUID: GADPbF3QQtK8jOnM+85ovA==
X-CSE-MsgGUID: bOp1tRhJRYSk1OJuJh7lTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="222419693"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.90]) ([10.166.28.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 12:21:11 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 20 Nov 2025 12:20:41 -0800
Subject: [PATCH iwl-next v4 1/6] ice: initialize ring_stats->syncp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-jk-refactor-queue-stats-v4-1-6e8b0cea75cc@intel.com>
References: <20251120-jk-refactor-queue-stats-v4-0-6e8b0cea75cc@intel.com>
In-Reply-To: <20251120-jk-refactor-queue-stats-v4-0-6e8b0cea75cc@intel.com>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Simon Horman <horms@kernel.org>, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Mailer: b4 0.15-dev-f4b34
X-Developer-Signature: v=1; a=openpgp-sha256; l=1378;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=QZXlHpYH5voD/+Ke49KI0FXvZ/9bAA/7qfaoDA6BEdo=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhkz5CpMIHUFvtXp9/zqz1ys+L5GyPjZNWbQ/Vkh3eZFe7
 b3jSrM6SlkYxLgYZMUUWRQcQlZeN54QpvXGWQ5mDisTyBAGLk4BmMhHbUaGR5N+ffG4r3PSNsH3
 eqGV7/ylC15JnMu9tMb1TkepsaSDJyPD8mtcclfPbudWsxZQ9ShmlPh6IpLN41pz5ZddjtePfL3
 DDAA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

The u64_stats_sync structure is empty on 64-bit systems. However, on 32-bit
systems it contains a seqcount_t which needs to be initialized. While the
memory is zero-initialized, a lack of u64_stats_init means that lockdep
won't get initialized properly. Fix this by adding u64_stats_init() calls
to the rings just after allocation.

Fixes: 2b245cb29421 ("ice: Implement transmit and NAPI support")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 44f3c2bab308..116a4f4ef91d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -400,7 +400,10 @@ static int ice_vsi_alloc_ring_stats(struct ice_vsi *vsi)
 			if (!ring_stats)
 				goto err_out;
 
+			u64_stats_init(&ring_stats->syncp);
+
 			WRITE_ONCE(tx_ring_stats[i], ring_stats);
+
 		}
 
 		ring->ring_stats = ring_stats;
@@ -419,6 +422,8 @@ static int ice_vsi_alloc_ring_stats(struct ice_vsi *vsi)
 			if (!ring_stats)
 				goto err_out;
 
+			u64_stats_init(&ring_stats->syncp);
+
 			WRITE_ONCE(rx_ring_stats[i], ring_stats);
 		}
 

-- 
2.51.0.rc1.197.g6d975e95c9d7


