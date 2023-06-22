Return-Path: <netdev+bounces-12984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EDD7399E5
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 10:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B5C71C20B4A
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 08:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E20D1F191;
	Thu, 22 Jun 2023 08:27:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033E61F16C
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:27:54 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74612681
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:27:33 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qCFf1-00035a-7Z
	for netdev@vger.kernel.org; Thu, 22 Jun 2023 10:27:23 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 8A5551DF432
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:27:06 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 339B11DF3A0;
	Thu, 22 Jun 2023 08:27:04 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 62aed880;
	Thu, 22 Jun 2023 08:27:01 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 23/33] can: kvaser_pciefd: Define unsigned constants with type suffix 'U'
Date: Thu, 22 Jun 2023 10:26:48 +0200
Message-Id: <20230622082658.571150-24-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622082658.571150-1-mkl@pengutronix.de>
References: <20230622082658.571150-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jimmy Assarsson <extja@kvaser.com>

Define unsigned constants with type suffix 'U'

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/20230529134248.752036-6-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/kvaser_pciefd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 88bad2c2b641..abb556fb5cb6 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -25,12 +25,12 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 
 #define KVASER_PCIEFD_WAIT_TIMEOUT msecs_to_jiffies(1000)
 #define KVASER_PCIEFD_BEC_POLL_FREQ (jiffies + msecs_to_jiffies(200))
-#define KVASER_PCIEFD_MAX_ERR_REP 256
-#define KVASER_PCIEFD_CAN_TX_MAX_COUNT 17
-#define KVASER_PCIEFD_MAX_CAN_CHANNELS 4
-#define KVASER_PCIEFD_DMA_COUNT 2
+#define KVASER_PCIEFD_MAX_ERR_REP 256U
+#define KVASER_PCIEFD_CAN_TX_MAX_COUNT 17U
+#define KVASER_PCIEFD_MAX_CAN_CHANNELS 4U
+#define KVASER_PCIEFD_DMA_COUNT 2U
 
-#define KVASER_PCIEFD_DMA_SIZE (4 * 1024)
+#define KVASER_PCIEFD_DMA_SIZE (4U * 1024U)
 #define KVASER_PCIEFD_64BIT_DMA_BIT BIT(0)
 
 #define KVASER_PCIEFD_VENDOR 0x1a07
-- 
2.40.1



