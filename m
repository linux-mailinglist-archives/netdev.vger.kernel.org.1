Return-Path: <netdev+bounces-119653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B67C19567EB
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 12:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8D181C21AC6
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 10:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6BD15FA96;
	Mon, 19 Aug 2024 10:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eYoy55Gy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD15615F40A
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062446; cv=none; b=K7Hso7EwzPke1ngJL8dLlLlKJKanvoJ8lIlrPJsqGIiPO0UqryzUMwJX3vy6IfMCTbgmexLgjsjnCb3NrmAg51BK2EMVdJLVvcY9FfgET3g9V+xGXlJYShsaG4g3m9DWjrtXjwt9NYwmL8FhxlvPoetY8S0KVAab/rTQkAx6SOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062446; c=relaxed/simple;
	bh=OdCIEHfgvFJ64xVjrEiuwnfedCAXa+QyPQoNYh8AiRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gEfIPrzolVr+9LpPcjh7LErcBKU8ImFbygwSv0/8zdos3OWM0HLpbE6QMDodfedvICb+MIoUriu1p2F6VQSV9VIOx20qE1mXCYQPuXGqSpCt3/JZh06to+Me9tEXb8feJh7FL+7F4MIm7Ih2KzCmTR/p0rJ618qcTGXPXs6Cd9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eYoy55Gy; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724062444; x=1755598444;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OdCIEHfgvFJ64xVjrEiuwnfedCAXa+QyPQoNYh8AiRI=;
  b=eYoy55GyHW9WYmUhsK/78QOV2wWMIixILrG3r7T5lMCOIgJgiUlk9Xky
   p/MjsXrKLaud8u3A1YK2l60ZxljX+e7TEbnt+BLR4mJ9rPKuRfpak+Hdv
   +JSesoLzlWfTHvP/GIT/mrdKLKnPNl4NB97KS7EEMlKKHXgupjZZzSoy5
   52YEmWW2QK8w/+3wOQJS+WYe5nI0shVspFZhCctQaJ4gu0sWbklqOkNpM
   gAzP7vLjSXSWvoSY5ifAi8fQ+/ZyZt4tiV93YKuTQi+4X5KB5JXbhUviU
   totL5UYIbS4RRYmop0wSYPjH5gZI0pr2I6QI5Qg9GM3ts1X/Re/8UBB9g
   g==;
X-CSE-ConnectionGUID: 1JHIJKC4S8i+AmhC8wYkig==
X-CSE-MsgGUID: 7HcL4GzzSliAejJJ8QXivg==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="13090090"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="13090090"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 03:14:03 -0700
X-CSE-ConnectionGUID: XDeJ29GoTMe+FR6D17qeLA==
X-CSE-MsgGUID: +90gsaXuSDO8fi4+jvastw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="91097032"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa001.fm.intel.com with ESMTP; 19 Aug 2024 03:14:02 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	wojciech.drewek@intel.com,
	przemyslaw.kitszel@intel.com
Subject: [iwl-next v1] ice: set correct dst VSI in only LAN filters
Date: Mon, 19 Aug 2024 12:14:01 +0200
Message-ID: <20240819101401.67924-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The filters set that will reproduce the problem:
$ tc filter add dev $VF0_PR ingress protocol arp prio 0 flower \
	skip_sw dst_mac ff:ff:ff:ff:ff:ff action mirred egress \
	redirect dev $PF0
$ tc filter add dev $VF0_PR ingress protocol arp prio 0 flower \
	skip_sw dst_mac ff:ff:ff:ff:ff:ff src_mac 52:54:00:00:00:10 \
	action mirred egress mirror dev $VF1_PR

Expected behaviour is to set all broadcast from VF0 to the LAN. If the
src_mac match the value from filters, send packet to LAN and to VF1.

In this case both LAN_EN and LB_EN flags in switch is set in case of
packet matching both filters. As dst VSI for the only LAN enable bit is
PF VSI, the packet is being seen on PF. To fix this change dst VSI to
the source VSI. It will block receiving any packet even when LB_EN is
set by switch, because local loopback is clear on VF VSI during normal
operation.

Side note: if the second filters action is redirect instead of mirror
LAN_EN is clear, because switch is AND-ing LAN_EN from each matched
filters and OR-ing LB_EN.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Fixes: 73b483b79029 ("ice: Manage act flags for switchdev offloads")
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index e6923f8121a9..ea39b999a0d0 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -819,6 +819,17 @@ ice_eswitch_add_tc_fltr(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr)
 		rule_info.sw_act.flag |= ICE_FLTR_TX;
 		rule_info.sw_act.src = vsi->idx;
 		rule_info.flags_info.act = ICE_SINGLE_ACT_LAN_ENABLE;
+		/* This is a specific case. The destination VSI index is
+		 * overwritten by the source VSI index. This type of filter
+		 * should allow the packet to go to the LAN, not to the
+		 * VSI passed here. It should set LAN_EN bit only. However,
+		 * the VSI must be a valid one. Setting source VSI index
+		 * here is safe. Even if the result from switch is set LAN_EN
+		 * and LB_EN (which normally will pass the packet to this VSI)
+		 * packet won't be seen on the VSI, because local loopback is
+		 * turned off.
+		 */
+		rule_info.sw_act.vsi_handle = vsi->idx;
 	} else {
 		/* VF to VF */
 		rule_info.sw_act.flag |= ICE_FLTR_TX;
-- 
2.42.0


