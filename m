Return-Path: <netdev+bounces-241117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AE65DC7F6D0
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 09:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2C9073483DF
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 08:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4AB2F2611;
	Mon, 24 Nov 2025 08:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aUzSIz5W"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8BC2F0681;
	Mon, 24 Nov 2025 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763974108; cv=none; b=dTxs9ubpUOAxwd/I27ZH+DcV/VpONAkWjw1AFR9fXS92CMJyIcVsQhX6LS7enaPUfjT7AQhlg1D8STn539xk9wuKmSUVEwWZybLv9S1yAGmQeAOBu2/4vUEDbbZt+/ErUqwnyT054rRRyPalP1WbKpaANTXictzvdpKciJ5fJwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763974108; c=relaxed/simple;
	bh=drmNgq3OAGtr22eH9B0jg8N/Ugx9X2lzloI3SoRn0Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olwQzsP6F2746QtxTcFD6x0XQmdyzb6dp+ZmEQc5rj+zTcaro3PsDbWCQHJ36LR4nDyde4acIzmh6AGFkR/4otz5hBD1J+1ab3EZSnRfzJAwyyrqaOCK011psOUmML1NYmOxD7PmiYhwxKH83QmDO7ZEtwHUPBNWCp9mIPeoN7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aUzSIz5W; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763974107; x=1795510107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=drmNgq3OAGtr22eH9B0jg8N/Ugx9X2lzloI3SoRn0Dw=;
  b=aUzSIz5WDuOFRXX/Y1853Dzw0QYa2gf1go38wTXA65AJIs86jV2XjzEh
   jjpDzfWiJ5/vElvE2i/wEIDkVR7nlyJbh/1FYh5YlSCW6D2nkthopzJKR
   Kbmd433luGob9zH1/qWDouUoeM36aF5pGOkkzDpC1lmA3zuSLCWmktZ7M
   wDM5EASiGSn7Pp2LfM3/BG+aQ4MCstA9CjaOiFJFmBcFEx1WdZ3IjkYBi
   IrYc6mKeLtWUyERh69y93T6zOvdMVZvY63XQk+oBpm2e4QJOAycN2kMWx
   filFaXYayYKyz+HO1wMvK4HfIrzo4F3Rm0sd7/avtUmiXaF/XQe1/qp2o
   Q==;
X-CSE-ConnectionGUID: lZsp2iy+RnCgrKwzKRkhSA==
X-CSE-MsgGUID: W0sNFhEhTkmT26KCjIUvfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="65918432"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="65918432"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 00:48:21 -0800
X-CSE-ConnectionGUID: 4LoD1nTcRReLCoF8wOs8dA==
X-CSE-MsgGUID: JfnEDHqbS/K0DBASRKRCUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="196729228"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 24 Nov 2025 00:48:19 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id D007F98; Mon, 24 Nov 2025 09:48:17 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Lemon <jonathan.lemon@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 1/4] ptp: ocp: Refactor signal_show() and fix %ptT misuse
Date: Mon, 24 Nov 2025 09:45:45 +0100
Message-ID: <20251124084816.205035-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251124084816.205035-1-andriy.shevchenko@linux.intel.com>
References: <20251124084816.205035-1-andriy.shevchenko@linux.intel.com>
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

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ptp/ptp_ocp.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 21a8109fae34..49bad0f83779 100644
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


