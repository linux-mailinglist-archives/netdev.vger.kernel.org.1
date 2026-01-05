Return-Path: <netdev+bounces-247049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 311E6CF3C1D
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 14:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABF6F311C028
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 13:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7DF2417C3;
	Mon,  5 Jan 2026 13:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bGHdgN8j"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B72223328
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767618509; cv=none; b=CGQynCj5EJnJeWlhSN9cvFS2AAxMN6dP9p3M34zUg14gV6uNAm5NuJty4P+4XerWbU5uYzN6R33SX5ehog9j/hx5yuJcPEgNjXa0reeZ7MXzXqrESyxYL3Y9qOD8eVHTeEoaJGkXyD+SDQO2980Bs42IY+xgOqx8p1HHeA2XLCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767618509; c=relaxed/simple;
	bh=34BAacbaXCRPTlIufrTUReA/4diDnwLT3uTFDTsh6Pc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IkICZwy7HQnlJrrUKGz0ZJoGY4CObd5vdMuIw4fHJgOWVLFx4MeQBqmtvzsvGGbibWwEgq4wFFqmulKTRy3KRXh8jy2dJbGd/AbOb716H6svv5tn1Pl8LTbVpXlYw3jRbhLYJT6U0HGWWgSuUgvN6AA505C0aBeIJk8Pyyoc+m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bGHdgN8j; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 270811A2662;
	Mon,  5 Jan 2026 13:08:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EE83A60726;
	Mon,  5 Jan 2026 13:08:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C4673103C852D;
	Mon,  5 Jan 2026 14:08:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767618505; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kIZGUOgrlFFSG+MXDelX5nuX7CrC7Vxiyp0xlM4B0vU=;
	b=bGHdgN8j7EJjPSIx4ITVX6ZVFhLUd/vSWynZVkvkdFiIp9OFm1mRPMblqk3CDEdnp6DISL
	JZui9hKzy5hLRZDrVnKmq223SkukmlnWeXs/Sbyv7n2EJySr+lG7Vy+sxQRvwwULTFHZPh
	PVuG6zBdinWFvF3lQnFzMvLgmAUYNJaVlpXazsQ2FS7uBWtDQgB8o0jRmTF8ctLaeyW+hx
	kf3gtHP4TFX6o7j2zvq6weA7m3mKWOeyMM55BTg2DQrsC9EprM0rSGYvOBpb5FfVYNlr4c
	485a/gFCrnqzJURi7y71mB6tGD243g9lcJbA5OtUdHTRqHtwhQiz9sh+BtdDlQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 05 Jan 2026 14:08:02 +0100
Subject: [PATCH net-next 3/9] net: dsa: microchip: Use regs[] to access
 REG_PTP_CLK_CTRL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-ksz-rework-v1-3-a68df7f57375@bootlin.com>
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

Accesses to the PTP_CLK_CTRL register are done through a hardcoded
address which doesn't match with the KSZ8463's register layout.

Add a new entry for the PTP_CLK_CTRL register in the regs[] tables.
Use the regs[] table to retrieve the PTP_CLK_CTRL register address
when accessing it.
Remove the macro defining the address to prevent further use.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c  |  2 ++
 drivers/net/dsa/microchip/ksz_common.h  |  1 +
 drivers/net/dsa/microchip/ksz_ptp.c     | 19 ++++++++++++-------
 drivers/net/dsa/microchip/ksz_ptp_reg.h |  3 +--
 4 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index fa392f952f9441cfbeb51498fc9411340b58747a..d7f407370c1cc59402d444e27ebe44e7a600b441 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -569,6 +569,7 @@ static const u16 ksz8463_regs[] = {
 	[S_START_CTRL]			= 0x01,
 	[S_BROADCAST_CTRL]		= 0x06,
 	[S_MULTICAST_CTRL]		= 0x04,
+	[PTP_CLK_CTRL]			= 0x0600,
 };
 
 static const u32 ksz8463_masks[] = {
@@ -803,6 +804,7 @@ static const u16 ksz9477_regs[] = {
 	[REG_SW_PME_CTRL]		= 0x0006,
 	[REG_PORT_PME_STATUS]		= 0x0013,
 	[REG_PORT_PME_CTRL]		= 0x0017,
+	[PTP_CLK_CTRL]			= 0x0500,
 };
 
 static const u32 ksz9477_masks[] = {
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 3add190e686260bb1807ba03b4b153abeead223e..8033cb9d84838705389e6ed52a5a54aaa8b49497 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -271,6 +271,7 @@ enum ksz_regs {
 	REG_SW_PME_CTRL,
 	REG_PORT_PME_STATUS,
 	REG_PORT_PME_CTRL,
+	PTP_CLK_CTRL,
 };
 
 enum ksz_masks {
diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 0ac2865ba9c000fa58b974647c9c88287164cd1c..68553d9f1e0e3a3cd6319d73b7f9bf6ee2fce7ce 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -585,13 +585,14 @@ void ksz_port_deferred_xmit(struct kthread_work *work)
 
 static int _ksz_ptp_gettime(struct ksz_device *dev, struct timespec64 *ts)
 {
+	const u16 *regs = dev->info->regs;
 	u32 nanoseconds;
 	u32 seconds;
 	u8 phase;
 	int ret;
 
 	/* Copy current PTP clock into shadow registers and read */
-	ret = ksz_rmw16(dev, REG_PTP_CLK_CTRL, PTP_READ_TIME, PTP_READ_TIME);
+	ret = ksz_rmw16(dev, regs[PTP_CLK_CTRL], PTP_READ_TIME, PTP_READ_TIME);
 	if (ret)
 		return ret;
 
@@ -676,6 +677,7 @@ static int ksz_ptp_settime(struct ptp_clock_info *ptp,
 {
 	struct ksz_ptp_data *ptp_data = ptp_caps_to_data(ptp);
 	struct ksz_device *dev = ptp_data_to_ksz_dev(ptp_data);
+	const u16 *regs = dev->info->regs;
 	int ret;
 
 	mutex_lock(&ptp_data->lock);
@@ -693,7 +695,7 @@ static int ksz_ptp_settime(struct ptp_clock_info *ptp,
 	if (ret)
 		goto unlock;
 
-	ret = ksz_rmw16(dev, REG_PTP_CLK_CTRL, PTP_LOAD_TIME, PTP_LOAD_TIME);
+	ret = ksz_rmw16(dev, regs[PTP_CLK_CTRL], PTP_LOAD_TIME, PTP_LOAD_TIME);
 	if (ret)
 		goto unlock;
 
@@ -723,6 +725,7 @@ static int ksz_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 {
 	struct ksz_ptp_data *ptp_data = ptp_caps_to_data(ptp);
 	struct ksz_device *dev = ptp_data_to_ksz_dev(ptp_data);
+	const u16 *regs = dev->info->regs;
 	u64 base, adj;
 	bool negative;
 	u32 data32;
@@ -743,12 +746,12 @@ static int ksz_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 		if (ret)
 			goto unlock;
 
-		ret = ksz_rmw16(dev, REG_PTP_CLK_CTRL, PTP_CLK_ADJ_ENABLE,
+		ret = ksz_rmw16(dev, regs[PTP_CLK_CTRL], PTP_CLK_ADJ_ENABLE,
 				PTP_CLK_ADJ_ENABLE);
 		if (ret)
 			goto unlock;
 	} else {
-		ret = ksz_rmw16(dev, REG_PTP_CLK_CTRL, PTP_CLK_ADJ_ENABLE, 0);
+		ret = ksz_rmw16(dev, regs[PTP_CLK_CTRL], PTP_CLK_ADJ_ENABLE, 0);
 		if (ret)
 			goto unlock;
 	}
@@ -763,6 +766,7 @@ static int ksz_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 	struct ksz_ptp_data *ptp_data = ptp_caps_to_data(ptp);
 	struct ksz_device *dev = ptp_data_to_ksz_dev(ptp_data);
 	struct timespec64 delta64 = ns_to_timespec64(delta);
+	const u16 *regs = dev->info->regs;
 	s32 sec, nsec;
 	u16 data16;
 	int ret;
@@ -782,7 +786,7 @@ static int ksz_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 	if (ret)
 		goto unlock;
 
-	ret = ksz_read16(dev, REG_PTP_CLK_CTRL, &data16);
+	ret = ksz_read16(dev, regs[PTP_CLK_CTRL], &data16);
 	if (ret)
 		goto unlock;
 
@@ -794,7 +798,7 @@ static int ksz_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 	else
 		data16 |= PTP_STEP_DIR;
 
-	ret = ksz_write16(dev, REG_PTP_CLK_CTRL, data16);
+	ret = ksz_write16(dev, regs[PTP_CLK_CTRL], data16);
 	if (ret)
 		goto unlock;
 
@@ -882,9 +886,10 @@ static long ksz_ptp_do_aux_work(struct ptp_clock_info *ptp)
 static int ksz_ptp_start_clock(struct ksz_device *dev)
 {
 	struct ksz_ptp_data *ptp_data = &dev->ptp_data;
+	const u16 *regs = dev->info->regs;
 	int ret;
 
-	ret = ksz_rmw16(dev, REG_PTP_CLK_CTRL, PTP_CLK_ENABLE, PTP_CLK_ENABLE);
+	ret = ksz_rmw16(dev, regs[PTP_CLK_CTRL], PTP_CLK_ENABLE, PTP_CLK_ENABLE);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/dsa/microchip/ksz_ptp_reg.h b/drivers/net/dsa/microchip/ksz_ptp_reg.h
index d71e85510cda56b6ddfefd4ed65564dfb4be7c88..bf8526390c2a2face12406c575a1ea3e4d42e3e6 100644
--- a/drivers/net/dsa/microchip/ksz_ptp_reg.h
+++ b/drivers/net/dsa/microchip/ksz_ptp_reg.h
@@ -15,8 +15,7 @@
 #define LED_SRC_PTP_GPIO_2		BIT(2)
 
 /* 5 - PTP Clock */
-#define REG_PTP_CLK_CTRL		0x0500
-
+/* REG_PTP_CLK_CTRL */
 #define PTP_STEP_ADJ			BIT(6)
 #define PTP_STEP_DIR			BIT(5)
 #define PTP_READ_TIME			BIT(4)

-- 
2.52.0


