Return-Path: <netdev+bounces-235715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B334C33F94
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 06:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6B15465929
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 05:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531492609EE;
	Wed,  5 Nov 2025 05:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yQ42XAmV"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C74258CDC;
	Wed,  5 Nov 2025 05:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762319586; cv=none; b=YINuZLr9fnbW9V2KB66RVwOSR/v43f6k3C8mbOKrtzkFwJYq3z5TGXoOjNB4wJyCHu4FUifhwBWwxZ9a4Qw9V9/ShtLpdr9Ltduvw5/2AN5ZFlrf43zScaDTvQg8meHBe4u0VSguPBom3regZsLRf7UCBROpKWQ+9rwZPqyNcbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762319586; c=relaxed/simple;
	bh=UiCXCmmRXk/In03RORdudlXDVnjIUdeWxJZhXWrtps0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pt1gyPI0zq7MjLoj+eAz6wakXLN3De9uUXXWQ8G4qOQAHbBvZN21fGSc4uRXH0sp6G9CM75JcFBBPDFzQEgprCZZlng+o220ZVrXp3Wf8iBN0AVyDio2J7fSAsT9LnDWzJ156JXCZ8h4Hjb5YsFrrXfCbj2mbsm2jcbLbPTsyxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yQ42XAmV; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762319584; x=1793855584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UiCXCmmRXk/In03RORdudlXDVnjIUdeWxJZhXWrtps0=;
  b=yQ42XAmVQtDpNZMAUXo4Ca7ScDOedxrt2tXfbYKwsIzzqZEGzvHviezK
   Gy9ezNW/CKGDmmsv9Y1pBf8ORi4XWQ/YEzJ3oTllXzSuG5c3kguhmkFnz
   8SUL0M6Km8Y0iFv1Vi0y1FQMbAYhi/sSI36JjaKZJ+Nc36I4cWtkNVAjr
   u7tDw0SruUWlWji7Zlaidvl6K/HONgrz39oeR94SErfTsF2C4//hJ2waK
   lWkeQ0uZBydNMPF2f5Ye+Pv97exzeXIXVbuw8E5NinDqmxne2qeqG9FBx
   5khfpNVk5Jqij2IO/lE9EzOJy6sCsd8s+p1weaHcPyNLX1u75F72iFWbm
   w==;
X-CSE-ConnectionGUID: QvDqlsI0RlKjbcCMavUb1Q==
X-CSE-MsgGUID: UKsa+TftSdKRZSZCWTevhA==
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="55067910"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 22:13:03 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Tue, 4 Nov 2025 22:12:30 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 4 Nov 2025 22:12:26 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <Parthiban.Veerasooran@microchip.com>, <piergiorgio.beruto@gmail.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Parthiban
 Veerasooran" <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next v3 2/2] net: phy: microchip_t1s:: add cable diagnostic support for LAN867x Rev.D0
Date: Wed, 5 Nov 2025 10:42:13 +0530
Message-ID: <20251105051213.50443-3-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105051213.50443-1-parthiban.veerasooran@microchip.com>
References: <20251105051213.50443-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Enable Open Alliance TC14 (OATC14) 10Base-T1S cable diagnostic feature
for Microchip LAN867x Rev.D0 PHY by implementing `cable_test_start` and
`cable_test_get_status` using the generic C45 functions. This allows the
`ethtool` utility to perform cable diagnostic tests directly on the PHY,
improving network troubleshooting and maintenance.

Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index bce5cf087b19..5a0a66778977 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -573,6 +573,8 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
 		.set_plca_cfg	    = lan86xx_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
+		.cable_test_start   = genphy_c45_oatc14_cable_test_start,
+		.cable_test_get_status = genphy_c45_oatc14_cable_test_get_status,
 	},
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_LAN865X_REVB),
-- 
2.34.1


