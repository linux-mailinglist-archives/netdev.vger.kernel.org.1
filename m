Return-Path: <netdev+bounces-157316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480ABA09EBF
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 00:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538CE3A1776
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 23:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C802221DB2;
	Fri, 10 Jan 2025 23:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kn1hKyVl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A271A20764C
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 23:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736552272; cv=none; b=ITcEYow+ky6gsrPXkUUjcNWMZfn1RFtAQy/Y8srcIOK65dSPoHpI55uvNC8/jZ0+fptYzMcGMS7ZFs9ugSmgRczoAcBOFMwxTGIbUy6tbSupRZA07bNfv3LPgzmzbQasGUYQVqGwisYLED4fj08R1v8GUwEq/id+j4ITTK+SQC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736552272; c=relaxed/simple;
	bh=zHQ4ZLwh1tJvzJXmXebl4aCYAAjrnRovb/kgEIc0LGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H20mOMFzLruA3ktcAAnOUNJqcc3/c/MoS8uTIwUYomvcn1f/jrWogYUID1HfVMtt5wsuhyhOqQ7//DD8bzpnYl99dvpSHhpRl7dD+Je/Q6NIe0GUWRvZobwziqq7nnflyvD794vToc9Pc/y+NsjlXy99AmrROIwfI+n5FKt22oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kn1hKyVl; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736552271; x=1768088271;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zHQ4ZLwh1tJvzJXmXebl4aCYAAjrnRovb/kgEIc0LGY=;
  b=Kn1hKyVl2e/09BqtQje7aX6uSaIBrAduyoWlxfDSBrTUcipFU0E3ReBb
   Ysk0dO5tRK5D+MrmssRmR9maI1oI3/hh5lrJoWPFR5ojWWxM/zIQIA8LN
   4wn6FgcC4I6EFNf0u1wmlPSqc89/U401agu/su4oIm9ZTkWbPYSGgfma5
   GDIQXLjjCDCNHkVhwumKRlsPrCha12T547PHK6+aW5fPHyChgVX2ox3Dv
   vQHBzEGw0B6TfE12GJDQCphr7DCia5kcJ7nRoF7ZN4lB+6thZtJw8AGGN
   2AeZNltPycY0Us0sf+prNtvXKgpiNzR9BiXlJlRUm3kZKa5B6N9rajSVR
   w==;
X-CSE-ConnectionGUID: BByKRyDSRCO4qi7t4++24Q==
X-CSE-MsgGUID: 7eBdib+/QPiCfAa1ZNCq1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="40542504"
X-IronPort-AV: E=Sophos;i="6.12,305,1728975600"; 
   d="scan'208";a="40542504"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 15:37:50 -0800
X-CSE-ConnectionGUID: FMYMb7IeQWO8Zd+QDusWnQ==
X-CSE-MsgGUID: 6R6fvFZdSw+OcJ1pcP113g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,305,1728975600"; 
   d="scan'208";a="103673256"
Received: from jf3418-16b10-250812-p7.jf.intel.com ([10.166.80.88])
  by fmviesa006.fm.intel.com with ESMTP; 10 Jan 2025 15:37:49 -0800
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net] idpf: fix handling rsc packet with a single segment
Date: Fri, 10 Jan 2025 16:29:22 -0800
Message-ID: <20250111002921.167301-2-sridhar.samudrala@intel.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle rsc packet with a single segment same as a multi
segment rsc packet so that CHECKSUM_PARTIAL is set in the
skb->ip_summed field. The current code is passing CHECKSUM_NONE
resulting in TCP GRO layer doing checksum in SW and hiding the
issue. This will fail when using dmabufs as payload buffers as
skb frag would be unreadable.

Fixes: 3a8845af66ed ("idpf: add RX splitq napi poll support")
Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 2fa9c36e33c9..c9fcf8f4d736 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3008,8 +3008,6 @@ static int idpf_rx_rsc(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 		return -EINVAL;
 
 	rsc_segments = DIV_ROUND_UP(skb->data_len, rsc_seg_len);
-	if (unlikely(rsc_segments == 1))
-		return 0;
 
 	NAPI_GRO_CB(skb)->count = rsc_segments;
 	skb_shinfo(skb)->gso_size = rsc_seg_len;
-- 
2.46.2


