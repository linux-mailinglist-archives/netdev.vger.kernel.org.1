Return-Path: <netdev+bounces-226339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9268B9F2F1
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 14:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16EA54E6E23
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 12:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B9A3126B8;
	Thu, 25 Sep 2025 12:14:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6232FD1B3
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802454; cv=none; b=nJ3aooaw3cFbfngdqnMnQiUwMf9kUnOsf+fSyZ53NxPlf8ks4+PifGkqXH/v4KVdIt+vGWp7r66n4O4ZT1sa8WbwKzy6JmRyAPkmZTnWU3KS/H+GcviiZd2dz1pXQgh/LTKBnTIjrjMrjHStTmqLl7jT5bUigJszC6WI3cvaIfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802454; c=relaxed/simple;
	bh=ZsRn1kYwmWIpw0KCPyxiPnVwumVZWhRuYbI8+uIPMcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADWKlEUutOQ+JitpttHq6LEEHXFe/y/KrXGMMhFhpGw2GT5teiXV+qNSfD4dj5vjAuB7nL3C1pEgn+4Hz2nFtRv4WdNCVQ2Vudi1g2BJt3kQktHvai5kZiXbHryQcm2pCATdWcbqwJwA4ePeP06xZCYNL27BSeuBPq/CxOXyRt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqw-0000YJ-DC; Thu, 25 Sep 2025 14:13:38 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqv-000Pwi-07;
	Thu, 25 Sep 2025 14:13:37 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C6617479989;
	Thu, 25 Sep 2025 12:13:36 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 29/48] can: dev: move struct data_bittiming_params to linux/can/bittiming.h
Date: Thu, 25 Sep 2025 14:08:06 +0200
Message-ID: <20250925121332.848157-30-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925121332.848157-1-mkl@pengutronix.de>
References: <20250925121332.848157-1-mkl@pengutronix.de>
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

From: Vincent Mailhol <mailhol@kernel.org>

In commit b803c4a4f788 ("can: dev: add struct data_bittiming_params to
group FD parameters"), struct data_bittiming_params was put into
linux/can/dev.h.

This structure being a collection of bittiming parameters, on second
thought, bittiming.h is actually a better location. This way, users of
struct data_bittiming_params will not have to forcefully include
linux/can/dev.h thus removing some complexity and reducing the risk of
circular dependencies in headers.

Move struct data_bittiming_params from linux/can/dev.h to
linux/can/bittiming.h.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20250923-canxl-netlink-prep-v4-1-e720d28f66fe@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/linux/can/bittiming.h | 11 +++++++++++
 include/linux/can/dev.h       | 11 -----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index 5dfdbb63b1d5..6572ec1712ca 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -114,6 +114,17 @@ struct can_tdc_const {
 	u32 tdcf_max;
 };
 
+struct data_bittiming_params {
+	const struct can_bittiming_const *data_bittiming_const;
+	struct can_bittiming data_bittiming;
+	const struct can_tdc_const *tdc_const;
+	struct can_tdc tdc;
+	const u32 *data_bitrate_const;
+	unsigned int data_bitrate_const_cnt;
+	int (*do_set_data_bittiming)(struct net_device *dev);
+	int (*do_get_auto_tdcv)(const struct net_device *dev, u32 *tdcv);
+};
+
 #ifdef CONFIG_CAN_CALC_BITTIMING
 int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 		       const struct can_bittiming_const *btc, struct netlink_ext_ack *extack);
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 3354f70ed2c6..c2fe956ab776 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -38,17 +38,6 @@ enum can_termination_gpio {
 	CAN_TERMINATION_GPIO_MAX,
 };
 
-struct data_bittiming_params {
-	const struct can_bittiming_const *data_bittiming_const;
-	struct can_bittiming data_bittiming;
-	const struct can_tdc_const *tdc_const;
-	struct can_tdc tdc;
-	const u32 *data_bitrate_const;
-	unsigned int data_bitrate_const_cnt;
-	int (*do_set_data_bittiming)(struct net_device *dev);
-	int (*do_get_auto_tdcv)(const struct net_device *dev, u32 *tdcv);
-};
-
 /*
  * CAN common private data
  */
-- 
2.51.0


