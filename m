Return-Path: <netdev+bounces-96390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D03A18C593C
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 18:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B9461C21F51
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 16:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60FA17EBB5;
	Tue, 14 May 2024 16:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="chVAlGxR"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014781292D2;
	Tue, 14 May 2024 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715702637; cv=none; b=p1/hDP7+8UIKy4WZvIfoH8aqxY8fryzLsA9Ru18lTOfPiAvN7Y2POrisGAjMD7SwVvKGFSryrGJjYRrc0eMrVayEP8KMWmDTVz8pumrghuG4P9W/vA8Q5tHI2zwhRqQ48aFHBvyhhZeuLq0OjhvzR7sGH8zemE3uzI1eFXYJH0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715702637; c=relaxed/simple;
	bh=DIj9Bf8iNALKtoElpdqCERvL/swGwTHjMYy3HwDYoUk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/aLSi3+somshRH/DQ1ryCBHMd6cgixoTt0/anzv9EkMrd3qcnvM7huawTNCMdRGqvWrrSHK8C+tVCb+WV49m1Bwm5B3QkZwy7cC8WW08kMIMOzIMzVByWFCBh9q+poJIJVp37LvinGlcIBln/YFuB77E2NvqXPmNYF4yR4+81U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=chVAlGxR; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715702636; x=1747238636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DIj9Bf8iNALKtoElpdqCERvL/swGwTHjMYy3HwDYoUk=;
  b=chVAlGxRosrMVYJSht5rDAunz3qDJ36BZXDXWk5XSnedmM+AoYO9UkMT
   Uyzda7bGkR7gUR4+7J37bWceJZO8CSU9FYHqB4Zzay81VVUNu2q1UYNSK
   mBFQNk5dFf34vMNzU1dliy1nPv30FhwpWIpJvFjVr3lY1RZUyxDtxDE35
   RK4ANSZopIvQ+Cmlc+ubibsPE0In+C1NzXhNDvGFSRAx5AuCqr9jLNYiu
   cG45fV1a+RxZXh4Te8TAGCC/cr0l2on9x52IIUglYNVb9rFh0g1gzn0fD
   Q5mW01kZA3IF0DdwzIrARkUAptbnOxe+TBxqIoKTm6wqR5dIexxb9WiDJ
   g==;
X-CSE-ConnectionGUID: fa/uIrenSP6Bi4ynGM2+AQ==
X-CSE-MsgGUID: HCpUCcM4TuywJfN4mJzLkg==
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="192034024"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 May 2024 09:03:48 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 09:03:30 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 09:03:26 -0700
From: Rengarajan S <rengarajan.s@microchip.com>
To: <woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <rengarajan.s@microchip.com>
Subject: [PATCH net-next v2 1/2] lan78xx: Enable 125 MHz CLK configuration for LAN7801 if NO EEPROM is detected
Date: Tue, 14 May 2024 21:32:00 +0530
Message-ID: <20240514160201.1651627-2-rengarajan.s@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240514160201.1651627-1-rengarajan.s@microchip.com>
References: <20240514160201.1651627-1-rengarajan.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The 125MHz and 25MHz clock configurations are enabled in the initialization
regardless of EEPROM (125MHz is needed for RGMII 1000Mbps operation). After
a lite reset (lan78xx_reset), these contents go back to defaults(all 0, so
no 125MHz or 25MHz clock).

Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>
---
 drivers/net/usb/lan78xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index ba6c8ac2a736..7ac540cc3686 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2944,6 +2944,8 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 		return ret;
 
 	buf |= HW_CFG_MEF_;
+	buf |= HW_CFG_CLK125_EN_;
+	buf |= HW_CFG_REFCLK25_EN_;
 
 	ret = lan78xx_write_reg(dev, HW_CFG, buf);
 	if (ret < 0)
-- 
2.25.1


