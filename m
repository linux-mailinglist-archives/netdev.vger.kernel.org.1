Return-Path: <netdev+bounces-162410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C51A26C8E
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 08:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70933165232
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 07:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6D01FECCF;
	Tue,  4 Feb 2025 07:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YiinC79v"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71B225765
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 07:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738654243; cv=none; b=uNxqd/240cu56iqmjGls6e1iVt2cVAEF6kqob9BFc19OHw9en/e+baD8QcH/WbZlrLQeE+HnB+3bCf0pcVotC2tWpt1oOapvCL41o5ydaK7NRiyHieSiSX3jmjQHhoL3fZjrqKWTU8EO9K4nufAmPW4YSItEdrf/bnKo+fiPWv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738654243; c=relaxed/simple;
	bh=R6YD0PFSM1ITHaz6pfLZRtBgjBLLNVEwpi/gHV7An7M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oOPHkGoiQXI+3QsspL6cNdzLzdZ5iNsPpoJrtgIFx1kdxKHCIjiVSMy9FS6NPJWIDlczQBNZRt/jeFP43uwUAdhinlpng+2DK5B7w0pMxIxw5fbtCzyLWyttNjRScJIOAqrod/HnsZYZczUesnAiUCr8k3X/FEda+D0GETgrFTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YiinC79v; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738654242; x=1770190242;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R6YD0PFSM1ITHaz6pfLZRtBgjBLLNVEwpi/gHV7An7M=;
  b=YiinC79v3BirXZO3QDTR0CDxL4JvIC1c3hx1H89pOdWpnDKHokWvD4Uh
   a8HSlR/rI6h8hTDlBhBvrY3ncf7ZqnW5UGwOmat/Ty5hDWRvjjxvdLMUh
   5St6cQ3aSses3RdCQFOcuBGQ1Z86jNydzRfl2pmcatD8VOqCsZe0/WFf1
   YUfMl+nLaAiqvizKGq/qN3p7j3zCjzll5HcgRIojG/lSYMwaC1dFkk9i1
   fKB7hJCkwM7vp2kIle36org36X8TU0I01vSgwHbM77zD3GYycZkdPdHbl
   kg5XPAEcq0iKXFyNVnozZc7AfamShlSB98+mqzMiQZDER7zAYmblRNWfT
   A==;
X-CSE-ConnectionGUID: gXEHnP3hQdKZdB3rSJFMMQ==
X-CSE-MsgGUID: hbic7JYZSCGcdiYMZam8nA==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="26769618"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="26769618"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 23:30:40 -0800
X-CSE-ConnectionGUID: 49k+WfkrSYWBInIeUOIu8Q==
X-CSE-MsgGUID: nAH/QppXR62PBd2/VGGl8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="110690139"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa008.fm.intel.com with ESMTP; 03 Feb 2025 23:30:38 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	pmenzel@molgen.mpg.de,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v2] ixgbe: add support for thermal sensor event reception
Date: Tue,  4 Feb 2025 08:17:00 +0100
Message-Id: <20250204071700.8028-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

E610 NICs unlike the previous devices utilising ixgbe driver
are notified in the case of overheatning by the FW ACI event.

In event of overheat when treshold is exceeded, FW suspends all
traffic and sends overtemp event to the driver. Then driver
logs appropriate message and closes the adapter instance.
The card remains in that state until the platform is rebooted.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
v2: commit msg tweaks
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      | 5 +++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 7236f20c9a30..5c804948dd1f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3165,6 +3165,7 @@ static void ixgbe_aci_event_cleanup(struct ixgbe_aci_event *event)
 static void ixgbe_handle_fw_event(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_aci_event event __cleanup(ixgbe_aci_event_cleanup);
+	struct net_device *netdev = adapter->netdev;
 	struct ixgbe_hw *hw = &adapter->hw;
 	bool pending = false;
 	int err;
@@ -3185,6 +3186,10 @@ static void ixgbe_handle_fw_event(struct ixgbe_adapter *adapter)
 		case ixgbe_aci_opc_get_link_status:
 			ixgbe_handle_link_status_event(adapter, &event);
 			break;
+		case ixgbe_aci_opc_temp_tca_event:
+			e_crit(drv, "%s\n", ixgbe_overheat_msg);
+			ixgbe_close(netdev);
+			break;
 		default:
 			e_warn(hw, "unknown FW async event captured\n");
 			break;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
index 8d06ade3c7cd..617e07878e4f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -171,6 +171,9 @@ enum ixgbe_aci_opc {
 	ixgbe_aci_opc_done_alt_write			= 0x0904,
 	ixgbe_aci_opc_clear_port_alt_write		= 0x0906,
 
+	/* TCA Events */
+	ixgbe_aci_opc_temp_tca_event                    = 0x0C94,
+
 	/* debug commands */
 	ixgbe_aci_opc_debug_dump_internals		= 0xFF08,
 
-- 
2.31.1


