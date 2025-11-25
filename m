Return-Path: <netdev+bounces-241435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE2BC84012
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5369D4E82BC
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE742E03F2;
	Tue, 25 Nov 2025 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iYJYVRXl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE6B2D0C64;
	Tue, 25 Nov 2025 08:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764059704; cv=none; b=Up9jkoJwtl1YeFRr5iXFAq2yNsQ4ZmIgWiFOImKOKb4GEWnokZunPd9mQqVtdL2qV897DHm2j4JR18wroOqE6Gw92JpApf96z0ndoIUz4Cc2fZpxM0DBkl8RgNDNbcOroT3ywe79gwt3zYAGkFCvEQHzw98vOHho/vM93Hkusi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764059704; c=relaxed/simple;
	bh=r5EaSDWS/NmPpI6YZYT8Fc7qlBaoieqrFHyUugOu9/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9ILg7HV7N/3/FkdmxivNooM0Rz+MtBCZvkSwfoCFWM8wFW8Ze/lQysIaPaSrIhC6Dt1ckJdLLn+R8jfEcLA+92EbXjTqps0mDqfaWGMr9Z4ptpH15L8N3H7dDDWgvMK5wTx9DMqM9VpI9bK07di/zfDyMXvAe4a2quY0+Xjxgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iYJYVRXl; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764059702; x=1795595702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r5EaSDWS/NmPpI6YZYT8Fc7qlBaoieqrFHyUugOu9/o=;
  b=iYJYVRXlHYOht90gx/Iz4OeZJznCe/oYcW6TyQYjh3a0dUWJ7zWdmqNw
   EYOq1+g1loRsfHeyRYevS06GpVR668P6B1DdNzugeuTrB6FdFOIBrAGgn
   MQnFG++ALCjIDOnDHpUp5MD9h7m9u3KpPyAAy3EyjGhqjQiHl5GeBaFaC
   +ztKIwBcZ5AQ/CDWlz3GTxzJa2pkTgeIntn3eE+kgs39xB+4tjUTmWM9g
   N97LBg2BwBDIE5u5Zz2bdoXU0Yyga1RnbtzARb78zccANwtm3+GT1Fmih
   XCuMEYd8NlAVFcZ8yJwYYEQ5Z4TZVlzaSiODXEvNwsK78PeUGdJcLYL6w
   w==;
X-CSE-ConnectionGUID: yPjTgxE5QCqMoeGmAbbx7w==
X-CSE-MsgGUID: 24US4iTQTAWyJKIFE7yLEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="76694425"
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="76694425"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 00:35:02 -0800
X-CSE-ConnectionGUID: Z6EnwLaTTHuXHK9utNrn6g==
X-CSE-MsgGUID: CANhbQb6SiGAIHx+HW7l3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="196749753"
Received: from hpe-dl385gen10.igk.intel.com ([10.91.240.117])
  by orviesa003.jf.intel.com with ESMTP; 25 Nov 2025 00:35:00 -0800
From: Jakub Slepecki <jakub.slepecki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	jakub.slepecki@intel.com,
	aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v2 1/8] ice: in dvm, use outer VLAN in MAC,VLAN lookup
Date: Tue, 25 Nov 2025 09:34:49 +0100
Message-ID: <20251125083456.28822-2-jakub.slepecki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125083456.28822-1-jakub.slepecki@intel.com>
References: <20251125083456.28822-1-jakub.slepecki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

In double VLAN mode (DVM), outer VLAN is located a word earlier in
the field vector compared to the single VLAN mode.  We already modify
ICE_SW_LKUP_VLAN to use it but ICE_SW_LKUP_MAC_VLAN was left untouched,
causing the lookup to match any packet with one or no layer of Dot1q.
This change enables to fix cross-vlan loopback traffic using MAC,VLAN
lookups.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Jakub Slepecki <jakub.slepecki@intel.com>

---
No changes in v2.
---
 drivers/net/ethernet/intel/ice/ice_vlan_mode.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_vlan_mode.c b/drivers/net/ethernet/intel/ice/ice_vlan_mode.c
index fb526cb84776..68a7b05de44e 100644
--- a/drivers/net/ethernet/intel/ice/ice_vlan_mode.c
+++ b/drivers/net/ethernet/intel/ice/ice_vlan_mode.c
@@ -198,6 +198,7 @@ static bool ice_is_dvm_supported(struct ice_hw *hw)
 #define ICE_SW_LKUP_VLAN_LOC_LKUP_IDX			1
 #define ICE_SW_LKUP_VLAN_PKT_FLAGS_LKUP_IDX		2
 #define ICE_SW_LKUP_PROMISC_VLAN_LOC_LKUP_IDX		2
+#define ICE_SW_LKUP_MAC_VLAN_LOC_LKUP_IDX		4
 #define ICE_PKT_FLAGS_0_TO_15_FV_IDX			1
 static struct ice_update_recipe_lkup_idx_params ice_dvm_dflt_recipes[] = {
 	{
@@ -234,6 +235,17 @@ static struct ice_update_recipe_lkup_idx_params ice_dvm_dflt_recipes[] = {
 		.mask_valid = false,  /* use pre-existing mask */
 		.lkup_idx = ICE_SW_LKUP_PROMISC_VLAN_LOC_LKUP_IDX,
 	},
+	{
+		/* Similarly to ICE_SW_LKUP_VLAN, change to outer/single VLAN in
+		 * DVM
+		 */
+		.rid = ICE_SW_LKUP_MAC_VLAN,
+		.fv_idx = ICE_EXTERNAL_VLAN_ID_FV_IDX,
+		.ignore_valid = true,
+		.mask = 0,
+		.mask_valid = false,
+		.lkup_idx = ICE_SW_LKUP_MAC_VLAN_LOC_LKUP_IDX,
+	},
 };
 
 /**
-- 
2.43.0


