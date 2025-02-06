Return-Path: <netdev+bounces-163575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C69ACA2AC50
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 16:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77A31889EDD
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 15:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2C71E5B72;
	Thu,  6 Feb 2025 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fKQL2M4c"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0A01C6FFD
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738855168; cv=none; b=YN3ui2mKu/UdUqAgcT68cASz/0hfBMV8EDrbAn/H0BVAmE/3fskRGb1TAqb4v8r+a/ypMqsI0KVShYo5pxXQoEUGy7xdP7BC9vdyhP8NXLO0Fy3sCab57ag4aQsNAYSNl4jPC/QgNSGuiYwUyHTzoFl51ZwnL55KBc8JteY07Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738855168; c=relaxed/simple;
	bh=goeTczSqW+i3xRmN3VUqgf3U0YfiCV4vdRbYGUjVccI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VZx9yh8dKL+ChYy/gu0KW7M8mdq7OkZFzC40xL7UX1olF1zsmAttpL5vqKCsbhRIl16AXvjGJ3W1HAbJ4Z0HF/1w9GUopy9Um3zQcWRXsys8SvWfsjWyfO93nhvhvFgDctEmdYuIUxwDGNkG8H6FeRQRkgpl02DKIpk71304Vx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fKQL2M4c; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738855164; x=1770391164;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=goeTczSqW+i3xRmN3VUqgf3U0YfiCV4vdRbYGUjVccI=;
  b=fKQL2M4cRw9nKu2A6PQxrUmand5ApORy61Q+oKbxX5c90iFZqQa2h/bh
   qsFp2AcOx29NEAc8AoOh4DPF/hUvaQAofZtsWUqO7+Up5BacPlw0I/MFo
   lCo9+dxj6YvT8SrWrnq7syceVefWgmc8kxIaC09jwYdCwOkJButEd0Qqd
   M/ql1ib9aNVlnZtDsAaS6yPOieC6K4OYXRFfGT8ucr1oZ6hncuEDA5q/6
   fflNoUI4LRsEsDT/qqlp9XN4eUGj8LRHJIV6Uvxp0snGcp867PtexJ3/C
   9g7Pr7ca2b2k3vTOb+nm96D9uey7ZET+1xImydlfpoCvfYwT9lRxWGGiL
   w==;
X-CSE-ConnectionGUID: amn1CZTMTPW7qgFhWvpFIg==
X-CSE-MsgGUID: jghUDM6mSTq3RG5oxx/Gew==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39360273"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="39360273"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 07:19:24 -0800
X-CSE-ConnectionGUID: CSgwnmqzT1aFstRjP3BMIQ==
X-CSE-MsgGUID: 8PziVqBUR0O3DqSf+FGKSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115858259"
Received: from aservou-mobl.ger.corp.intel.com (HELO vbox-pkwap.ger.corp.intel.com) ([10.246.20.218])
  by fmviesa005.fm.intel.com with ESMTP; 06 Feb 2025 07:19:23 -0800
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net] ixgbe: fix media cage present detection for E610 device
Date: Thu,  6 Feb 2025 16:19:20 +0100
Message-ID: <20250206151920.20292-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 23c0e5a16bcc ("ixgbe: Add link management support for E610
device") introduced incorrect checking of media cage presence for E610
device. Fix it.

Fixes: 23c0e5a16bcc ("ixgbe: Add link management support for E610 device")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/e7d73b32-f12a-49d1-8b60-1ef83359ec13@stanley.mountain/
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 683c668..cb07ecd 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -1122,7 +1122,7 @@ static bool ixgbe_is_media_cage_present(struct ixgbe_hw *hw)
 	 * returns error (ENOENT), then no cage present. If no cage present then
 	 * connection type is backplane or BASE-T.
 	 */
-	return ixgbe_aci_get_netlist_node(hw, cmd, NULL, NULL);
+	return !ixgbe_aci_get_netlist_node(hw, cmd, NULL, NULL);
 }
 
 /**
-- 
2.43.0


