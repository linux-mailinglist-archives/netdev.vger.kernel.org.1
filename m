Return-Path: <netdev+bounces-206112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E41B01990
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 12:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB113AE170
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 10:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D8127FD41;
	Fri, 11 Jul 2025 10:17:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2775821ABCB
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 10:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752229036; cv=none; b=G1j1r3w4A81TxGqMtqi9JEacPnfBh4vj6JWmbrVe1AS9PH2uDItaCxIQ79yWwUpwlBTXVLlKHkR3ZXx1pVbVC7jvlOwHqg/nbV4cHI5dl4lmQ8V8buCUEq0cAqBZZ2wZ7+/CioH3EPCdKmhakrEF64y8fAWvUm4TrtKHns0xNpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752229036; c=relaxed/simple;
	bh=MfKKQy7H71bFuQfQ3gBqA+0Rnkt9sHoMRgP27H0LjaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X5C5jg57Wq34yKE3QIXySAJv9QWJf1H4Fev4snxKbP3j29sybvDXEd1G+EUYg98GFgGXQxMVnuJ9wqHgbSV18Uqx52LIEHIaKArtovj81hPg+Oz7pZNJNvZTTSpyy49o2u03kvYQxu4RqkP07STTfyWLJ88K/RZyH1b36415tAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uaAoY-0003zl-EA
	for netdev@vger.kernel.org; Fri, 11 Jul 2025 12:17:10 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uaAoY-007uA7-0l
	for netdev@vger.kernel.org;
	Fri, 11 Jul 2025 12:17:10 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id E3B9C43C7E5
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 10:17:09 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id A5A6B43C7D6;
	Fri, 11 Jul 2025 10:17:08 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 58746210;
	Fri, 11 Jul 2025 10:17:07 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/2] pull-request: can-next 2025-07-11
Date: Fri, 11 Jul 2025 12:15:07 +0200
Message-ID: <20250711101706.2822687-1-mkl@pengutronix.de>
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

this is a pull request of 2 patches for net-next/main.

The first patch is by Geert Uytterhoeven and converts the rcar_can
driver to DEFINE_SIMPLE_DEV_PM_OPS.

The last patch is by Biju Das and removes unused macros from the
rcar_canfd driver.

regards,
Marc

---

The following changes since commit 0f26870a989bf69957ed69d10c7ffc57ca5a7f52:

  Merge tag 'nf-next-25-07-10' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next (2025-07-10 18:18:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-6.17-20250711

for you to fetch changes up to 0e6639c8505d70e821bc27f951a0ff6303f10d4d:

  can: rcar_canfd: Drop unused macros (2025-07-11 11:48:02 +0200)

----------------------------------------------------------------
linux-can-next-for-6.17-20250711

----------------------------------------------------------------
Biju Das (1):
      can: rcar_canfd: Drop unused macros

Geert Uytterhoeven (1):
      can: rcar_can: Convert to DEFINE_SIMPLE_DEV_PM_OPS()

 drivers/net/can/rcar/rcar_can.c   |  9 ++--
 drivers/net/can/rcar/rcar_canfd.c | 93 ---------------------------------------
 2 files changed, 5 insertions(+), 97 deletions(-)


