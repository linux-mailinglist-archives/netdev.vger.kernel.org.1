Return-Path: <netdev+bounces-236025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AF1C37F13
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 22:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAAB33BBF9A
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 21:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C67B350288;
	Wed,  5 Nov 2025 21:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jq8ogMzG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E99D359711
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 21:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376839; cv=none; b=nm6JBJ5hk6yow2MePpLBLdAT7e0B+rX8oxb7X10d8bwPHGR90eYYCvXtIPmuCEK6UGa0gDMfrnIo+kNShrnREvqbL2cxLEXMtZZG8Dmo/nLxJJU/Vb4ynNkZ5q7G7XliZVCXiB5wVXm7e9nEGRFENRPhcqTdZV+MI7j53DzHBl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376839; c=relaxed/simple;
	bh=BMVpGA3Y2sen2yYUHz0R0DzPuU/EERBPL57N+aE9sQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h+AjVQPznoatbhyd94j0r/Asz4spZakMzJRC8Cc+FCsBJ14dWOU11UelJaeVF7dSxocxHkEY+W9AnCR4Lj/8WofFCuxHgWtb1C2fhCRpmU4BWD4ZZjlpBW5SYc0vg+70DS5nlOm6LUgLu060h6wbLfabb0MVp3vMxdodaVP9MJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jq8ogMzG; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762376838; x=1793912838;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=BMVpGA3Y2sen2yYUHz0R0DzPuU/EERBPL57N+aE9sQo=;
  b=jq8ogMzGVueVrW5/6YPYlxg0Jkyox9P1GEwH6AOYwHSU4TvKR0Ed/A9N
   rcBhOYUUa5s7tWXSgH89bxG4Tu/Hato/Pk5cdX/5tplmMz+PFYE1VAszK
   4GQKqE/K5JusUOSzHIxmvQnRdk8MzN/zH2D/rt9iRNItuuKLo3hxSSqvc
   yTu7w2ezzSikpezFFEIiPy4T7G0QhyEgm2f8TSaG6UcV0zHccBs37+ZUm
   by1f2WoZYS8pHKuVCMwjPlqwgpOHr2M8YRJg8Th1sFEHviS5WxRbMzLjd
   x69SEtpqMXxL7Kq5jrqNZdj9Kh51J7GpORN87L4Fgz0Lfy6QsdtW8fHBw
   g==;
X-CSE-ConnectionGUID: q2RkjabcRyanyqKXESFVVg==
X-CSE-MsgGUID: AogMuQ7FRvKyyzq6PuBk+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64201029"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="64201029"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 13:07:13 -0800
X-CSE-ConnectionGUID: EzZLez45RNWq33/fItWRBQ==
X-CSE-MsgGUID: 0KmFzqn+TX+Kf+3kvbgX/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="187513281"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.90]) ([10.166.28.90])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 13:07:13 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 05 Nov 2025 13:06:33 -0800
Subject: [PATCH iwl-next v2 1/9] ice: initialize ring_stats->syncp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-jk-refactor-queue-stats-v2-1-8652557f9572@intel.com>
References: <20251105-jk-refactor-queue-stats-v2-0-8652557f9572@intel.com>
In-Reply-To: <20251105-jk-refactor-queue-stats-v2-0-8652557f9572@intel.com>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Mailer: b4 0.15-dev-f4b34
X-Developer-Signature: v=1; a=openpgp-sha256; l=1378;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=BMVpGA3Y2sen2yYUHz0R0DzPuU/EERBPL57N+aE9sQo=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhkzuPXVHD63OnVLH2RwYy8g3s2kd/0mLKYmTOZRPLTlhv
 9w1L7qmo5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgIlcncnI0B7cJ3p3nqze1dKH
 PXtrFWXCp/q1mibouyxo1cqc8aafi+F/3o9VVadFfre/2nHmVL+Fodb3o28/MkaItz44GO6+RKW
 EFwA=
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
index e366d089bef9..46cd8f33c38f 100644
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


