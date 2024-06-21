Return-Path: <netdev+bounces-105573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0DD911E03
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56136280BEE
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 08:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2064017106A;
	Fri, 21 Jun 2024 08:02:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B3216D33D
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 08:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956931; cv=none; b=Umrkq1l/qxz7mSXZeg7cvIGUc2Ayv0Tu2Xc8mOtOPxS+wBAMnUGLGZArunGoIfqRQLcMk4cp5LEzCjRhNmbDx+P73qBdGdiXnx+Po71jAHKwk4RXEkWKw1BJ5irWnEsUESAvkRogKSAwG3EufYrBxuTL/Glh4rOU57hsTfxDCj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956931; c=relaxed/simple;
	bh=cuTRdAbv5pmD6MDftPmn2b5bpw9AlY/dg/AiR2JBElo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dTF9DPic6j0dGn3Y25ovDqballVVHWT+xTP5p5c4A4JIN53pUaN5QpkHE0gA04VFznD+mCXv4k8uAhhDHMnNey2hs7totSFRZL+H4HAfYrYFpDkzLm5JNLIR1U9J74rttNEaIzmo1hnXuVT2GJO7BkUEQMLbjmQ6CUM8iB7gWgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDg-0003w0-Ku
	for netdev@vger.kernel.org; Fri, 21 Jun 2024 10:02:04 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDg-003tFb-4j
	for netdev@vger.kernel.org; Fri, 21 Jun 2024 10:02:04 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id CFADA2EE3B1
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 08:02:03 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id ACC872EE38C;
	Fri, 21 Jun 2024 08:02:02 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 6343a23b;
	Fri, 21 Jun 2024 08:02:02 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/24] pull-request: can-next 2024-06-21
Date: Fri, 21 Jun 2024 09:48:20 +0200
Message-ID: <20240621080201.305471-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hello netdev-team,

this is a pull request of 24 patches for net-next/master.

The first 2 patches are by Andy Shevchenko, one cleans up the includes
in the mcp251x driver, the other one updates the sja100 plx_pci driver
to make use of predefines PCI subvendor ID.

Mans Rullgard's patch cleans up the Kconfig help text of for the slcan
driver.

Oliver Hartkopp provides a patch to update the documentation, which
removes the ISO 15675-2 specification version where possible.

The next 2 patches are by Harini T and update the documentation of the
xilinx_can driver.

Francesco Valla provides documentation for the ISO 15765-2 protocol.

A patch by Dr. David Alan Gilbert removes an unused struct from the
mscan driver.

12 patches are by Martin Jocic. The first three add support for 3 new
devices to the kvaser_usb driver. The remaining 9 first clean up the
kvaser_pciefd driver, and then add support for MSI.

Krzysztof Kozlowski contributes 3 patches simplifies the CAN SPI
drivers by making use of spi_get_device_match_data().

The last patch is by Martin Hundebøll, which reworks the m_can driver
to not enable the CAN transceiver during probe.

regards,
Marc

---

The following changes since commit 7e8fcb815432e68897dbbc2c4213e546ac40f49c:

  Merge branch 'ionic-rework-fix-for-doorbell-miss' (2024-06-19 18:31:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-6.11-20240621

for you to fetch changes up to cd5a46ce6fa62abedd7740e4bd9f3d82041210ee:

  can: m_can: don't enable transceiver when probing (2024-06-21 09:47:24 +0200)

----------------------------------------------------------------
linux-can-next-for-6.11-20240621

----------------------------------------------------------------
Andy Shevchenko (2):
      can: mcp251x: Fix up includes
      can: sja1000: plx_pci: Reuse predefined CTI subvendor ID

Dr. David Alan Gilbert (1):
      can: mscan: remove unused struct 'mscan_state'

Francesco Valla (1):
      Documentation: networking: document ISO 15765-2

Harini T (2):
      dt-bindings: can: xilinx_can: Modify the title to indicate CAN and CANFD controllers are supported
      can: xilinx_can: Document driver description to list all supported IPs

Krzysztof Kozlowski (3):
      can: hi311x: simplify with spi_get_device_match_data()
      can: mcp251x: simplify with spi_get_device_match_data()
      can: mcp251xfd: simplify with spi_get_device_match_data()

Mans Rullgard (1):
      can: Kconfig: remove obsolete help text for slcan

Marc Kleine-Budde (6):
      Merge patch series "can: xilinx_can: Document driver description to list all supported IPs"
      Merge patch "Documentation: networking: document ISO 15765-2"
      Merge patch series "can: kvaser_usb: Add support for three new devices"
      Merge patch series "can: kvaser_pciefd: Minor improvements and cleanups"
      Merge patch series "can: kvaser_pciefd: Support MSI interrupts"
      Merge patch series "can: hi311x: simplify with spi_get_device_match_data()"

Martin Hundebøll (1):
      can: m_can: don't enable transceiver when probing

Martin Jocic (12):
      can: kvaser_usb: Add support for Vining 800
      can: kvaser_usb: Add support for Kvaser USBcan Pro 5xCAN
      can: kvaser_usb: Add support for Kvaser Mini PCIe 1xCAN
      can: kvaser_pciefd: Group #defines together
      can: kvaser_pciefd: Skip redundant NULL pointer check in ISR
      can: kvaser_pciefd: Remove unnecessary comment
      can: kvaser_pciefd: Add inline
      can: kvaser_pciefd: Add unlikely
      can: kvaser_pciefd: Rename board_irq to pci_irq
      can: kvaser_pciefd: Change name of return code variable
      can: kvaser_pciefd: Move reset of DMA RX buffers to the end of the ISR
      can: kvaser_pciefd: Add MSI interrupts

Oliver Hartkopp (1):
      can: isotp: remove ISO 15675-2 specification version where possible

 .../devicetree/bindings/net/can/xilinx,can.yaml    |   2 +-
 Documentation/networking/index.rst                 |   1 +
 Documentation/networking/iso15765-2.rst            | 386 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 drivers/net/can/Kconfig                            |   5 +-
 drivers/net/can/kvaser_pciefd.c                    | 137 ++++----
 drivers/net/can/m_can/m_can.c                      | 165 +++++----
 drivers/net/can/m_can/tcan4x5x-core.c              |  13 +-
 drivers/net/can/mscan/mscan.c                      |   6 -
 drivers/net/can/sja1000/plx_pci.c                  |   3 +-
 drivers/net/can/spi/hi311x.c                       |   7 +-
 drivers/net/can/spi/mcp251x.c                      |  11 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     |   9 +-
 drivers/net/can/usb/Kconfig                        |   3 +
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   |   9 +
 drivers/net/can/xilinx_can.c                       |   2 +-
 include/uapi/linux/can/isotp.h                     |   2 +-
 net/can/Kconfig                                    |  11 +-
 net/can/isotp.c                                    |  11 +-
 19 files changed, 612 insertions(+), 172 deletions(-)
 create mode 100644 Documentation/networking/iso15765-2.rst


