Return-Path: <netdev+bounces-222348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E53B53F34
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 01:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E475A1453
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 23:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C362FA0EF;
	Thu, 11 Sep 2025 23:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oEBCciSU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63972F8BC5;
	Thu, 11 Sep 2025 23:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757634105; cv=none; b=oC5IM36DKDZA+IfItGMk78ehYvD8s1yrBX4UGRbgM80zexLC8n7o/kD+QUP2zyxSgb1hVW/AvpW29+5+CsIEXdXzymuvt2VVptJRihCQf/wzq/cvfhlEmBXLdLbM3gGmVyUJSHVF8zE2W9KakndFouD0UZM02QKSSM63Qe2n0pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757634105; c=relaxed/simple;
	bh=9YzEHPC3kMFw3ZqY8wpSZT2CZ0Ko0RK1ZiOYgDcqnaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dg5unq7UXamcxH8yiFbZfc0K+X+Cz3ue8IkxrmkBfdof3UfGJf3tS4q3G3eGEo5dHEm9p5sYDhYZx5awPe48KLazcmUddDV01Cb0IHiZAvQm9y3eJCpXIyKG9joA8R19s0d1aY346xPLzreQLinpYGVDwaUH7ctiDK0v7OrwgkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oEBCciSU; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757634104; x=1789170104;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=9YzEHPC3kMFw3ZqY8wpSZT2CZ0Ko0RK1ZiOYgDcqnaY=;
  b=oEBCciSUQ5Xk/xxYrDbittPEGEGFDLTmjifjahhN/NuZB1sB+1+nkWog
   3Nsn2jgqxJPAJqyQygekEuIFPRGUcVbH+gXVfFvzcGr0Htf9QI+2bJhxb
   eQtwOhUhYqC6yHDRNnXWN7efc5NM2JsPC5PDEzKssShvQ6hjPIpfxySJD
   a+uRwXvJmsROKNZNK4QWavH4l45He8/QFUsV0TFwbUDXLN7TTy4T/p5Tl
   DhEduKhZZmKQ48f+g39Vj/UUkRL6klyBQn9yq2vbUBe5dIZjuCA8fifjh
   n2KzbRLYLcmrLk9SekopSenjz1lqsBzwcgHqoxhUYw2a0DzpM+NcY+vyL
   Q==;
X-CSE-ConnectionGUID: 1v447bEDRXyg5863v2XutA==
X-CSE-MsgGUID: Rr0kl8+kSf6wKkrY9IA4Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="71354805"
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="71354805"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 16:41:38 -0700
X-CSE-ConnectionGUID: TgY34MZkRZakLQKG3qIahQ==
X-CSE-MsgGUID: 9bNzkSA6QxK2Pn6rzg+nnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="204589499"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 16:41:37 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 11 Sep 2025 16:40:40 -0700
Subject: [PATCH v3 4/5] ice: implement transmit hardware timestamp
 statistics
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-resend-jbrandeb-ice-standard-stats-v3-4-1bcffd157aa5@intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1987;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=fVsMI2sxazmf90Rmjei3DDI63a9Lm7CC2bI4YMCczTA=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhozDcYb3DV9I5kxROxms9iZ6e+tDDc5biWrMR28dZKww2
 jRj+5fkjlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACZir8zwi3nuipOyE8I2VbX6
 r79leaw2+MfpLwbb7V+fO8Gx7Mc2ay5Ghr+xnT7OXJOXtJqLHPfRt5BZ9Gpx+8/6pFMJcet4Ily
 3cgMA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The kernel now has common statistics for transmit timestamps, so
implement them in the ice driver.

use via
ethtool -I -T eth0

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 3d99c4a1e287..f8bb2d55b28c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -4730,6 +4730,23 @@ static void ice_get_rmon_stats(struct net_device *netdev,
 	*ranges = ice_rmon_ranges;
 }
 
+/* ice_get_ts_stats - provide timestamping stats
+ * @netdev: the netdevice pointer from ethtool
+ * @ts_stats: the ethtool data structure to fill in
+ */
+static void ice_get_ts_stats(struct net_device *netdev,
+			     struct ethtool_ts_stats *ts_stats)
+{
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
+	struct ice_ptp *ptp = &pf->ptp;
+
+	ts_stats->pkts = ptp->tx_hwtstamp_good;
+	ts_stats->err = ptp->tx_hwtstamp_skipped +
+			ptp->tx_hwtstamp_flushed +
+			ptp->tx_hwtstamp_discarded;
+	ts_stats->lost = ptp->tx_hwtstamp_timeouts;
+}
+
 #define ICE_ETHTOOL_PFR (ETH_RESET_IRQ | ETH_RESET_DMA | \
 	ETH_RESET_FILTER | ETH_RESET_OFFLOAD)
 
@@ -4816,6 +4833,7 @@ static const struct ethtool_ops ice_ethtool_ops = {
 	.get_eth_mac_stats	= ice_get_eth_mac_stats,
 	.get_pause_stats	= ice_get_pause_stats,
 	.get_rmon_stats		= ice_get_rmon_stats,
+	.get_ts_stats		= ice_get_ts_stats,
 	.get_drvinfo		= ice_get_drvinfo,
 	.get_regs_len		= ice_get_regs_len,
 	.get_regs		= ice_get_regs,

-- 
2.51.0.rc1.197.g6d975e95c9d7


