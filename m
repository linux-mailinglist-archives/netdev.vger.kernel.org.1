Return-Path: <netdev+bounces-190301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5681FAB6193
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 06:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644121893647
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 04:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04601F4295;
	Wed, 14 May 2025 04:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JQHVSGFE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19981DFDE;
	Wed, 14 May 2025 04:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747197098; cv=none; b=NS/D2jUMy9CbZXRQJr/CpwOE2A2VrOjMDlo+EGjVjZPUjruDIPyI7TMrYAA2FM79jZsw1jSCbAxwhmvUYl2xQ36OfuYBkPVcOwP4NiCqRr8rg/lT4dJkBq8zkVSt7PqGrUhNDOqZi8g4gbbeyvwEcAfuIWvzTWBYwt/U6/Xes9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747197098; c=relaxed/simple;
	bh=rH3C6pzsOZigobTduN+uaXbF+DvbFzqeaIAoM3YchGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eBHXbn5iizSj7kjdkVhhlPL+6p+C/jewTsOjFQkwEJCzm50yQyDTWA23D0rjxY+kvHvOYpkJDmS7PyS8dTryR2ooVs/S53AG1Uwwkl5LrIJg6kuqKoQ7vH+TV4FITkExIRWS965d+iXE4YhlIqOjm3w7WxJRwRKnBWTrNH3ifHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JQHVSGFE; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747197097; x=1778733097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rH3C6pzsOZigobTduN+uaXbF+DvbFzqeaIAoM3YchGs=;
  b=JQHVSGFE7uPyV5gLMQjWojiljWwgNz88ZRz7l80aySwL7SOdmOHaCag4
   phI7L/+SKdIVnwT/PYZTOij6JD9F74QGLzwVaJ29a+U8c2nn8m4aaEzUw
   1eKlNAD57rZF/HlM2UgO/dwNgdjAs+pUwlZoyETGB6fwAzbxdAD7xW3US
   O0VOBqWXWYe0Mn2tdrSbgxEmlcwmIfFESm57cc5FYur8crPolO5Ts51o1
   2G9NU8K8fxZ7NITqB/oUXNDCxd+kyFbqlqjdhsLhirj+BlruJATmYNJIc
   iAkup9PtwsI8Ui7nSx4eAlwG8ZSbeT6vl9hrBzypF3+r3170dcTAsteLa
   w==;
X-CSE-ConnectionGUID: sKdMfE44RiOd+bO5WAM/Pg==
X-CSE-MsgGUID: vse+GWfVT76cweyEZVLrYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="36699404"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="36699404"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 21:31:21 -0700
X-CSE-ConnectionGUID: f4l0QCjpSOO1pXLhdvJxqg==
X-CSE-MsgGUID: dUhuNqdCS66fa6005xIJ6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="142861861"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by orviesa004.jf.intel.com with ESMTP; 13 May 2025 21:31:18 -0700
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>
Subject: [PATCH iwl-next v2 5/8] igc: add private flag to reverse TX queue priority in TSN mode
Date: Wed, 14 May 2025 00:29:42 -0400
Message-Id: <20250514042945.2685273-6-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514042945.2685273-1-faizal.abdul.rahim@linux.intel.com>
References: <20250514042945.2685273-1-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

By default, igc assigns TX hw queue 0 the highest priority and queue 3
the lowest. This is opposite of most NICs, where TX hw queue 3 has the
highest priority and queue 0 the lowest.

mqprio in igc already uses TX arbitration unconditionally to reverse TX
queue priority when mqprio is enabled. The TX arbitration logic does not
require a private flag, because mqprio was added recently and no known
users depend on the default queue ordering, which differs from the typical
convention.

taprio does not use TX arbitration, so it inherits the default igc TX
queue priority order. This causes tc command inconsistencies when
configuring frame preemption with taprio compared to mqprio in igc.
Other tc command inconsistencies and configuration issues already exist
when using taprio on igc compared to other network controllers. These
issues are described in a later section.

To harmonize TX queue priority behavior between taprio and mqprio, and
to fix these issues without breaking long-standing taprio use cases,
this patch adds a new private flag, called reverse-tsn-txq-prio, to
reverse the TX queue priority. It makes queue 3 the highest and queue 0
the lowest, reusing the TX arbitration logic already used by mqprio.

Users must set the private flag when enabling frame preemption with
taprio to follow the standard convention. Doing so promotes adoption of
the correct priority model for new features while preserving
compatibility with legacy configurations.

This new private flag addresses:

1.  Non-standard socket → tc → TX hw queue mapping for taprio in igc

Without the private flag:
- taprio maps (socket → tc → TX hardware queue) differently on igc
  compared to other network controllers
- On igc, mqprio maps tc differently from taprio, since mqprio already
  uses TX arbitration

The following examples compare taprio configuration on igc and other
network controllers:
a)  On other NICs (TX hw queue 3 is highest priority):
    taprio num_tc 4 map 0 1 2 3 .... \
    queues 1@0 1@1 1@2 1@3

    Mapping translates to:
    socket 0 → tc 0 → queue 0
    socket 3 → tc 3 → queue 3

    This is the normal mapping that respects the standard convention:
    higher socket number → higher tc -> higher priority TX hw queue

b)  On igc (TX hw queue 0 is highest priority by default):
    taprio num_tc 4 map 3 2 1 0 .... \
    queues 1@0 1@1 1@2 1@3

    Mapping translates to:
    socket 0 → tc 3 → queue 3
    socket 3 → tc 0 → queue 0

    This igc tc mapping example is based on Intel's TSN validation test
    case, where a higher socket priority maps to a higher priority queue.
    It respects the mapping:
      higher socket number -> higher priority TX hw queue
    but breaks the expected ordering:
      higher tc -> higher priority TX hw queue
    as defined in [Ref1]. This custom mapping complicates common taprio
    setup across NICs.

2.  Non-standard frame preemption mapping for taprio in igc

Without the private flag:
- Compared to other network controllers, taprio on igc must flip the
  expected fp sequence, since express traffic is expected to map to the
  highest priority queue and preemptible traffic to lower ones
- On igc, frame preemption configuration for mqprio differs from taprio,
  since mqprio already uses TX arbitration

The following examples compare taprio frame preemption configuration on
igc and other network controllers:
a)  On other NICs (TX hw queue 3 is highest priority):
    taprio num_tc 4 map ..... \
    queues 1@0 1@1 1@2 1@3 \
    fp P P P E

    Mapping translates to:
    tc0, tc1, tc2 → preemptible → queue 0, 1, 2
    tc3           → express     → queue 3

    This is the normal mapping that respects the standard convention:
    higher tc -> express traffic -> higher priority TX hw queue
    lower tc  -> preemptible traffic -> lower priority TX hw queue

b)  On igc (TX hw queue 0 is highest priority by default):
    taprio num_tc 4 map ...... \
    queues 1@0 1@1 1@2 1@3 \
    fp E P P P

    Mapping translates to:
    tc0           → express     → queue 0
    tc1, tc2, tc3 → preemptible → queue 1, 2, 3

    This inversion respects the mapping of:
      express traffic -> higher priority TX hw queue
    but breaks the expected ordering:
      higher tc -> express traffic
    as defined in [Ref1] where higher tc indicates higher priority. In
    this case, the lower tc0 is assigned to express traffic. This custom
    mapping further complicates common preemption setup across NICs.

Tests were performed on taprio with the following combinations, where
two apps send traffic simultaneously on different queues:

  Private Flag   Traffic Sent By           Traffic Sent By
  ----------------------------------------------------------------
  enabled        iperf3 (queue 3)          iperf3 (queue 0)
  disabled       iperf3 (queue 0)          iperf3 (queue 3)
  enabled        iperf3 (queue 3)          real-time app (queue 0)
  disabled       iperf3 (queue 0)          real-time app (queue 3)
  enabled        real-time app (queue 3)   iperf3 (queue 0)
  disabled       real-time app (queue 0)   iperf3 (queue 3)
  enabled        real-time app (queue 3)   real-time app (queue 0)
  disabled       real-time app (queue 0)   real-time app (queue 3)

Private flag is controlled with:
 ethtool --set-priv-flags enp1s0 reverse-tsn-txq-prio <on|off>

[Ref1]
IEEE 802.1Q clause 8.6.8 Transmission selection:
"For a given Port and traffic class, frames are selected from the
corresponding queue for transmission if and only if:
...
b) For each queue corresponding to a numerically higher value of traffic
class supported by the Port, the operation of the transmission selection
algorithm supported by that queue determines that there is no frame
available for transmission."

Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h         |  1 +
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 12 ++++++++++--
 drivers/net/ethernet/intel/igc/igc_main.c    |  3 ++-
 drivers/net/ethernet/intel/igc/igc_tsn.c     |  3 ++-
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index daab06fc3f80..023ff8a5b285 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -395,6 +395,7 @@ extern char igc_driver_name[];
 #define IGC_FLAG_TSN_QBV_ENABLED	BIT(17)
 #define IGC_FLAG_TSN_QAV_ENABLED	BIT(18)
 #define IGC_FLAG_TSN_PREEMPT_ENABLED	BIT(19)
+#define IGC_FLAG_TSN_REVERSE_TXQ_PRIO	BIT(20)
 
 #define IGC_FLAG_TSN_ANY_ENABLED				\
 	(IGC_FLAG_TSN_QBV_ENABLED | IGC_FLAG_TSN_QAV_ENABLED |	\
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 3fc1eded9605..054b7390cb4b 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -122,9 +122,11 @@ static const char igc_gstrings_test[][ETH_GSTRING_LEN] = {
 #define IGC_STATS_LEN \
 	(IGC_GLOBAL_STATS_LEN + IGC_NETDEV_STATS_LEN + IGC_QUEUE_STATS_LEN)
 
+#define IGC_PRIV_FLAGS_LEGACY_RX		BIT(0)
+#define IGC_PRIV_FLAGS_REVERSE_TSN_TXQ_PRIO	BIT(1)
 static const char igc_priv_flags_strings[][ETH_GSTRING_LEN] = {
-#define IGC_PRIV_FLAGS_LEGACY_RX	BIT(0)
 	"legacy-rx",
+	"reverse-tsn-txq-prio",
 };
 
 #define IGC_PRIV_FLAGS_STR_LEN ARRAY_SIZE(igc_priv_flags_strings)
@@ -1600,6 +1602,9 @@ static u32 igc_ethtool_get_priv_flags(struct net_device *netdev)
 	if (adapter->flags & IGC_FLAG_RX_LEGACY)
 		priv_flags |= IGC_PRIV_FLAGS_LEGACY_RX;
 
+	if (adapter->flags & IGC_FLAG_TSN_REVERSE_TXQ_PRIO)
+		priv_flags |= IGC_PRIV_FLAGS_REVERSE_TSN_TXQ_PRIO;
+
 	return priv_flags;
 }
 
@@ -1608,10 +1613,13 @@ static int igc_ethtool_set_priv_flags(struct net_device *netdev, u32 priv_flags)
 	struct igc_adapter *adapter = netdev_priv(netdev);
 	unsigned int flags = adapter->flags;
 
-	flags &= ~IGC_FLAG_RX_LEGACY;
+	flags &= ~(IGC_FLAG_RX_LEGACY | IGC_FLAG_TSN_REVERSE_TXQ_PRIO);
 	if (priv_flags & IGC_PRIV_FLAGS_LEGACY_RX)
 		flags |= IGC_FLAG_RX_LEGACY;
 
+	if (priv_flags & IGC_PRIV_FLAGS_REVERSE_TSN_TXQ_PRIO)
+		flags |= IGC_FLAG_TSN_REVERSE_TXQ_PRIO;
+
 	if (flags != adapter->flags) {
 		adapter->flags = flags;
 
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 1033d64fc0e8..c1cb0e666469 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6698,7 +6698,8 @@ static int igc_tc_query_caps(struct igc_adapter *adapter,
 	case TC_SETUP_QDISC_TAPRIO: {
 		struct tc_taprio_caps *caps = base->caps;
 
-		caps->broken_mqprio = true;
+		if (!(adapter->flags & IGC_FLAG_TSN_REVERSE_TXQ_PRIO))
+			caps->broken_mqprio = true;
 
 		if (hw->mac.type == igc_i225) {
 			caps->supports_queue_max_sdu = true;
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 78a4a9cf5f96..43151ab4c1b7 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -398,7 +398,8 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 	if (igc_is_device_id_i226(hw))
 		igc_tsn_set_retx_qbvfullthreshold(adapter);
 
-	if (adapter->strict_priority_enable)
+	if (adapter->strict_priority_enable ||
+	    adapter->flags & IGC_FLAG_TSN_REVERSE_TXQ_PRIO)
 		igc_tsn_tx_arb(adapter, true);
 
 	for (i = 0; i < adapter->num_tx_queues; i++) {
-- 
2.34.1


