Return-Path: <netdev+bounces-38387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2417BAAF0
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 21:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 18DC62828EF
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 19:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F08941E42;
	Thu,  5 Oct 2023 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6590B41AB6
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 19:58:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C43F9
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 12:58:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qoUUH-0004kE-1f
	for netdev@vger.kernel.org; Thu, 05 Oct 2023 21:58:21 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1qoUUE-00BLHW-0k
	for netdev@vger.kernel.org; Thu, 05 Oct 2023 21:58:18 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id A245422FFDC
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 19:58:17 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 644C922FF80;
	Thu,  5 Oct 2023 19:58:15 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 270f363a;
	Thu, 5 Oct 2023 19:58:14 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 12/37] can: at91_can: use a consistent indention
Date: Thu,  5 Oct 2023 21:57:47 +0200
Message-Id: <20231005195812.549776-13-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231005195812.549776-1-mkl@pengutronix.de>
References: <20231005195812.549776-1-mkl@pengutronix.de>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Convert the driver to use a consistent indention of one space after
defines and in enums. That makes it easier to add new defines, which
will be done in the coming patches.

Link: https://lore.kernel.org/all/20231005-at91_can-rx_offload-v2-2-9987d53600e0@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 124 ++++++++++++++++++-------------------
 1 file changed, 62 insertions(+), 62 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 4621266851ed..367ccf109652 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -25,89 +25,89 @@
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
 
-#define AT91_MB_MASK(i)		((1 << (i)) - 1)
+#define AT91_MB_MASK(i) ((1 << (i)) - 1)
 
 /* Common registers */
 enum at91_reg {
-	AT91_MR		= 0x000,
-	AT91_IER	= 0x004,
-	AT91_IDR	= 0x008,
-	AT91_IMR	= 0x00C,
-	AT91_SR		= 0x010,
-	AT91_BR		= 0x014,
-	AT91_TIM	= 0x018,
-	AT91_TIMESTP	= 0x01C,
-	AT91_ECR	= 0x020,
-	AT91_TCR	= 0x024,
-	AT91_ACR	= 0x028,
+	AT91_MR = 0x000,
+	AT91_IER = 0x004,
+	AT91_IDR = 0x008,
+	AT91_IMR = 0x00C,
+	AT91_SR = 0x010,
+	AT91_BR = 0x014,
+	AT91_TIM = 0x018,
+	AT91_TIMESTP = 0x01C,
+	AT91_ECR = 0x020,
+	AT91_TCR = 0x024,
+	AT91_ACR = 0x028,
 };
 
 /* Mailbox registers (0 <= i <= 15) */
-#define AT91_MMR(i)		((enum at91_reg)(0x200 + ((i) * 0x20)))
-#define AT91_MAM(i)		((enum at91_reg)(0x204 + ((i) * 0x20)))
-#define AT91_MID(i)		((enum at91_reg)(0x208 + ((i) * 0x20)))
-#define AT91_MFID(i)		((enum at91_reg)(0x20C + ((i) * 0x20)))
-#define AT91_MSR(i)		((enum at91_reg)(0x210 + ((i) * 0x20)))
-#define AT91_MDL(i)		((enum at91_reg)(0x214 + ((i) * 0x20)))
-#define AT91_MDH(i)		((enum at91_reg)(0x218 + ((i) * 0x20)))
-#define AT91_MCR(i)		((enum at91_reg)(0x21C + ((i) * 0x20)))
+#define AT91_MMR(i) ((enum at91_reg)(0x200 + ((i) * 0x20)))
+#define AT91_MAM(i) ((enum at91_reg)(0x204 + ((i) * 0x20)))
+#define AT91_MID(i) ((enum at91_reg)(0x208 + ((i) * 0x20)))
+#define AT91_MFID(i) ((enum at91_reg)(0x20C + ((i) * 0x20)))
+#define AT91_MSR(i) ((enum at91_reg)(0x210 + ((i) * 0x20)))
+#define AT91_MDL(i) ((enum at91_reg)(0x214 + ((i) * 0x20)))
+#define AT91_MDH(i) ((enum at91_reg)(0x218 + ((i) * 0x20)))
+#define AT91_MCR(i) ((enum at91_reg)(0x21C + ((i) * 0x20)))
 
 /* Register bits */
-#define AT91_MR_CANEN		BIT(0)
-#define AT91_MR_LPM		BIT(1)
-#define AT91_MR_ABM		BIT(2)
-#define AT91_MR_OVL		BIT(3)
-#define AT91_MR_TEOF		BIT(4)
-#define AT91_MR_TTM		BIT(5)
-#define AT91_MR_TIMFRZ		BIT(6)
-#define AT91_MR_DRPT		BIT(7)
+#define AT91_MR_CANEN BIT(0)
+#define AT91_MR_LPM BIT(1)
+#define AT91_MR_ABM BIT(2)
+#define AT91_MR_OVL BIT(3)
+#define AT91_MR_TEOF BIT(4)
+#define AT91_MR_TTM BIT(5)
+#define AT91_MR_TIMFRZ BIT(6)
+#define AT91_MR_DRPT BIT(7)
 
-#define AT91_SR_RBSY		BIT(29)
+#define AT91_SR_RBSY BIT(29)
 
-#define AT91_MMR_PRIO_SHIFT	(16)
+#define AT91_MMR_PRIO_SHIFT (16)
 
-#define AT91_MID_MIDE		BIT(29)
+#define AT91_MID_MIDE BIT(29)
 
-#define AT91_MSR_MRTR		BIT(20)
-#define AT91_MSR_MABT		BIT(22)
-#define AT91_MSR_MRDY		BIT(23)
-#define AT91_MSR_MMI		BIT(24)
+#define AT91_MSR_MRTR BIT(20)
+#define AT91_MSR_MABT BIT(22)
+#define AT91_MSR_MRDY BIT(23)
+#define AT91_MSR_MMI BIT(24)
 
-#define AT91_MCR_MRTR		BIT(20)
-#define AT91_MCR_MTCR		BIT(23)
+#define AT91_MCR_MRTR BIT(20)
+#define AT91_MCR_MTCR BIT(23)
 
 /* Mailbox Modes */
 enum at91_mb_mode {
-	AT91_MB_MODE_DISABLED	= 0,
-	AT91_MB_MODE_RX		= 1,
-	AT91_MB_MODE_RX_OVRWR	= 2,
-	AT91_MB_MODE_TX		= 3,
-	AT91_MB_MODE_CONSUMER	= 4,
-	AT91_MB_MODE_PRODUCER	= 5,
+	AT91_MB_MODE_DISABLED = 0,
+	AT91_MB_MODE_RX = 1,
+	AT91_MB_MODE_RX_OVRWR = 2,
+	AT91_MB_MODE_TX = 3,
+	AT91_MB_MODE_CONSUMER = 4,
+	AT91_MB_MODE_PRODUCER = 5,
 };
 
 /* Interrupt mask bits */
-#define AT91_IRQ_ERRA		BIT(16)
-#define AT91_IRQ_WARN		BIT(17)
-#define AT91_IRQ_ERRP		BIT(18)
-#define AT91_IRQ_BOFF		BIT(19)
-#define AT91_IRQ_SLEEP		BIT(20)
-#define AT91_IRQ_WAKEUP		BIT(21)
-#define AT91_IRQ_TOVF		BIT(22)
-#define AT91_IRQ_TSTP		BIT(23)
-#define AT91_IRQ_CERR		BIT(24)
-#define AT91_IRQ_SERR		BIT(25)
-#define AT91_IRQ_AERR		BIT(26)
-#define AT91_IRQ_FERR		BIT(27)
-#define AT91_IRQ_BERR		BIT(28)
+#define AT91_IRQ_ERRA BIT(16)
+#define AT91_IRQ_WARN BIT(17)
+#define AT91_IRQ_ERRP BIT(18)
+#define AT91_IRQ_BOFF BIT(19)
+#define AT91_IRQ_SLEEP BIT(20)
+#define AT91_IRQ_WAKEUP BIT(21)
+#define AT91_IRQ_TOVF BIT(22)
+#define AT91_IRQ_TSTP BIT(23)
+#define AT91_IRQ_CERR BIT(24)
+#define AT91_IRQ_SERR BIT(25)
+#define AT91_IRQ_AERR BIT(26)
+#define AT91_IRQ_FERR BIT(27)
+#define AT91_IRQ_BERR BIT(28)
 
-#define AT91_IRQ_ERR_ALL	(0x1fff0000)
-#define AT91_IRQ_ERR_FRAME	(AT91_IRQ_CERR | AT91_IRQ_SERR | \
-				 AT91_IRQ_AERR | AT91_IRQ_FERR | AT91_IRQ_BERR)
-#define AT91_IRQ_ERR_LINE	(AT91_IRQ_ERRA | AT91_IRQ_WARN | \
-				 AT91_IRQ_ERRP | AT91_IRQ_BOFF)
+#define AT91_IRQ_ERR_ALL (0x1fff0000)
+#define AT91_IRQ_ERR_FRAME (AT91_IRQ_CERR | AT91_IRQ_SERR | \
+			    AT91_IRQ_AERR | AT91_IRQ_FERR | AT91_IRQ_BERR)
+#define AT91_IRQ_ERR_LINE (AT91_IRQ_ERRA | AT91_IRQ_WARN | \
+			   AT91_IRQ_ERRP | AT91_IRQ_BOFF)
 
-#define AT91_IRQ_ALL		(0x1fffffff)
+#define AT91_IRQ_ALL (0x1fffffff)
 
 enum at91_devtype {
 	AT91_DEVTYPE_SAM9263,
-- 
2.40.1



