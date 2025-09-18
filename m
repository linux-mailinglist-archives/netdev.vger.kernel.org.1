Return-Path: <netdev+bounces-221243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD6DB4FE05
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF10E1885523
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 13:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A0D342C93;
	Tue,  9 Sep 2025 13:48:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A220A342C8B
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 13:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425727; cv=none; b=Tfq0KC31TlufX1TFIi4hYFvS2xiGVpqEbhB+Am26wzp3h9hjjSAyhcZ6krrxTFHlDxUzromDbai2bhABMxNAABTfvMyVVfaiGbwk8+3I4PjkR+NZAyNJBnPBSM08/vrP1uijRuabzbE/liI5AtZlviWiB7md3oTlBwqln76prwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425727; c=relaxed/simple;
	bh=ENZBonPpkHIXZjduXOGlH5Jt3VfTDhsFHwZfOoaLocE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u43CKl5gfwzFip3DGI+DdN/8MPg+zw3w8auoH7aTW6gfcNmXNfoORABAnGOnhK0hABIGvWSgs6ElVPC+Y7J5E6gFxs1UB/x5Zvy6JxnjR4Xoc/zfb65inkSh19cXTCjN41WViQXZ7MGLdE0yqsemkP76haklfwkEDyNGLWSeh9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvyiC-0002i2-3Y
	for netdev@vger.kernel.org; Tue, 09 Sep 2025 15:48:44 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvyiB-000Qkv-2p
	for netdev@vger.kernel.org;
	Tue, 09 Sep 2025 15:48:43 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 836FB46A03D
	for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 13:48:43 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 3BAB046A023;
	Tue, 09 Sep 2025 13:48:42 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 0e1bf272;
	Tue, 9 Sep 2025 13:48:41 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/7] pull-request: can 2025-09-09
Date: Tue,  9 Sep 2025 15:34:53 +0200
Message-ID: <20250909134840.783785-1-mkl@pengutronix.de>
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

this is a pull request of 7 patches for net/main.

The 1st patch is by Alex Tran and fixes the Documentation of the
struct bcm_msg_head.

Davide Caratti's patch enabled the VCAN driver as a module for the
Linux self tests.

Tetsuo Handa contributes 3 patches that fix various problems in the
CAN j1939 protocol.

Anssi Hannula's patch fixes a potential use-after-free in the
xilinx_can driver.

Geert Uytterhoeven's patch fixes the rcan_can's suspend to RAM on
R-Car Gen3 using PSCI.

regards,
Marc

---

The following changes since commit d3b28612bc5500133260aaf36794a0a0c287d61b:

  net: phy: NXP_TJA11XX: Update Kconfig with TJA1102 support (2025-09-08 18:24:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.17-20250909

for you to fetch changes up to 74485647e0f97a39417a5d993aaf65e378ca3e13:

  can: rcar_can: rcar_can_resume(): fix s2ram with PSCI (2025-09-09 14:30:15 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.17-20250909

----------------------------------------------------------------
Alex Tran (1):
      docs: networking: can: change bcm_msg_head frames member to support flexible array

Anssi Hannula (1):
      can: xilinx_can: xcan_write_frame(): fix use-after-free of transmitted SKB

Davide Caratti (1):
      selftests: can: enable CONFIG_CAN_VCAN as a module

Geert Uytterhoeven (1):
      can: rcar_can: rcar_can_resume(): fix s2ram with PSCI

Tetsuo Handa (3):
      can: j1939: implement NETDEV_UNREGISTER notification handler
      can: j1939: j1939_sk_bind(): call j1939_priv_put() immediately when j1939_local_ecu_get() failed
      can: j1939: j1939_local_ecu_get(): undo increment when j1939_local_ecu_get() fails

 Documentation/networking/can.rst       |  2 +-
 drivers/net/can/rcar/rcar_can.c        |  8 +-----
 drivers/net/can/xilinx_can.c           | 16 +++++------
 net/can/j1939/bus.c                    |  5 +++-
 net/can/j1939/j1939-priv.h             |  1 +
 net/can/j1939/main.c                   |  3 ++
 net/can/j1939/socket.c                 | 52 ++++++++++++++++++++++++++++++++++
 tools/testing/selftests/net/can/config |  4 +++
 tools/testing/selftests/net/config     |  3 --
 9 files changed, 74 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/net/can/config


