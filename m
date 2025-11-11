Return-Path: <netdev+bounces-237701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2968C4F209
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 17:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA6018891DC
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 16:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C46E3730E8;
	Tue, 11 Nov 2025 16:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ixoxb+Mr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19ED1D6195;
	Tue, 11 Nov 2025 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762879959; cv=none; b=Iu7aZbTO66vmvXj2ZdD5dbN/LViugzKR4SzDf+VNllkQcl61VAui746ooYMSnr6YIWU7hNM72I+ZSkt/URelm7p4369xCCgEnQxUgq+n8kynwMdk7Lnt+v5l56LNe/aI2I1D8ZQAvY7hT+INN6kt+rwF2WqotupZLvodo7J5zjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762879959; c=relaxed/simple;
	bh=gMn0a0EVTO2keC8r5bAdD/NVSv2VYQzw6KrPmUQjum4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNY073ox8xCOaHxObjJp0u7CJPmHH5jXsOiWLoAcCdhSOsAybBViHZvN+IyUVo8FCGZ8yDY9u3wxJkr/2tW90FLpiswASnWSTbzkAwn2OroTo2hRzmp39eBvmiqhUHpR6uTNraOSLXdPGuRmI28Dk6AqHV1lUTP9s8AquOZk3oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ixoxb+Mr; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762879957; x=1794415957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gMn0a0EVTO2keC8r5bAdD/NVSv2VYQzw6KrPmUQjum4=;
  b=Ixoxb+MriwVmvtz/tiEFCSfQZAGiNLKR9t+55YhZLjjZS0dppcTQBfTP
   dLR6ktUl9j+sg7q8QlifD/YSfl1GGt90k75CuVhZGUFVUFEjQvNOSMgD+
   1X02iSn66cn7yfkc2o/Ydeb04ry6pmkvbVTo36OG0qQ9gfdBrFyGIevNh
   nv6aKuQj+R8QrtYJ1rdLTEAndAI6os4yKkW6LAgUCkRsdvKlaz2omt3+N
   wEU8tDZrYxlOkEFo1czOMOcqppZAU9hDMc1GaoRWTnHVeJfUEjyEw75dg
   mIkwgeJAc7hL/W/tw/FIASmMPTfVRI8E9nS+ddaj/1IGe1MWgmTHRQ1Ro
   A==;
X-CSE-ConnectionGUID: t+9RrdfdTzyckgfNlPSxvg==
X-CSE-MsgGUID: tSDiH/VqTxOQNl5AtDCdEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="64647249"
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="64647249"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 08:52:36 -0800
X-CSE-ConnectionGUID: fQR50bBYQCGE2TBwk18Taw==
X-CSE-MsgGUID: euX1PPzyRB+tdkNDo0/iig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="194202543"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 11 Nov 2025 08:52:34 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 79B859A; Tue, 11 Nov 2025 17:52:33 +0100 (CET)
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
Subject: [PATCH net-next v1 4/7] ptp: ocp: Apply standard pattern for cleaning up loop
Date: Tue, 11 Nov 2025 17:52:11 +0100
Message-ID: <20251111165232.1198222-5-andriy.shevchenko@linux.intel.com>
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

The while (i--) is a standard pattern for the cleaning up loops.
Apply this pattern where it makes sense in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ptp/ptp_ocp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 1dbbca4197bc..67a4c60cbbcd 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -4821,8 +4821,7 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	return 0;
 out_dpll:
-	while (i) {
-		--i;
+	while (i--) {
 		dpll_pin_unregister(bp->dpll, bp->sma[i].dpll_pin, &dpll_pins_ops, &bp->sma[i]);
 		dpll_pin_put(bp->sma[i].dpll_pin);
 	}
-- 
2.50.1


