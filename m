Return-Path: <netdev+bounces-249606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEC3D1B845
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 23:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C1356300A792
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 22:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3D1352C3B;
	Tue, 13 Jan 2026 22:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SKapsM16"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A141E2E54A3
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 22:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768341751; cv=none; b=JE4B+fE4ZVfhz1uNwyfXwbJWYgIey8lHBh+NvkedpKK2tSElRJFuTt9RsXWj0t8fChH8SDWl1byh2mM5diSM2EjJ+qkZq2OkhffVwm2sb7dQRDGPig65+NuDzSHSSP1SN2XsHr3SqvtEEbAMJv8XQOjkuLK6D2bukrarTsN5eSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768341751; c=relaxed/simple;
	bh=cocmHT4O9IDB7iApy18xeJTtCJx6/SOtto7Ptl+9p4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMvPhZpvQDjiau14vnYQQDA1J2i9l1q9sbcsh2zy1o3o3IfN07a0a0Fbg72xh1SvXtQxDxC6fVzBWBqlFDrWYbOdAiMQSLlc0DSFyYD9+LJ3Z5ryBlBn/0NFeZy776p+QA88oT68mrU7syFEbVYw0Cz4Rhr5fBj+QgTZyQNcnNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SKapsM16; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768341750; x=1799877750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cocmHT4O9IDB7iApy18xeJTtCJx6/SOtto7Ptl+9p4A=;
  b=SKapsM16ASIwMtL/wu5GYVUMxWEoteHXLZhYnMkrjqnQ/zinm08WCkCT
   /KcJ43E+yUZcZ6+PN1RfZ6f2jnn9PHHIfogzSnzy50Mw/sqUdmUa9JNgx
   wmAknSD1GhqnxE9viHGhnMQJOF/uZambcpGtSR/ILayW4E6lhCtmMrT0h
   5NBVF3waFe0kok+n6OwgLW6GrkFWbCkfNLk9XNQQkP4jFjSYGfa030IPl
   Hv0+puAQxm282ueFfXOveyUrG+gh/2/YI4bdCmFbN+EqIE+GzkkMIFU22
   3UWNJGZNHLoS2/Ae+6/CFMdKVG4pugNR573nip6Vppmp//3zbkPQC2Ik/
   w==;
X-CSE-ConnectionGUID: 3YoiU643ThmG9k/3kyIbvA==
X-CSE-MsgGUID: BWBaIww7QDyC5ARCEmlkpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69558659"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="69558659"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 14:02:28 -0800
X-CSE-ConnectionGUID: gyhTN97NT+yfjmmC2EIaeQ==
X-CSE-MsgGUID: Yn3O/2eHRvKYgc/1estOMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="204388167"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 13 Jan 2026 14:02:27 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 1/6] ice: initialize ring_stats->syncp
Date: Tue, 13 Jan 2026 14:02:14 -0800
Message-ID: <20260113220220.1034638-2-anthony.l.nguyen@intel.com>
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

From: Jacob Keller <jacob.e.keller@intel.com>

The u64_stats_sync structure is empty on 64-bit systems. However, on 32-bit
systems it contains a seqcount_t which needs to be initialized. While the
memory is zero-initialized, a lack of u64_stats_init means that lockdep
won't get initialized properly. Fix this by adding u64_stats_init() calls
to the rings just after allocation.

Fixes: 2b245cb29421 ("ice: Implement transmit and NAPI support")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 15621707fbf8..9ebbe1bff214 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -398,6 +398,8 @@ static int ice_vsi_alloc_ring_stats(struct ice_vsi *vsi)
 			if (!ring_stats)
 				goto err_out;
 
+			u64_stats_init(&ring_stats->syncp);
+
 			WRITE_ONCE(tx_ring_stats[i], ring_stats);
 		}
 
@@ -417,6 +419,8 @@ static int ice_vsi_alloc_ring_stats(struct ice_vsi *vsi)
 			if (!ring_stats)
 				goto err_out;
 
+			u64_stats_init(&ring_stats->syncp);
+
 			WRITE_ONCE(rx_ring_stats[i], ring_stats);
 		}
 
-- 
2.47.1


