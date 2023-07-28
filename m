Return-Path: <netdev+bounces-22168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790D1766623
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7FE21C2040E
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 08:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CF7C8DA;
	Fri, 28 Jul 2023 07:58:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796FB10786
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 07:58:59 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDAA44B2
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 00:58:42 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qPIMq-0008FT-F9
	for netdev@vger.kernel.org; Fri, 28 Jul 2023 09:58:32 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 635D11FD1BA
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 07:56:18 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id F11831FD197;
	Fri, 28 Jul 2023 07:56:16 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 7c42827d;
	Fri, 28 Jul 2023 07:56:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/21] pull-request: can-next 2023-07-28
Date: Fri, 28 Jul 2023 09:55:53 +0200
Message-Id: <20230728075614.1014117-1-mkl@pengutronix.de>
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
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello netdev-team,

this is a pull request of 21 patches for net-next/master.

The 1st patch is by Gerhard Uttenthaler, which adds Gerhard as the
maintainer ems_pci driver.

Peter Seiderer's patch removes a unused function from the peak_usb
driver.

The next 4 patches are by John Watts and add support for the sun4i_can
driver on the Allwinner D1.

Rob Herring's patch corrects the DT includes in various CAN drivers.

Followed by 14 patches from me concerning the gs_usb driver. The first
11 are various cleanups consisting of coding style improvements, error
path printout cleanups, and removal of unneeded
usb_kill_anchored_urbs(). The last 3 convert the driver to use NAPI to
avoid out-of-order reception of CAN frames.

regards,
Marc

---

The following changes since commit 3d40aed862874db14e1dd41fd6f12636dcfdcc3e:

  net: Explicitly include correct DT includes (2023-07-27 20:33:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-6.6-20230728

for you to fetch changes up to 52be626ccbd7421f6124429b6d9fea9e31ae602f:

  Merge patch series "can: gs_usb: convert to NAPI" (2023-07-28 09:46:15 +0200)

----------------------------------------------------------------
linux-can-next-for-6.6-20230728

----------------------------------------------------------------
Gerhard Uttenthaler (1):
      MAINTAINERS: Add myself as maintainer of the ems_pci.c driver

John Watts (4):
      dt-bindings: net: can: Add support for Allwinner D1 CAN controller
      riscv: dts: allwinner: d1: Add CAN controller nodes
      can: sun4i_can: Add acceptance register quirk
      can: sun4i_can: Add support for the Allwinner D1

Marc Kleine-Budde (17):
      Merge patch series "Add support for Allwinner D1 CAN controllers"
      can: gs_usb: remove leading space from goto labels
      can: gs_usb: gs_usb_probe(): align block comment
      can: gs_usb: gs_usb_set_timestamp(): remove return statements form void function
      can: gs_usb: uniformly use "parent" as variable name for struct gs_usb
      can: gs_usb: gs_usb_receive_bulk_callback(): make use of netdev
      can: gs_usb: gs_usb_receive_bulk_callback(): make use of stats
      can: gs_usb: gs_usb_receive_bulk_callback(): count RX overflow errors also in case of OOM
      can: gs_usb: gs_can_start_xmit(), gs_can_open(): clean up printouts in error path
      can: gs_usb: gs_can_close(): don't complain about failed device reset during ndo_stop
      can: gs_usb: gs_destroy_candev(): remove not needed usb_kill_anchored_urbs()
      can: gs_usb: gs_usb_disconnect(): remove not needed usb_kill_anchored_urbs()
      Merge patch series "can: gs_usb-cleanups: various clenaups"
      can: rx-offload: rename rx_offload_get_echo_skb() -> can_rx_offload_get_echo_skb_queue_timestamp()
      can: rx-offload: add can_rx_offload_get_echo_skb_queue_tail()
      can: gs_usb: convert to NAPI/rx-offload to avoid OoO reception
      Merge patch series "can: gs_usb: convert to NAPI"

Peter Seiderer (1):
      can: peak_usb: remove unused/legacy peak_usb_netif_rx() function

Rob Herring (1):
      can: Explicitly include correct DT includes, part 2

 .../bindings/net/can/allwinner,sun4i-a10-can.yaml  |   6 +-
 MAINTAINERS                                        |   7 +
 arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi  |  30 ++++
 drivers/net/can/Kconfig                            |   4 +-
 drivers/net/can/bxcan.c                            |   1 -
 drivers/net/can/dev/rx-offload.c                   |  36 +++-
 drivers/net/can/flexcan/flexcan-core.c             |   4 +-
 drivers/net/can/ifi_canfd/ifi_canfd.c              |   1 -
 drivers/net/can/m_can/m_can.c                      |   9 +-
 drivers/net/can/m_can/m_can.h                      |   1 -
 drivers/net/can/rcar/rcar_canfd.c                  |   1 -
 drivers/net/can/sja1000/sja1000_platform.c         |   1 -
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c      |   6 +-
 drivers/net/can/sun4i_can.c                        |  23 ++-
 drivers/net/can/ti_hecc.c                          |   5 +-
 drivers/net/can/usb/Kconfig                        |   1 +
 drivers/net/can/usb/gs_usb.c                       | 187 +++++++++++++--------
 drivers/net/can/usb/peak_usb/pcan_usb_core.c       |  13 --
 drivers/net/can/usb/peak_usb/pcan_usb_core.h       |   2 -
 include/linux/can/rx-offload.h                     |  11 +-
 20 files changed, 225 insertions(+), 124 deletions(-)



