Return-Path: <netdev+bounces-225497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974F3B94D39
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 09:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CDB72E1B0E
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 07:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2CA3164D8;
	Tue, 23 Sep 2025 07:42:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDE93164C2
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 07:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758613378; cv=none; b=ZI/TdBjvosAVaByTKrS/E9vfDzgCxCA23KNFHll99Femu8cP7QhJX+p8fvm2JkEC5pZhrFNoEj0Yct+TwwFzg39Y4CE5ohb4J4H1oWT2WkcFV1xjuNGCFPKdwW5HN90wNygOJ+4DQtGt3o2yWUu7Je4I+GDsmOQSAqN+8DPVOHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758613378; c=relaxed/simple;
	bh=7+xUfCB1aKwd8F9tPQYDfPP0+KThw87QTnZkmMsFrCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DU4g85RB1JokGepOWzoIR1en0VZJ81jvgT5VKoyZBbaxZqy3dd0y9PQIqJKqlvx9cUIpwYN7+rletgdiYGqqGjYI3nF+iSfcMLp0HqhoRBP/d8TkKPvR6kKKwu2xUhAjjy9cluauYDalTz1cC/3CH54iB7l6YTemxi/6xmYi4yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0xfg-0003ck-QX; Tue, 23 Sep 2025 09:42:44 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0xff-0003Nb-3D;
	Tue, 23 Sep 2025 09:42:44 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 94B19477A82;
	Tue, 23 Sep 2025 07:34:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/7] pull-request: can 2025-09-23
Date: Tue, 23 Sep 2025 09:32:46 +0200
Message-ID: <20250923073427.493034-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
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

this is a pull request of 7 patches for net/main.

The 1st patch is by Chen Yufeng and fixes a potential NULL pointer
deref in the hi311x driver.

Duy Nguyen contributes a patch for the rcar_canfd driver to fix the
controller mode setting.

The next 4 patches are by Vincent Mailhol and populate the
ndo_change_mtu(( callback in the etas_es58x, hi311x, sun4i_can and
mcba_usb driver to prevent buffer overflows.

Stéphane Grosjean's patch for the peak_usb driver fixes a
shift-out-of-bounds issue.

regards,
Marc

---

The following changes since commit cbf658dd09419f1ef9de11b9604e950bdd5c170b:

  Merge tag 'net-6.17-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-09-18 10:22:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.17-20250923

for you to fetch changes up to c443be70aaee42c2d1d251e0329e0a69dd96ae54:

  can: peak_usb: fix shift-out-of-bounds issue (2025-09-19 19:17:37 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.17-20250923

----------------------------------------------------------------
Chen Yufeng (1):
      can: hi311x: fix null pointer dereference when resuming from sleep before interface was enabled

Duy Nguyen (1):
      can: rcar_canfd: Fix controller mode setting

Marc Kleine-Budde (1):
      Merge patch series "can: populate ndo_change_mtu() to prevent buffer overflow"

Stéphane Grosjean (1):
      can: peak_usb: fix shift-out-of-bounds issue

Vincent Mailhol (4):
      can: etas_es58x: populate ndo_change_mtu() to prevent buffer overflow
      can: hi311x: populate ndo_change_mtu() to prevent buffer overflow
      can: sun4i_can: populate ndo_change_mtu() to prevent buffer overflow
      can: mcba_usb: populate ndo_change_mtu() to prevent buffer overflow

 drivers/net/can/rcar/rcar_canfd.c            |  7 +++---
 drivers/net/can/spi/hi311x.c                 | 34 +++++++++++++++-------------
 drivers/net/can/sun4i_can.c                  |  1 +
 drivers/net/can/usb/etas_es58x/es58x_core.c  |  3 ++-
 drivers/net/can/usb/mcba_usb.c               |  1 +
 drivers/net/can/usb/peak_usb/pcan_usb_core.c |  2 +-
 6 files changed, 27 insertions(+), 21 deletions(-)

