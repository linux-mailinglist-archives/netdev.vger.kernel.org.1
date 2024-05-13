Return-Path: <netdev+bounces-96142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 373078C4773
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 21:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D82280FCB
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 19:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B35F48CCC;
	Mon, 13 May 2024 19:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kwd7dyUt"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D465A4CD;
	Mon, 13 May 2024 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715628139; cv=none; b=U2scXyVkurz/4aZ+sxI60Xy2EAmg0LZz7sEIirvDcETlTGom8qaiBuRbsrDTOac38uPLjd497rH/jL5Dcpw/bawx+BtxcKHlPhKT2LXyIo2Qab86Fli1g1e/5xlIe3qQl8rwBMu7nNeDls3hFdlPCWVrLXcttYCnOwPqgAgi+dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715628139; c=relaxed/simple;
	bh=ANzLfyitrT66TC5PrzGIG4Ao4Hz5G1gvu8BHHzCW1lE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=koym18MesYblsKPlMYhYXaUJTs5lf48C5QG7txJe3162khp5U6cnIT5bd9TcxS92XFskEh3Fa/WJnDFcf4sYIoaDdCR5WWd8eqHSK4eUIxyOc6YyD9nSF/FEZz27e8NTWJyYxqo24u02rDFLj5jgDVzHTEcgTapTXA4BihSWHq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kwd7dyUt; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715628137; x=1747164137;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ANzLfyitrT66TC5PrzGIG4Ao4Hz5G1gvu8BHHzCW1lE=;
  b=kwd7dyUtJCpq4OSWp4ThsixvH7BqhY93UD+v1hGBHKrV4KbGyzlY6SEb
   CXqgE5hX1ZGXG+yyx9rnnjKFYJuvfJfXt08EIagrCNtW1n5kSCjdmHhpK
   CZ6RqKaJS+Ancc2bDFjGxntl2UY21HIPoLVWRRtmiN4LLpziBv1HDz/1Q
   wVjFvMQdW2PlIxKoV2krMpx/tUrlyuqOR7j313gcsgHNQC12uPqOWGja/
   fVd1s0bFHv8sfIBK7XoXYxfDxQlm9+oYdx7rQ/G5GCwHDxZC9rQKXlCfo
   O+vBiJhQPQvKGyOpriPYTe6jsRObFvRcFs4p1GMK0zCOt0LgZut6UXjfl
   A==;
X-CSE-ConnectionGUID: OQ8P2cr3Qse3nU7CMDdgCg==
X-CSE-MsgGUID: HYroyLDqS/CcXMEDx6F+7A==
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="26770103"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 May 2024 12:22:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 13 May 2024 12:22:04 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 13 May 2024 12:22:02 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net] net: micrel: Fix receiving the timestamp in the frame for lan8841
Date: Mon, 13 May 2024 21:21:57 +0200
Message-ID: <20240513192157.3917664-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The blamed commit started to use the ptp workqueue to get the second
part of the timestamp. And when the port was set down, then this
workqueue is stopped. But if the config option NETWORK_PHY_TIMESTAMPING
is not enabled, then the ptp_clock is not initialized so then it would
crash when it would try to access the delayed work.
So then basically by setting up and then down the port, it would crash.
The fix consists in checking if the ptp_clock is initialized and only
then cancel the delayed work.

Fixes: cc7554954848 ("net: micrel: Change to receive timestamp in the frame for lan8841")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index ddb50a0e2bc82..87780465cd0d5 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -4676,7 +4676,8 @@ static int lan8841_suspend(struct phy_device *phydev)
 	struct kszphy_priv *priv = phydev->priv;
 	struct kszphy_ptp_priv *ptp_priv = &priv->ptp_priv;
 
-	ptp_cancel_worker_sync(ptp_priv->ptp_clock);
+	if (ptp_priv->ptp_clock)
+		ptp_cancel_worker_sync(ptp_priv->ptp_clock);
 
 	return genphy_suspend(phydev);
 }
-- 
2.34.1


