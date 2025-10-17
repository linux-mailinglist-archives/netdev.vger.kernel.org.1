Return-Path: <netdev+bounces-230506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9424EBE9BBE
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 17:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1184D747433
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 15:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB36E32E13C;
	Fri, 17 Oct 2025 15:08:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C4632E14A
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713720; cv=none; b=LebXUXPd0a+lsuaNgLutzC/cuVR6e6bNrTb6dY4ivaJYunSDVQgYJRz0dP4u8tInUDnNC9UTvukiNirgJBhwQ5SiDQciE/xi80zQSYLdkLySzCjWMHR7N+Ws/K7BsxR8z6Xx7O9yOVHwrBeXK27HwxpUwp5dfOUIjOJ5RcIQnPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713720; c=relaxed/simple;
	bh=nYaJvHpbGLuKJ5+CLiuvaLgt7AyJ1CPkeMz9DS9ghXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUN0K5BHW9m4OhyEf8u87PIHUoHoKy35f+ExbgSjAbL9kDpiEMAYHeA9fbe1W1O1EgTXJZNoMwPvrb+YJv4RxfDhjPJc/X0Sx4ASIpJ2sF2KqgpnnmwLsdfcxfmRDxLh241iRzeEtMrlNe+GnwAIpW/28PIBdjDX13zCgpmtHYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9m4E-0003NN-2R; Fri, 17 Oct 2025 17:08:30 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9m4D-00450j-2W;
	Fri, 17 Oct 2025 17:08:29 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 869224892B8;
	Fri, 17 Oct 2025 15:08:29 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 07/13] can: m_can: m_can_init_ram(): make static
Date: Fri, 17 Oct 2025 17:04:15 +0200
Message-ID: <20251017150819.1415685-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017150819.1415685-1-mkl@pengutronix.de>
References: <20251017150819.1415685-1-mkl@pengutronix.de>
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

Since commit eaacfeaca7ad ("can: m_can: Call the RAM init directly from
m_can_chip_config") m_can_init_ram() is not used outside of m_can.c.

Mark as static and remove the EXPORT_SYMBOL_GPL().

Link: https://patch.msgid.link/20251008-m_can-cleanups-v1-1-1784a18eaa84@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 43 +++++++++++++++++------------------
 drivers/net/can/m_can/m_can.h |  1 -
 2 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 8569596ae830..9f4002f3481e 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1380,6 +1380,27 @@ static const struct can_bittiming_const m_can_data_bittiming_const_31X = {
 	.brp_inc = 1,
 };
 
+static int m_can_init_ram(struct m_can_classdev *cdev)
+{
+	int end, i, start;
+	int err = 0;
+
+	/* initialize the entire Message RAM in use to avoid possible
+	 * ECC/parity checksum errors when reading an uninitialized buffer
+	 */
+	start = cdev->mcfg[MRAM_SIDF].off;
+	end = cdev->mcfg[MRAM_TXB].off +
+		cdev->mcfg[MRAM_TXB].num * TXB_ELEMENT_SIZE;
+
+	for (i = start; i < end; i += 4) {
+		err = m_can_fifo_write_no_off(cdev, i, 0x0);
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
 static int m_can_set_bittiming(struct net_device *dev)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
@@ -2374,28 +2395,6 @@ static void m_can_of_parse_mram(struct m_can_classdev *cdev,
 		cdev->mcfg[MRAM_TXB].off, cdev->mcfg[MRAM_TXB].num);
 }
 
-int m_can_init_ram(struct m_can_classdev *cdev)
-{
-	int end, i, start;
-	int err = 0;
-
-	/* initialize the entire Message RAM in use to avoid possible
-	 * ECC/parity checksum errors when reading an uninitialized buffer
-	 */
-	start = cdev->mcfg[MRAM_SIDF].off;
-	end = cdev->mcfg[MRAM_TXB].off +
-		cdev->mcfg[MRAM_TXB].num * TXB_ELEMENT_SIZE;
-
-	for (i = start; i < end; i += 4) {
-		err = m_can_fifo_write_no_off(cdev, i, 0x0);
-		if (err)
-			break;
-	}
-
-	return err;
-}
-EXPORT_SYMBOL_GPL(m_can_init_ram);
-
 int m_can_class_get_clocks(struct m_can_classdev *cdev)
 {
 	int ret = 0;
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index f2f89687bbd2..4743342b2fba 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -139,7 +139,6 @@ void m_can_class_free_dev(struct net_device *net);
 int m_can_class_register(struct m_can_classdev *cdev);
 void m_can_class_unregister(struct m_can_classdev *cdev);
 int m_can_class_get_clocks(struct m_can_classdev *cdev);
-int m_can_init_ram(struct m_can_classdev *priv);
 int m_can_check_mram_cfg(struct m_can_classdev *cdev, u32 mram_max_size);
 
 int m_can_class_suspend(struct device *dev);
-- 
2.51.0


