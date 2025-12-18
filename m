Return-Path: <netdev+bounces-245345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A3FCCBCB2
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 13:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0C3B3016783
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 12:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E08311C19;
	Thu, 18 Dec 2025 12:31:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA102A1BF
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766061105; cv=none; b=UglByLw0meJNZbZvkXKZHo1bT24Jrt6Mm9o/smyBk17MoaWUWFSCdj7Qbm5X8/TtPyyVq6k74AfyDHfG1eY8nlJTTRC1xZWRcgyph/q+rofC2J9kZKtrLlVwTC30odQg7zN37ve6L/CazPj1Z4h0qS5B5BJo9Io4xrrF/QFL4Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766061105; c=relaxed/simple;
	bh=ogpn+aQ4VK0e9e2dY//GG2PAfkNqplUhUxYC7DVNeT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q3Id/j8ZmhdL//32SNdWfkFdR0EONu4UIB7il8RMtijihETnWgjut6Gg/8EAE66MHfnU6zZEflQXYajmkubjOl8351vGv7HostAvC20mMwInsiVoUdWRUX4c8ydIwQkljHmy7ttfhydf2kIfAtUr6XhAJu9hICHQXY8Z2efLqOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vWDAP-0007wM-Tz; Thu, 18 Dec 2025 13:31:37 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vWDAO-006HQR-2e;
	Thu, 18 Dec 2025 13:31:36 +0100
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 918914B8270;
	Thu, 18 Dec 2025 12:31:36 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/3] pull-request: can 2025-12-18
Date: Thu, 18 Dec 2025 10:27:16 +0100
Message-ID: <20251218123132.664533-1-mkl@pengutronix.de>
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

this is a pull request of 3 patches for net/main.

Tetsuo Handa contributes 2 patches to fix race windows in the j1939
protocol to properly handle disappearing network devices.

The last patch is by me, it fixes a build dependency with the CAN
drivers, that got introduced while fixing a dependency between the CAN
protocol and CAN device code.

regards,
Marc

---

The following changes since commit 885bebac9909994050bbbeed0829c727e42bd1b7:

  nfc: pn533: Fix error code in pn533_acr122_poweron_rdr() (2025-12-11 01:40:00 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.19-20251218

for you to fetch changes up to 5a5aff6338c0f4164a6a8d8a7eb400c4054df256:

  can: fix build dependency (2025-12-18 09:04:47 +0100)

----------------------------------------------------------------
linux-can-fixes-for-6.19-20251218

----------------------------------------------------------------
Marc Kleine-Budde (1):
      can: fix build dependency

Tetsuo Handa (2):
      can: j1939: make j1939_session_activate() fail if device is no longer registered
      can: j1939: make j1939_sk_bind() fail if device is no longer registered

 drivers/net/can/Kconfig   | 2 +-
 net/can/j1939/socket.c    | 6 ++++++
 net/can/j1939/transport.c | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

