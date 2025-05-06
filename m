Return-Path: <netdev+bounces-188351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 065C3AAC72F
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 15:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03FA03B9CAC
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 13:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728BE281363;
	Tue,  6 May 2025 13:59:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603FA27E1AC
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 13:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746539987; cv=none; b=QWVBfgZ5VQ5IAZSaU5mGzv3h2yOY+Q6RPL7SFt0g22rocvdjDJBNGiPtxMhxm8EwVifADUXi8HEyDPFuNnBLve3uloMLRZigfZxX5yV2SmwMqB17M7jF4w6dbZQelYaT+lxe+Lh95FU/eIFYYRvJfmh2GCilph7JH1H+r9ydmvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746539987; c=relaxed/simple;
	bh=CkoiTXTjj8d9aaicoVN2Rau20I/DIb8g+69Zn9p40Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r/IxQaWbCf0RNUsiD+Wmk1TP2eVoN39tGGp00lCwg/ZCf2N72y5z0mZdwJIIhrR0JaG+gaCFfa5WK4YECvkEfE8M2JryHp/grzTyQyhMY6YqjAzBoBsYUkqScUv+XgAb9KnbCoeuHZnsyuAvysi1+KV2TmEM+ovb3v8k23vR0HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uCIpj-0007oF-Nr
	for netdev@vger.kernel.org; Tue, 06 May 2025 15:59:43 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uCIpj-001P7u-1J
	for netdev@vger.kernel.org;
	Tue, 06 May 2025 15:59:43 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 1DB48408F4E
	for <netdev@vger.kernel.org>; Tue, 06 May 2025 13:59:43 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id CC0C2408F33;
	Tue, 06 May 2025 13:59:41 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 071df4b2;
	Tue, 6 May 2025 13:59:40 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/6] pull-request: can 2025-05-06
Date: Tue,  6 May 2025 15:56:16 +0200
Message-ID: <20250506135939.652543-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
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

this is a pull request of 6 patches for net/main.

The first patch is by Antonios Salios and adds a missing
spin_lock_init() to the m_can driver.

The next 3 patches are by me and fix the unregistration order in the
mcp251xfd, rockchip_canfd and m_can driver.

The last patch is by Oliver Hartkopp and fixes RCU and BH
locking/handling in the CAN gw protocol.

regards,
Marc

---

The following changes since commit ebd297a2affadb6f6f4d2e5d975c1eda18ac762d:

  Merge tag 'net-6.15-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-05-01 10:37:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.15-20250506

for you to fetch changes up to 511e64e13d8cc72853275832e3f372607466c18c:

  can: gw: fix RCU/BH usage in cgw_create_job() (2025-05-06 15:55:36 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.15-20250506

----------------------------------------------------------------
Antonios Salios (1):
      can: m_can: m_can_class_allocate_dev(): initialize spin lock on device probe

Kelsey Maes (1):
      can: mcp251xfd: fix TDC setting for low data bit rates

Marc Kleine-Budde (4):
      can: mcp251xfd: mcp251xfd_remove(): fix order of unregistration calls
      can: rockchip_canfd: rkcanfd_remove(): fix order of unregistration calls
      can: mcan: m_can_class_unregister(): fix order of unregistration calls
      Merge patch series "can: rx-offload: fix order of unregistration calls"

Oliver Hartkopp (1):
      can: gw: fix RCU/BH usage in cgw_create_job()

 drivers/net/can/m_can/m_can.c                  |   3 +-
 drivers/net/can/rockchip/rockchip_canfd-core.c |   2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c |  42 +++++--
 net/can/gw.c                                   | 151 +++++++++++++++----------
 4 files changed, 127 insertions(+), 71 deletions(-)


