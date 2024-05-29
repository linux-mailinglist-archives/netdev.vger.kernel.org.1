Return-Path: <netdev+bounces-99051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AA08D38A4
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB7C4B24A3E
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 14:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2131210F8;
	Wed, 29 May 2024 14:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hdtXU6nG"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9501F95E;
	Wed, 29 May 2024 14:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991522; cv=none; b=dN9kyEviuD8Z5MN/KMUarrdyjKjDAHRUfokN38RQDsHyTRJDOvqU5db+CmvHC9w4f5XUC5OBFYadDRryAzg8qnKXYHouTV2dGvjmFJleY+mDLnF52G1VDl84Ev8pgLL8AviROEC52JBqqi4pcgJgRwwwkEouxuPluxPITqJr8so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991522; c=relaxed/simple;
	bh=xLXQdWfnM+lZS5GVhD6SBArCWokhO6jmgrkUuYBlHAs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CI4jKBlTfKt2ng8ypeTcAqRvMUpDUXQWDZwF2+2+5GLqdl2wDqGIa3/oO9SeNBlmQhGV4Ogaj0v1PHYI1zTWaRER45vMaTRwk2t3LA2B8XGZYJhCpgVldKI7watPUPeW+j0ify1RqkKEK/Q1FJrE9g48aQswfRXHO19LB0mw3xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hdtXU6nG; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716991521; x=1748527521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xLXQdWfnM+lZS5GVhD6SBArCWokhO6jmgrkUuYBlHAs=;
  b=hdtXU6nGWER6Yo2w4X3tpixF6XDWZssWqfFvAitcE+iIxh5pmg5uYOT1
   lFJx59tuZO26jGXFV0kb5D4qmFUBBPfPEyPihC2MlzanvfiIBWNK6ojJ+
   n9GtXpHLNRQbP0AD5rPDtozpAeNGwArou68Qy9f78ddCZK9JRTfksr6SG
   8Edm/vlN05VGhU7v3Nij+xzUkOmoFPm4beIPAER0TGzYIIog06ZydxqoG
   h7gGRUeec6LOVvaQrqY0Im8sZyp2ZWphlyhVKQoUHZzFMoF1xckUBbCep
   IizBaMRqCe7PUtyzunm7nA2KFpqPhYEVz0k9urQHtL3Y6FKGqKN2QNUkR
   A==;
X-CSE-ConnectionGUID: J4E1/ZSyRQW1wK6IW2PL8w==
X-CSE-MsgGUID: fhosNk4gT+OOU4eVFz4BXw==
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="257537345"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 May 2024 07:05:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 29 May 2024 07:04:41 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 29 May 2024 07:04:38 -0700
From: Rengarajan S <rengarajan.s@microchip.com>
To: <woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <rengarajan.s@microchip.com>
Subject: [PATCH net-next v3 2/2] lan78xx: Enable Auto Speed and Auto Duplex configuration for LAN7801 if NO EEPROM is detected
Date: Wed, 29 May 2024 19:32:56 +0530
Message-ID: <20240529140256.1849764-3-rengarajan.s@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240529140256.1849764-1-rengarajan.s@microchip.com>
References: <20240529140256.1849764-1-rengarajan.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Enabled ASD/ADD configuration for LAN7801 in the absence of EEPROM.
After the lite reset these contents go back to defaults where ASD/
ADD is disabled. The check is already available for LAN7800.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>
---
 drivers/net/usb/lan78xx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 7ac540cc3686..62dbfff8dad4 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -3034,8 +3034,11 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 		return ret;
 
 	/* LAN7801 only has RGMII mode */
-	if (dev->chipid == ID_REV_CHIP_ID_7801_)
+	if (dev->chipid == ID_REV_CHIP_ID_7801_) {
 		buf &= ~MAC_CR_GMII_EN_;
+		/* Enable Auto Duplex and Auto speed */
+		buf |= MAC_CR_AUTO_DUPLEX_ | MAC_CR_AUTO_SPEED_;
+	}
 
 	if (dev->chipid == ID_REV_CHIP_ID_7800_ ||
 	    dev->chipid == ID_REV_CHIP_ID_7850_) {
-- 
2.25.1


