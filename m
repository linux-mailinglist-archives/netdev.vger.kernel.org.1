Return-Path: <netdev+bounces-39012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6347BD74B
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 11:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF887281414
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 09:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2737156E6;
	Mon,  9 Oct 2023 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05FD156F0
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 09:39:21 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5074B9
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 02:39:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qpmjO-0000cV-9g
	for netdev@vger.kernel.org; Mon, 09 Oct 2023 11:39:18 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1qpmjN-000NeF-CG
	for netdev@vger.kernel.org; Mon, 09 Oct 2023 11:39:17 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 4F7BF232621
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 08:52:59 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 1031F2325FC;
	Mon,  9 Oct 2023 08:52:58 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 247cc0be;
	Mon, 9 Oct 2023 08:52:57 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/6] pull-request: can 2023-10-09
Date: Mon,  9 Oct 2023 10:50:02 +0200
Message-ID: <20231009085256.693378-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.42.0
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello netdev-team,

this is a pull request of 6 patches for net/master. (It's basically
linux-can-fixes-for-6.6-20231005 with the problematic j1939 patch
removed.)

Lukas Magel's patch for the CAN ISO-TP protocol fixes the TX state
detection and wait behavior.

John Watts contributes a patch to only show the sun4i_can Kconfig
option on ARCH_SUNXI.

A patch by Miquel Raynal fixes the soft-reset workaround for Renesas
SoCs in the sja1000 driver.

Markus Schneider-Pargmann's patch for the tcan4x5x m_can glue driver
fixes the id2 register for the tcan4553.

2 patches by Haibo Chen fix the flexcan stop mode for the imx93 SoC.

regards,
Marc

---
The following changes since commit d0f95894fda7d4f895b29c1097f92d7fee278cb2:

  netlink: annotate data-races around sk->sk_err (2023-10-04 17:32:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.6-20231009

for you to fetch changes up to c881047071547f4442aae72a6a45140d373b5cb0:

  Merge patch series "arm64: dts: imx93: add the Flex-CAN stop mode by GPR" (2023-10-06 12:55:10 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.6-20231009

----------------------------------------------------------------
Haibo Chen (2):
      arm64: dts: imx93: add the Flex-CAN stop mode by GPR
      can: flexcan: remove the auto stop mode for IMX93

John Watts (1):
      can: sun4i_can: Only show Kconfig if ARCH_SUNXI is set

Lukas Magel (1):
      can: isotp: isotp_sendmsg(): fix TX state detection and wait behavior

Marc Kleine-Budde (1):
      Merge patch series "arm64: dts: imx93: add the Flex-CAN stop mode by GPR"

Markus Schneider-Pargmann (1):
      can: tcan4x5x: Fix id2_register for tcan4553

Miquel Raynal (1):
      can: sja1000: Always restart the Tx queue after an overrun

 arch/arm64/boot/dts/freescale/imx93.dtsi |  4 ++-
 drivers/net/can/Kconfig                  |  2 +-
 drivers/net/can/flexcan/flexcan-core.c   | 46 +++++++++-----------------------
 drivers/net/can/flexcan/flexcan.h        |  2 --
 drivers/net/can/m_can/tcan4x5x-core.c    |  2 +-
 drivers/net/can/sja1000/sja1000.c        |  8 +++++-
 net/can/isotp.c                          | 19 ++++++-------
 7 files changed, 33 insertions(+), 50 deletions(-)



