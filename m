Return-Path: <netdev+bounces-236899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D37DEC41F4A
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 00:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5DD3B34DC
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 23:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C565314B73;
	Fri,  7 Nov 2025 23:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kU/+CXWS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1252FFF9D
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 23:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762558343; cv=none; b=kmXEU+4cbtJ3bv8H1c0HssSBHpAptZ79mpTvpkC+qlUfKrdmQ5X7wAV04tS9t2gbopU0tBkbtTeUJajdRAlBj8ZOX7QI6TAbGdkeYZEBZKdbaXEp/b9wPEnLmg2P60k/wGZWZzZo4jMmC2Vrc3YkODuRBQenjyYjk4bzXxMx3RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762558343; c=relaxed/simple;
	bh=BMVpGA3Y2sen2yYUHz0R0DzPuU/EERBPL57N+aE9sQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I/WXhsQP9rvpJe37RsRpg5T/0eje0tZZwL/01RPL7IMKJFz1fs0dAJnzehoT7Ozrv9PnsK5OTToQ0P+W/BbwvX8G0MGg6dXRNkX5DZngWcLiVcVLlk2uUX972oOx+je+5Sjl7ni4iX85cKCAPIKqV6j2mxoQ+40cZAbBx7XO+3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kU/+CXWS; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762558342; x=1794094342;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=BMVpGA3Y2sen2yYUHz0R0DzPuU/EERBPL57N+aE9sQo=;
  b=kU/+CXWS1jwTKtNlbx0n5T8Rgk247RAP5KK1xYSX4IlSvG0Om4F6D576
   7ehQd0idwAJzutu6zvlG9iruLmjdMdmzHpl8IM6df7O4c+sdbvRLs1cLF
   3W2zDifwCpC/89cR3/rFre5WwumfriqvtPiFPe6qLIZDRmtfRqALuLDR/
   Yt2cx9DhKkT3mns0c8HKJWlUQltychtOJdw/alLqM2YRCtl+YMb1PehR4
   SQwRNBj94V+zPJFsZd+5WHpWhcqt/Y4RJnGCBixI+NUBa2iwO879JCTHq
   eKvr9dMWzhMMMMiW6iaEUn5hP+1snQS7ILfBwpppnNuFF9v0YWE4sEXVc
   A==;
X-CSE-ConnectionGUID: SEwCfxJDRoC59STFMckRzQ==
X-CSE-MsgGUID: 1OSXRJjNRZKUB7HDriVC6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="64806320"
X-IronPort-AV: E=Sophos;i="6.19,288,1754982000"; 
   d="scan'208";a="64806320"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 15:32:19 -0800
X-CSE-ConnectionGUID: zV1LiB4hSBCejp5xmwyB0Q==
X-CSE-MsgGUID: HlTWaxukQUSQj8w29NsdPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,288,1754982000"; 
   d="scan'208";a="218815416"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.90]) ([10.166.28.90])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 15:32:20 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 07 Nov 2025 15:31:45 -0800
Subject: [PATCH iwl-next v3 1/9] ice: initialize ring_stats->syncp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-jk-refactor-queue-stats-v3-1-771ae1414b2e@intel.com>
References: <20251107-jk-refactor-queue-stats-v3-0-771ae1414b2e@intel.com>
In-Reply-To: <20251107-jk-refactor-queue-stats-v3-0-771ae1414b2e@intel.com>
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
 bh=BMVpGA3Y2sen2yYUHz0R0DzPuU/EERBPL57N+aE9sQo=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhky+xob7BjcOd1tbX7MWnNTz7udcfvf32xKPro2Yrf3nP
 KPbKs34jlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACby+jnDP2P9s+WbReKuaBt+
 beqzWD3xo6nzw4iURcvLRaSdxE4JL2D475jywDsqS1vm5sf77KF+53Pu3Mz5z3DombHlROn9Re+
 nMQMA
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


