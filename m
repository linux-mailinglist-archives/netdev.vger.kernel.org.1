Return-Path: <netdev+bounces-152929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 076969F65B1
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 13:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D607818821A0
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 12:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16021A2381;
	Wed, 18 Dec 2024 12:17:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE97199EA1
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 12:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734524250; cv=none; b=ilbuoT1KIP8bfTvt1kk0oGFcE33q8a0DPlHbZ8BFSH24shU7cjp0fUumTK7LglcMqsPSrLjCR9GUMfre3C5F0A/ak+BnO3qetonWdk8iXzbQVO08GkKMcwe+jAb8j3Y56SUgW0fsNjnFXHjew0BaazfRmHZoWHTzXJqUoK39QOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734524250; c=relaxed/simple;
	bh=K3Q5friwXF+y+4U48NWKPARZppEkjNyoH+uGCDtDhp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d73OZaOBJ8tYeIXQAwI8Zn8eQDQBUho5HJbwLY3RI7JMsBba9eStSom4ZWLE1IwHGsn5ifeWX5zAQt9Uqu8vLhITJ2Cp2coKv6MGGjezCFWSWptCHpnTPSdCnIBl/GUOo954FJM2XrOmMpjBDde08Ve2nE0XcyB22aamnWE0kaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tNszW-0003Tw-3C
	for netdev@vger.kernel.org; Wed, 18 Dec 2024 13:17:26 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tNszV-0041vU-0P
	for netdev@vger.kernel.org;
	Wed, 18 Dec 2024 13:17:25 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 96814391684
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 12:17:25 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 55B2F391676;
	Wed, 18 Dec 2024 12:17:24 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f5cbc05e;
	Wed, 18 Dec 2024 12:17:23 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/2] pull-request: can 2024-12-18
Date: Wed, 18 Dec 2024 13:10:26 +0100
Message-ID: <20241218121722.2311963-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
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

this is a pull request of 21 patches for net/master.

There are 2 patches by Matthias Schiffer for the m_can_pci driver that
handles the m_can cores found on the Intel Elkhart Lake processor.
They fix the initialization and the interrupt handling under high CAN
bus load.

regards,
Marc

---

The following changes since commit 954a2b40719a21e763a1bba2f0da92347e058fce:

  rtnetlink: Try the outer netns attribute in rtnl_get_peer_net(). (2024-12-17 17:54:18 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.13-20241218

for you to fetch changes up to 87f54c12195150fec052f6a5458fcecdda5ec62f:

  Merge patch series "can: m_can: set init flag earlier in probe" (2024-12-18 09:32:14 +0100)

----------------------------------------------------------------
linux-can-fixes-for-6.13-20241218

----------------------------------------------------------------
Marc Kleine-Budde (1):
      Merge patch series "can: m_can: set init flag earlier in probe"

Matthias Schiffer (2):
      can: m_can: set init flag earlier in probe
      can: m_can: fix missed interrupts with m_can_pci

 drivers/net/can/m_can/m_can.c     | 36 ++++++++++++++++++++++++++----------
 drivers/net/can/m_can/m_can.h     |  1 +
 drivers/net/can/m_can/m_can_pci.c |  1 +
 3 files changed, 28 insertions(+), 10 deletions(-)


