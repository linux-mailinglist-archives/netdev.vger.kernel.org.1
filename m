Return-Path: <netdev+bounces-222347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433E4B53F31
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 01:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB655A1392
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 23:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0FF2F99A9;
	Thu, 11 Sep 2025 23:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KWmfgPxq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C9C2F7ADC;
	Thu, 11 Sep 2025 23:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757634104; cv=none; b=LmANq99QtrdoWRzyjZmd9bf7UII7t213O+cwDPi0EOXt7+vdjS5lvNrtN6Fv9O+UTnmOXsLWihmopqjm0CaA3/0KKM49PZHseYfA6mgJ4vz1jOAmcc8FMLW52Ssm8V7qw2cLz38AI73GYHn52LeqzjLVttBzmJj/9VxM2PNHOU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757634104; c=relaxed/simple;
	bh=0lR819Q6hVHKftUnHgobtlPp/21TNCumWUp9mYFgO5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qHsW05PMdrd6Oc/TZEdCLcBEYfg7pkUuAtb6cXswvi50Y/ERtenHki+gKSz+uo5OKB4CA9SmNEzK6JS+nzbPCq+Q3F5AWBkkxes7ednUNlc8SQzn+T76hjHJfMp6W/TI/VPURqD99x8QwpbqaQBN7Nnrfr7xUsUKcpdv38pZjSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KWmfgPxq; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757634103; x=1789170103;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=0lR819Q6hVHKftUnHgobtlPp/21TNCumWUp9mYFgO5Q=;
  b=KWmfgPxqJW1EVYMxMamuivxiRFtArcmT0joD6dxBtFo57QShkRShdL4Q
   zvWdBGswUx8x3C/ceEw5v5XYZSi26mXv2L07iPqZrwCpCP/HgseRHZYmT
   G+4bIL9Otza5nVblFkkgHdtu7Us07uuL0I2r6X8TDdx5UlGVNJYv/nZT/
   oIJ7RwcdjvimnqEmPSYw4O5N2hL9fED37bmOSJCZAkKZx3lPAWzMzrqSE
   cMeGLqjF8JiMqkevaxWzZ9oJcj6AneYhaLTcTEoUOdCO5xNCLNSTdST2s
   bxq2uuS45LQuw/o/xKOQHX6fM5arJJy7wBLJz00+iz0Jxtgi0IAqbgdlv
   w==;
X-CSE-ConnectionGUID: fas3bFp9QGKAckxIT69+IA==
X-CSE-MsgGUID: G/zrGhSqQOGdn9yVgEreJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="71354799"
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="71354799"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 16:41:38 -0700
X-CSE-ConnectionGUID: UsC3Y0Z4Rt60s9pI2C3GGQ==
X-CSE-MsgGUID: YgMQ2ex7Sc+7RnAFgf0tdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="204589496"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 16:41:37 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 11 Sep 2025 16:40:39 -0700
Subject: [PATCH v3 3/5] ice: add tracking of good transmit timestamps
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-resend-jbrandeb-ice-standard-stats-v3-3-1bcffd157aa5@intel.com>
References: <20250911-resend-jbrandeb-ice-standard-stats-v3-0-1bcffd157aa5@intel.com>
In-Reply-To: <20250911-resend-jbrandeb-ice-standard-stats-v3-0-1bcffd157aa5@intel.com>
To: Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Jakub Kicinski <kuba@kernel.org>, Hariprasad Kelam <hkelam@marvell.com>, 
 Simon Horman <horms@kernel.org>, 
 Marcin Szycik <marcin.szycik@linux.intel.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, netdev@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org, corbet@lwn.net, 
 Jacob Keller <jacob.e.keller@intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
X-Mailer: b4 0.15-dev-c61db
X-Developer-Signature: v=1; a=openpgp-sha256; l=3014;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=l9QPbikcO3yzD0f+hT38WuIhSPbXbHBQQnlptoND3ck=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhozDcYZXE5qZ+bunzzJ4Lefi9Slk+6b3my/fKIyeHaTwg
 vEqQ5JWRykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABNZ5cnw38GY3eT53gL+z0Fz
 D5lyrlvd6bnMbcdybcs1Si8c92W7zmb47xmiHWL7i7VxypQbmb5cfwqVFl9ikjqlZbR7rq/CvVN
 t/AA=
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
index 9b065709c899..d2ca9d7bcfc1 100644
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


