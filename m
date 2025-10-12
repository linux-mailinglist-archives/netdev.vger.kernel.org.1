Return-Path: <netdev+bounces-228624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C00CCBD03D3
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 16:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15ECD4E9DC9
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 14:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285BB288510;
	Sun, 12 Oct 2025 14:28:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534C82874EA
	for <netdev@vger.kernel.org>; Sun, 12 Oct 2025 14:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760279335; cv=none; b=oUw3uxAUJKpHtOvH9KRnRXVc22e6XZMlLXY+5V2AtRUah1VHG9sVuPrY5jDo9TyOFVcdvwGYLFF2YeL3L2xE0sL3N5sMtPR59boz375I/mx/ZsYvUZHmJYeaVqCcIPboo7vj45w+ErsuXT4DLo/HMau8se3H86lB2Tqd86safp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760279335; c=relaxed/simple;
	bh=GYgaT837COzfq0a2uDjVt7G+BVNrg+bGNkXg4+DLpZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9hj0+AlBxmazVrUIV2OYH2j+W059NrypCux2Xtwv5YP9hf1rG5A8QN2e+SBa4lojhY6jGSsNcuadFA3155NKSBdzCqKqY/O4o8FWNIiMP2ywzPnIp9uQDWGPtPK1CeAMtQcUaPadjJ80+msKb5ggrx1i4uKx8I8n/4HhxusxbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v7x3w-00044o-FI; Sun, 12 Oct 2025 16:28:40 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v7x3v-003EUv-2H;
	Sun, 12 Oct 2025 16:28:39 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6DE52484064;
	Sun, 12 Oct 2025 14:28:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH net 7/9] can: m_can: replace Dong Aisheng's old email address
Date: Sun, 12 Oct 2025 16:20:51 +0200
Message-ID: <20251012142836.285370-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012142836.285370-1-mkl@pengutronix.de>
References: <20251012142836.285370-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Dong Aisheng's old Freescale email is not valid anymore and bounces,
replace it by the new NXP one.

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
Link: https://patch.msgid.link/20251009-m_can-update-email-address-v1-1-30a268587f69@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .mailmap                               | 1 +
 drivers/net/can/m_can/m_can.c          | 4 ++--
 drivers/net/can/m_can/m_can_platform.c | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/.mailmap b/.mailmap
index d30f9363a4c9..8160c62f11e9 100644
--- a/.mailmap
+++ b/.mailmap
@@ -227,6 +227,7 @@ Dmitry Safonov <0x7f454c46@gmail.com> <dima@arista.com>
 Dmitry Safonov <0x7f454c46@gmail.com> <d.safonov@partner.samsung.com>
 Dmitry Safonov <0x7f454c46@gmail.com> <dsafonov@virtuozzo.com>
 Domen Puncer <domen@coderock.org>
+Dong Aisheng <aisheng.dong@nxp.com> <b29396@freescale.com>
 Douglas Gilbert <dougg@torque.net>
 Drew Fustini <fustini@kernel.org> <drew@pdp7.com>
 <duje@dujemihanovic.xyz> <duje.mihanovic@skole.hr>
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index f2576e577058..ad4f577c1ef7 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // CAN bus driver for Bosch M_CAN controller
 // Copyright (C) 2014 Freescale Semiconductor, Inc.
-//      Dong Aisheng <b29396@freescale.com>
+//      Dong Aisheng <aisheng.dong@nxp.com>
 // Copyright (C) 2018-19 Texas Instruments Incorporated - http://www.ti.com/
 
 /* Bosch M_CAN user manual can be obtained from:
@@ -2556,7 +2556,7 @@ int m_can_class_resume(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(m_can_class_resume);
 
-MODULE_AUTHOR("Dong Aisheng <b29396@freescale.com>");
+MODULE_AUTHOR("Dong Aisheng <aisheng.dong@nxp.com>");
 MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("CAN bus driver for Bosch M_CAN controller");
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index 057eaa7b8b4b..4a412add2b8d 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // IOMapped CAN bus driver for Bosch M_CAN controller
 // Copyright (C) 2014 Freescale Semiconductor, Inc.
-//	Dong Aisheng <b29396@freescale.com>
+//	Dong Aisheng <aisheng.dong@nxp.com>
 //
 // Copyright (C) 2018-19 Texas Instruments Incorporated - http://www.ti.com/
 
@@ -236,7 +236,7 @@ static struct platform_driver m_can_plat_driver = {
 
 module_platform_driver(m_can_plat_driver);
 
-MODULE_AUTHOR("Dong Aisheng <b29396@freescale.com>");
+MODULE_AUTHOR("Dong Aisheng <aisheng.dong@nxp.com>");
 MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("M_CAN driver for IO Mapped Bosch controllers");
-- 
2.51.0


