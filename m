Return-Path: <netdev+bounces-204145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F72AF9327
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 14:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D39BE562FC0
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 12:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1672D8DC8;
	Fri,  4 Jul 2025 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tq+A+qyO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DC92D8DB1
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 12:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751633535; cv=none; b=X+a0UDU735J7SGxA5XkGAIGLfv7fGRUQGUT5xE9d1KFd0jEmw7a63XjgBXObNRgSLb9QF/ZNwOyJ8/fC+DwDTW8ahBFDG5+MYsZ2m0GhR/Y06OHJthPTqj8U7J6KsN99FRHPzBQ4umq0ZW1yicdtSXoNE9AHbZj8eMxy6U7hBVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751633535; c=relaxed/simple;
	bh=UpJO7tHztgaENI7GQIg23EKFxr+O+WGUa8QjAu6KUcw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dMiixYBXiy7IcahsVt33xUlecwO7rsIUQ9ZdsmaPKwu33vMecTdspEr+uzmyX1mwJnUIDijeMHjzoNDPxDtF+RoJ9AraQxAquIHKKuDX525ab2v045ajdKrEJsylr+S44VK+pBuLV1LobDeAnLPF4Zxko5v24Jplwd0zjmJ4zZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tq+A+qyO; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751633534; x=1783169534;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UpJO7tHztgaENI7GQIg23EKFxr+O+WGUa8QjAu6KUcw=;
  b=Tq+A+qyO2+fmZsGqQCUAY80i+Om6a1szIsDk1Iy9KjodoRTbgh/9w5ZS
   8/Y+ntgI4HeIknwTJKZKY+3ypKivroLDZ2+BwG9FunFje3x73KaHlNwL6
   0ViFV8UUXnl+NR6tNQAH7ZeQPd9JzjIRgCkm8j0cQcwja2Su6ig0cEOQa
   MIGoGetrsV3f0qaycOY85F4DJ8ZQfaQXZWz/lL4KA1F5izMYK9pMb6X83
   SoXb2gXPhSXOdHTNvZA0U04U95wMNkCSXmqWHEXDCM/3WdG6nfxExHeH/
   cQ0hD4tsCmJC+cnbtNcejqGpsjKCwrWwMKvBe97ttJxIsYltr5wjfFBzy
   g==;
X-CSE-ConnectionGUID: thcRETOgQgqS6ces+f5UZw==
X-CSE-MsgGUID: nmCUqVj7RLqDQ2zDKnjQbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="64660138"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="64660138"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 05:52:13 -0700
X-CSE-ConnectionGUID: UvMSU6XUScas0Yn5Y0BKvQ==
X-CSE-MsgGUID: ClfXJyNQStOm6u6sB87fig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="154764656"
Received: from amlin-018-252.igk.intel.com ([10.102.18.252])
  by orviesa007.jf.intel.com with ESMTP; 04 Jul 2025 05:52:11 -0700
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	andrew@lunn.ch,
	pmenzel@molgen.mpg.de,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [iwl-next v2] ixgbe: add the 2.5G and 5G speeds in auto-negotiation for E610
Date: Fri,  4 Jul 2025 15:06:24 +0200
Message-ID: <20250704130624.372651-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The auto-negotiation limitation for 2.5G and 5G speeds is no longer true
for X550 successors like E610 adapter. Enable the 2.5G and 5G speeds in
auto-negotiation for E610 at driver load.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
v1 -> v2
  More details in commit message
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 35 +++++++------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index d741164..b202639 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -1953,6 +1953,16 @@ int ixgbe_identify_phy_e610(struct ixgbe_hw *hw)
 	    phy_type_low  & IXGBE_PHY_TYPE_LOW_1G_SGMII    ||
 	    phy_type_high & IXGBE_PHY_TYPE_HIGH_1G_USXGMII)
 		hw->phy.speeds_supported |= IXGBE_LINK_SPEED_1GB_FULL;
+	if (phy_type_low  & IXGBE_PHY_TYPE_LOW_2500BASE_T   ||
+	    phy_type_low  & IXGBE_PHY_TYPE_LOW_2500BASE_X   ||
+	    phy_type_low  & IXGBE_PHY_TYPE_LOW_2500BASE_KX  ||
+	    phy_type_high & IXGBE_PHY_TYPE_HIGH_2500M_SGMII ||
+	    phy_type_high & IXGBE_PHY_TYPE_HIGH_2500M_USXGMII)
+		hw->phy.speeds_supported |= IXGBE_LINK_SPEED_2_5GB_FULL;
+	if (phy_type_low  & IXGBE_PHY_TYPE_LOW_5GBASE_T  ||
+	    phy_type_low  & IXGBE_PHY_TYPE_LOW_5GBASE_KR ||
+	    phy_type_high & IXGBE_PHY_TYPE_HIGH_5G_USXGMII)
+		hw->phy.speeds_supported |= IXGBE_LINK_SPEED_5GB_FULL;
 	if (phy_type_low  & IXGBE_PHY_TYPE_LOW_10GBASE_T       ||
 	    phy_type_low  & IXGBE_PHY_TYPE_LOW_10G_SFI_DA      ||
 	    phy_type_low  & IXGBE_PHY_TYPE_LOW_10GBASE_SR      ||
@@ -1963,31 +1973,10 @@ int ixgbe_identify_phy_e610(struct ixgbe_hw *hw)
 	    phy_type_high & IXGBE_PHY_TYPE_HIGH_10G_USXGMII)
 		hw->phy.speeds_supported |= IXGBE_LINK_SPEED_10GB_FULL;
 
-	/* 2.5 and 5 Gbps link speeds must be excluded from the
-	 * auto-negotiation set used during driver initialization due to
-	 * compatibility issues with certain switches. Those issues do not
-	 * exist in case of E610 2.5G SKU device (0x57b1).
-	 */
-	if (!hw->phy.autoneg_advertised &&
-	    hw->device_id != IXGBE_DEV_ID_E610_2_5G_T)
+	/* Initialize autoneg speeds */
+	if (!hw->phy.autoneg_advertised)
 		hw->phy.autoneg_advertised = hw->phy.speeds_supported;
 
-	if (phy_type_low  & IXGBE_PHY_TYPE_LOW_2500BASE_T   ||
-	    phy_type_low  & IXGBE_PHY_TYPE_LOW_2500BASE_X   ||
-	    phy_type_low  & IXGBE_PHY_TYPE_LOW_2500BASE_KX  ||
-	    phy_type_high & IXGBE_PHY_TYPE_HIGH_2500M_SGMII ||
-	    phy_type_high & IXGBE_PHY_TYPE_HIGH_2500M_USXGMII)
-		hw->phy.speeds_supported |= IXGBE_LINK_SPEED_2_5GB_FULL;
-
-	if (!hw->phy.autoneg_advertised &&
-	    hw->device_id == IXGBE_DEV_ID_E610_2_5G_T)
-		hw->phy.autoneg_advertised = hw->phy.speeds_supported;
-
-	if (phy_type_low  & IXGBE_PHY_TYPE_LOW_5GBASE_T  ||
-	    phy_type_low  & IXGBE_PHY_TYPE_LOW_5GBASE_KR ||
-	    phy_type_high & IXGBE_PHY_TYPE_HIGH_5G_USXGMII)
-		hw->phy.speeds_supported |= IXGBE_LINK_SPEED_5GB_FULL;
-
 	/* Set PHY ID */
 	memcpy(&hw->phy.id, pcaps.phy_id_oui, sizeof(u32));
 
-- 
2.47.1


