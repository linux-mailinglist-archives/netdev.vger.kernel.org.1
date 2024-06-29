Return-Path: <netdev+bounces-107883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE7191CC6F
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 13:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59ECA1C21189
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 11:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C664B50279;
	Sat, 29 Jun 2024 11:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA8726AE8
	for <netdev@vger.kernel.org>; Sat, 29 Jun 2024 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719661225; cv=none; b=EvA114DzlS4FXaw5m0w5OTb2ar0fOB2v0j1QMtFEV+VeVyefIjDX0v2Dt07qVQOcpYC4JkNZT3PQbE22yuMnKoS0K4+mTtYmv8MywU/6bihFaiaAPUd3HTp/YUV2Pk94tWsLfcfRY+iq7i4iP4tSTByiRn/8qDXLSwYdPPPikng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719661225; c=relaxed/simple;
	bh=AY9FvO2u7+alDjTsyZFlGs5aeY2Yt0frJV28TFHjGLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XUfGYyOOAtAYiKK/kSWRGRw5AHLTT2Q8c9zIyLZ6Amecv5EHIklKA7WhGs84A5/dSzcQvSCpx3mACivtrN90IvDmzZLclE0YAMona/QEiyNCdcfbHob5wE9GF0zFK/tlE6Tp9kH2qG1LmCpGtm05ioLeWcxiqCSYncSbudQiaOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sNWRJ-00033G-Ap
	for netdev@vger.kernel.org; Sat, 29 Jun 2024 13:40:21 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sNWRI-005pWo-S9
	for netdev@vger.kernel.org; Sat, 29 Jun 2024 13:40:20 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 8AF982F6442
	for <netdev@vger.kernel.org>; Sat, 29 Jun 2024 11:40:20 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 261E32F642E;
	Sat, 29 Jun 2024 11:40:19 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 4041228f;
	Sat, 29 Jun 2024 11:40:18 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/14] pull-request: can-next 2024-06-29
Date: Sat, 29 Jun 2024 13:36:14 +0200
Message-ID: <20240629114017.1080160-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
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

Hello netdev-team,

this is a pull request of 14 patches for net-next/master.

Geert Uytterhoeven contributes 3 patches with small improvements and
cleanups for the rcar_canfd driver.

A patch by Christophe JAILLET constifies the struct m_can_ops in the
m_can driver to reduce the code size.

The last 9 patches are by me an work around erratum DS80000789E 6 of
mcp2518fd.

regards,
Marc

---

The following changes since commit 94833addfaba89d12e5dbd82e350a692c00648ab:

  net: thunderx: Unembed netdev structure (2024-06-27 16:55:34 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-6.11-20240629

for you to fetch changes up to ae44fa998ee280303ee5dffe99cb669e4c245706:

  Merge patch series "can: mcp251xfd: workaround for erratum DS80000789E 6 of mcp2518fd" (2024-06-28 23:49:37 +0200)

----------------------------------------------------------------
linux-can-next-for-6.11-20240629

----------------------------------------------------------------
Christophe JAILLET (1):
      can: m_can: Constify struct m_can_ops

Geert Uytterhoeven (3):
      can: rcar_canfd: Simplify clock handling
      can: rcar_canfd: Improve printing of global operational state
      can: rcar_canfd: Remove superfluous parentheses in address calculations

Marc Kleine-Budde (12):
      Merge patch series "can: rcar_canfd: Small improvements and cleanups"
      can: gs_usb: add VID/PID for Xylanta SAINT3 product family
      can: mcp251xfd: properly indent labels
      can: mcp251xfd: update errata references
      can: mcp251xfd: move mcp251xfd_timestamp_start()/stop() into mcp251xfd_chip_start/stop()
      can: mcp251xfd: clarify the meaning of timestamp
      can: mcp251xfd: mcp251xfd_handle_rxif_ring_uinc(): factor out in separate function
      can: mcp251xfd: rx: prepare to workaround broken RX FIFO head index erratum
      can: mcp251xfd: rx: add workaround for erratum DS80000789E 6 of mcp2518fd
      can: mcp251xfd: tef: prepare to workaround broken TEF FIFO tail index erratum
      can: mcp251xfd: tef: update workaround for erratum DS80000789E 6 of mcp2518fd
      Merge patch series "can: mcp251xfd: workaround for erratum DS80000789E 6 of mcp2518fd"

 drivers/net/can/m_can/m_can.h                      |   2 +-
 drivers/net/can/m_can/m_can_pci.c                  |   2 +-
 drivers/net/can/m_can/m_can_platform.c             |   2 +-
 drivers/net/can/m_can/tcan4x5x-core.c              |   2 +-
 drivers/net/can/rcar/rcar_canfd.c                  |  41 ++---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     |  82 +++++-----
 drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c     |   2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c   |   2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c     |   5 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c       | 165 ++++++++++++++-------
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c      | 129 ++++++++--------
 .../net/can/spi/mcp251xfd/mcp251xfd-timestamp.c    |  29 ++--
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h          |  56 +++----
 drivers/net/can/usb/gs_usb.c                       |   5 +
 14 files changed, 294 insertions(+), 230 deletions(-)


