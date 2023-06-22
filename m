Return-Path: <netdev+bounces-12962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D18A3739982
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 10:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E26C1C2106F
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 08:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111C91775A;
	Thu, 22 Jun 2023 08:27:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B3016406
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:27:19 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F301BE1
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:27:05 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qCFeh-0002Qa-Th
	for netdev@vger.kernel.org; Thu, 22 Jun 2023 10:27:03 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 0DA991DF352
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:27:02 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id BE4151DF337;
	Thu, 22 Jun 2023 08:27:00 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e474603c;
	Thu, 22 Jun 2023 08:27:00 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/33] pull-request: can-next 2023-06-22
Date: Thu, 22 Jun 2023 10:26:25 +0200
Message-Id: <20230622082658.571150-1-mkl@pengutronix.de>
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

this is a pull request of 33 patches for net-next/master.

The first patch is by Carsten Schmidt, targets the kvaser_usb driver
and adds len8_dlc support.

Marcel Hellwig's patch for the xilinx_can driver adds support for CAN
transceivers via the PHY framework.

Frank Jungclaus contributes 6+2 patches for the esd_usb driver in
preparation for the upcoming CAN-USB/3 support.

The 2 patches by Miquel Raynal for the sja1000 driver work around
overruns stalls on the Renesas SoCs.

The next 3 patches are by me and fix the coding style in the
rx-offload helper and in the m_can and ti_hecc driver.

Vincent Mailhol contributes 3 patches to fix and update the
calculation of the length of CAN frames on the wire.

Oliver Hartkopp's patch moves the CAN_RAW_FILTER_MAX definition into
the correct header.

The remaining 14 patches are by Jimmy Assarsson, target the
kvaser_pciefd driver and bring various updates and improvements.

regards,
Marc

---

The following changes since commit d49b9b07725f5dfa3344dc3eed59b8ccc0a0ddbc:

  Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue (2023-05-22 12:44:44 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-6.5-20230622

for you to fetch changes up to 790ef3901f18be794f5b246f990f305bbd08ffd7:

  Merge patch series "can: kvaser_pciefd: Fixes and improvements" (2023-06-22 09:53:03 +0200)

----------------------------------------------------------------
linux-can-next-for-6.5-20230622

----------------------------------------------------------------
Carsten Schmidt (1):
      can: kvaser_usb: Add len8_dlc support

Frank Jungclaus (8):
      can: esd_usb: Make use of existing kernel macros
      can: esd_usb: Replace initializer macros used for struct can_bittiming_const
      can: esd_usb: Use consistent prefixes for macros
      can: esd_usb: Prefix all structures with the device name
      can: esd_usb: Replace hardcoded message length given to USB commands
      can: esd_usb: Don't bother the user with nonessential log message
      can: esd_usb: Make use of kernel macros BIT() and GENMASK()
      can: esd_usb: Use consistent prefix ESD_USB_ for macros

Jimmy Assarsson (14):
      can: kvaser_pciefd: Remove useless write to interrupt register
      can: kvaser_pciefd: Remove handler for unused KVASER_PCIEFD_PACK_TYPE_EFRAME_ACK
      can: kvaser_pciefd: Add function to set skb hwtstamps
      can: kvaser_pciefd: Set hardware timestamp on transmitted packets
      can: kvaser_pciefd: Define unsigned constants with type suffix 'U'
      can: kvaser_pciefd: Remove SPI flash parameter read functionality
      can: kvaser_pciefd: Sort includes in alphabetic order
      can: kvaser_pciefd: Rename device ID defines
      can: kvaser_pciefd: Change return type for kvaser_pciefd_{receive,transmit,set_tx}_irq()
      can: kvaser_pciefd: Sort register definitions
      can: kvaser_pciefd: Use FIELD_{GET,PREP} and GENMASK where appropriate
      can: kvaser_pciefd: Add len8_dlc support
      can: kvaser_pciefd: Refactor code
      can: kvaser_pciefd: Use TX FIFO size read from CAN controller

Marc Kleine-Budde (9):
      Merge patch series "can: esd_usb: More preparation before supporting esd CAN-USB/3"
      Merge patch series "can: esd_usb: More preparation before supporting esd CAN-USB/3 (addendum)"
      Merge patch series "can: sja1000: Prepare the use of a threaded handler"
      can: rx-offload: fix coding style
      can: ti_hecc: fix coding style
      can: m_can: fix coding style
      Merge patch series "can: fix coding style"
      Merge patch series "can: length: fix definitions and add bit length calculation"
      Merge patch series "can: kvaser_pciefd: Fixes and improvements"

Marcel Hellwig (1):
      can: dev: add transceiver capabilities to xilinx_can

Miquel Raynal (2):
      can: sja1000: Prepare the use of a threaded handler
      can: sja1000: Prevent overrun stalls with a soft reset on Renesas SoCs

Oliver Hartkopp (1):
      can: uapi: move CAN_RAW_FILTER_MAX definition to raw.h

Vincent Mailhol (3):
      can: length: fix description of the RRS field
      can: length: fix bitstuffing count
      can: length: refactor frame lengths definition to add size in bits

 drivers/net/can/Kconfig                           |   3 +-
 drivers/net/can/dev/length.c                      |  15 +-
 drivers/net/can/dev/rx-offload.c                  |   2 +-
 drivers/net/can/kvaser_pciefd.c                   | 945 ++++++++--------------
 drivers/net/can/m_can/m_can.c                     |   4 +-
 drivers/net/can/sja1000/sja1000.c                 |  40 +-
 drivers/net/can/sja1000/sja1000.h                 |   1 +
 drivers/net/can/sja1000/sja1000_platform.c        |   5 +-
 drivers/net/can/ti_hecc.c                         |   2 +-
 drivers/net/can/usb/esd_usb.c                     | 350 ++++----
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c  |   2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c |  13 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c  |   6 +-
 drivers/net/can/xilinx_can.c                      |  19 +
 include/linux/can/length.h                        | 315 +++++---
 include/uapi/linux/can.h                          |   1 -
 include/uapi/linux/can/raw.h                      |   2 +
 17 files changed, 811 insertions(+), 914 deletions(-)



