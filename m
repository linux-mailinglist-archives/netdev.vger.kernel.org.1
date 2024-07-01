Return-Path: <netdev+bounces-108030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7444691D9A5
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 10:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E959284EEA
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 08:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FB7823DE;
	Mon,  1 Jul 2024 08:06:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223C577F1B
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 08:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719821217; cv=none; b=B80DZ7gXY6oVIShnTfouaGzbkKfCZ/tMaCaYWI6ZfbCKPoo2vwhYT0u9G9NGs9SAU0NznCLTWjttyWE6um6tuEY6sm4CKcPg3+0I+NBpP2ZmAWDWHxK4ng/Ky69+9PUG2rLNKnpNbmTh+a/mwglRsQohiqwcybOLlUNwL2gnV6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719821217; c=relaxed/simple;
	bh=qHArqbNYlXaBcr5ma4KWcFFp3nH2lHPUG2fCdNxhQoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iDXE+LKgBmId8XWXifIVEgorM1Qdizcvrxue+BKnP3ZDR5yRi99OXQMrKw8fTd1hsicLY+tkYnocjOVjh4bK4RaDf+pyERawmjviHQseT6eklO3PhyiJadL3/6k9gsToad/E4yppgL+zYcNVCVaj+IbeYPaCWJtlZTE4EnPlh3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sOC3k-0002lX-O3
	for netdev@vger.kernel.org; Mon, 01 Jul 2024 10:06:48 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sOC3k-006KC8-BC
	for netdev@vger.kernel.org; Mon, 01 Jul 2024 10:06:48 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 092732F7193
	for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 08:06:47 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id EB5932F7189;
	Mon, 01 Jul 2024 08:06:46 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ef2aa0a2;
	Mon, 1 Jul 2024 08:06:46 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/1] pull-request: can 2024-07-01
Date: Mon,  1 Jul 2024 10:03:21 +0200
Message-ID: <20240701080643.1354022-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
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

this is a pull request of 1 patch for net/master.

Jimmy Assarsson's patch for the kvaser_usb adds a missing explicit
initialization of the struct kvaser_usb_driver_info::family for the
kvaser_usb_driver_info_leafimx.

regards,
Marc

---
The following changes since commit 134061163ee5ca4759de5c24ca3bd71608891ba7:

  bnx2x: Fix multiple UBSAN array-index-out-of-bounds (2024-06-28 18:19:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.10-20240701

for you to fetch changes up to 19d5b2698c35b2132a355c67b4d429053804f8cc:

  can: kvaser_usb: Explicitly initialize family in leafimx driver_info struct (2024-07-01 08:55:16 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.10-20240701

----------------------------------------------------------------
Jimmy Assarsson (1):
      can: kvaser_usb: Explicitly initialize family in leafimx driver_info struct

 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 1 +
 1 file changed, 1 insertion(+)


