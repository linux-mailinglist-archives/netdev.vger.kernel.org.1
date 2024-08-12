Return-Path: <netdev+bounces-117723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD4F94EEB1
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 15:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DECA2B22FB2
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 13:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB5918130D;
	Mon, 12 Aug 2024 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bySGq+Bk"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F7B17CA03;
	Mon, 12 Aug 2024 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470562; cv=none; b=KD4DGAMD51yssxkOK07Q2aPGC2Vx9ycgnLQVEG/pmttfq1TivDAzcvRUEDS/9ZT62jNQWMsxEArZDTrAupK05U+B9KW7UqnwOXy+X/mU7y3vXCtX8d72QKa+jZ3UBdFVxFeWgydqepkgY0r00d4iliTwwbs7g6yvknzpBwRT5Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470562; c=relaxed/simple;
	bh=tOUANnEFpl3H68hQRgKU8vbAucntHBRRrjm04G2x0ps=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EcvD+XluBgnJ4ckrhttaMUPAf49QkozDCPhAxlEyMOiqqmtqUW1tBkooLtYo0MeBubswlDva8yUX9+VneZITiSjTAGffNA/qD5QycFJtXlh6NqpnsehRtH+LwXp5Tp0sqszNTb6AW54CAJVvRm0JHnDZ8mw115dOaB5qKj9nya4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bySGq+Bk; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723470560; x=1755006560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tOUANnEFpl3H68hQRgKU8vbAucntHBRRrjm04G2x0ps=;
  b=bySGq+Bk2pW7ET3V5xwQojN5LRvWnP5j2ZKakUqh3hpiL9e9DqRjlLuA
   +1c5IWJuAt4ZuktaSXLuCw5eynGHBRxC28EIgn8fJJeJoSAgkU5YXtsPS
   Lrev+56erKl0yeB5ksfGWmz8XIG7y6P9MdywkF8HZFKFTof2q4hN2A42W
   yVn2lA8LDP7iFiDey8GbHOln2++ELAIm/37Xfjh2onvYIAqL2XQRnOy42
   de13QVJ/YtaY/W3VnZUNXYelFoOiinUDzStu84cXKkH7jZhTxHQnMkptQ
   1g2t41VQH1GhLhs+9Q6x4rwvwXsUFC74BGHe1OW3dgsflZHIdGtIa6HDZ
   Q==;
X-CSE-ConnectionGUID: yI+1XPNJS2+OYumvWzLkww==
X-CSE-MsgGUID: WmqDsjmCQY6sR4bZtVyDtA==
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="31049515"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2024 06:49:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Aug 2024 06:49:03 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 12 Aug 2024 06:48:59 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parthiban.veerasooran@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next 4/7] net: phy: microchip_t1s: move LAN867X reset handling to a new function
Date: Mon, 12 Aug 2024 19:18:13 +0530
Message-ID: <20240812134816.380688-5-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812134816.380688-1-Parthiban.Veerasooran@microchip.com>
References: <20240812134816.380688-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch moves LAN867X reset handling code to a new function called
lan867x_check_reset_complete() which will be useful for the next patch
which also uses the same code to handle the reset functionality.

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index 187540ae95c0..d0af02a25d01 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -265,7 +265,7 @@ static int lan865x_revb_config_init(struct phy_device *phydev)
 	return 0;
 }
 
-static int lan867x_revb1_config_init(struct phy_device *phydev)
+static int lan867x_check_reset_complete(struct phy_device *phydev)
 {
 	int err;
 
@@ -287,6 +287,17 @@ static int lan867x_revb1_config_init(struct phy_device *phydev)
 		}
 	}
 
+	return 0;
+}
+
+static int lan867x_revb1_config_init(struct phy_device *phydev)
+{
+	int err;
+
+	err = lan867x_check_reset_complete(phydev);
+	if (err)
+		return err;
+
 	/* Reference to AN1699
 	 * https://ww1.microchip.com/downloads/aemDocuments/documents/AIS/ProductDocuments/SupportingCollateral/AN-LAN8670-1-2-config-60001699.pdf
 	 * AN1699 says Read, Modify, Write, but the Write is not required if the
-- 
2.34.1


