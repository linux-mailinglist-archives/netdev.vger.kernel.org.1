Return-Path: <netdev+bounces-210558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6B3B13EB7
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44C1F18883DD
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 15:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C94274B5E;
	Mon, 28 Jul 2025 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="GBMthJrg"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1ED27380F;
	Mon, 28 Jul 2025 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753716920; cv=none; b=sfyL+HkkSbN1g7OUgxudbUYC3s/qT05hhR/QVqi9VJvEoq23qRNa+cKBAUBw5WJ8m3Q2kDUCd4FTQxYzqV9MdS5z7UgBS8yH1nuakWqf6s44H8dedRWu8wSTuD9ViHtGtkDli+t6mOdTib42KOtgBIzvgnIp16Q4D3i6p6eXgGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753716920; c=relaxed/simple;
	bh=fVUmTsT1aVGwMRX+rjvd/Y9HAd0yJQPHy+zphDQ3/zE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hdLiyC18F9J4saUSIl5O6lcrvOkOQSFx3YRG0s8Ke2IW9JYg56GTBpBEMiSll3flbBxZ1LBfCk+Dupju5zugKUvlej7y3nZ9g0q3fBP3qX0VnUutOw+l1W/bbM276Y8JKHJqfkJ7wIAwJcjeRFUSot+pONNZ2TqiW2sR1bdaL5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=GBMthJrg; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id E7177A0A55;
	Mon, 28 Jul 2025 17:35:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=ITO07SSY5VSdV4RAypVkZOuvZxUXVYAV/4k1hVCN4Lg=; b=
	GBMthJrglHxwjqJagUQSixLDuDXpnM3CYjvTmc8IXIMQ9Mxpyp+PiuA7OPboaLRb
	rT7WWmyH7wdWW1ePdhA6Myn6TlHnBqjfbD0MwvTL3yoY2v2+FbbbvkeihIeACMIm
	tkGsQ5WVyndzixNVt/zsE6UF1RQSBhaEkvRxVLaOzjEfRcewc2IgtdAb1ai/637G
	+G3+Xw9cbCCByoshTX9/Vxwq/g/GKt5WF4os+Tpd7DC/ul2rTIRbd7XhzP5rdzmX
	76KXwPxW13XELePfYbxJjCcAvolnOGK2/McbIcFTqoFumJs8fH23H5Krqh9NMEjB
	34zu0ykmrXJmVN6citIRYyOTUSaqsbpAvWw3yG/dLw/Z9jA2Ug8fd9AtkxARLUnP
	AxZAkMeIwjdLYIBaNGQWHwa8zq3OOK9AIRTUZ+/ItHadyNi9/0F2WstEsMvPDjzG
	ziNikPiLB0m3S4vS48QzesHwGFbXyd6JJrmxmGpotNnZjmGs1OZEEuotShSyIQEB
	ga4XfTEbS8oeSyM4bcJJkW+6ASwwdf1t9BhUOvtMcY/8FxOwT8qhKAnL2nFsyeS9
	Bu4mlDDRtFLTLPPSkQl5DB7HvyXQF41BzGREyKVcXeyNs82T0uXSteCJvnihs1yw
	iXrH+CoHMY4QWUJS0PtpNiHJzd+Q98C81HyuctuM9I4=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Sergei Shtylyov
	<sergei.shtylyov@cogentembedded.com>, "David S. Miller"
	<davem@davemloft.net>, Rob Herring <robh@kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Dmitry Torokhov" <dmitry.torokhov@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Csaba Buday
	<buday.csaba@prolan.hu>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] net: mdio_bus: Use devm for getting reset GPIO
Date: Mon, 28 Jul 2025 17:34:55 +0200
Message-ID: <20250728153455.47190-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1753716913;VERSION=7994;MC=189549094;ID=373804;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155E677063

Commit bafbdd527d56 ("phylib: Add device reset GPIO support") removed
devm_gpiod_get_optional() in favor of the non-devres managed
fwnode_get_named_gpiod(). When it was kind-of reverted by commit
40ba6a12a548 ("net: mdio: switch to using gpiod_get_optional()"), the devm
functionality was not reinstated. Nor was the GPIO unclaimed on device
remove. This leads to the GPIO being claimed indefinitely, even when the
device and/or the driver gets removed.

Fixes: bafbdd527d56 ("phylib: Add device reset GPIO support")
Fixes: 40ba6a12a548 ("net: mdio: switch to using gpiod_get_optional()")
Cc: Csaba Buday <buday.csaba@prolan.hu>
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 drivers/net/phy/mdio_bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index fda2e27c1810..24bdab5bdd24 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -36,8 +36,8 @@
 static int mdiobus_register_gpiod(struct mdio_device *mdiodev)
 {
 	/* Deassert the optional reset signal */
-	mdiodev->reset_gpio = gpiod_get_optional(&mdiodev->dev,
-						 "reset", GPIOD_OUT_LOW);
+	mdiodev->reset_gpio = devm_gpiod_get_optional(&mdiodev->dev,
+						      "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(mdiodev->reset_gpio))
 		return PTR_ERR(mdiodev->reset_gpio);
 

base-commit: fa582ca7e187a15e772e6a72fe035f649b387a60
-- 
2.43.0



