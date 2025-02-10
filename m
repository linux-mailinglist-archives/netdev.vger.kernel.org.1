Return-Path: <netdev+bounces-164894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DE7A2F890
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C611163D1E
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1901B257AFF;
	Mon, 10 Feb 2025 19:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lrkawFZ5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBFA2566FE
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 19:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739215448; cv=none; b=n6OoHPB4+LI9YfVusWCWZnc5vUgstcSW+OuEkJyyWN/cjC/wy/D0JIq39U3/5OghZDvauktDz4UvZMGdDRryd0JyVg5sjqI6X4/48oWKnBehAc14abLuIVMXiMas8B1bgw7WOyF3JoCK60k5QzD0xQ6X3Ke3+xmdnkbjk5OuPH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739215448; c=relaxed/simple;
	bh=J104uvR1ub4bAqKaQUlrSnOJsaox7yHWYVuu1tnWdXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sP1UGASQj+SJk/Md9gre2vDPK+6PeEe4bZGTRYpJArTu+EuPSZG9/99BBlSY2LjtxnWE0V7tE/UrZSzQ7PHTqzrST3A+jBS8DofWaM9jETOw5663yfpl1CrgVzVg0TgM+vzKK00LR6f6Wi4JfPV2NxMtt8kKenIVZQircufM5YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lrkawFZ5; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739215446; x=1770751446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J104uvR1ub4bAqKaQUlrSnOJsaox7yHWYVuu1tnWdXE=;
  b=lrkawFZ5c/ucvoTfKOomzMcgVqxzrZVhoe1X7SfKiJ5GlibJoL1MJCFY
   7d+hW7FcO9iP9upTkpCuiaepfolTGQ3a/sRtu+w36J2a5e7Q34po+Rch5
   qmybXnWVDgxDMIEx0rummBt1ZvProNb09IuiJX2NaSJjk7Q41jkfPxX5g
   Fnvursii5GdShEJ9eSTWAM+M7y+rYGczT7M5a69OIJABOmyLZuZZsbzD9
   OtRZTuMOhhpLDbUzIxu8fVifTJwH/vaMsh4Df3rsjABxl4MUvdtGz+/ym
   B6fv51gduKoPhd913wMRrPH+/oZN9XsZXL0wsLHJSjojcSQwbqCcEFBMl
   w==;
X-CSE-ConnectionGUID: fwCYQDQZTrS9QSWpdt4yYg==
X-CSE-MsgGUID: s+Dwz8bHQNSTcHMp/QgiXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39929242"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="39929242"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 11:24:01 -0800
X-CSE-ConnectionGUID: poDjftUsSQSDtBbq5oD22w==
X-CSE-MsgGUID: cywMl/2ZQha7CYDBUeIWBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112733877"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 10 Feb 2025 11:24:02 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	grzegorz.nitka@intel.com,
	przemyslaw.kitszel@intel.com
Subject: [PATCH net-next 06/10] ice: Refactor ice_ptp_init_tx_*
Date: Mon, 10 Feb 2025 11:23:44 -0800
Message-ID: <20250210192352.3799673-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210192352.3799673-1-anthony.l.nguyen@intel.com>
References: <20250210192352.3799673-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Unify ice_ptp_init_tx_* functions for most of the MAC types except E82X.
This simplifies the code for the future use with new MAC types.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 56 ++++++++----------------
 drivers/net/ethernet/intel/ice/ice_ptp.h |  3 +-
 2 files changed, 20 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 6e1801285a5d..79ec8727388b 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -971,28 +971,6 @@ ice_ptp_release_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
 	tx->len = 0;
 }
 
-/**
- * ice_ptp_init_tx_eth56g - Initialize tracking for Tx timestamps
- * @pf: Board private structure
- * @tx: the Tx tracking structure to initialize
- * @port: the port this structure tracks
- *
- * Initialize the Tx timestamp tracker for this port. ETH56G PHYs
- * have independent memory blocks for all ports.
- *
- * Return: 0 for success, -ENOMEM when failed to allocate Tx tracker
- */
-static int ice_ptp_init_tx_eth56g(struct ice_pf *pf, struct ice_ptp_tx *tx,
-				  u8 port)
-{
-	tx->block = port;
-	tx->offset = 0;
-	tx->len = INDEX_PER_PORT_ETH56G;
-	tx->has_ready_bitmap = 1;
-
-	return ice_ptp_alloc_tx_tracker(tx);
-}
-
 /**
  * ice_ptp_init_tx_e82x - Initialize tracking for Tx timestamps
  * @pf: Board private structure
@@ -1003,9 +981,11 @@ static int ice_ptp_init_tx_eth56g(struct ice_pf *pf, struct ice_ptp_tx *tx,
  * the timestamp block is shared for all ports in the same quad. To avoid
  * ports using the same timestamp index, logically break the block of
  * registers into chunks based on the port number.
+ *
+ * Return: 0 on success, -ENOMEM when out of memory
  */
-static int
-ice_ptp_init_tx_e82x(struct ice_pf *pf, struct ice_ptp_tx *tx, u8 port)
+static int ice_ptp_init_tx_e82x(struct ice_pf *pf, struct ice_ptp_tx *tx,
+				u8 port)
 {
 	tx->block = ICE_GET_QUAD_NUM(port);
 	tx->offset = (port % ICE_PORTS_PER_QUAD) * INDEX_PER_PORT_E82X;
@@ -1016,24 +996,27 @@ ice_ptp_init_tx_e82x(struct ice_pf *pf, struct ice_ptp_tx *tx, u8 port)
 }
 
 /**
- * ice_ptp_init_tx_e810 - Initialize tracking for Tx timestamps
+ * ice_ptp_init_tx - Initialize tracking for Tx timestamps
  * @pf: Board private structure
  * @tx: the Tx tracking structure to initialize
+ * @port: the port this structure tracks
+ *
+ * Initialize the Tx timestamp tracker for this PF. For all PHYs except E82X,
+ * each port has its own block of timestamps, independent of the other ports.
  *
- * Initialize the Tx timestamp tracker for this PF. For E810 devices, each
- * port has its own block of timestamps, independent of the other ports.
+ * Return: 0 on success, -ENOMEM when out of memory
  */
-static int
-ice_ptp_init_tx_e810(struct ice_pf *pf, struct ice_ptp_tx *tx)
+static int ice_ptp_init_tx(struct ice_pf *pf, struct ice_ptp_tx *tx, u8 port)
 {
-	tx->block = pf->hw.port_info->lport;
+	tx->block = port;
 	tx->offset = 0;
-	tx->len = INDEX_PER_PORT_E810;
+	tx->len = INDEX_PER_PORT;
+
 	/* The E810 PHY does not provide a timestamp ready bitmap. Instead,
 	 * verify new timestamps against cached copy of the last read
 	 * timestamp.
 	 */
-	tx->has_ready_bitmap = 0;
+	tx->has_ready_bitmap = pf->hw.mac_type != ICE_MAC_E810;
 
 	return ice_ptp_alloc_tx_tracker(tx);
 }
@@ -3235,6 +3218,8 @@ static int ice_ptp_init_work(struct ice_pf *pf, struct ice_ptp *ptp)
  * ice_ptp_init_port - Initialize PTP port structure
  * @pf: Board private structure
  * @ptp_port: PTP port structure
+ *
+ * Return: 0 on success, -ENODEV on invalid MAC type, -ENOMEM on failed alloc.
  */
 static int ice_ptp_init_port(struct ice_pf *pf, struct ice_ptp_port *ptp_port)
 {
@@ -3244,16 +3229,13 @@ static int ice_ptp_init_port(struct ice_pf *pf, struct ice_ptp_port *ptp_port)
 
 	switch (hw->mac_type) {
 	case ICE_MAC_E810:
-		return ice_ptp_init_tx_e810(pf, &ptp_port->tx);
+	case ICE_MAC_GENERIC_3K_E825:
+		return ice_ptp_init_tx(pf, &ptp_port->tx, ptp_port->port_num);
 	case ICE_MAC_GENERIC:
 		kthread_init_delayed_work(&ptp_port->ov_work,
 					  ice_ptp_wait_for_offsets);
-
 		return ice_ptp_init_tx_e82x(pf, &ptp_port->tx,
 					    ptp_port->port_num);
-	case ICE_MAC_GENERIC_3K_E825:
-		return ice_ptp_init_tx_eth56g(pf, &ptp_port->tx,
-					      ptp_port->port_num);
 	default:
 		return -ENODEV;
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index a3b27f716282..783139de7f74 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -128,8 +128,7 @@ struct ice_ptp_tx {
 /* Quad and port information for initializing timestamp blocks */
 #define INDEX_PER_QUAD			64
 #define INDEX_PER_PORT_E82X		16
-#define INDEX_PER_PORT_E810		64
-#define INDEX_PER_PORT_ETH56G		64
+#define INDEX_PER_PORT			64
 
 /**
  * struct ice_ptp_port - data used to initialize an external port for PTP
-- 
2.47.1


