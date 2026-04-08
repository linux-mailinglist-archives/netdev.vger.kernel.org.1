Return-Path: <netdev+bounces-276550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WELWOZ9U1mm8DQgAu9opvQ
	(envelope-from <netdev+bounces-276550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:14:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 652B83BCADF
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 007823072E13
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 13:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FD63CCFB7;
	Wed,  8 Apr 2026 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BGgdxmu5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAC03CAE7D
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775653952; cv=none; b=Hu5eqFsQhXwg2ipOk7G0HP/87VYxRBkFqOfLnyzKcD4TiAVt8X9TzF85h/Dm+/+0PW1HoQe12h0ABmGJm7U6e83zVH8M9ruei5xM2DacPLTRPIWWW9jNHUEKjZ5ZTK+M3P0Hv2KtGIrwoPgIYN1mDUT+XAEbc3pUFZRD4q/vmJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775653952; c=relaxed/simple;
	bh=qSs/6cxPK78CVLwR3TsPdb+AwFgYd6qJdHXW2+qXedc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYLQQedGUnqbYzyZEZCVpYwCYnwN1HUN1XhZ3MDz5BQaJsoyIniUZIl8mgiGU4B/0apT6bsdtmgvR1enmsU/BXtpMDA6aSJzNX5e2qwGyxiTncGGJ8T/BCrA08xsH3R8yPb6dwQp17nrzFDfAt36xX2YWwnmFjjTrrki2G0KQVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BGgdxmu5; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775653951; x=1807189951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qSs/6cxPK78CVLwR3TsPdb+AwFgYd6qJdHXW2+qXedc=;
  b=BGgdxmu5tNzI148KpFgBAUIph2JCVcMj5r8orjgU1sOXcfdYGjGaoEjz
   cSakOlGnogRpjABF4abpV8rmkoqoNxiagIgtO0xoC64eJmh2+/82FGq5z
   b0KQMiZOsO7goL2BtwyD3fbJYTJyfJlC3pBNcGrQYXsZbVVUdiumAyiZN
   9rA8395f70f2idr6dNjqF4AGZ4xBQy0KdHtPexzqyOtVUtpXVCqBTshX3
   cVsvA8T4d7aEObBzng5pAhoCXL+afh4ETgwM4fy4tUt/OzoWrzbjzgRi0
   Wfc9xQlfZjCm/mNOc7UH+jj8bI4/wRkXwe0t/FPHY/LF9W/gnAWzTUMnW
   A==;
X-CSE-ConnectionGUID: zq3hoQevSQqNviy5cADkqg==
X-CSE-MsgGUID: OHWanZ1KTeiQ3e7RtiMX0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="102087298"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="102087298"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 06:12:31 -0700
X-CSE-ConnectionGUID: KnQNf1VbReiLKVuzPvE/tg==
X-CSE-MsgGUID: PnM6zYYXS8K5ZkkPwLKTsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="228715125"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa007.jf.intel.com with ESMTP; 08 Apr 2026 06:12:30 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next v2 8/8] ixgbe: use int instead of u32 for error code variables
Date: Wed,  8 Apr 2026 15:12:16 +0200
Message-ID: <20260408131216.2662245-9-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408131216.2662245-1-aleksandr.loktionov@intel.com>
References: <20260408131216.2662245-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276550-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 652B83BCADF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The variables used to store return values of kernel and driver functions
throughout the ixgbe driver are declared as u32 in several places.  Such
functions return negative errno values on error (e.g. -EIO, -EFAULT),
which are sign-extended negative integers.  Storing them in an unsigned
u32 silently wraps the value: -EIO (0xFFFFFFF7) stored in u32 becomes a
large positive number, so any "if (status)" truthiness check still works
by accident, but comparisons against specific negative error codes or
propagation up the call stack produce wrong results.

In the Linux kernel, u32 is reserved for fixed-width quantities used in
hardware interfaces or protocol structures.  Using it for generic error
codes misleads reviewers into thinking the value is hardware-constrained.

Change all such local variables from u32 to int driver-wide: one in
ixgbe_main.c (ixgbe_resume), three in ixgbe_phy.c
(ixgbe_identify_phy_generic, ixgbe_tn_check_overtemp,
ixgbe_set_copper_phy_power), and six in ixgbe_x550.c
(ixgbe_check_link_t_X550em, ixgbe_get_lasi_ext_t_x550em,
ixgbe_enable_lasi_ext_t_x550em, ixgbe_handle_lasi_ext_t_x550em,
ixgbe_ext_phy_t_x550em_get_link, ixgbe_setup_internal_phy_t_x550em).

No functional change.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v1 -> v2:
 - Carry Reviewed-by: Simon Horman from the IWL posting; add [N/M]
   numbering; no code change.

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |  6 +++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 12 ++++++------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index ed5b75b..99cfccd 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7531,7 +7531,7 @@ static int ixgbe_resume(struct device *dev_d)
 	struct pci_dev *pdev = to_pci_dev(dev_d);
 	struct ixgbe_adapter *adapter = pci_get_drvdata(pdev);
 	struct net_device *netdev = adapter->netdev;
-	u32 err;
+	int err;
 
 	adapter->hw.hw_addr = adapter->io_addr;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index ab733e7..de8f6c6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -262,7 +262,7 @@ static bool ixgbe_probe_phy(struct ixgbe_hw *hw, u16 phy_addr)
  **/
 int ixgbe_identify_phy_generic(struct ixgbe_hw *hw)
 {
-	u32 status = -EFAULT;
+	int status = -EFAULT;
 	u32 phy_addr;
 
 	if (!hw->phy.phy_semaphore_mask) {
@@ -2811,7 +2811,7 @@ static void ixgbe_i2c_bus_clear(struct ixgbe_hw *hw)
 bool ixgbe_tn_check_overtemp(struct ixgbe_hw *hw)
 {
 	u16 phy_data = 0;
-	u32 status;
+	int status;
 
 	if (hw->device_id != IXGBE_DEV_ID_82599_T3_LOM)
 		return false;
@@ -2831,7 +2831,7 @@ bool ixgbe_tn_check_overtemp(struct ixgbe_hw *hw)
  **/
 int ixgbe_set_copper_phy_power(struct ixgbe_hw *hw, bool on)
 {
-	u32 status;
+	int status;
 	u16 reg;
 
 	/* Bail if we don't have copper phy */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 76d2fa3..9b14f3b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1911,7 +1911,7 @@ static int ixgbe_check_link_t_X550em(struct ixgbe_hw *hw,
 				     bool *link_up,
 				     bool link_up_wait_to_complete)
 {
-	u32 status;
+	int status;
 	u16 i, autoneg_status;
 
 	if (hw->mac.ops.get_media_type(hw) != ixgbe_media_type_copper)
@@ -2330,7 +2330,7 @@ static int ixgbe_get_link_capabilities_X550em(struct ixgbe_hw *hw,
 static int ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc,
 				       bool *is_overtemp)
 {
-	u32 status;
+	int status;
 	u16 reg;
 
 	*is_overtemp = false;
@@ -2418,7 +2418,7 @@ static int ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc,
 static int ixgbe_enable_lasi_ext_t_x550em(struct ixgbe_hw *hw)
 {
 	bool lsc, overtemp;
-	u32 status;
+	int status;
 	u16 reg;
 
 	/* Clear interrupt flags */
@@ -2512,7 +2512,7 @@ static int ixgbe_handle_lasi_ext_t_x550em(struct ixgbe_hw *hw,
 {
 	struct ixgbe_phy_info *phy = &hw->phy;
 	bool lsc;
-	u32 status;
+	int status;
 
 	status = ixgbe_get_lasi_ext_t_x550em(hw, &lsc, is_overtemp);
 	if (status)
@@ -2606,7 +2606,7 @@ static int ixgbe_setup_kr_x550em(struct ixgbe_hw *hw)
  **/
 static int ixgbe_ext_phy_t_x550em_get_link(struct ixgbe_hw *hw, bool *link_up)
 {
-	u32 ret;
+	int ret;
 	u16 autoneg_status;
 
 	*link_up = false;
@@ -2642,7 +2642,7 @@ static int ixgbe_setup_internal_phy_t_x550em(struct ixgbe_hw *hw)
 {
 	ixgbe_link_speed force_speed;
 	bool link_up;
-	u32 status;
+	int status;
 	u16 speed;
 
 	if (hw->mac.ops.get_media_type(hw) != ixgbe_media_type_copper)
-- 
2.52.0

