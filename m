Return-Path: <netdev+bounces-169001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8809A41E79
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 13:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD8F443C1E
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 12:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CFB2192F0;
	Mon, 24 Feb 2025 12:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="haxFM71u"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2816204F80;
	Mon, 24 Feb 2025 12:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398444; cv=none; b=ODqO23hXHZUmXJUdDrlssRyXV91bgdYHo2TT+unbF5GM8eL5WYukgpgvQ5nxqswpGoJO6JkSH8ncIpByqaxD1xDoBM8PWFWB9FIPhVjzZceWbBdLyCdkZkn1HtGUMhxOs7m3OjBEl8iJWYWzOKQ3xiEkWefOTw2lOEkfv+cTwVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398444; c=relaxed/simple;
	bh=u28YiekULcOeQfNrsqDVN5Ia2LW7L5zTpSfjG8iptX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SufzyetH5RrTvwwE6NFPrSKgCb3bodQWuCFcwRNg7kFKABzY2tlsqFyGTbBSvPH/Scv1fy49uBq9EdU3DWMgwtVeP/wNQCQag6A7EgjhYrBWdd/4vo7nRNRKgmWuOmXLDERJ6WSTe4cCpqR26AYdviV7mm462PNKO5L4w+2AcB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=haxFM71u; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740398443; x=1771934443;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u28YiekULcOeQfNrsqDVN5Ia2LW7L5zTpSfjG8iptX4=;
  b=haxFM71uI2+WSSQZ7ggTACWWfQ2m8eC2ge1lV2KaEAtgC2ysv3uLwEAj
   MuDCt3Hcb+ZY6lZkvfvDo98JAo3IVhLSnmjNX3rfzGvotKznjo2cMbcP7
   RSeSSP1y7bmgqmku8bLVdmkqFHeUH86C+Ykfv7d5p8Uwo6qkoVBY7cqP2
   rI/GUO4sYQ8S+qMeR0D9qeR3gU15Xcu0oxMiSscJ9Sgwena7L880YjooC
   tbvuPIUw+UhKnjv2Ga6+9iWScbZ7bSDXvrsz3ijOAtUD5CHwmIdrv/4AR
   nMBxgZzDvU9WxUrR2QHhTR1eGB0gGUswfkMunw4mxpBbSUTkh9qr6xU5I
   A==;
X-CSE-ConnectionGUID: BhIKPkf/Rkam2av0tyAarg==
X-CSE-MsgGUID: H39fjSp5Qu+t5Wy6WudJAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="40336769"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="40336769"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 04:00:42 -0800
X-CSE-ConnectionGUID: SBKkhjxOTiadjwYG7gY+Pw==
X-CSE-MsgGUID: F2XdlP0tQzqDz6jc0MWj+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="116667805"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 24 Feb 2025 04:00:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9C59B19E; Mon, 24 Feb 2025 14:00:38 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Iyappan Subramanian <iyappan@os.amperecomputing.com>,
	Keyur Chudgar <keyur@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v1 1/1] drivers: net: xgene: Don't use "proxy" headers
Date: Mon, 24 Feb 2025 14:00:37 +0200
Message-ID: <20250224120037.3801609-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.45.1.3035.g276e886db78b
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

In this case replace *gpio.h, which are subject to remove by the GPIOLIB
subsystem, with the respective headers that are being used by the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.c b/drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.c
index 86607b79c09f..cc3b1631c905 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.c
@@ -6,8 +6,14 @@
  *	    Keyur Chudgar <kchudgar@apm.com>
  */
 
-#include <linux/of_gpio.h>
-#include <linux/gpio.h>
+#include <linux/acpi.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/io.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
 #include "xgene_enet_main.h"
 #include "xgene_enet_hw.h"
 #include "xgene_enet_xgmac.h"
-- 
2.45.1.3035.g276e886db78b


