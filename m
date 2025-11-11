Return-Path: <netdev+bounces-237704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9C2C4F21B
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 17:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFBE7189D9B9
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 16:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8761A3BD7;
	Tue, 11 Nov 2025 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SPz64imb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2E71AA7BF;
	Tue, 11 Nov 2025 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762879962; cv=none; b=ITM7NcN9AjVE+SJMrrhN4NuiAw/tvngbnAL+2CpMjynuwvSOYf6CxWYX3swCVpCQWSboSzjdPGxJf5WsCXDkz2NY2VIccCx94zIE7FSXiyW0vsn0jiMVIIcIEBUu2ejDRTNpD8PP7W2+s8AgiXJ83XH6Z6JPpiZv/J2XV2quJjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762879962; c=relaxed/simple;
	bh=aazcxWLrKHyY7rbPLqqqaWDYNKAua34+BWSjNQwtzlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHP7Rf9pohdV5+TXN2Hx+TuT27kOY5cKUmlFfgoJMuVqK5Ql2bRDEVZIOpU0UKSTOrSX5olveG66DpP4I26lhchWNggjqQqEUYip/P7viE84ZQLPLFy/VWJamXj0CEqIuPRL7xn5/6deu6kl8x0ARELmCQh7fKq7d9sQAlqxIwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SPz64imb; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762879960; x=1794415960;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aazcxWLrKHyY7rbPLqqqaWDYNKAua34+BWSjNQwtzlg=;
  b=SPz64imbLAXDYSVxflEXgL4fmWAcKqzEWh2bdUXiz7++YjmQwj3nWv9U
   UwHkMx3LGyhPPd+pL6buEy4Qwcv7n/EXrC0tq1LmVv8E7k8+f//SDH9yp
   83zK6EC+B0K9Ra/Ml2P+LQz+a9oVorKRzvZE0Ysulg05t0aEzfBPU8ps+
   oeQb/JG0AI8IvYlVHQkPp6xRXt208q26/Y3N2Nul66pJJUWifcrRMTMVe
   G5JtBCqNUAOLheKR1oA2exwyz1aw/z0G7D8gME8qfMhWgCdvIvsEmjj0z
   3ZkKJREPUdQapFmK/GEe2llSS43YuKZpexNbtqBrQOUYz1tBGf3yybwR4
   w==;
X-CSE-ConnectionGUID: G7oPcq1lT1anAZzWV4veTA==
X-CSE-MsgGUID: weWh5couRLGQF47JBFIBEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="76049256"
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="76049256"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 08:52:40 -0800
X-CSE-ConnectionGUID: E96FJg6bTqKaqOC8SqhpLg==
X-CSE-MsgGUID: LEr3mtVAQKie8tVgyvTT4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="193112858"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 11 Nov 2025 08:52:38 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 82A229C; Tue, 11 Nov 2025 17:52:33 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Richard Cochran <richardcochran@gmail.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v1 6/7] ptp: ocp: Sort headers alphabetically
Date: Tue, 11 Nov 2025 17:52:13 +0100
Message-ID: <20251111165232.1198222-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251111165232.1198222-1-andriy.shevchenko@linux.intel.com>
References: <20251111165232.1198222-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For better maintenance sort headers alphabetically.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ptp/ptp_ocp.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 4c4b4a40e9d4..984293a2a696 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -2,28 +2,28 @@
 /* Copyright (c) 2020 Facebook */
 
 #include <linux/bits.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/crc16.h>
+#include <linux/debugfs.h>
+#include <linux/dpll.h>
 #include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/debugfs.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/serial_8250.h>
-#include <linux/clkdev.h>
-#include <linux/clk-provider.h>
-#include <linux/platform_device.h>
-#include <linux/platform_data/i2c-xiic.h>
-#include <linux/platform_data/i2c-ocores.h>
-#include <linux/ptp_clock_kernel.h>
-#include <linux/spi/spi.h>
-#include <linux/spi/xilinx_spi.h>
-#include <linux/spi/altera.h>
-#include <net/devlink.h>
-#include <linux/i2c.h>
 #include <linux/mtd/mtd.h>
 #include <linux/nvmem-consumer.h>
-#include <linux/crc16.h>
-#include <linux/dpll.h>
+#include <linux/pci.h>
+#include <linux/platform_data/i2c-ocores.h>
+#include <linux/platform_data/i2c-xiic.h>
+#include <linux/platform_device.h>
+#include <linux/ptp_clock_kernel.h>
+#include <linux/serial_8250.h>
+#include <linux/spi/altera.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/xilinx_spi.h>
+#include <net/devlink.h>
 
 #define PCI_DEVICE_ID_META_TIMECARD		0x0400
 
-- 
2.50.1


