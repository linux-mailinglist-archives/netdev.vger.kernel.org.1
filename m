Return-Path: <netdev+bounces-177019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C82A6D445
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 07:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2126F1681D4
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 06:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A7318DB20;
	Mon, 24 Mar 2025 06:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kz1c6gg+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2BA33981;
	Mon, 24 Mar 2025 06:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742797679; cv=none; b=qM/wd0/iTmYVlly1zHM623l8W/7QQuZ7y1tJynDhxQkFvoICiQDjDk80ZhpXrYacn5CY8K77vEIkCNJYWTcm6hm+/R2XRWFR5APX5z4cZdzZ7/7e37DlUShrcllyAFtJTkhnP55U30RpKfnPiX+GxhhsFxazCmTplKEuAU/x2Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742797679; c=relaxed/simple;
	bh=eITHe9O29qurQr+w4lnf9ce6r8QgdKu3VSz+sAB0QJc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G7kJ0Ky0orW5+PwkGxMp0VsoF9LbBgzMuyw6l/ZlXsixaEJEUnmlXJUp+APdpcSj4AMawpvOxmXIK7a+7XyqTcwd0KhvztruWxcuazJUgoIancuyxrwZmiYNdpALGNE5vcourfR6Z5pe8LT2D6NyhbnoQmv/4EZNyz4z/fffMDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kz1c6gg+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742797677; x=1774333677;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eITHe9O29qurQr+w4lnf9ce6r8QgdKu3VSz+sAB0QJc=;
  b=Kz1c6gg+Ias6OFknNF5dyEMfUNnD3OsOmHWhm0ZpymJk8xrV1UTYyD1J
   Kd2vlnW1hff7ekdCF1jVu6VNYXKL6DrkbJ/SCRiCRBTyCltZGvGBcz4BR
   rj0ZBqo/WvG4KMoDbbZlGHpOSgay6enaiUzdpWaYa+55GjfdGJa44eJ9d
   oeh8fw6A6luUz+Y7Go7EJpD9X6jtOHqfA6SYwKGwAWRlRoU+kr7t5tyIw
   tiX8T7Y5Ggxem0GvZhBCEbMJIQa1TBBKluV3PeACyORHCrzk3up374RJ9
   HdaJ1rz1uUr7VWGNl9RVXaIvFpFqZurnormgU3LhPHCn2TeXedpKBa2ao
   w==;
X-CSE-ConnectionGUID: tryT+XEiTIqul8/xoTrLVw==
X-CSE-MsgGUID: 8ifJC+9wTNujKU9dtpjuPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="47638762"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="47638762"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2025 23:27:56 -0700
X-CSE-ConnectionGUID: B48+T+GRQwqiLpAT4hNPdA==
X-CSE-MsgGUID: BDisJXbXTsSeVaZTCIRHpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="124901989"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.227.39])
  by orviesa008.jf.intel.com with ESMTP; 23 Mar 2025 23:27:54 -0700
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v1 1/1] stmmac: intel: interface switching support for RPL-P platform
Date: Mon, 24 Mar 2025 14:27:42 +0800
Message-Id: <20250324062742.462771-1-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on the patch series [1], the enablement of interface switching for
RPL-P will use the same handling as ADL-N.

Link: https://patchwork.kernel.org/project/netdevbpf/cover/20250227121522.1802832-1-yong.liang.choong@linux.intel.com/ [1]

Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 5910571a954f..c8bb9265bbb4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -1437,7 +1437,7 @@ static const struct pci_device_id intel_eth_pci_id_table[] = {
 	{ PCI_DEVICE_DATA(INTEL, ADLS_SGMII1G_0, &adls_sgmii1g_phy0_info) },
 	{ PCI_DEVICE_DATA(INTEL, ADLS_SGMII1G_1, &adls_sgmii1g_phy1_info) },
 	{ PCI_DEVICE_DATA(INTEL, ADLN_SGMII1G, &adln_sgmii1g_phy0_info) },
-	{ PCI_DEVICE_DATA(INTEL, RPLP_SGMII1G, &tgl_sgmii1g_phy0_info) },
+	{ PCI_DEVICE_DATA(INTEL, RPLP_SGMII1G, &adln_sgmii1g_phy0_info) },
 	{}
 };
 MODULE_DEVICE_TABLE(pci, intel_eth_pci_id_table);
-- 
2.34.1


