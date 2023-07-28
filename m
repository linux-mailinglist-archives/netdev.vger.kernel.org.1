Return-Path: <netdev+bounces-22169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9406D76662A
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B781C2037B
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 08:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94021094D;
	Fri, 28 Jul 2023 07:59:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED5010949
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 07:59:00 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFADD44B8
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 00:58:43 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qPIMq-0008Fz-TV
	for netdev@vger.kernel.org; Fri, 28 Jul 2023 09:58:32 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 67A7F1FD1FB
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 07:56:19 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 84A191FD19F;
	Fri, 28 Jul 2023 07:56:17 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 2e6063a1;
	Fri, 28 Jul 2023 07:56:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 04/21] MAINTAINERS: Add myself as maintainer of the ems_pci.c driver
Date: Fri, 28 Jul 2023 09:55:57 +0200
Message-Id: <20230728075614.1014117-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230728075614.1014117-1-mkl@pengutronix.de>
References: <20230728075614.1014117-1-mkl@pengutronix.de>
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

From: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>

At the suggestion of Marc Kleine-Budde [1], I add myself as maintainer
of the ems_pci.c driver.

[1] https://lore.kernel.org/all/20230720-purplish-quizzical-247024e66671-mkl@pengutronix.de

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Link: https://lore.kernel.org/all/20230720144032.28960-1-uttenthaler@ems-wuensche.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 24eb7ed6211f..c4f95a9d03b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7606,6 +7606,13 @@ L:	linux-mmc@vger.kernel.org
 S:	Supported
 F:	drivers/mmc/host/cqhci*
 
+EMS CPC-PCI CAN DRIVER
+M:	Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
+M:	support@ems-wuensche.com
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	drivers/net/can/sja1000/ems_pci.c
+
 EMULEX 10Gbps iSCSI - OneConnect DRIVER
 M:	Ketan Mukadam <ketan.mukadam@broadcom.com>
 L:	linux-scsi@vger.kernel.org
-- 
2.40.1



