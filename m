Return-Path: <netdev+bounces-187331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BDFAA668C
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 00:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 027661BC6FE3
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 22:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1510270EAC;
	Thu,  1 May 2025 22:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mfHbYT6N"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B04E26C3B5
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 22:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140083; cv=none; b=U4FTLEmV5Ey3jMQ+XoF1/a+Z5A2yWuv8qH+Sd668LT2K911Mfcaf7kkRXROcF0kRFZ/YA7iTgb+RdjEPm7J/bLHaiX5z2fQzqyOf2moQltH6nPjDjzMg7vexn7OVjTQe7tH1ygRnMJ/eXM3y6Ml8L+F4buPJQMB+OvXXyAqVyrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140083; c=relaxed/simple;
	bh=jSo8j64JGGR/skDT2WVH5xA6fBUSYY6TUgU39Fs67CQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m0sriqZVS7unVPXQt3YXC7W+ZFbh96/bZy033Lsg7pnDMPDyFZCroO9bacf5Sq1Apr9DqPPISKEMdhqyKaUkYtqivL+/uOGqybiz01GfDIkCEw5bLzCgNy0wuCPJflr9UF4/P2PUENvMp0VEh1VDGvtOm/VkMq8TRzSZdy8iXBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mfHbYT6N; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746140083; x=1777676083;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=jSo8j64JGGR/skDT2WVH5xA6fBUSYY6TUgU39Fs67CQ=;
  b=mfHbYT6No4pCN1d1bDW0HCPVZF2pvOh589UCOEmYUhQzxz2TSWQ0uA4H
   i3M8F/DU4qncTY/jGbbGpjWv3obt0nRPC7o0sBru4yD9sCtJs2+By9c0v
   ZbCb/vWms7YDuqyO6JXcvRGzoGyi83PbWwxUSrc8mpCZbXbITfhqArnkk
   xniRrrq9/FGf+iLGv/MGx8XMSqvn8XFXhDjNZ85f4kGI3beHXyjKY9z9g
   PK7p1uJkxuSJqN92MUC6NzUO6aH4/owIiKbDM6VVVfKy8CfBUjhzarkgi
   wq3PYhEN8WsFWEjFwBqy1fAAKMO3AAB3Lq7LEggtUsn3pXl3wOUz5lJhy
   w==;
X-CSE-ConnectionGUID: DswDOUX7QaqAFLknkeocZQ==
X-CSE-MsgGUID: L+a9G84sSz6kRUzpeiWs/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="58811751"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="58811751"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 15:54:38 -0700
X-CSE-ConnectionGUID: 9ZA1gwNhSjqM4+lXOqDBIg==
X-CSE-MsgGUID: lWWjBaa1SLKZHoRhXiLe6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="138514316"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 15:54:36 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 01 May 2025 15:54:24 -0700
Subject: [PATCH v4 13/15] ice: fall back to TCXO on TSPLL lock fail
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250501-kk-tspll-improvements-alignment-v4-13-24c83d0ce7a8@intel.com>
References: <20250501-kk-tspll-improvements-alignment-v4-0-24c83d0ce7a8@intel.com>
In-Reply-To: <20250501-kk-tspll-improvements-alignment-v4-0-24c83d0ce7a8@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Karol Kolacinski <karol.kolacinski@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Milena Olech <milena.olech@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>
X-Mailer: b4 0.14.2

From: Karol Kolacinski <karol.kolacinski@intel.com>

TSPLL can fail when trying to lock to TIME_REF as a clock source, e.g.
when the external clock source is not stable or connected to the board.
To continue operation after failure, try to lock again to internal TCXO
and inform user about this.

Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tspll.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index a392b39920aeb7c23008a03baf3df9cd14dcbb7e..7b61e1afe8b43a24c77edf0a0590562fbfa0ce3e 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -497,5 +497,17 @@ int ice_tspll_init(struct ice_hw *hw)
 	/* Configure the TSPLL using the parameters from the function
 	 * capabilities.
 	 */
-	return ice_tspll_cfg(hw, tspll_freq, clk_src);
+	err = ice_tspll_cfg(hw, tspll_freq, clk_src);
+	if (err) {
+		dev_warn(ice_hw_to_dev(hw), "Failed to lock TSPLL to predefined frequency. Retrying with fallback frequency.\n");
+
+		/* Try to lock to internal TCXO as a fallback. */
+		tspll_freq = ice_tspll_default_freq(hw->mac_type);
+		clk_src = ICE_CLK_SRC_TCXO;
+		err = ice_tspll_cfg(hw, tspll_freq, clk_src);
+		if (err)
+			dev_warn(ice_hw_to_dev(hw), "Failed to lock TSPLL to fallback frequency.\n");
+	}
+
+	return err;
 }

-- 
2.48.1.397.gec9d649cc640


