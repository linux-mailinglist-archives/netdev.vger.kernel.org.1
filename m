Return-Path: <netdev+bounces-73206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C2E85B5E2
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 09:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6924B24D32
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 08:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E8E5F545;
	Tue, 20 Feb 2024 08:51:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ABC5D75D
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 08:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419097; cv=none; b=eCi7Z+Nu74ZSe5A4rASo/AYz0DritbAb1Z43OtZs6CTY/K6oYmNUyyPzjPyl4PLwPsfRZ31Zr04fN1bJ+Yx/As4VCtMsM9LT4IKxlOiFueRvDQSrtmY07nB4VsltzEsIyn920aVyowddz4J1/PkzA0yvc32dCUElC7bYmqHUZQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419097; c=relaxed/simple;
	bh=rGRlYgkcoT4Z6Iv9PfzTPJKdlQ/ym0Pi+wvQsiDHsyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IQVXwDY/PryJbH4BTK6uOiVX5GsivYxmF+wzNUWd3mcAEk1XEwnbwljasK625xTDnwgF0P88n5IsjbMr0bPL0HHZqIT7CCer5MvNDtXZwoTbNuIkK64CCaxYC9f38FL24JiAhMU0mR3NZXQmh1m/xd37hlYvH3oMF5Is6faqnyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcLqg-0001aS-3M
	for netdev@vger.kernel.org; Tue, 20 Feb 2024 09:51:34 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcLqf-001oDF-GN
	for netdev@vger.kernel.org; Tue, 20 Feb 2024 09:51:33 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 3A3B5292EF4
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 08:51:33 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id DA252292EDA;
	Tue, 20 Feb 2024 08:51:31 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3524c8b0;
	Tue, 20 Feb 2024 08:51:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/9] pull-request: can-next 2024-02-20
Date: Tue, 20 Feb 2024 09:46:02 +0100
Message-ID: <20240220085130.2936533-1-mkl@pengutronix.de>
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

this is a pull request of 9 patches for net-next/master.

The first patch is by Francesco Dolcini and removes a redundant check
for pm_clock_support from the m_can driver.

Martin Hundebøll contributes 3 patches to the m_can/tcan4x5x driver to
allow resume upon RX of a CAN frame.

3 patches by Srinivas Goud add support for ECC statistics to the
xilinx_can driver.

The last 2 patches are by Oliver Hartkopp and me, target the CAN RAW
protocol and fix an error in the getsockopt() for CAN-XL introduced in
the previous pull request to net-next (linux-can-next-for-6.9-20240213).

regards,
Marc

---

The following changes since commit e1a00373e1305578cd09526aa056940409e6b877:

  Merge tag 'linux-can-next-for-6.9-20240213' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next (2024-02-14 10:00:35 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-6.9-20240220

for you to fetch changes up to 00bf80c437dcbbd808d61cc2866c8f065ff436bd:

  can: raw: raw_getsockopt(): reduce scope of err (2024-02-20 09:40:46 +0100)

----------------------------------------------------------------
linux-can-next-for-6.9-20240220

----------------------------------------------------------------
Francesco Dolcini (1):
      can: m_can: remove redundant check for pm_clock_support

Marc Kleine-Budde (3):
      Merge patch series "can: tcan4x5x: support resume upon rx can frame"
      Merge patch series "Add ECC feature support to Tx and Rx FIFOs for Xilinx CAN Controller."
      can: raw: raw_getsockopt(): reduce scope of err

Martin Hundebøll (3):
      dt-bindings: can: tcan4x5x: Document the wakeup-source flag
      can: m_can: allow keeping the transceiver running in suspend
      can: tcan4x5x: support resuming from rx interrupt signal

Oliver Hartkopp (1):
      can: raw: fix getsockopt() for new CAN_RAW_XL_VCID_OPTS

Srinivas Goud (3):
      dt-bindings: can: xilinx_can: Add 'xlnx,has-ecc' optional property
      can: xilinx_can: Add ECC support
      can: xilinx_can: Add ethtool stats interface for ECC errors

 .../devicetree/bindings/net/can/tcan4x5x.txt       |   3 +
 .../devicetree/bindings/net/can/xilinx,can.yaml    |   5 +
 drivers/net/can/m_can/m_can.c                      |  30 ++--
 drivers/net/can/m_can/m_can.h                      |   1 +
 drivers/net/can/m_can/m_can_pci.c                  |   1 +
 drivers/net/can/m_can/m_can_platform.c             |   1 +
 drivers/net/can/m_can/tcan4x5x-core.c              |  33 +++-
 drivers/net/can/xilinx_can.c                       | 169 ++++++++++++++++++++-
 net/can/raw.c                                      |  17 ++-
 9 files changed, 239 insertions(+), 21 deletions(-)


