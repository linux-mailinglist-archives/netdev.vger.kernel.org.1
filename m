Return-Path: <netdev+bounces-80783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B118810D2
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 12:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9067C1F24A7E
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 11:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDBA3F8F6;
	Wed, 20 Mar 2024 11:21:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319CF3C060
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710933713; cv=none; b=RbL0nKBoJJZERrMbuFe104McYP8z5Z+5rRrbo/0mDO88JMZzk4CjjvW4isFcJLzj6aCaHxIwa10KoRMwn02T4e2Or7JTDv62iIvPdaQJWoNn+fhlO/G9IbBOzhOAZdDhJj90roOYMdZJzuojckeJg5FqYCSO/aCxWWflYSf7s7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710933713; c=relaxed/simple;
	bh=56+XN9Gm3MPNwwzg6kROpfaR0TLddtGJb7+YQi6bQrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WoycOvAKW8qkGya1tnLP3EgCGdmk5m1W2oai5aNJIr4Ua4YWj2VJvW0DEN1to9yALvvJkqDxvIwSYmwEN+ebMJ8soZDtEet/kbtY7R/z9d7rLgXDONx86J1HG9LXEasFZXPCd6ba5wS3cQVmFTPpb6fyG1j3ERJjYhm1MLvTSW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rmu0y-0007lQ-9B
	for netdev@vger.kernel.org; Wed, 20 Mar 2024 12:21:48 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rmu0x-007SJE-Rw
	for netdev@vger.kernel.org; Wed, 20 Mar 2024 12:21:47 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 8745D2A8249
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 11:21:47 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 66AF12A823F;
	Wed, 20 Mar 2024 11:21:46 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id fffd2902;
	Wed, 20 Mar 2024 11:21:45 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/1] pull-request: can 2024-03-20
Date: Wed, 20 Mar 2024 11:50:25 +0100
Message-ID: <20240320112144.582741-1-mkl@pengutronix.de>
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

this is a pull request of 1 patch for net/master.

Martin Jocić contributes a fix for the kvaser_pciefd driver, so that
up to 8 channels on the Xilinx-based adapters can be used. This issue
has been introduced in net-next for v6.9.

regards,
Marc

---

The following changes since commit e54e09c05c00120cbe817bdb037088035be4bd79:

  net: remove {revc,send}msg_copy_msghdr() from exports (2024-03-14 16:48:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.9-20240319

for you to fetch changes up to af1752ecdc9c665b72fbe2cef9035a6cba34b473:

  can: kvaser_pciefd: Add additional Xilinx interrupts (2024-03-19 15:26:01 +0100)

----------------------------------------------------------------
linux-can-fixes-for-6.9-20240319

----------------------------------------------------------------
Martin Jocić (1):
      can: kvaser_pciefd: Add additional Xilinx interrupts

 drivers/net/can/kvaser_pciefd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


