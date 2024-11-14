Return-Path: <netdev+bounces-144865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 103989C8975
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 13:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67709B230B3
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804581FA26D;
	Thu, 14 Nov 2024 12:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sBLVXzEp"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51421F9EBF;
	Thu, 14 Nov 2024 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731585855; cv=none; b=EklxOeeaoJD7IU5H11D29c90U4y3WaT/8ZtSWnfU4AMSXiRlMqIX/PYVs/Q+t8Is8poj54MRgbrD8DvncySJb4Ji0PWVNF8TcbtdYuCVvmMPzCVtWQnjp2UVqLLIWJkjSpU9KtU9kFL2zJ1gNY1DZNMEIiZvNTDEAK30USXtIaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731585855; c=relaxed/simple;
	bh=L2xMvjFhSzNlCCFLJQnhYx9gZKRLuyLxM+8JcAKs/Mo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSOUcTA/sbngnyp+j/x99P+/mU4WAtG60fk5IwiWJm98vm83bP6JXKy/mHUGwWghHIJ9COX8Bk/bprAyccioOxjM9kco0+MtMCAyAc0LckLXp9kCnBw/6lR+4jtj7qJvP8W0le//WoxWRUK/ZNtz3NFjLJvSEMF5owAG8YvGTIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sBLVXzEp; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731585854; x=1763121854;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=L2xMvjFhSzNlCCFLJQnhYx9gZKRLuyLxM+8JcAKs/Mo=;
  b=sBLVXzEpqEwHsIUPaqBQgci/8Lb94CApFURYmAQxTDFt6r/u8DznGUU7
   1Z5RhoG0WS9EV3tYx+lSsSxojjFK/rZkPhXS/e2cGzHog+Xh9NMACphjX
   izeMyCbPgRn/V3CegHvobwMPe/zcYnH74f5dkx5vcouZpKeUUVedpqLB/
   iAS3C+aC01m2F0a9xf5vN1kmm+Mw5dO0ZBzZT46DCc8aRdkR+TAIY7hiS
   osyRkAruO3uFO039/u4de5w4W2gkYeumHgj+13Iw2Fg6SV9K7yu5EhdYG
   WHaXQZodrO/hfggB3RqrvG5SxRu89N/YNLyu8eP9Stdpz/FQo16HU+a+D
   Q==;
X-CSE-ConnectionGUID: R1m+lyWhTgaRIjoFVkjDnA==
X-CSE-MsgGUID: HT99vUEHQ8uwuklIqa+PtA==
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="34821617"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2024 05:04:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Nov 2024 05:03:56 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 14 Nov 2024 05:03:50 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v4 4/5] net: phy: Makefile: Add makefile support for ptp in Microchip phys
Date: Thu, 14 Nov 2024 17:34:54 +0530
Message-ID: <20241114120455.5413-5-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241114120455.5413-1-divya.koppera@microchip.com>
References: <20241114120455.5413-1-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Add makefile support for ptp library.

Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
---
v1 -> v2 -> v3 -> v4
- No changes
---
 drivers/net/phy/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index e6145153e837..0a19308dcd40 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -79,6 +79,7 @@ obj-$(CONFIG_MESON_GXL_PHY)	+= meson-gxl.o
 obj-$(CONFIG_MICREL_KS8995MA)	+= spi_ks8995.o
 obj-$(CONFIG_MICREL_PHY)	+= micrel.o
 obj-$(CONFIG_MICROCHIP_PHY)	+= microchip.o
+obj-$(CONFIG_MICROCHIP_PHYPTP) += microchip_ptp.o
 obj-$(CONFIG_MICROCHIP_T1_PHY)	+= microchip_t1.o
 obj-$(CONFIG_MICROCHIP_T1S_PHY) += microchip_t1s.o
 obj-$(CONFIG_MICROSEMI_PHY)	+= mscc/
-- 
2.17.1


