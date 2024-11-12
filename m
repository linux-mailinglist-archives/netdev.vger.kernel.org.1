Return-Path: <netdev+bounces-144097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 951A59C5B72
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 16:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22613B601CD
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C65514A4DE;
	Tue, 12 Nov 2024 13:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JVh8oDdi"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B2F7080F;
	Tue, 12 Nov 2024 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731418674; cv=none; b=Bfe7PUrrORD+ySfLwy1nbfQrHguaAWTay8KkHzWeIC8NJ3kLUVqM7WQnJ30o5csYhDh1bh181YSeBTrL39WXqmqa94oufGSF2BEeLlndjp084VdqTQ9dBs0oYFVTImI0juSe223/3AHLRpTp2sP9UaJMFpshIjnEHoFI3C5SFiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731418674; c=relaxed/simple;
	bh=+7ZfKEw35KcQen19rN09ULhsV8Sz9ncTORpvzpsftXs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uM544JzNNajeFPvR6e4zof8FJrnwVI2zOTRjB+FhxAKrGcF8GTCSAL7YsmTjZcZRc0AJpA8QMZm5eAuX7daDm8/L0f9I02SrcKru/LHysQlSo+/WUAG2oO3VHAppUwnSwYXeSNrnCHUxchMfvTDeLYTgSMTWGXGse1VHWNpzmGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JVh8oDdi; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731418673; x=1762954673;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=+7ZfKEw35KcQen19rN09ULhsV8Sz9ncTORpvzpsftXs=;
  b=JVh8oDdi04YX0LP/Y4n6MEilYRao6EZd8T15+cuGKDaE9hQ3FW7VJGrO
   f0z98Oyx9TcvBQijRc9hgHj/VdYtI+bS5VFg0KIpElDCbDqLCn1kYzPrX
   Qpr8w6baXyaMJgO4ipfyf3uFnKmeWhMJWBUfn0GVLouFxA/XJgslRuoHj
   Af/6uKFeVxgMtOGlc/rMZNKnunFp9Anl94/ZHFew1+PVqv+jyamhD4H3n
   FPKmC1Swet23G42OlYhiMeQ+R/rVPPfApNWds+NLlPa4AjWfVNe7LjRwG
   f/D5cIbIuzXFOugRD0gGOCW10hJrPOrD2Am52SS6tANXLa8Lwz7nuUlC+
   Q==;
X-CSE-ConnectionGUID: Z+lqW6AuToqQiDfZr0WV1g==
X-CSE-MsgGUID: 0gjT6aGTSj+1bjTB2OuPgA==
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="34197676"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Nov 2024 06:37:47 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Nov 2024 06:37:26 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 12 Nov 2024 06:37:21 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v3 4/5] net: phy: Makefile: Add makefile support for ptp in Microchip phys
Date: Tue, 12 Nov 2024 19:07:23 +0530
Message-ID: <20241112133724.16057-5-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241112133724.16057-1-divya.koppera@microchip.com>
References: <20241112133724.16057-1-divya.koppera@microchip.com>
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
v1 -> v2 -> v3
- No changes
---
 drivers/net/phy/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 90f886844381..58a4a2953930 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -80,6 +80,7 @@ obj-$(CONFIG_MESON_GXL_PHY)	+= meson-gxl.o
 obj-$(CONFIG_MICREL_KS8995MA)	+= spi_ks8995.o
 obj-$(CONFIG_MICREL_PHY)	+= micrel.o
 obj-$(CONFIG_MICROCHIP_PHY)	+= microchip.o
+obj-$(CONFIG_MICROCHIP_PHYPTP) += microchip_ptp.o
 obj-$(CONFIG_MICROCHIP_T1_PHY)	+= microchip_t1.o
 obj-$(CONFIG_MICROCHIP_T1S_PHY) += microchip_t1s.o
 obj-$(CONFIG_MICROSEMI_PHY)	+= mscc/
-- 
2.17.1


