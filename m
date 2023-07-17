Return-Path: <netdev+bounces-18391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 290BE756BCD
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 20:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59CD71C20B66
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 18:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C6CC12F;
	Mon, 17 Jul 2023 18:22:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3761FD7
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 18:22:49 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80A413D
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 11:22:34 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qLSrh-0001YF-9z
	for netdev@vger.kernel.org; Mon, 17 Jul 2023 20:22:33 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 3F3A51F39D1
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 18:22:32 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id E085A1F39B6;
	Mon, 17 Jul 2023 18:22:30 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 9f5d0ac8;
	Mon, 17 Jul 2023 18:22:30 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/8] pull-request: can-next 2023-07-17
Date: Mon, 17 Jul 2023 20:22:21 +0200
Message-Id: <20230717182229.250565-1-mkl@pengutronix.de>
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
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello netdev-team,

this is a pull request of 8 patches for net-next/master.

The first 2 patches are by Judith Mendez, target the m_can driver and
add hrtimer based polling support for TI AM62x SoCs, where the
interrupt of the MCU domain's m_can cores is not routed to the Cortex
A53 core.

Wu Yunchuan's patch removes an unnecessary cast from the ems_pci
driver.

A patch by Rob Herring converts the grcan driver to use the correct DT
include files.

Michal Simek and Srinivas Neeli add support for optional reset control
to the xilinx_can driver.

The last 2 patches are by Jimmy Assarsson and add support for new
Kvaser pciefd to the kvaser_pciefd driver.

regards,
Marc

---

The following changes since commit 68af900072c157c0cdce0256968edd15067e1e5a:

  gve: trivial spell fix Recive to Receive (2023-07-14 10:28:17 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-6.6-20230717

for you to fetch changes up to d0fc0ef083bc51d8d0211a2e1498d450220c1bc3:

  Merge patch series "can: kvaser_pciefd: Add support for new Kvaser PCI Express devices" (2023-07-17 17:05:38 +0200)

----------------------------------------------------------------
linux-can-next-for-6.6-20230717

----------------------------------------------------------------
Jimmy Assarsson (2):
      can: kvaser_pciefd: Move hardware specific constants and functions into a driver_data struct
      can: kvaser_pciefd: Add support for new Kvaser pciefd devices

Judith Mendez (2):
      dt-bindings: net: can: Remove interrupt properties for MCAN
      can: m_can: Add hrtimer to generate software interrupt

Marc Kleine-Budde (3):
      Merge patch series "Enable multiple MCAN on AM62x"
      Merge patch series "can: xilinx_can: Add support for reset"
      Merge patch series "can: kvaser_pciefd: Add support for new Kvaser PCI Express devices"

Michal Simek (1):
      dt-bindings: can: xilinx_can: Add reset description

Rob Herring (1):
      can: Explicitly include correct DT includes

Srinivas Neeli (1):
      can: xilinx_can: Add support for controller reset

Wu Yunchuan (1):
      can: ems_pci: Remove unnecessary (void *) conversions

 .../devicetree/bindings/net/can/bosch,m_can.yaml   |  20 +-
 .../devicetree/bindings/net/can/xilinx,can.yaml    |   3 +
 drivers/net/can/Kconfig                            |   5 +
 drivers/net/can/grcan.c                            |   3 +-
 drivers/net/can/kvaser_pciefd.c                    | 307 +++++++++++++++------
 drivers/net/can/m_can/m_can.c                      |  32 ++-
 drivers/net/can/m_can/m_can.h                      |   3 +
 drivers/net/can/m_can/m_can_platform.c             |  21 +-
 drivers/net/can/sja1000/ems_pci.c                  |   6 +-
 drivers/net/can/xilinx_can.c                       |  25 +-
 10 files changed, 333 insertions(+), 92 deletions(-)



