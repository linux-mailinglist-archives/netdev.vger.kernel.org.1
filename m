Return-Path: <netdev+bounces-241114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E686CC7F6B5
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 09:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3E734E2257
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 08:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE102EFDB2;
	Mon, 24 Nov 2025 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HPAWQDMD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CF52EF665;
	Mon, 24 Nov 2025 08:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763974104; cv=none; b=gahKkik9rApGwP6iaTcL7zyIRwiwv6TRNZCRAnuh3/74T1u5ExOLXUYWRReeDxMsy/KNEwKnJ76obyGGkPVSSqKSDHnLr9qAY5HCaNSZF55QzhGM4JrEYp5oJIkZ4k8DUGLOOw3hIfbNMR244IbVkZrXj+buc2auBS8EFMawP44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763974104; c=relaxed/simple;
	bh=o3MmZCf8pomvHEJmGGf6fQQ2DxNe6T0aBzettfVtUa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a847OKsEd2VWA+jTH+GiuADdZb32aUosbI5TaFiX9CfC9KarK07fzmqKD31+VkhNzbQRXAPPMWkCHNpd14zX980HiSmYEyRq6+9blnn/Zh0HWUrwEZjSTk6V7o5JYQYyaPos74JvEoXVo7Dxcl8fVZpaTEoznjXbu2ZGblpnX+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HPAWQDMD; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763974102; x=1795510102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o3MmZCf8pomvHEJmGGf6fQQ2DxNe6T0aBzettfVtUa4=;
  b=HPAWQDMD1u5+Il+cqDYkfoFHZRoj9uuSee9PGYEwlvQYOy5nZxQVjgzW
   ZozHqj2x85Yuql6yf2t+i8cZV9VrKyawEBiqAAISLtJJbE0/yso78F+xN
   Oq37vQ0d0jKo89Me3PJ7HCSUq5+tYYIC90bQVHhtY7MtOd9EiCyjS9WGI
   q5yhBcUo//mL+Pnhj3tpff9yOntrNtwgOdePPETmMwtbKmR7WvCHNMA5f
   G5zVzJcIoD2+k8ecGUd8lAirF+8iwVORVid6Ukb2kjdFYHDDPN0W1RZAl
   XpX1RBYoqvcusXs9nSlh6R0X+xDCkbq5zF3BweE9RC84zQgrunZx4tjTk
   Q==;
X-CSE-ConnectionGUID: FwvQVo+DS6qOtM1ReiqXfQ==
X-CSE-MsgGUID: tS/wi7/6SrezSPpMRqZcpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="83583713"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="83583713"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 00:48:21 -0800
X-CSE-ConnectionGUID: FOszCJjtQki2rcWTDOqiPQ==
X-CSE-MsgGUID: sKUZjwG+S0uNS73TtzT7OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="192068187"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 24 Nov 2025 00:48:19 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id D498D99; Mon, 24 Nov 2025 09:48:17 +0100 (CET)
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
Subject: [PATCH net-next v2 2/4] ptp: ocp: Make ptp_ocp_unregister_ext() NULL-aware
Date: Mon, 24 Nov 2025 09:45:46 +0100
Message-ID: <20251124084816.205035-3-andriy.shevchenko@linux.intel.com>
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

It's a common practice to make resource release functions be NULL-aware.
Make ptp_ocp_unregister_ext() NULL-aware.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ptp/ptp_ocp.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 49bad0f83779..1fd2243e0f9f 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -2225,6 +2225,9 @@ ptp_ocp_ts_enable(void *priv, u32 req, bool enable)
 static void
 ptp_ocp_unregister_ext(struct ptp_ocp_ext_src *ext)
 {
+	if (!ext)
+		return;
+
 	ext->info->enable(ext, ~0, false);
 	pci_free_irq(ext->bp->pdev, ext->irq_vec, ext);
 	kfree(ext);
@@ -4555,21 +4558,14 @@ ptp_ocp_detach(struct ptp_ocp *bp)
 	ptp_ocp_detach_sysfs(bp);
 	ptp_ocp_attr_group_del(bp);
 	timer_delete_sync(&bp->watchdog);
-	if (bp->ts0)
-		ptp_ocp_unregister_ext(bp->ts0);
-	if (bp->ts1)
-		ptp_ocp_unregister_ext(bp->ts1);
-	if (bp->ts2)
-		ptp_ocp_unregister_ext(bp->ts2);
-	if (bp->ts3)
-		ptp_ocp_unregister_ext(bp->ts3);
-	if (bp->ts4)
-		ptp_ocp_unregister_ext(bp->ts4);
-	if (bp->pps)
-		ptp_ocp_unregister_ext(bp->pps);
+	ptp_ocp_unregister_ext(bp->ts0);
+	ptp_ocp_unregister_ext(bp->ts1);
+	ptp_ocp_unregister_ext(bp->ts2);
+	ptp_ocp_unregister_ext(bp->ts3);
+	ptp_ocp_unregister_ext(bp->ts4);
+	ptp_ocp_unregister_ext(bp->pps);
 	for (i = 0; i < 4; i++)
-		if (bp->signal_out[i])
-			ptp_ocp_unregister_ext(bp->signal_out[i]);
+		ptp_ocp_unregister_ext(bp->signal_out[i]);
 	for (i = 0; i < __PORT_COUNT; i++)
 		if (bp->port[i].line != -1)
 			serial8250_unregister_port(bp->port[i].line);
-- 
2.50.1


