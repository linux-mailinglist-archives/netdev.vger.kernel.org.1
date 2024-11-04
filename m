Return-Path: <netdev+bounces-141449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D78689BAF23
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 10:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98DFF281B3B
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 09:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E4C1AC456;
	Mon,  4 Nov 2024 09:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="P/NVIbBp"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4567A1AF0D2;
	Mon,  4 Nov 2024 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730711331; cv=none; b=Q0cpfVBl7voD7Ej8gLXmcq9q9B8x1K/1LGiLg+KPqr/B6XeYfQVP2YPwA2SSrcFS6Hzg5L09Ec1LLCAmPO0DlMvMjcXuI0GNeYQjrYKTWv7VPX99YF863mPYSzEnFKpMG8QujGDacoYZEPri3duu0q1Uvh08qb9Bn3xVdMTPues=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730711331; c=relaxed/simple;
	bh=/xIZbDo9LECT05XfH5ney7CuUR4+mf9L8XDS6NREgXI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kMjHfNm65NojCfA/2TahHeCvzetfCNhVG556R8qjdW+7PIjAQ57zrYHCwOCyjj1UgFjGA8FuAAkc2n/nbiN3J3wAwmEpIhmbWQkS7Jr77t24nnSMluosmPIkK8cTUCrmQEg8bVfEvWu0n+YcxFgAEoPFvCv9CEPophPs7SqHIg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=P/NVIbBp; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1730711330; x=1762247330;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=/xIZbDo9LECT05XfH5ney7CuUR4+mf9L8XDS6NREgXI=;
  b=P/NVIbBpmiAnfu/iUvFmu9aaZg60BOG0R9tmwKYS8YyJ0adoYFI14Isi
   6EIXlOm20XVvs4XeI0QAAjjuBHKL444zroyqJ5ZhDpPtvorm6vxtiSXxI
   ZXYLbEVU1M3eu9Va+mmKT/IV+bgcpUFPLuSJCZlyM1pJWND8HsAY9KQRy
   RO0Q/BDVTf2pr35EhONXHEslLAqc08DulTmexpy1LQQkuqTjSXBNUjJ4W
   bHC3r7AS8XQNnIkRQqUWCUlLOWWzi+OyMsN7LQok2PxbdIOanZVHMTBSG
   NipJOdA305BpElNSh2OfzpfRH+sBG3ROYWaPFWeQRx9OhRPJKk88eKP+Y
   g==;
X-CSE-ConnectionGUID: 76DCBbJASTWMbmfvXbdxcw==
X-CSE-MsgGUID: 3I152VT6RfabZ14DgzQyRg==
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="33830842"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Nov 2024 02:08:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Nov 2024 02:08:14 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 4 Nov 2024 02:08:10 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>
Subject: [PATCH net-next 4/5] net: phy: Makefile: Add makefile support for ptp in Microchip phys
Date: Mon, 4 Nov 2024 14:37:49 +0530
Message-ID: <20241104090750.12942-5-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241104090750.12942-1-divya.koppera@microchip.com>
References: <20241104090750.12942-1-divya.koppera@microchip.com>
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


