Return-Path: <netdev+bounces-12977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ABB7399D1
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 10:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264E628189B
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 08:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D803D1EA92;
	Thu, 22 Jun 2023 08:27:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFB61E52A
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:27:46 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268E91FC6
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:27:23 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qCFew-0002u8-2f
	for netdev@vger.kernel.org; Thu, 22 Jun 2023 10:27:18 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id D28B41DF406
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:27:05 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id F24631DF36E;
	Thu, 22 Jun 2023 08:27:02 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 2101b65a;
	Thu, 22 Jun 2023 08:27:01 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Thomas Kopp <Thomas.Kopp@microchip.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 16/33] can: length: fix description of the RRS field
Date: Thu, 22 Jun 2023 10:26:41 +0200
Message-Id: <20230622082658.571150-17-mkl@pengutronix.de>
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

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

The CAN-FD frames only have one reserved bit. The bit corresponding to
Classical CAN frame's RTR bit is called the "Remote Request
Substitution (RRS)" [1].

N.B. The RRS is not to be confused with the Substitute Remote Request
(SRR).

Fix the description in the CANFD_FRAME_OVERHEAD_SFF/EFF macros.

The total remains unchanged, so this is just a documentation fix.

In addition to the above add myself as copyright owner for 2020 (as
coauthor of the initial version, c.f. Fixes tag).

[1] ISO 11898-1:2015 paragraph 10.4.2.3 "Arbitration field":

  RSS bit [only in FD Frames]

    The RRS bit shall be transmitted in FD Frames at the position of
    the RTR bit in Classical Frames. The RRS bit shall be transmitted
    dominant, but receivers shall accept recessive and dominant RRS
    bits.

Fixes: 85d99c3e2a13 ("can: length: can_skb_get_frame_len(): introduce function to get data length of frame in data link layer")
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reviewed-by: Thomas Kopp <Thomas.Kopp@microchip.com>
Link: https://lore.kernel.org/all/20230611025728.450837-3-mailhol.vincent@wanadoo.fr
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/linux/can/length.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/can/length.h b/include/linux/can/length.h
index b8c12c83bc51..521fdbce2d69 100644
--- a/include/linux/can/length.h
+++ b/include/linux/can/length.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2020 Oliver Hartkopp <socketcan@hartkopp.net>
  * Copyright (C) 2020 Marc Kleine-Budde <kernel@pengutronix.de>
+ * Copyright (C) 2020 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
  */
 
 #ifndef _CAN_LENGTH_H
@@ -64,7 +65,7 @@
  * ---------------------------------------------------------
  * Start-of-frame			1
  * Identifier				11
- * Reserved bit (r1)			1
+ * Remote Request Substitution (RRS)	1
  * Identifier extension bit (IDE)	1
  * Flexible data rate format (FDF)	1
  * Reserved bit (r0)			1
@@ -95,7 +96,7 @@
  * Substitute remote request (SRR)	1
  * Identifier extension bit (IDE)	1
  * Identifier B				18
- * Reserved bit (r1)			1
+ * Remote Request Substitution (RRS)	1
  * Flexible data rate format (FDF)	1
  * Reserved bit (r0)			1
  * Bit Rate Switch (BRS)		1
-- 
2.40.1



