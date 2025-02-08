Return-Path: <netdev+bounces-164248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 302A7A2D1F7
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 01:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BA887A4DF6
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 00:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DA1A95E;
	Sat,  8 Feb 2025 00:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="I060GgTz"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CB39475;
	Sat,  8 Feb 2025 00:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974343; cv=none; b=haY2CK7ClksuA5w30QCJRk+ZFIRXh2O0n2X8DjqRzPw4gXRxw42R/I0k1TIihxWtv1Yr6iIzC9/tBbTvfFj/1gGOMhSA/uOn5PjcLCSCTyYSYLZyc0xZ0TKDilaU/6wMk4E578bA9XXUbXsNcqVB7RQpHutNlw0rJN9OQUN+ceo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974343; c=relaxed/simple;
	bh=KnnMJ5gA4MaTm4LyzoHVsG5QMMlcHjMBNuQdqkXXobo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1ziimDCFgQuxOMwwKqwEjQleLSPZm20tD4PYQy4KoqTJRaVexldX6fWBQ5blBNtBw4rbHCNVjXjiNMk/9Qs0yIRukuFPWXBeKc1lEhHI95FfozlVCEozk7IlHIvCUzCRZHR7O64Ee/i0hSah65ycaYDQUycJr41roE83Oq/sjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=I060GgTz; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1738974341; x=1770510341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KnnMJ5gA4MaTm4LyzoHVsG5QMMlcHjMBNuQdqkXXobo=;
  b=I060GgTzvlqAVJHJxAG+O6oWbCwP40CNfHN/7YnFG4WoljB2rMaw5y1V
   KxxdcHzE8YmqzyHEK/Okzk6ICtUmfITnAMmBQjVdf5bWjDB7qqllnywfz
   MUOozQMH1siskGYqQ2ug1Rg4NHOy3vC00PPGyGweMhCWJpUdWk79OUudF
   888aZeLANw9r+r9nfZPgic9R937v18U9CxF3PzXQlA1y4pYQSR5VVYMMg
   WspaeQJ8Wzfc4ktX+HLaR5A7n8rusImeL+B5bwLto3wNNTWAZxNgoJCMi
   7VKRPfpQj8mLa3P9Rf7LEMl4NEd3V2GcAMIt1Fs10GkwLmJ8sGu1KHMFS
   w==;
X-CSE-ConnectionGUID: gjF3bHhWQjawgqi63hdssw==
X-CSE-MsgGUID: cfMPCns0SHaIaVWTYroJtw==
X-IronPort-AV: E=Sophos;i="6.13,268,1732604400"; 
   d="scan'208";a="37033620"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Feb 2025 17:25:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 7 Feb 2025 17:24:18 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 7 Feb 2025 17:24:18 -0700
From: <Tristram.Ha@microchip.com>
To: Russell King <linux@armlinux.org.uk>, Woojung Huh
	<woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
	<olteanv@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, "Maxime
 Chevallier" <maxime.chevallier@bootlin.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH RFC net-next v3 1/2] net: pcs: xpcs: Activate DW_XPCS_SGMII_MODE_MAC_MANUAL for KSZ9477
Date: Fri, 7 Feb 2025 16:24:16 -0800
Message-ID: <20250208002417.58634-2-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250208002417.58634-1-Tristram.Ha@microchip.com>
References: <20250208002417.58634-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

Microchip KSZ9477 SGMII uses old XPCS IP and requires special code to
operate correctly.  A special value from PMA device ids will be used to
activate DW_XPCS_SGMII_MODE_MAC_MANUL.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 drivers/net/pcs/pcs-xpcs.c   | 2 ++
 include/linux/pcs/pcs-xpcs.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index d522e4a5a138..5aad67ff4a4f 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1482,6 +1482,8 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev)
 		xpcs->sgmii_10_100_8bit = DW_XPCS_SGMII_10_100_8BIT;
 		xpcs->sgmii_mode = DW_XPCS_SGMII_MODE_PHY_HW;
 	} else {
+		if (xpcs->info.pma == MICROCHIP_KSZ9477_PMA_ID)
+			xpcs->sgmii_mode = DW_XPCS_SGMII_MODE_MAC_MANUAL;
 		xpcs->need_reset = true;
 	}
 
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index 733f4ddd2ef1..637d5356a961 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -39,6 +39,7 @@ enum dw_xpcs_pma_id {
 	DW_XPCS_PMA_GEN5_10G_ID,
 	DW_XPCS_PMA_GEN5_12G_ID,
 	WX_TXGBE_XPCS_PMA_10G_ID = 0x0018fc80,
+	MICROCHIP_KSZ9477_PMA_ID = 0x00229477,
 };
 
 struct dw_xpcs_info {
-- 
2.34.1


