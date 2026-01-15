Return-Path: <netdev+bounces-250051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF093D23583
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6E7C3016B98
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CC7345CDC;
	Thu, 15 Jan 2026 09:06:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F1134676E
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 09:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768467979; cv=none; b=ONzIHKzC8hKwJAnGuKdoD5/B/PX0b1TawS7xIFH3uvKVg02e8G1ybbA97sRPLvDTGZgGiSq+PylVV7aBgLnmbo56159GWtC8TCMRLtb3od1aK9vw2ALLE6dbvKqavAnvZDaYJCSUVrBRqT231afbn3uhR3H4X0E92capwCpEoW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768467979; c=relaxed/simple;
	bh=v6HrDI9cHjNgf34ugiRGvSLeT0iHi/rraxnkXrDSAmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MqewBhwtJ9o4sqwTRnGHTaCBdw39A4us/Xe93m5kurDs3yDmqVkC5Rieu+Kz6JqdWG9udLWeRvF10DnfVOwUHlvR4JEscfhFBJzQZ7csfG21vMJVl+SXiMv8GdCPFzurgNjcUIxKfearwU3Ha41IXhSC2rtcmYvUuZfMQtPO0XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgJIu-0004cP-TW; Thu, 15 Jan 2026 10:06:08 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgJIv-000jGP-1B;
	Thu, 15 Jan 2026 10:06:08 +0100
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 70DB74CD6AF;
	Thu, 15 Jan 2026 09:06:08 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/4] pull-request: can 2026-01-15
Date: Thu, 15 Jan 2026 09:57:07 +0100
Message-ID: <20260115090603.1124860-1-mkl@pengutronix.de>
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

this is a pull request of 4 patches for net/main, it super-seeds the
"can 2026-01-14" pull request. The dev refcount leak in patch #3 is
fixed.

The first 3 patches are by Oliver Hartkopp and revert the approach to
instantly reject unsupported CAN frames introduced in
net-next-for-v6.19 and replace it by placing the needed data into the
CAN specific ml_priv.

The last patch is by Tetsuo Handa and fixes a J1939 refcount leak for
j1939_session in session deactivation upon receiving the second RTS.

regards,
Marc

---

The following changes since commit 3879cffd9d07aa0377c4b8835c4f64b4fb24ac78:

  net/sched: sch_qfq: do not free existing class in qfq_change_class() (2026-01-13 19:36:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.19-20260115

for you to fetch changes up to 1809c82aa073a11b7d335ae932d81ce51a588a4a:

  net: can: j1939: j1939_xtp_rx_rts_session_active(): deactivate session upon receiving the second rts (2026-01-15 09:52:39 +0100)

----------------------------------------------------------------
linux-can-fixes-for-6.19-20260115

----------------------------------------------------------------
Marc Kleine-Budde (1):
      Merge patch series "can: raw: better approach to instantly reject unsupported CAN frames"

Oliver Hartkopp (3):
      Revert "can: raw: instantly reject unsupported CAN frames"
      can: propagate CAN device capabilities via ml_priv
      can: raw: instantly reject disabled CAN frames

Tetsuo Handa (1):
      net: can: j1939: j1939_xtp_rx_rts_session_active(): deactivate session upon receiving the second rts

 drivers/net/can/Kconfig       |  7 ++++--
 drivers/net/can/Makefile      |  2 +-
 drivers/net/can/dev/Makefile  |  5 +++--
 drivers/net/can/dev/dev.c     | 27 +++++++++++++++++++++++
 drivers/net/can/dev/netlink.c |  1 +
 drivers/net/can/vcan.c        | 15 +++++++++++++
 drivers/net/can/vxcan.c       | 15 +++++++++++++
 include/linux/can/can-ml.h    | 24 ++++++++++++++++++++
 include/linux/can/dev.h       |  8 +------
 net/can/j1939/transport.c     | 10 ++++++++-
 net/can/raw.c                 | 51 +++++++++----------------------------------
 11 files changed, 111 insertions(+), 54 deletions(-)

