Return-Path: <netdev+bounces-195872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2CBAD28BA
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 23:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E51F27A94D9
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 21:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357382248A1;
	Mon,  9 Jun 2025 21:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L7XqGxna"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7655E223300
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 21:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749504427; cv=none; b=lwFUtzQxXKkQeCxLSpQfSBWCL7s0Y8K+0p5Wr732Iepeiq/f6dWlu3pQPkyn/o6SDxKIg/1A2XJqHw4g7HJ5WGjTvmfzPNDA4iQ7CldkD3hKtkx4sbcU3FLJYNO3X9/k5Een0nfjbpR6gxx4Bv7+pvXWZeWDNS+vFU3ZghlvD8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749504427; c=relaxed/simple;
	bh=ZGy2xdLKKkyYKSIyzBv7YamYvUi1jVbe99ir8r1rTng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+h/FHOko2WxY6c8lKlsKALcvqbsNuTywqnASsZAG7XiPV64FP4FIQQ9xJ3oAlnB1JljqcvexABl6MSYCIDhVK6w4BD+EzMFrrgsS09YW3mI2+ZwK9S2maZSKFRqTmO3c+rGnsslp2+QDMP4i03uvShSHgxbOgBYrVaE8MIxQU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L7XqGxna; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749504425; x=1781040425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZGy2xdLKKkyYKSIyzBv7YamYvUi1jVbe99ir8r1rTng=;
  b=L7XqGxna74HkE9R+YvtKrb/Uc8CBAXY00dJJzN2uDB63+0bHfHWAuUVO
   Eu03ZvL5OEidUPjvf0l1WZUJT+1TZ1HG/5VLSDHAveQEa9tBUPAJIVreR
   v0ib7/1M17hQFmSQMkpA/bnb86Z5uG4D1V85vMqVBzGWIvVhrcNGqxT15
   j+I5SXcNWE+847In74R7VJAkGyRyktvkoU00jup/4A6o0btThe/2El7gz
   Mop4roVz6V2MvK3hd5+UlaWrioDBFLHl42kS6Po+6b3Mo5Z/+Pqup5VXz
   f9WiiMqDLfCOB9FsOrpv0H3k6zn0dK6A87KYaHn8UqdVc2o4umQDrJ80Y
   Q==;
X-CSE-ConnectionGUID: +afzCdjvSseaNYwsAnpY1w==
X-CSE-MsgGUID: k2mnxrhFRhaCvGMpHE0+0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="61864191"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="61864191"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 14:27:03 -0700
X-CSE-ConnectionGUID: Szk41OA1SiKSJZuIxZYnVA==
X-CSE-MsgGUID: mI15ExLCRzeOvtN6PwXy+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="150469028"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 09 Jun 2025 14:27:03 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 04/11] i40e: add link_down_events statistic
Date: Mon,  9 Jun 2025 14:26:43 -0700
Message-ID: <20250609212652.1138933-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250609212652.1138933-1-anthony.l.nguyen@intel.com>
References: <20250609212652.1138933-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

Introduce a link_down_events counter to the i40e driver, incremented
each time the link transitions from up to down.
This counter can help diagnose issues related to link stability,
such as port flapping or unexpected link drops.

The value is exposed via ethtool's get_link_ext_stats() interface.

Co-developed-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h         |  1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 10 ++++++++++
 drivers/net/ethernet/intel/i40e/i40e_main.c    |  3 +++
 3 files changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index c67963bfe14e..54d5fdc303ca 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -548,6 +548,7 @@ struct i40e_pf {
 	u16 empr_count; /* EMP reset count */
 	u16 pfr_count; /* PF reset count */
 	u16 sw_int_count; /* SW interrupt count */
+	u32 link_down_events;
 
 	struct mutex switch_mutex;
 	u16 lan_vsi;       /* our default LAN VSI */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 814e20325feb..c7f2d85eafcd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2750,6 +2750,15 @@ static void i40e_diag_test(struct net_device *netdev,
 	netif_info(pf, drv, netdev, "testing failed\n");
 }
 
+static void i40e_get_link_ext_stats(struct net_device *netdev,
+				    struct ethtool_link_ext_stats *stats)
+{
+	struct i40e_netdev_priv *np = netdev_priv(netdev);
+	struct i40e_pf *pf = np->vsi->back;
+
+	stats->link_down_events = pf->link_down_events;
+}
+
 static void i40e_get_wol(struct net_device *netdev,
 			 struct ethtool_wolinfo *wol)
 {
@@ -5810,6 +5819,7 @@ static const struct ethtool_ops i40e_ethtool_ops = {
 	.get_regs		= i40e_get_regs,
 	.nway_reset		= i40e_nway_reset,
 	.get_link		= ethtool_op_get_link,
+	.get_link_ext_stats	= i40e_get_link_ext_stats,
 	.get_wol		= i40e_get_wol,
 	.set_wol		= i40e_set_wol,
 	.set_eeprom		= i40e_set_eeprom,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 67faf5a8dcbf..fcfa2162a3dd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9960,6 +9960,9 @@ static void i40e_link_event(struct i40e_pf *pf)
 	     new_link == netif_carrier_ok(vsi->netdev)))
 		return;
 
+	if (!new_link && old_link)
+		pf->link_down_events++;
+
 	i40e_print_link_message(vsi, new_link);
 
 	/* Notify the base of the switch tree connected to
-- 
2.47.1


