Return-Path: <netdev+bounces-285268-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFhiBIF2/Gm3QQAAu9opvQ
	(envelope-from <netdev+bounces-285268-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:24:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AA84E76BD
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A8F5301CF97
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 11:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB543B7776;
	Thu,  7 May 2026 11:23:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B7637D13E
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 11:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778153010; cv=none; b=SI+BhVISPGKVfoH3HXYEQJvsKy064hO4m3+FhNy39y0llMflQCrFIkuldn++EF7LDKGsMhSWmbFLgjKCsqDp4xq6w7oGnZLCR4cPRq4acwAZqpWATrwreMexRwzfYjzQbITpWIAQ9QhG3dIbyCLChbv+zyWxfdh1rcwmxofXY6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778153010; c=relaxed/simple;
	bh=mUOYDX69Yo2Cey6LzU6C+AKQLmkzTJl6hjB+pZR5lyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lI2qLP2IOmkf4GXjn+KN86K6f9Ldm5iBiOjIJcSymKfa29W6+Xqy2rj3y/h0VDpuhMR8xDNhIFAiqgy88zF2POTbRfmktbyQybza8fG6OqbFmGZU0/NI1c1yflnmbIPqzZ87pNO745gcj9u7lCtpjW8QB45Z+PmsInzWXHBJoeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1wKwp9-0002vi-Kp; Thu, 07 May 2026 13:23:23 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wKwp8-000ufc-2Z;
	Thu, 07 May 2026 13:23:23 +0200
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id F3CCB530405;
	Thu, 07 May 2026 11:23:22 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/6] pull-request: can 2026-05-07
Date: Thu,  7 May 2026 10:22:22 +0200
Message-ID: <20260507112321.439968-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
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
X-Rspamd-Queue-Id: 67AA84E76BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285268-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello netdev-team,

this is a pull request of 6 patches for net/main.

The first patch is by Oliver Hartkopp and adds missing locking to the
raw_setsockopt() function in the CAN raw protocol.

A patch by Lee Jones fixes a hrtimer Use-After-Free in the CAN
broadcast manager protocol.

Alexander Hölzl's patch fixes the RX timeout for CTS holds messages in
the CAN J1939 protocol.

Shuhao Fu contributes a patch that adds missing locking to the
local-destination check in the CAN J1939 protocol.

Stéphane Grosjean's patch updates his email address.

The last patch is by Ciprian Marian Costea and consistently
disables/enables the all IRQ lines while writing the IRQ enable
registers.

regards,
Marc

---

The following changes since commit b266bacba796ff5c4dcd2ae2fc08aacf7ab39153:

  net: ethernet: cortina: Drop half-assembled SKB (2026-05-06 18:43:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-7.1-20260507

for you to fetch changes up to f22a636357d5ff4fd2bb10d8079d851ccb320438:

  can: flexcan: disable all IRQ lines in flexcan_chip_interrupts_enable() (2026-05-07 10:05:55 +0200)

----------------------------------------------------------------
linux-can-fixes-for-7.1-20260507

----------------------------------------------------------------
Alexander Hölzl (1):
      can: j1939: fix wrong RX timeout for CTS hold messages

Ciprian Marian Costea (1):
      can: flexcan: disable all IRQ lines in flexcan_chip_interrupts_enable()

Lee Jones (1):
      can: bcm: prevent thrtimer UAF in rx path by checking RX_NO_AUTOTIMER

Oliver Hartkopp (1):
      can: raw: add locking for raw flags bitfield

Shuhao Fu (1):
      can: j1939: fix lockless local-destination check

Stéphane Grosjean (1):
      can: peak: Modification of references to email accounts being deleted

 .mailmap                                      |  4 +-
 drivers/net/can/flexcan/flexcan-core.c        | 14 ++++++
 drivers/net/can/peak_canfd/peak_canfd.c       |  2 +-
 drivers/net/can/peak_canfd/peak_canfd_user.h  |  2 +-
 drivers/net/can/peak_canfd/peak_pciefd_main.c |  4 +-
 drivers/net/can/sja1000/peak_pci.c            |  4 +-
 drivers/net/can/sja1000/peak_pcmcia.c         |  4 +-
 drivers/net/can/usb/peak_usb/pcan_usb.c       |  2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c  |  4 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.h  |  2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c    |  2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c   |  2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.h   |  2 +-
 include/linux/can/dev/peak_canfd.h            |  2 +-
 net/can/bcm.c                                 |  6 +++
 net/can/j1939/transport.c                     | 20 ++++++--
 net/can/raw.c                                 | 66 ++++++++++++---------------
 17 files changed, 83 insertions(+), 59 deletions(-)

