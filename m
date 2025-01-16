Return-Path: <netdev+bounces-158933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0691DA13D9C
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66556188C63A
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 15:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3228022AE55;
	Thu, 16 Jan 2025 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AKzDLKy1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AF113AA35;
	Thu, 16 Jan 2025 15:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737041269; cv=none; b=FK9mvTQCmrfTGlDpEy4vPQZrTxABzCgJXkZWqMB+E30/Ip8rD+RaXGfoT4iu1NY8GnVm1jjqsLy/OCIcakBtE0YKVfZkR8/ZUoX4GC+F8AM23fPOg7qTW661WB5C7QI8BAnvFCj3inewSC+wMUr/raprqMTXjUZk9HdtrNaZdfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737041269; c=relaxed/simple;
	bh=myBHpucL5mlkU/eDPoSKRGsRNHNBsxAcFzoiWMSpXf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WthxFmFjI1YRvHk9OxdseweTYtKP1IqdAtcOI7VND4wP+Az7MVptnpl1ZR3KAGJF1RZHHYr4T4bk9hdfkgd4zAmidCYwEo6sVCW6H3V8poGKGlUbnq9VFE7Wh6UuYrtLwHo+CrMCuwogA/a7PhYIrBMqANlZVh8Ao6wjfz+pmQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AKzDLKy1; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737041267; x=1768577267;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=myBHpucL5mlkU/eDPoSKRGsRNHNBsxAcFzoiWMSpXf0=;
  b=AKzDLKy1TuCmb8etJ/AId4ArtlrKaZpYM1OjWxl+rx0rEjP/OhBlFoUj
   Zuuqo/Mz2SPqvzxV2iwwI7JemS2dugn4lrfqLS3u+RROZ3Vrk91PT5Jf3
   B0aitfgBw3Op0Elypc+F0gqSIHDsNiYf3v07RMo8qzY9SXPBGT1W5a9K+
   +MXe2W+FYYumgibACFTitr9blwDCCRXQXrMzvAV55thpNkwOPo3fTtKi5
   MeMLeiQHviXffn03iMZQuIAJ+gsvTcv7suMY1CA3giXKMYzV1pGrijksW
   +b4PAOPLvlZbYxvx+3YwOL8nTs7mU7ruuPcFouq2sCD0RGMRYEASoq+6J
   A==;
X-CSE-ConnectionGUID: S2GynI45SWmZNxIWjQXduQ==
X-CSE-MsgGUID: 5mwhPjJLSxKLQ3DBOuvP+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="48846736"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="48846736"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 07:27:47 -0800
X-CSE-ConnectionGUID: p6kANKICToKUD4tPzJO6qQ==
X-CSE-MsgGUID: yvPEI6rzQCCaixSfwtnx/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="105284630"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 16 Jan 2025 07:27:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BEA5039C; Thu, 16 Jan 2025 17:27:43 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v2 1/1] nfc: st21nfca: Remove unused of_gpio.h
Date: Thu, 16 Jan 2025 17:27:28 +0200
Message-ID: <20250116152742.147739-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_gpio.h is deprecated and subject to remove. The drivers in question
don't use it, simply remove the unused header.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: added tag (Krzysztof)
 drivers/nfc/st21nfca/i2c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nfc/st21nfca/i2c.c b/drivers/nfc/st21nfca/i2c.c
index 02c3d11a19c4..6d7861383806 100644
--- a/drivers/nfc/st21nfca/i2c.c
+++ b/drivers/nfc/st21nfca/i2c.c
@@ -11,7 +11,6 @@
 #include <linux/i2c.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of_irq.h>
-#include <linux/of_gpio.h>
 #include <linux/acpi.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
-- 
2.43.0.rc1.1336.g36b5255a03ac


