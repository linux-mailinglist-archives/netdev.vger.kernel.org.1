Return-Path: <netdev+bounces-211021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 820C7B1635A
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 17:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97DC13A85B1
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 15:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987BB2DC345;
	Wed, 30 Jul 2025 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UZ5+2XMV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A981AF0A7
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 15:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753888119; cv=none; b=jwmiiDxxd0CbBbovsg40ov4RnriJgMEDXFOnsnnFyJxrCxPH2dbhklMn9GCHkOFmuGOP20aZ+8jhDg/mthX3nc5rGlPN01VXxEnHs9WglJ6unN308YMdqPXcAkIsPnxef3Oi0avkRsgrxYakNW7cAQx67mcOHfNkYTZSlK48SCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753888119; c=relaxed/simple;
	bh=RJ3rDAj4sWeP/zmJ+H5foZYfyHgKgRPaIkyolVDqA2o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fpM823OBBTgHv+/WchzBxLG9cs8VYrCGNegROTKKsn/LAz/34HEClXUZpyLCQ7VTe0RtmGdXOOyyPROI7zUSe7qUwLWBB3bu0Pwl9r6XA6sLhWZqjNJ/76HOOxbTJLf1NELjL8h3EqPNwuYd2MfXfIEhXaZgyXZXRCTU+9lwu6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UZ5+2XMV; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753888117; x=1785424117;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RJ3rDAj4sWeP/zmJ+H5foZYfyHgKgRPaIkyolVDqA2o=;
  b=UZ5+2XMVcuMLu0R2fXV+M2bCvayNArcotdcXhAywS1g2ldD498Vd7+jl
   rL+JqVsTpkj1vCEjMbFpkoFZSvndrvuC+/Pi5jDzA1Y0zEj1jnxVRrRW3
   dROKwGTwWF2Ho5WSjPvjy1+J4K0Vbu4MN4JjzhiZ2CtBN5C9e46fDsBlk
   Yz76mp44JcMEEaptHuNL215H0txFf/+uOMThxOBymP0Uu4U5nVDR42boT
   va6jknIp8W/Eat7dE0VNMk+WMbmBttAc2UJ2b3wXlqC4HHe+lTU9kA4iI
   0M+CyRxCGGpw698EjQRV8us4kglbxjEOICrkn5PCkNl/P2m0JxgI8G50U
   A==;
X-CSE-ConnectionGUID: vN1OkWhEQ/C8FhoC9L3Y3Q==
X-CSE-MsgGUID: BuUypf6bQ9qLSjYTtYaXXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56079838"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="56079838"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 08:08:37 -0700
X-CSE-ConnectionGUID: DllWJNIeRI63WFtRgOKtow==
X-CSE-MsgGUID: h5LE7lPiRDaTG4t3oXaJ1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="200184582"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa001.jf.intel.com with ESMTP; 30 Jul 2025 08:08:36 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-net v1] ixgbe: fix ixgbe_orom_civd_info struct layout
Date: Wed, 30 Jul 2025 16:52:09 +0200
Message-Id: <20250730145209.1670909-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current layout of struct ixgbe_orom_civd_info causes incorrect data
storage due to compiler-inserted padding. This results in issues when
writing OROM data into the structure.

Add the __packed attribute to ensure the structure layout matches the
expected binary format without padding.

Fixes: 70db0788a262 ("ixgbe: read the OROM version information")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
index 09df67f03cf4..38a41d81de0f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -1150,7 +1150,7 @@ struct ixgbe_orom_civd_info {
 	__le32 combo_ver;	/* Combo Image Version number */
 	u8 combo_name_len;	/* Length of the unicode combo image version string, max of 32 */
 	__le16 combo_name[32];	/* Unicode string representing the Combo Image version */
-};
+} __packed;
 
 /* Function specific capabilities */
 struct ixgbe_hw_func_caps {
-- 
2.31.1


