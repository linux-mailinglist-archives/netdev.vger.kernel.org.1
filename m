Return-Path: <netdev+bounces-157127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 290F1A08F57
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 12:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781FB1682B4
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 11:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E71E20CCF0;
	Fri, 10 Jan 2025 11:27:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE1820CCDF
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508448; cv=none; b=GKXSa6l+TpNb0dEIPhIAO/HE29N0Kw4chW2i2Zx/dyqal3XEOsjnrFehGjeDCIO5QH7TR2uuiC2VDSK2QpPoM4N+a2mn60QoyH81v/BnaoBnieFpumZ/3k4yd6QZQX8HxyVmYoXcpYbMd+qzncCgt7qmmcryzuclTNIYC/oVpQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508448; c=relaxed/simple;
	bh=eDTaj2cSpeELI5MytHZlE7kGIDVwMM4WC+7I4W4yEUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZtChAYzttLYkLJaUg2e3k9dLoJfU4nWL0CeHMnaM4N0gSlPqqaJj24wAEMt05LGF35ptmd+6F3BFwfwvmM7mk6MyYkoRdSZoe9q4Q+pjnU+kZxP6iCy874IhNxU3wDgKK+XpjAb/xmwnnt8P3F7hsHhdcVFYaFbca4H/B3FyDT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWDAg-00053o-8W
	for netdev@vger.kernel.org; Fri, 10 Jan 2025 12:27:22 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWDAc-0009ho-2z
	for netdev@vger.kernel.org;
	Fri, 10 Jan 2025 12:27:18 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 7C2863A4617
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 11:27:18 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 1A3FA3A45A1;
	Fri, 10 Jan 2025 11:27:15 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 103f7989;
	Fri, 10 Jan 2025 11:27:14 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Sean Nyekjaer <sean@geanix.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 11/18] can: m_can: add deinit callback
Date: Fri, 10 Jan 2025 12:04:19 +0100
Message-ID: <20250110112712.3214173-12-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250110112712.3214173-1-mkl@pengutronix.de>
References: <20250110112712.3214173-1-mkl@pengutronix.de>
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

From: Sean Nyekjaer <sean@geanix.com>

This is added in preparation for calling standby mode in the tcan4x5x
driver or other users of m_can.
For the tcan4x5x; If Vsup 12V, standby mode will save 7-8mA, when the
interface is down.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Link: https://patch.msgid.link/20241122-tcan-standby-v3-1-90bafaf5eccd@geanix.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 7 +++++++
 drivers/net/can/m_can/m_can.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 16e9e7d7527d..e31ce973892a 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1756,6 +1756,13 @@ static void m_can_stop(struct net_device *dev)
 
 	/* set the state as STOPPED */
 	cdev->can.state = CAN_STATE_STOPPED;
+
+	if (cdev->ops->deinit) {
+		ret = cdev->ops->deinit(cdev);
+		if (ret)
+			netdev_err(dev, "failed to deinitialize: %pe\n",
+				   ERR_PTR(ret));
+	}
 }
 
 static int m_can_close(struct net_device *dev)
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 92b2bd8628e6..6206535341a2 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -68,6 +68,7 @@ struct m_can_ops {
 	int (*write_fifo)(struct m_can_classdev *cdev, int addr_offset,
 			  const void *val, size_t val_count);
 	int (*init)(struct m_can_classdev *cdev);
+	int (*deinit)(struct m_can_classdev *cdev);
 };
 
 struct m_can_tx_op {
-- 
2.45.2



