Return-Path: <netdev+bounces-247051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2625CF3BC6
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 14:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68F7B301D610
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 13:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF58426ED48;
	Mon,  5 Jan 2026 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k+w7MQ5+"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99D92561A2
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767618512; cv=none; b=aXNt5H777f/NUXzbCkIxw2yo6oyf3CxgBNQsfu6oNTJnA7oc7Vb2sUGrmzOMk3trSMJbmyCq/DCiyxNC1fq3qKclAKrT/jRJ838wfQPyTsbQyBcGZ4beNLKux2IhI+mPVF/W9MyMiCVL4izd2tYjqCC7nyyfucxziQRMzMYe9hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767618512; c=relaxed/simple;
	bh=YLEf1VwMYzGZ8leQPDXtKftELdmbC7L627VN6hdyjdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hSWYZ0d15ubHzy4Ifc4W2w2B/Q8q/CNHdpgNgb20y4WfCi4KlN3i3WCup7kSEB1uRDmgHXlFwA2Xvf0XQVokNBryks8Youd3J0ninqTdFB+6Gdbyg0mauEcE6NgGEajyX5opNJGlnTuQGhisUjMmnXeuFZ2DuqsPlnsBJ1nNuGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k+w7MQ5+; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2F3481A2665;
	Mon,  5 Jan 2026 13:08:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 01A0460726;
	Mon,  5 Jan 2026 13:08:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D2C31103C8416;
	Mon,  5 Jan 2026 14:08:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767618508; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qKlZzN5tUG8JW9r14COXHcGVAvYMFuw4AbBxGPuQo+w=;
	b=k+w7MQ5+6fiRQPuJJASC5/gzvUSFdy/rdJrEVZZF7W/atnQ7EXpGZGjQjCyjR1tZG1MXUm
	qIs/sRrxOnkKDP5dOIR2CURm3vTh/abdVWYrlBV9oE84pC4eww8Z4fTFkzZMk0a35k92IV
	GlCQzBvklt0HPrcNScTQEpM06YfqGMOq/urepPETbxBSsTDOrJKgmpIaKImmjFBQv4vPyd
	n0ywbDJFqRLxcDj8hR1iDDWwzqU3Vi4Y8+1LSUoqa1+sAa00jncD3Z9jY6XnAus8v7fwiM
	93HXGWMxpEe8X5AbLGivZyhtFzyJ5zPdLSuJA4IzTaJwuAZph/EBpqtXs/9lqA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 05 Jan 2026 14:08:04 +0100
Subject: [PATCH net-next 5/9] net: dsa: microchip: Use regs[] to access
 REG_PTP_RTC_SEC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-ksz-rework-v1-5-a68df7f57375@bootlin.com>
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

Accesses to the PTP_RTC_SEC register are done through a hardcoded
address which doesn't match with the KSZ8463's register layout.

Add a new entry for the PTP_RTC_SEC register in the regs[] tables.
Use the regs[] table to retrieve the PTP_RTC_SEC register address
when accessing it.
Remove the macro defining the address to prevent further use.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c  | 2 ++
 drivers/net/dsa/microchip/ksz_common.h  | 1 +
 drivers/net/dsa/microchip/ksz_ptp.c     | 6 +++---
 drivers/net/dsa/microchip/ksz_ptp_reg.h | 2 --
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index d400a4ad57b5691d54bce7680fc831475535a85c..595438031d316eda96ee7fa781aebdb65575b336 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -571,6 +571,7 @@ static const u16 ksz8463_regs[] = {
 	[S_MULTICAST_CTRL]		= 0x04,
 	[PTP_CLK_CTRL]			= 0x0600,
 	[PTP_RTC_NANOSEC]		= 0x0604,
+	[PTP_RTC_SEC]			= 0x0608,
 };
 
 static const u32 ksz8463_masks[] = {
@@ -807,6 +808,7 @@ static const u16 ksz9477_regs[] = {
 	[REG_PORT_PME_CTRL]		= 0x0017,
 	[PTP_CLK_CTRL]			= 0x0500,
 	[PTP_RTC_NANOSEC]		= 0x0504,
+	[PTP_RTC_SEC]			= 0x0508,
 };
 
 static const u32 ksz9477_masks[] = {
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 6d100f1f5e6efe8b43969845ca517625ea825314..b4305bd47fbebfd917fca978a6f916d13b6115ea 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -273,6 +273,7 @@ enum ksz_regs {
 	REG_PORT_PME_CTRL,
 	PTP_CLK_CTRL,
 	PTP_RTC_NANOSEC,
+	PTP_RTC_SEC,
 };
 
 enum ksz_masks {
diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 226b10d0f89a6d58c9b329a66ee25eabc9d294a9..5a94beb410df38f5d0465e1cd896039292f9a5ec 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -604,7 +604,7 @@ static int _ksz_ptp_gettime(struct ksz_device *dev, struct timespec64 *ts)
 	if (ret)
 		return ret;
 
-	ret = ksz_read32(dev, REG_PTP_RTC_SEC, &seconds);
+	ret = ksz_read32(dev, regs[PTP_RTC_SEC], &seconds);
 	if (ret)
 		return ret;
 
@@ -691,7 +691,7 @@ static int ksz_ptp_settime(struct ptp_clock_info *ptp,
 	if (ret)
 		goto unlock;
 
-	ret = ksz_write32(dev, REG_PTP_RTC_SEC, ts->tv_sec);
+	ret = ksz_write32(dev, regs[PTP_RTC_SEC], ts->tv_sec);
 	if (ret)
 		goto unlock;
 
@@ -782,7 +782,7 @@ static int ksz_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 	if (ret)
 		goto unlock;
 
-	ret = ksz_write32(dev, REG_PTP_RTC_SEC, abs(sec));
+	ret = ksz_write32(dev, regs[PTP_RTC_SEC], abs(sec));
 	if (ret)
 		goto unlock;
 
diff --git a/drivers/net/dsa/microchip/ksz_ptp_reg.h b/drivers/net/dsa/microchip/ksz_ptp_reg.h
index 9ab918c7af4b46a73e00846950ac09917c65db5a..d1d31514488609df9f5eee4b12bff074965b1c6e 100644
--- a/drivers/net/dsa/microchip/ksz_ptp_reg.h
+++ b/drivers/net/dsa/microchip/ksz_ptp_reg.h
@@ -29,8 +29,6 @@
 #define PTP_RTC_SUB_NANOSEC_M		0x0007
 #define PTP_RTC_0NS			0x00
 
-#define REG_PTP_RTC_SEC			0x0508
-
 #define REG_PTP_SUBNANOSEC_RATE		0x050C
 
 #define PTP_SUBNANOSEC_M		0x3FFFFFFF

-- 
2.52.0


