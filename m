Return-Path: <netdev+bounces-229260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA665BD9E8E
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 16:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16541883DA6
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 14:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75165314A8E;
	Tue, 14 Oct 2025 14:10:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91956314A9B
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760451031; cv=none; b=nmYTud70e7kiAd98hupMnA178bdteK6r4icPpf73Qn93wLWfRBAJFeBh6BiFkKiiT6Q0ThrVkgvkTw3oMe4NRDICCCm9R+XLZ82NUOPCqBC2VKUZJixc9J7a6D/ToiPZ/g3LTlxhZowJAkMmEUYKQtDdevjn6z4esKfz2Xny+AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760451031; c=relaxed/simple;
	bh=oKizBa0OR+H5xyFMbad+hPugvFniPBKaToqcR7eGSn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d6z20VRvUbvkLrh68ewKayxk0RurWcZX4v9npTHSNeNmhttbUukWSbMriwAVMLX/US1uVTNsNfIcO5HAa8k9ukepFke2wcRQcB/a3Z9KatI+5pRWq2qc79E0MEyoeEqZlJxJ5YF8XHvsqyDMbFHVxQk36VqWG8wI2FeahbaPnFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v8fjK-0008IE-TW; Tue, 14 Oct 2025 16:10:22 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v8fjK-003ZPq-0A;
	Tue, 14 Oct 2025 16:10:22 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AC717485F14;
	Tue, 14 Oct 2025 14:10:21 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/10] pull-request: can 2025-10-14
Date: Tue, 14 Oct 2025 14:17:47 +0200
Message-ID: <20251014122140.990472-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
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

this is a pull request of 10 patches for net/main.

The first 2 paches are by Celeste Liu and target the gS_usb driver.
The first patch remove the limitation to 3 CAN interface per USB
device. The second patch adds the missing population of
net_device->dev_port.

THe next 4 patches are by me and fix the m_can driver. They add a
missing pm_runtime_disable(), fix the CAN state transition back to
Error Active and fix the state after ifup and suspend/resume.

Another patch by me targets the m_can driver, too and replaces Dong
Aisheng's old email address.

The next 2 patches are by Vincent Mailhol and update the CAN
networking Documentation.

Tetsuo Handa contributes the last patch that add missing cleanup calls
in the NETDEV_UNREGISTER notification handler.

regards,
Marc

---

The following changes since commit 2c95a756e0cfc19af6d0b32b0c6cf3bada334998:

  net: pse-pd: tps23881: Fix current measurement scaling (2025-10-07 18:30:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.18-20251014

for you to fetch changes up to 93a27b5891b8194a8c083c9a80d2141d4bf47ba8:

  can: j1939: add missing calls in NETDEV_UNREGISTER notification handler (2025-10-13 21:26:31 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.18-20251014

----------------------------------------------------------------
Celeste Liu (2):
      can: gs_usb: increase max interface to U8_MAX
      can: gs_usb: gs_make_candev(): populate net_device->dev_port

Marc Kleine-Budde (7):
      can: m_can: m_can_plat_remove(): add missing pm_runtime_disable()
      can: m_can: m_can_handle_state_errors(): fix CAN state transition to Error Active
      can: m_can: m_can_chip_config(): bring up interface in correct state
      can: m_can: fix CAN state in system PM
      Merge patch series "can: m_can: fix pm_runtime and CAN state handling"
      can: m_can: replace Dong Aisheng's old email address
      Merge patch series "can: add Transmitter Delay Compensation (TDC) documentation"

Tetsuo Handa (1):
      can: j1939: add missing calls in NETDEV_UNREGISTER notification handler

Vincent Mailhol (2):
      can: remove false statement about 1:1 mapping between DLC and length
      can: add Transmitter Delay Compensation (TDC) documentation

 .mailmap                               |  1 +
 Documentation/networking/can.rst       | 71 ++++++++++++++++++++++++++++++++--
 drivers/net/can/m_can/m_can.c          | 68 ++++++++++++++++++--------------
 drivers/net/can/m_can/m_can_platform.c |  6 +--
 drivers/net/can/usb/gs_usb.c           | 23 ++++++-----
 net/can/j1939/main.c                   |  2 +
 6 files changed, 123 insertions(+), 48 deletions(-)

