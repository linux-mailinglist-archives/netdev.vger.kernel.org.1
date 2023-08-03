Return-Path: <netdev+bounces-23917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7F376E27B
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 10:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0A91C21511
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 08:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970B414271;
	Thu,  3 Aug 2023 08:08:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD2713AFD
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 08:08:41 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D355FE6
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 01:08:36 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qRTNr-0000S9-A0
	for netdev@vger.kernel.org; Thu, 03 Aug 2023 10:08:35 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 0FA55202248
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 08:08:34 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id C454420222D;
	Thu,  3 Aug 2023 08:08:32 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 67af3b46;
	Thu, 3 Aug 2023 08:08:32 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/9] pull-request: can-next 2023-08-03
Date: Thu,  3 Aug 2023 10:08:21 +0200
Message-Id: <20230803080830.1386442-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello netdev-team,

this is a pull request of 9 patches for net-next/master.

The 1st patch is by Ruan Jinjie, targets the flexcan driver, and
cleans up the error handling of platform_get_irq() in the
flexcan_probe() function.

Markus Schneider-Pargmann contributes 6 patches for the tcan4x5x M_CAN
driver, consisting of some cleanups, and adding support for the
tcan4552/4553 chips.

Another patch by Ruan Jinjie, that cleans up the error path of
platform_get_irq() in the c_can_plat_probe() function of the C_CAN
platform driver.

The last patch is by Frank Jungclaus and adds support for the
CAN-USB/3 and CAN FD to the ESD USB CAN driver.

regards,
Marc

---

The following changes since commit 2b3082c6ef3b0104d822f6f18d2afbe5fc9a5c2c:

  net: flow_dissector: Use 64bits for used_keys (2023-07-31 09:11:24 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-6.6-20230803

for you to fetch changes up to 806e95aee5440a9fbe155c3822e1422ba6a90478:

  Merge patch "can: esd_usb: Add support for esd CAN-USB/3" (2023-08-03 09:24:33 +0200)

----------------------------------------------------------------
linux-can-next-for-6.6-20230803

----------------------------------------------------------------
Frank Jungclaus (1):
      can: esd_usb: Add support for esd CAN-USB/3

Marc Kleine-Budde (2):
      Merge patch series "can: tcan4x5x: Introduce tcan4552/4553"
      Merge patch "can: esd_usb: Add support for esd CAN-USB/3"

Markus Schneider-Pargmann (6):
      dt-bindings: can: tcan4x5x: Add tcan4552 and tcan4553 variants
      can: tcan4x5x: Remove reserved register 0x814 from writable table
      can: tcan4x5x: Check size of mram configuration
      can: tcan4x5x: Rename ID registers to match datasheet
      can: tcan4x5x: Add support for tcan4552/4553
      can: tcan4x5x: Add error messages in probe

Ruan Jinjie (2):
      can: flexcan: fix the return value handle for platform_get_irq()
      can: c_can: Do not check for 0 return after calling platform_get_irq()

 .../devicetree/bindings/net/can/tcan4x5x.txt       |  11 +-
 drivers/net/can/c_can/c_can_platform.c             |   4 +-
 drivers/net/can/flexcan/flexcan-core.c             |  12 +-
 drivers/net/can/m_can/m_can.c                      |  16 ++
 drivers/net/can/m_can/m_can.h                      |   1 +
 drivers/net/can/m_can/tcan4x5x-core.c              | 142 +++++++++--
 drivers/net/can/m_can/tcan4x5x-regmap.c            |   1 -
 drivers/net/can/usb/esd_usb.c                      | 275 ++++++++++++++++++---
 8 files changed, 397 insertions(+), 65 deletions(-)



