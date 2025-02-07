Return-Path: <netdev+bounces-163792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5610A2B930
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 03:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F71C166FDC
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 02:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F00918132A;
	Fri,  7 Feb 2025 02:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qN7j1jUP"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9F117CA17;
	Fri,  7 Feb 2025 02:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738896236; cv=none; b=f+xQifB8Mj+mM5S/Yr37baL7zTsfigVY8cIa6Pb+kV92M94RF3Ne29VwH+xCU45oqewKsUuoJcUN0W0oD6p5dMa1kj2F3woESHOA6wIdqal4rwoCdKfgNr5eNDd0q52lj6xbgv1gSXCBq0tfU7SMECtYVXuFT0jXxhwdKepiD/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738896236; c=relaxed/simple;
	bh=KnnMJ5gA4MaTm4LyzoHVsG5QMMlcHjMBNuQdqkXXobo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ww/gpIS+VUn1obbiWZx4GH+/b/NyRaRLc2Sa6cNuobO7t/IIRc9w3S/Gz/3fWAmMTeLis98vgin7dX04dZCkvBJgZ5N4UwtH8N6UH8M4iUw+kuFISiB1lqrczd76EW+DZn2TEoLR1+3F+v9FsHejO/RS/44j2PrKa/FG4ni9VCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qN7j1jUP; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1738896235; x=1770432235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KnnMJ5gA4MaTm4LyzoHVsG5QMMlcHjMBNuQdqkXXobo=;
  b=qN7j1jUPJfPkna1G6tu1xpDF1nlMSXifabxtbt+woE0U8diSr91jOoto
   z0CKAfekw6t3sj/Bu+z9qQh2isRBSq/o4/i3wvscpid/CsNzeoiHOdzBj
   n64O4mi0nESjWausGQl6QD8gsqo1yqhQV/w/xob/jSii554EH0dbXtXcH
   hdrDvXIgfk8yWVyKixn3rllh4B91b/y7xC1H7T1Q588JCICIYKvvIdn8E
   zSkCW1J6KcvNLeiX9KkWo8H9paNxK/PtwGEGqaI4ml4JWFfXs7ewKhdwg
   bwIeInr18hdXv4OiDVF9gbQHanCaAOeeAHEVOPBVXhdvXnY16sJLjIao5
   w==;
X-CSE-ConnectionGUID: HtEgmb03QQa8PJ+IoVcYWA==
X-CSE-MsgGUID: g+PjePLaRVmmcLrwtqXAmA==
X-IronPort-AV: E=Sophos;i="6.13,266,1732604400"; 
   d="scan'208";a="37381075"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Feb 2025 19:43:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 6 Feb 2025 19:43:09 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 6 Feb 2025 19:43:08 -0700
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
Subject: [PATCH RFC net-next v2 1/3] net: pcs: xpcs: Activate DW_XPCS_SGMII_MODE_MAC_MANUAL for KSZ9477
Date: Thu, 6 Feb 2025 18:43:14 -0800
Message-ID: <20250207024316.25334-2-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250207024316.25334-1-Tristram.Ha@microchip.com>
References: <20250207024316.25334-1-Tristram.Ha@microchip.com>
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


