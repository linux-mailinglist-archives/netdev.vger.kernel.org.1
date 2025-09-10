Return-Path: <netdev+bounces-221664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFD2B51792
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 15:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B2C444FF7
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 13:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6C6315765;
	Wed, 10 Sep 2025 13:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i/wMpz5c"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C0028751A;
	Wed, 10 Sep 2025 13:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509662; cv=none; b=P+B+6s4Aq2PIPS0lsNTgfLHN8zsf8w6YOYfphFvo9OeVxtrGd1o5SdIDcCFRMEP4Kr6J32EhTyT+l7e0aJtanrBTEXRAyQm4PrngAHTweNvRrpzhqpr+LNY6jTgol9fgPiGrIJu7f7uUc5pgenSftXvJq9RGh7GInHqFNEL18wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509662; c=relaxed/simple;
	bh=MXqsGbYWSiofoLCT6vUM7yK8s7VLuwMfb/Rz5sSo/+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uIOaGcrgq4uW5GpxyK5hDS4gNWDQCOru3R619oYuLPP6p7lytP5uXbg220rieLwfVwF/xVk+FudPgOWoGKlXC4rKduFg0JG8Uj4/4Z2WgQk6MlhiPqpXTau67lfDh9PyDfLpFmFoaiRd20IL4mdC1cR1RR58uJfIdRdNCvW38uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=i/wMpz5c; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2C482C653F9;
	Wed, 10 Sep 2025 13:07:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D92BB606D4;
	Wed, 10 Sep 2025 13:07:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9FB93102F24D7;
	Wed, 10 Sep 2025 15:07:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757509655; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=r2SJ9l9HI7zA+U/h8NvB9xjHxSc96b4EXJRsV7IaaWU=;
	b=i/wMpz5cwN1rOjapDwtjmOXkr0rl6ZCiorIMpYFmVjAasnl89iqqxPZEEitX80owYgwd7E
	LvimZDdtWEU5VVS0f4lS0Td8pWTjzaeGRDCN5cjayEXCX2us4+CfiJpri9ccNFy1c3Qs5K
	D18eNZYQ83i5GWgUplyXAgMyV0cQDtgF/LaOpLO+WkBgrgUgZ9MMg9yNF2rI8U1e4Lp5mg
	IgAwjS7Akp8Yv1p70sQvsE7948VoMQGfclra001gH84HpIFnOr2XopMCgvTAUMOHMHWVB9
	RRc+clCW5JK+yV0PL/rNPDSjPeZ+AQk2DMH5a1RoJdtAejkj86uSH1Xt0ORuyA==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Wed, 10 Sep 2025 15:07:21 +0200
Subject: [PATCH net] net: dsa: microchip: Select SPI_MODE 0 for KSZ8463
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-fix-omap-spi-v1-1-fd732c42b7be@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAh4wWgC/x2MywqAIBAAf0X23IJKD+pXooPkWntIRSOC6N9bO
 g7DzAOVClOFST1Q6OLKKQqYRsG6u7gRshcGq22nR6Mx8I3pcBlrZvTD2rfBtqb3ASTJhcT/uxk
 inbC87wcc2QLYYwAAAA==
X-Change-ID: 20250910-fix-omap-spi-d7c64f2416df
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Tristram Ha <tristram.ha@microchip.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Pascal Eberhard <pascal.eberhard@se.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

KSZ8463 expects the SPI clock to be low on idle and samples data on
rising edges. This fits SPI mode 0 (CPOL = 0 / CPHA = 0) but the SPI
mode is set to 3 for all the switches supported by the driver. This
can lead to invalid read/write on the SPI bus.

Set SPI mode to 0 for the KSZ8463.
Leave SPI mode 3 as default for the other switches.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
Fixes: 84c47bfc5b3b ("net: dsa: microchip: Add KSZ8463 switch support to KSZ DSA driver")
---
 drivers/net/dsa/microchip/ksz_spi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchip/ksz_spi.c
index d8001734b05741446fa78a1e88c2f82e894835ce..dcc0dbddf7b9d70fbfb31d4b260b80ca78a65975 100644
--- a/drivers/net/dsa/microchip/ksz_spi.c
+++ b/drivers/net/dsa/microchip/ksz_spi.c
@@ -139,6 +139,7 @@ static int ksz_spi_probe(struct spi_device *spi)
 	const struct regmap_config *regmap_config;
 	const struct ksz_chip_data *chip;
 	struct device *ddev = &spi->dev;
+	u32 spi_mode = SPI_MODE_3;
 	struct regmap_config rc;
 	struct ksz_device *dev;
 	int i, ret = 0;
@@ -155,8 +156,10 @@ static int ksz_spi_probe(struct spi_device *spi)
 	dev->chip_id = chip->chip_id;
 	if (chip->chip_id == KSZ88X3_CHIP_ID)
 		regmap_config = ksz8863_regmap_config;
-	else if (chip->chip_id == KSZ8463_CHIP_ID)
+	else if (chip->chip_id == KSZ8463_CHIP_ID) {
 		regmap_config = ksz8463_regmap_config;
+		spi_mode = SPI_MODE_0;
+	}
 	else if (chip->chip_id == KSZ8795_CHIP_ID ||
 		 chip->chip_id == KSZ8794_CHIP_ID ||
 		 chip->chip_id == KSZ8765_CHIP_ID)
@@ -185,7 +188,7 @@ static int ksz_spi_probe(struct spi_device *spi)
 		dev->pdata = spi->dev.platform_data;
 
 	/* setup spi */
-	spi->mode = SPI_MODE_3;
+	spi->mode = spi_mode;
 	ret = spi_setup(spi);
 	if (ret)
 		return ret;

---
base-commit: c65e2aee8971eb9d4bc2b8edc3a3a62dc98f0410
change-id: 20250910-fix-omap-spi-d7c64f2416df

Best regards,
-- 
Bastien Curutchet <bastien.curutchet@bootlin.com>


