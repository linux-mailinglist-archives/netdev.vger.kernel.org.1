Return-Path: <netdev+bounces-247053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE97CF4013
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 15:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 70CB4300A93E
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 14:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D16A286425;
	Mon,  5 Jan 2026 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iejyKNjU"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408EE2737E0
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767618515; cv=none; b=N2XHq098pW5tcnbAMM0mYb9+jwGTUKyhovEPuacsdyxD+VfGTepGKtHZa1mx+b5xvPMVM8Ql89rc1VpVcXCjC6h2pRx6jE+uUgX37aPXnXjse5TNgSZPRqgx/EbhutJ8eMBJNHPnDwL9NJ6NmOFAjsBqy/mvSl3ZnvaUxpYHIsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767618515; c=relaxed/simple;
	bh=gKGh5hObYHFfGOe2gRFxe13rG/sSzFUdbNZLyVOLqB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bMPgn99SLaFw1RD3jcIAiMOPKL8c0WVKHZQ9AdVMFmxfV0lzj8iFBxrivJWjVAzUUM2vVB8/xEXxrD+0X1L6SaGlbLI5nkqjx0S8qL7tRhRjOW3Au2qGzV1UCJSlAsT/x4edRZEIxgv2r3kRic4JUAufZZ0HQXyflx3ZoXn6spc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iejyKNjU; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id CB741C1E488;
	Mon,  5 Jan 2026 13:08:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C77A460726;
	Mon,  5 Jan 2026 13:08:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD4FB103C8510;
	Mon,  5 Jan 2026 14:08:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767618511; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RvTCTJumGyaWU6Zx6AbiAXwD9Yv/ZwJcpm0eYOrOQOE=;
	b=iejyKNjUoyw7L5aYqbSGEngpY9uwKjQpFQTVcF+tezDSXj7WdGI3NAoxZ0euEk3VlK8z3w
	i9fIhsBJLYu62oIVS3sEvYDT5PpVu9JQfQKIgdhapiRT0QKmyVkCW7EiE1Bl90YXQKCWN9
	0hDutjAsLR9SuE4m4shjohKekU1nybZYM/HYZoeVpVWEAX0k0h4nHf8phrMCEYu3q4ti7A
	I8cYwzhHV3mrycBjqggO/7NPA7KF6rmNDk7/3A1nzV5bPhSH+qayt9yY8wIye4cu+js3SV
	NbxxY9RV7bJ4mm4Y3U8KPLuQiKN65pzh/9lPZfzuzyacsek8kHITdzGy4MBidw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 05 Jan 2026 14:08:06 +0100
Subject: [PATCH net-next 7/9] net: dsa: microchip: Use regs[] to access
 REG_PTP_SUBNANOSEC_RATE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-ksz-rework-v1-7-a68df7f57375@bootlin.com>
References: <20260105-ksz-rework-v1-0-a68df7f57375@bootlin.com>
In-Reply-To: <20260105-ksz-rework-v1-0-a68df7f57375@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Accesses to the PTP_SUBNANOSEC_RATE register are done through a
hardcoded address which doesn't match with the KSZ8463's register
layout.

Add a new entry for the PTP_SUBNANOSEC_RATE register in the regs[]
tables.
Use the regs[] table to retrieve the PTP_SUBNANOSEC_RATE register
address when accessing it.
Remove the macro defining the address to prevent further use.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c  | 2 ++
 drivers/net/dsa/microchip/ksz_common.h  | 1 +
 drivers/net/dsa/microchip/ksz_ptp.c     | 2 +-
 drivers/net/dsa/microchip/ksz_ptp_reg.h | 3 +--
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 7af008cafccf716c2114f486938cdc25b7daae73..cbd918c0add30da17ea6ebe44ff44b866fcf2a1f 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -573,6 +573,7 @@ static const u16 ksz8463_regs[] = {
 	[PTP_RTC_NANOSEC]		= 0x0604,
 	[PTP_RTC_SEC]			= 0x0608,
 	[PTP_RTC_SUB_NANOSEC]		= 0x060C,
+	[PTP_SUBNANOSEC_RATE]		= 0x0610,
 };
 
 static const u32 ksz8463_masks[] = {
@@ -811,6 +812,7 @@ static const u16 ksz9477_regs[] = {
 	[PTP_RTC_SUB_NANOSEC]		= 0x0502,
 	[PTP_RTC_NANOSEC]		= 0x0504,
 	[PTP_RTC_SEC]			= 0x0508,
+	[PTP_SUBNANOSEC_RATE]		= 0x050C,
 };
 
 static const u32 ksz9477_masks[] = {
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index d1baa3ce09b5fee8e0984791a730b70b704fcfdd..16a7600789e3233dab1e1ed5d4599b875aa57aa1 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -275,6 +275,7 @@ enum ksz_regs {
 	PTP_RTC_NANOSEC,
 	PTP_RTC_SEC,
 	PTP_RTC_SUB_NANOSEC,
+	PTP_SUBNANOSEC_RATE,
 };
 
 enum ksz_masks {
diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 3766d8bde478e6c2cf0ec19e7ac27570c2bb7676..538162e3e4569483c85c710182cb3918a8713d74 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -742,7 +742,7 @@ static int ksz_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 		if (!negative)
 			data32 |= PTP_RATE_DIR;
 
-		ret = ksz_write32(dev, REG_PTP_SUBNANOSEC_RATE, data32);
+		ret = ksz_write32(dev, regs[PTP_SUBNANOSEC_RATE], data32);
 		if (ret)
 			goto unlock;
 
diff --git a/drivers/net/dsa/microchip/ksz_ptp_reg.h b/drivers/net/dsa/microchip/ksz_ptp_reg.h
index 41891ddadaa30ce2cf3ac41273fd335987258230..1e823b1a19daa480cccdc0367b436a0940e85093 100644
--- a/drivers/net/dsa/microchip/ksz_ptp_reg.h
+++ b/drivers/net/dsa/microchip/ksz_ptp_reg.h
@@ -28,8 +28,7 @@
 #define PTP_RTC_SUB_NANOSEC_M		0x0007
 #define PTP_RTC_0NS			0x00
 
-#define REG_PTP_SUBNANOSEC_RATE		0x050C
-
+/* REG_PTP_SUBNANOSEC_RATE */
 #define PTP_SUBNANOSEC_M		0x3FFFFFFF
 #define PTP_RATE_DIR			BIT(31)
 #define PTP_TMP_RATE_ENABLE		BIT(30)

-- 
2.52.0


