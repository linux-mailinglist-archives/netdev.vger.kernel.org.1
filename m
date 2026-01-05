Return-Path: <netdev+bounces-247054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FF3CF3BC3
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 14:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 56ED03003FF5
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 13:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2473E28C009;
	Mon,  5 Jan 2026 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eQgh84s0"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13D6283FF4
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 13:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767618517; cv=none; b=pYOBvdRKbw36MBANAUbE9wY71kOlI/UrRmBEe0ytNdTrv4Qcj2ZKEeeDNNnvvtJgRaZ97nAWmsVcBSyBFltUmZ70Y3O5w/0iWlImZUIpHcDOPwPIkWIDLCWnP44VeVaxX0H0wRuCDF+0ewJDnYbYQVqZGdqurwWcJjuY/ULXxtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767618517; c=relaxed/simple;
	bh=Hj8A2udcq68Ialhjy1HdRJNmlsQBb6OT07lScnDSk9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I1H6tt8BPTQJDpKG649h3CBuLCiNnH9eaijB8NfEdW7F+c0Gf+sqXlX896tC8NkqtN+8ZKs7KUluqf1pwOAufRKo/YJ2ZOrTVS/y7x7BScFfhLgAR4GdQdU/iraG/RIITT4w7ZZTahqGRBOrCfz45woQ2aCCKb2pyWvmQZ7OVtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eQgh84s0; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6592B1A266A;
	Mon,  5 Jan 2026 13:08:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3AD3460726;
	Mon,  5 Jan 2026 13:08:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4FAAF103C8530;
	Mon,  5 Jan 2026 14:08:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767618512; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ijE6JIYADwBrtZFkP/tXhPkQ6YftzQ+V6+ssQl8kO9s=;
	b=eQgh84s0i7VGbCH8HvP0CRxCoKj0jHtWkxZR5cJB3k5DWev9jOjrs/u9AVc1A3Fbg553+K
	sdG/Q58/Ssnx1wblQTIUaqMwtNxLIbcFE59YzxVzyx7ZlFs7GRY+KemKxwH3sUMfn5x4A1
	gshKjhV1tHarY3saWzVacKqCdtUtelgihy0usulV8j1jn3DQpBsROmY3FXF/zICkepXbpR
	1KwrUG+davKPiHrKME7+lHowuUhYtX+TyKxyd+vD2Xxe3Bv0+wJ6grd+ofw7GwbRZmUS/E
	aBg/gHla8DuQCWOlo2ik0uUE79X5n+wB37ArY/mXkx6jO0HgYpFgl01+34jnhw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 05 Jan 2026 14:08:07 +0100
Subject: [PATCH net-next 8/9] net: dsa: microchip: Use regs[] to access
 REG_PTP_MSG_CONF1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-ksz-rework-v1-8-a68df7f57375@bootlin.com>
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

Accesses to the PTP_MSG_CONF1 register are done through a hardcoded
address which doesn't match with the KSZ8463's register layout.

Add a new entry for the PTP_MSG_CONF1 register in the regs[] tables.
Use the regs[] table to retrieve the PTP_MSG_CONF1 register address
when accessing it.
Remove the macro defining the address to prevent further use.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c  |  2 ++
 drivers/net/dsa/microchip/ksz_common.h  |  1 +
 drivers/net/dsa/microchip/ksz_ptp.c     | 11 +++++++----
 drivers/net/dsa/microchip/ksz_ptp_reg.h |  3 +--
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index cbd918c0add30da17ea6ebe44ff44b866fcf2a1f..e5fa1f5fc09b37c1a9d907175f8cd2cd60aee180 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -574,6 +574,7 @@ static const u16 ksz8463_regs[] = {
 	[PTP_RTC_SEC]			= 0x0608,
 	[PTP_RTC_SUB_NANOSEC]		= 0x060C,
 	[PTP_SUBNANOSEC_RATE]		= 0x0610,
+	[PTP_MSG_CONF1]			= 0x0620,
 };
 
 static const u32 ksz8463_masks[] = {
@@ -813,6 +814,7 @@ static const u16 ksz9477_regs[] = {
 	[PTP_RTC_NANOSEC]		= 0x0504,
 	[PTP_RTC_SEC]			= 0x0508,
 	[PTP_SUBNANOSEC_RATE]		= 0x050C,
+	[PTP_MSG_CONF1]			= 0x0514,
 };
 
 static const u32 ksz9477_masks[] = {
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 16a7600789e3233dab1e1ed5d4599b875aa57aa1..929aff4c55de5254defdc1afb52b224b3898233b 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -276,6 +276,7 @@ enum ksz_regs {
 	PTP_RTC_SEC,
 	PTP_RTC_SUB_NANOSEC,
 	PTP_SUBNANOSEC_RATE,
+	PTP_MSG_CONF1,
 };
 
 enum ksz_masks {
diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 538162e3e4569483c85c710182cb3918a8713d74..b3fff0643ea7a63aec924ec1cd9b451ecfeeab3d 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -263,6 +263,7 @@ static int ksz_ptp_enable_mode(struct ksz_device *dev)
 {
 	struct ksz_tagger_data *tagger_data = ksz_tagger_data(dev->ds);
 	struct ksz_ptp_data *ptp_data = &dev->ptp_data;
+	const u16 *regs = dev->info->regs;
 	struct ksz_port *prt;
 	struct dsa_port *dp;
 	bool tag_en = false;
@@ -283,7 +284,7 @@ static int ksz_ptp_enable_mode(struct ksz_device *dev)
 
 	tagger_data->hwtstamp_set_state(dev->ds, tag_en);
 
-	return ksz_rmw16(dev, REG_PTP_MSG_CONF1, PTP_ENABLE,
+	return ksz_rmw16(dev, regs[PTP_MSG_CONF1], PTP_ENABLE,
 			 tag_en ? PTP_ENABLE : 0);
 }
 
@@ -335,6 +336,7 @@ static int ksz_set_hwtstamp_config(struct ksz_device *dev,
 				   struct ksz_port *prt,
 				   struct kernel_hwtstamp_config *config)
 {
+	const u16 *regs = dev->info->regs;
 	int ret;
 
 	if (config->flags)
@@ -353,7 +355,7 @@ static int ksz_set_hwtstamp_config(struct ksz_device *dev,
 		prt->ptpmsg_irq[KSZ_PDRES_MSG].ts_en = false;
 		prt->hwts_tx_en = true;
 
-		ret = ksz_rmw16(dev, REG_PTP_MSG_CONF1, PTP_1STEP, PTP_1STEP);
+		ret = ksz_rmw16(dev, regs[PTP_MSG_CONF1], PTP_1STEP, PTP_1STEP);
 		if (ret)
 			return ret;
 
@@ -367,7 +369,7 @@ static int ksz_set_hwtstamp_config(struct ksz_device *dev,
 		prt->ptpmsg_irq[KSZ_PDRES_MSG].ts_en = true;
 		prt->hwts_tx_en = true;
 
-		ret = ksz_rmw16(dev, REG_PTP_MSG_CONF1, PTP_1STEP, 0);
+		ret = ksz_rmw16(dev, regs[PTP_MSG_CONF1], PTP_1STEP, 0);
 		if (ret)
 			return ret;
 
@@ -902,6 +904,7 @@ static int ksz_ptp_start_clock(struct ksz_device *dev)
 int ksz_ptp_clock_register(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
+	const u16 *regs = dev->info->regs;
 	struct ksz_ptp_data *ptp_data;
 	int ret;
 	u8 i;
@@ -941,7 +944,7 @@ int ksz_ptp_clock_register(struct dsa_switch *ds)
 	/* Currently only P2P mode is supported. When 802_1AS bit is set, it
 	 * forwards all PTP packets to host port and none to other ports.
 	 */
-	ret = ksz_rmw16(dev, REG_PTP_MSG_CONF1, PTP_TC_P2P | PTP_802_1AS,
+	ret = ksz_rmw16(dev, regs[PTP_MSG_CONF1], PTP_TC_P2P | PTP_802_1AS,
 			PTP_TC_P2P | PTP_802_1AS);
 	if (ret)
 		return ret;
diff --git a/drivers/net/dsa/microchip/ksz_ptp_reg.h b/drivers/net/dsa/microchip/ksz_ptp_reg.h
index 1e823b1a19daa480cccdc0367b436a0940e85093..eab9aecb7fa8a50323de4140695b2004d1beab8c 100644
--- a/drivers/net/dsa/microchip/ksz_ptp_reg.h
+++ b/drivers/net/dsa/microchip/ksz_ptp_reg.h
@@ -39,8 +39,7 @@
 #define REG_PTP_RATE_DURATION_H		0x0510
 #define REG_PTP_RATE_DURATION_L		0x0512
 
-#define REG_PTP_MSG_CONF1		0x0514
-
+/* REG_PTP_MSG_CONF1 */
 #define PTP_802_1AS			BIT(7)
 #define PTP_ENABLE			BIT(6)
 #define PTP_ETH_ENABLE			BIT(5)

-- 
2.52.0


