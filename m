Return-Path: <netdev+bounces-158936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4432A13DAD
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02B547A475C
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 15:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2BA22BACD;
	Thu, 16 Jan 2025 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WWVVrXoY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDBE22B8CD;
	Thu, 16 Jan 2025 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737041485; cv=none; b=TaO+ttRyErw6cC72PERQfh4TkfjQLUzThzBWTHA3Ijqn0fqNO0MBClGyVxE55XsRkaOgkoqdVxAW2WLjkmC1OQczejyb2vTmRzy2S3zat1hb/rbkXtyw096Cdd/KvEgas8PgN5x90Iv+62AeSIPPZ+Bm4+wGjTt6x28k12Z8M5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737041485; c=relaxed/simple;
	bh=Ea+xh9161oQBF/+OHse3A+eTivFVQCzvHeepbIkX46I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t2w1usSbYUeizm/GyoxGnVtcwB9t+goyt3YzqMSdEFORRDzuNye93X8rX+07em79XuOAutPw4FAUV40TuEgZLPCfKfUjltr6/4HBXe00hGI7jcIF7MO1+jPUs80SWyAnsjbRGH46b37qWDETAJU+HKeMaAuNRqCoF9UcCHEqPcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WWVVrXoY; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737041484; x=1768577484;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ea+xh9161oQBF/+OHse3A+eTivFVQCzvHeepbIkX46I=;
  b=WWVVrXoYDnUoYS4Nm04gXFCzc7gkxc+ZJSgbEWGglV99oTGJM0qCrWku
   f2CCkTHn2y9/elGBmAf9FHu1dejRqxA5Xs1BIvu+c9prd3zjamxhj+6/S
   mgEnSUzHTdQW2je1Pub/f09KxI1lgabXpvFULkRfJWiMj3aO3POorMssx
   ZNRBCsO7A8NK9agClNJLDm+vvftihJqzwLg98rm2WnS3v9mNU7VLY7I21
   r7VkjtGUd39B4VBYiTDAOXYhjNbahbhmbm04ipGGe16oPhWYleBrIRhgp
   qLApplhaBjJpdipP30AnFwMVp5HCdfLiqknyug2lijoxyqnUNfTD0fk+M
   Q==;
X-CSE-ConnectionGUID: o6gLkH4NQlKzCK05iRunnA==
X-CSE-MsgGUID: fLPzSS5LShuMfHKCFYfrKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="48021975"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="48021975"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 07:31:23 -0800
X-CSE-ConnectionGUID: cJHxoVTbQiqK56S6YFRaSw==
X-CSE-MsgGUID: /TVkTFyvQ+6RZcBWLHVbjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="105477327"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 16 Jan 2025 07:31:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E358B39C; Thu, 16 Jan 2025 17:31:20 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH net-next v2 1/1] nfc: mrvl: Don't use "proxy" headers
Date: Thu, 16 Jan 2025 17:30:37 +0200
Message-ID: <20250116153119.148097-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

In this case replace of_gpio.h, which is subject to remove by the GPIOLIB
subsystem, with the respective headers that are being used by the driver.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: added tag (Krzysztof), elaborated what's done in the commit message (Jakub)
 drivers/nfc/nfcmrvl/uart.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/uart.c b/drivers/nfc/nfcmrvl/uart.c
index 956ae92f7573..2037cd6d4f4f 100644
--- a/drivers/nfc/nfcmrvl/uart.c
+++ b/drivers/nfc/nfcmrvl/uart.c
@@ -5,11 +5,16 @@
  * Copyright (C) 2015, Marvell International Ltd.
  */
 
-#include <linux/module.h>
 #include <linux/delay.h>
-#include <linux/of_gpio.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/printk.h>
+
 #include <net/nfc/nci.h>
 #include <net/nfc/nci_core.h>
+
 #include "nfcmrvl.h"
 
 static unsigned int hci_muxed;
-- 
2.43.0.rc1.1336.g36b5255a03ac


