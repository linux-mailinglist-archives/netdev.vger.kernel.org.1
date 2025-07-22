Return-Path: <netdev+bounces-208879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FC3B0D79D
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D447B1AA737B
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 11:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C2B2D63F3;
	Tue, 22 Jul 2025 11:01:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865D6243364
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 11:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753182065; cv=none; b=KX6zpG0Mh5+ieYS02jKhDhCmRTSmVvnU7TSZGJPhqfcvGupGraiDU0zXXF4FEAneAU2vkAzld8T6OmJy7+O8Rts/DEfahmbmGdfS6CtfRVL9ZiE80KnkV1EDA1LGCGnn6g3rH5wrzFmZw5kIsgnc+lMPXnRi+XBMUiMA6MMj0BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753182065; c=relaxed/simple;
	bh=YqxjOCYHVsZhsjopP1jOUVttcmHJ8CB+cAo4Ub+7uZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=do9EJip+SDLxVEgMnLhuvjsmfiUhUefYFrl2RQ4pnWrXSqPMOuok8RORJdwBjzjsJWA8q1iPQz3KI6ZUVIwVx1EzfFv1hUOc6p/JF6wt4sPBTczxO6pzwZj1C7FEqaMFstJKEu2/BXv++Bmab1j9uQjC+e8wyluaB3ARBvEzmhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ueAk2-0000FX-IV
	for netdev@vger.kernel.org; Tue, 22 Jul 2025 13:01:02 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ueAk2-009i4C-19
	for netdev@vger.kernel.org;
	Tue, 22 Jul 2025 13:01:02 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 0EDF44463E3
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 11:01:02 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id E5DF64463D9;
	Tue, 22 Jul 2025 11:01:00 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 2d76f8a4;
	Tue, 22 Jul 2025 11:01:00 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/1] pull-request: can 2025-07-22
Date: Tue, 22 Jul 2025 12:58:31 +0200
Message-ID: <20250722110059.3664104-1-mkl@pengutronix.de>
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

The patch is by me and fixes a potential NULL pointer deref in the CAN
device driver infrastructure. It can be triggered from user space.

regards,
Marc

---

The following changes since commit b03f15c0192b184078206760c839054ae6eb4eaa:

  gve: Fix stuck TX queue for DQ queue format (2025-07-21 17:14:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.16-20250722

for you to fetch changes up to c1f3f9797c1f44a762e6f5f72520b2e520537b52:

  can: netlink: can_changelink(): fix NULL pointer deref of struct can_priv::do_set_mode (2025-07-22 12:55:13 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.16-20250722

----------------------------------------------------------------
Marc Kleine-Budde (1):
      can: netlink: can_changelink(): fix NULL pointer deref of struct can_priv::do_set_mode

 drivers/net/can/dev/dev.c     | 12 +++++++++---
 drivers/net/can/dev/netlink.c | 12 ++++++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)


