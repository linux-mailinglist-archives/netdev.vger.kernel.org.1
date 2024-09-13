Return-Path: <netdev+bounces-128102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8CC97807A
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 14:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 106C0B24066
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 12:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6030E1DA2F5;
	Fri, 13 Sep 2024 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QIk15wl6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40001D9354;
	Fri, 13 Sep 2024 12:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726231923; cv=none; b=Wo5nGOSQ1AOYx8Pn2c+nM4FWdzcs2Py4i3kJqH3BFQ1R90ME3SREJlpTle6uakPQKnUQTb7L5zO98sRkjwAehIKhW+tZx3f159/G4K11lzpbfhJAO/Qoy37sY6+WqOzZICmjj0B+tzEEzrME5yXcZw1sroa4qAWHWNqQO3qmyeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726231923; c=relaxed/simple;
	bh=opKtSYOP11iB37GmEu3c5JYfOAW+vJkmvop3fOEpU4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T1qse8VSHmS7TFuwg/RRdn64jiC8wvudvgbBRmiyJbWwPD81SZChPwY2nSb3imNohZeMzXUF6UCc8Yei6pG8ICylcEFUm4cyvKQ7+ng7HlLx8RVx7xUJaGkZ2Ok3DcXF3NDOAItof3ukbf7vNW5w5TpULUzmCbL7R7lXUNL6IEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QIk15wl6; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726231922; x=1757767922;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=opKtSYOP11iB37GmEu3c5JYfOAW+vJkmvop3fOEpU4Y=;
  b=QIk15wl6NsAdKQ8NUQQIeIS9THTOFHGXFZoN/x55Bal4mMmn76NnmwK/
   jRMB1kc+q3bq+fixuphqMGkxpkJWKfWRTY93HwQ6f3IucGlzsvpMYzK1X
   91Mekn8Oi6X1bvYi0bLhL7x6bmL41d2NgxpEIs0Ew4oU9UipGdEhlQjGL
   rqrhTYGzbqWsLtDuZEj8zHyE6/BgCgq87ulaKwwFImjSqN7Q4g/BMc9mq
   nh4UTcMNiLOMVR74nLn8abrcdo0GfGwmllszhfxCme03+xLc2lZj/9qVu
   r0+9L56dd7lwm+vWpNJ8pFP5csI7RCdfCkP9vAx1SKdOljD63JWqeQVyE
   w==;
X-CSE-ConnectionGUID: H27jBa4UQLeEh0msOI3mlA==
X-CSE-MsgGUID: k7iKpS4RTOmmb8YEIuNTRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="25255808"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="25255808"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 05:52:01 -0700
X-CSE-ConnectionGUID: /EETgf/bTzGHgZbt5Z1yjQ==
X-CSE-MsgGUID: O63I8223TAick/taRh/2wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="68365341"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 13 Sep 2024 05:51:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0A897334; Fri, 13 Sep 2024 15:51:56 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH net-next v1 1/1] net: macb: Use predefined PCI vendor ID constant
Date: Fri, 13 Sep 2024 15:51:46 +0300
Message-ID: <20240913125146.3628751-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCI vendor ID for Cadence is defined in pci_ids.h. Use it.
While at it, move to PCI_VDEVICE() macro and usual pattern for
PCI device ID.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/ethernet/cadence/macb_pci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_pci.c b/drivers/net/ethernet/cadence/macb_pci.c
index f66d22de5168..fc4f5aee6ab3 100644
--- a/drivers/net/ethernet/cadence/macb_pci.c
+++ b/drivers/net/ethernet/cadence/macb_pci.c
@@ -19,8 +19,7 @@
 #define PCI_DRIVER_NAME "macb_pci"
 #define PLAT_DRIVER_NAME "macb"
 
-#define CDNS_VENDOR_ID 0x17cd
-#define CDNS_DEVICE_ID 0xe007
+#define PCI_DEVICE_ID_CDNS_MACB 0xe007
 
 #define GEM_PCLK_RATE 50000000
 #define GEM_HCLK_RATE 50000000
@@ -117,7 +116,7 @@ static void macb_remove(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id dev_id_table[] = {
-	{ PCI_DEVICE(CDNS_VENDOR_ID, CDNS_DEVICE_ID), },
+	{ PCI_VDEVICE(CDNS, PCI_DEVICE_ID_CDNS_MACB) },
 	{ 0, }
 };
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


