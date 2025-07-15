Return-Path: <netdev+bounces-207057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40432B05796
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 12:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E3E1C21F06
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 10:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529ED2D5423;
	Tue, 15 Jul 2025 10:16:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FA1222574
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 10:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752574593; cv=none; b=c9YFv0CkRmiGohBwXOIx5RCw4UmnSnORNfxSNnN/Ww/csrbEEfjvajoGWXyGHPUBXBu/3woU1qy+nO04pZ2ki67U0/FVI1NOCLF+/fAy/vb6kVeaHWKg65dOKkW8kjKxqkJyU5fk1DYW4GubDpQ8PmXGxPbvFaMr774zuHdwW+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752574593; c=relaxed/simple;
	bh=9NQXbLYHLCVTUaqTmaD5MLKq5KGNRk+/GTkeDF2gbFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YOAiKojyt+L0f/AA4QmPfv6oDGAd72HBddJ+MTWh3hMDydJHCqCs+K07WDIq2QwEevn3KHGcXfGFp5EbEsNVwP2/+bvt7HQxa2nD/lNZaUXTQ3cdYA3/jlJjWj06PAjl07MO+JLCSXXvFNhYYGeBn3OREJqXtgbg4N5unroZRBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ubci4-0008KE-WB
	for netdev@vger.kernel.org; Tue, 15 Jul 2025 12:16:29 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ubci4-008Z0W-2Z
	for netdev@vger.kernel.org;
	Tue, 15 Jul 2025 12:16:28 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 7C2864422F7
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 10:16:28 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 64BBC4422EA;
	Tue, 15 Jul 2025 10:16:27 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id c18f7048;
	Tue, 15 Jul 2025 10:16:26 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/1] pull-request: can 2025-07-15
Date: Tue, 15 Jul 2025 12:13:38 +0200
Message-ID: <20250715101625.3202690-1-mkl@pengutronix.de>
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

this is a pull request of 1 patch for net/main.

Brett Werling's patch for the tcan4x5x glue code driver fixes the
detection of chips which are held in reset/sleep and must be woken up
by GPIO prior to communication.

regards,
Marc

---

The following changes since commit f0f2b992d8185a0366be951685e08643aae17d6d:

  net: phy: Don't register LEDs for genphy (2025-07-14 17:53:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.16-20250715

for you to fetch changes up to 0f97a7588db7a545ea07ee0d512789bfad4931d8:

  can: tcan4x5x: fix reset gpio usage during probe (2025-07-15 11:59:43 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.16-20250715

----------------------------------------------------------------
Brett Werling (1):
      can: tcan4x5x: fix reset gpio usage during probe

 drivers/net/can/m_can/tcan4x5x-core.c | 61 +++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 20 deletions(-)


