Return-Path: <netdev+bounces-237703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1C7C4F218
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 17:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE7AF1888E96
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 16:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F64393DD6;
	Tue, 11 Nov 2025 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FOQL980j"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0D9377E93;
	Tue, 11 Nov 2025 16:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762879961; cv=none; b=U4GshyT7rSiLKD94Z4Zll5AbGOlGSBex/WETeXch8GuPtRk1udw6EORqd5r7ItPyWxlRbIOjBilFCG9jAV1JrwfmPQIhrU+N2qVh3OT6y3fq9Dv2E8V4GAYRpjhSlsMdbxVS/2x9aoXLXYPiyEcI/OY4A+pGzaVOjm0M8AAjTnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762879961; c=relaxed/simple;
	bh=n21JxC+PX1CB9sFEWjSyHhZRgvxqQIKCXsnZMj5jQ5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OF2AKoFNwpKE2BYp17WwhsPS2q+3y5S1zgxkS0jhbOF3iWl6235p2zIheariuTYYp2ZSgwYb2ub5RMdsDNqjxRWz/KSjyum5jsaKd+EGQN/4BmYaEEeRtxhBLRljxrli8f/4XNSIExXSXPeuqhBqt8GaKryq3miicEeBeXlSaRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FOQL980j; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762879959; x=1794415959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n21JxC+PX1CB9sFEWjSyHhZRgvxqQIKCXsnZMj5jQ5g=;
  b=FOQL980jxHXZaJPip1GmIOxeES7wRDcp5j8+9taYosGv75ptz+G6zrMA
   h/vpylrx/6dnLdef3BUmHjk6mijWIWwytvetTefpxllEiIT6QpD1u5ZZF
   V06TsH4V/Q8CUr3ciLu8FaicRFS5ZoCgbHRUGox6NbJMXC9J8Nxe/tOD6
   1NYj+VE9llL+lc7wZhy0cEN0O3ieAKQlylEbOZN8nWthPn78G+Rru6UPa
   Phgncz2SLbNW0VQO+686NxmtDMtFd7m29394Ojv71gGAuhQTUrUf00tqi
   1SGvNwXG0py416haOVFiNiGFl+kOUbjXTeCaoEit9XQJ79EkCumU5kfg9
   Q==;
X-CSE-ConnectionGUID: mtGWuR4jRUSN2rFrL5tGXw==
X-CSE-MsgGUID: yuH18ebBRJGJX+/6bcrzbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="64647258"
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="64647258"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 08:52:36 -0800
X-CSE-ConnectionGUID: Bv1dFJReTe6BgsPFmYhpbw==
X-CSE-MsgGUID: H6esjo8CRDKTya+62MwoYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="194202544"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 11 Nov 2025 08:52:34 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6C5B097; Tue, 11 Nov 2025 17:52:33 +0100 (CET)
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
Subject: [PATCH net-next v1 1/7] ptp: ocp: Refactor signal_show() and fix %ptT misuse
Date: Tue, 11 Nov 2025 17:52:08 +0100
Message-ID: <20251111165232.1198222-2-andriy.shevchenko@linux.intel.com>
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

Refactor signal_show() to avoid sequential calls to sysfs_emit*()
and use the same pattern to get the index of a signal as it's done
in signal_store().

While at it, fix wrong use of %ptT against struct timespec64.
It's kinda lucky that it worked just because the first member
there 64-bit and it's of time64_t type. Now with %ptS it may
be used correctly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ptp/ptp_ocp.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index eeebe4d149f7..95889f85ffb2 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -3250,20 +3250,16 @@ signal_show(struct device *dev, struct device_attribute *attr, char *buf)
 	struct dev_ext_attribute *ea = to_ext_attr(attr);
 	struct ptp_ocp *bp = dev_get_drvdata(dev);
 	struct ptp_ocp_signal *signal;
+	int gen = (uintptr_t)ea->var;
 	struct timespec64 ts;
-	ssize_t count;
-	int i;
 
-	i = (uintptr_t)ea->var;
-	signal = &bp->signal[i];
-
-	count = sysfs_emit(buf, "%llu %d %llu %d", signal->period,
-			   signal->duty, signal->phase, signal->polarity);
+	signal = &bp->signal[gen];
 
 	ts = ktime_to_timespec64(signal->start);
-	count += sysfs_emit_at(buf, count, " %ptT TAI\n", &ts);
 
-	return count;
+	return sysfs_emit(buf, "%llu %d %llu %d %ptT TAI\n",
+			  signal->period, signal->duty, signal->phase, signal->polarity,
+			  &ts.tv_sec);
 }
 static EXT_ATTR_RW(signal, signal, 0);
 static EXT_ATTR_RW(signal, signal, 1);
-- 
2.50.1


