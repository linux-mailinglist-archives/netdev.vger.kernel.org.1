Return-Path: <netdev+bounces-230322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20792BE693F
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 08:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F6C84FCB62
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 06:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669E6315D44;
	Fri, 17 Oct 2025 06:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ndqc8J2d"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714D5313278;
	Fri, 17 Oct 2025 06:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681466; cv=none; b=QoFb/dUgwWvsfmkoLB3aJ6A8j84PtyJ8eoVxNkmddK5QLvbMZ8T4eMHKcvXqvWNQkSyGHZB7sLkH++oG99Rthttr6ye7LToH2SLYD5l/bNDNgVHkyd2HCXwJcuZqo/Wb4s7BEC+00bcAFLVjjFcC2fd+qjsNw2/eD/C7eABEVdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681466; c=relaxed/simple;
	bh=LhxeTyRSi5tzmuwdniowFXTW4S9TVULOnCm6iJl08r8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fLBnuTp+z6ufx7yrCPAZdDRdGWMgs+354MbbusSO2tQHvq685VV0tG5OGALXz5QOQ07UjJ+gNHx7u6ZdPkD8EflIJhQ4bbXySJOUxyRLi3xIb0WpEmBxzFJ/xKj0Qb+AvdhjeHX3fSNNfgtgHBpqEabYWMEL+G6R8jSa5INqksE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ndqc8J2d; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760681463; x=1792217463;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=LhxeTyRSi5tzmuwdniowFXTW4S9TVULOnCm6iJl08r8=;
  b=ndqc8J2dvBjMefBYJVV/moA0DVZJUvqHzDuDOlH9tuFgrYRV5zhlEe+A
   taMByTOjpencBE2sH4S+FXNV2MNt8gG8RtMXVA5LczLxdNqN0FCm5Q2L6
   vrmFiPf+VM6qcV0tdvTTbeCCrMcaiX4nzZU9nf8eKsmXx4gAZYrfPQMnY
   pUFzBuXCnJzuJICJxRpOrHK04mln4CkKEissqAVf8M8eFuGgZtL9LvmCZ
   WbLzWv8jUveowSHZDM0I7M4X/JGMRRiSEuAWL6m93sarCqt+80BeeJim+
   2a7bje3KOFPpjTkZisIJaIaU7CrYh0+6HB4lHcUjeJCO1/1NB7cmR4HXG
   A==;
X-CSE-ConnectionGUID: fkaQlWhVSYSj2fcB9M2ysA==
X-CSE-MsgGUID: qAyVhXuAR3mACAbFG8DFQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="50453998"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="50453998"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 23:10:55 -0700
X-CSE-ConnectionGUID: uqswW4jPSKSj5BX7DIdMng==
X-CSE-MsgGUID: kUP8VmQPQOqtw0luN1p46g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="183059508"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 23:10:54 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 16 Oct 2025 23:08:39 -0700
Subject: [PATCH net-next v2 10/14] ice: add tracking of good transmit
 timestamps
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-jk-iwl-next-2025-10-15-v2-10-ff3a390d9fc6@intel.com>
References: <20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com>
In-Reply-To: <20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Rinitha S <sx.rinitha@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 jbrandeburg@cloudflare.com
X-Mailer: b4 0.15-dev-f4b34
X-Developer-Signature: v=1; a=openpgp-sha256; l=3125;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=v6YKr0JvH0CzlK42kuefD+8jO5JXcihujiXU5BaupJY=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhoyPd1+6n351WTl3w4refxWXb3d9+JQvJ6AZGzYtV63uQ
 0n2+lXvOkpZGMS4GGTFFFkUHEJWXjeeEKb1xlkOZg4rE8gQBi5OAZiIhA3D/2KW+QuPMAiuKZv/
 8pZ05Gnm6Kuz7ghluU95Ovnh1nvbn25hZPhgl3CEvZVBTcjuRpFesdf9TXe1Cxzls48GpKfk2hW
 eYwIA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

As a pre-requisite to implementing timestamp statistics, start tracking
successful PTP timestamps. There already existed a trace event, but
add a counter as well so it can be displayed by the next patch.

Good count is a u64 as it is much more likely to be incremented. The
existing error stats are all u32 as before, and are less likely so will
wrap less.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.h | 2 ++
 drivers/net/ethernet/intel/ice/ice_ptp.c | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 137f2070a2d9..27016aac4f1e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -237,6 +237,7 @@ struct ice_ptp_pin_desc {
  * @clock: pointer to registered PTP clock device
  * @tstamp_config: hardware timestamping configuration
  * @reset_time: kernel time after clock stop on reset
+ * @tx_hwtstamp_good: number of completed Tx timestamp requests
  * @tx_hwtstamp_skipped: number of Tx time stamp requests skipped
  * @tx_hwtstamp_timeouts: number of Tx skbs discarded with no time stamp
  * @tx_hwtstamp_flushed: number of Tx skbs flushed due to interface closed
@@ -261,6 +262,7 @@ struct ice_ptp {
 	struct ptp_clock *clock;
 	struct kernel_hwtstamp_config tstamp_config;
 	u64 reset_time;
+	u64 tx_hwtstamp_good;
 	u32 tx_hwtstamp_skipped;
 	u32 tx_hwtstamp_timeouts;
 	u32 tx_hwtstamp_flushed;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index fb0f6365a6d6..4f50e952bfb5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -500,6 +500,9 @@ void ice_ptp_complete_tx_single_tstamp(struct ice_ptp_tx *tx)
 	if (tstamp) {
 		shhwtstamps.hwtstamp = ns_to_ktime(tstamp);
 		ice_trace(tx_tstamp_complete, skb, idx);
+
+		/* Count the number of Tx timestamps that succeeded */
+		pf->ptp.tx_hwtstamp_good++;
 	}
 
 	skb_tstamp_tx(skb, &shhwtstamps);
@@ -558,6 +561,7 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 {
 	struct ice_ptp_port *ptp_port;
 	unsigned long flags;
+	u32 tstamp_good = 0;
 	struct ice_pf *pf;
 	struct ice_hw *hw;
 	u64 tstamp_ready;
@@ -658,11 +662,16 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 		if (tstamp) {
 			shhwtstamps.hwtstamp = ns_to_ktime(tstamp);
 			ice_trace(tx_tstamp_complete, skb, idx);
+
+			/* Count the number of Tx timestamps that succeeded */
+			tstamp_good++;
 		}
 
 		skb_tstamp_tx(skb, &shhwtstamps);
 		dev_kfree_skb_any(skb);
 	}
+
+	pf->ptp.tx_hwtstamp_good += tstamp_good;
 }
 
 /**

-- 
2.51.0.rc1.197.g6d975e95c9d7


