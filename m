Return-Path: <netdev+bounces-206783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9CAB0459F
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E92787ABF1C
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7EC265CB3;
	Mon, 14 Jul 2025 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BgPARjtu"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CBB263F49;
	Mon, 14 Jul 2025 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511035; cv=none; b=ekqDkP06lvbNakANvFuCCwFb5F98X0GfNUDuujaxqN5sc2piKn+FYyH3quqv3mOjNa4HAmgyuNKXxRpo+hcX12RCb8SkuUrL4RL8hZflk3gOJlCdEmtMgsqFQ5ElvHCCoMxGcmMRku6z1ggWWcKGpGuv8XzVltA+digMsPwTyTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511035; c=relaxed/simple;
	bh=fpIAXpXNXAv248bbnrtINLulVPuRlVHg3Zy4cW4/LIE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FzK/SNY0cT8Y3H03iN77mT0lfLawDVZD9JOuSZrtwqvuqBEgBi0Ld+CKly4AdJ/FyLgIuPb6a3KCZqea75WJnPNmL/YaqEIWyjjM55pDAe6Ld1QEqTFnBbTzhqspuvgySNyDM+PzLMrPX108Jfb/8MlJIEXn6idALRm7KYxJ06M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BgPARjtu; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1752511033; x=1784047033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fpIAXpXNXAv248bbnrtINLulVPuRlVHg3Zy4cW4/LIE=;
  b=BgPARjtu1J856xJNkDTsBDlxOapz0W29takYLAP2k5NKjrGfVSKnVpbC
   Lp6ElwX3ZvI2WlXjj/N2u7WxKTPXgcqHMU08EICqhMnWozAzpe+QzF7pn
   OucvmeECoQ1nLEsLpJ/5pjwQjam1mdPJFAl9rqyZDwjTSdbvroeLd0xui
   vTyR0gB5I3gBsOLQaCq0Cs/nUrLtKGmgOLUNKVyUs0AGED2+zkIgHk+s8
   sdoRT7lYhYG1jDGr5yY4h1bMcjOofq0SbBk0mzDDcFbNcfaVLM//XeexC
   yZ5YLJk7114ql/PIZhmNj13aoZ4tPvUwyQr+YOGftJ5ShBUoGuhI5YHQo
   A==;
X-CSE-ConnectionGUID: hBq1ljEWSkqL674rDMJkcA==
X-CSE-MsgGUID: dA8NuFKRS86B4XYXOA7fdw==
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="211399329"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jul 2025 09:37:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 14 Jul 2025 09:36:29 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 14 Jul 2025 09:36:29 -0700
From: <Ryan.Wanner@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, "Ryan
 Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH v2 5/5] ARM: dts: microchip: sama7g5: Add RMII ext refclk flag
Date: Mon, 14 Jul 2025 09:37:03 -0700
Message-ID: <8ea2d96c898ee7b57310b5155eee92efd4e25215.1752510727.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1752510727.git.Ryan.Wanner@microchip.com>
References: <cover.1752510727.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

The REFCLK for the RMII interface is provided by an extrenal source.

This flag matches the change in the macb driver to determine the REFCLK
source.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama7g5ek.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts b/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
index 2543599013b1..3c898afdc313 100644
--- a/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
@@ -542,6 +542,7 @@ &pinctrl_gmac1_mdio_default
 	phy-mode = "rmii";
 	nvmem-cells = <&eeprom1_eui48>;
 	nvmem-cell-names = "mac-address";
+	cdns,refclk-ext;
 	status = "okay"; /* Conflict with pdmc0. */
 
 	ethernet-phy@0 {
-- 
2.43.0


