Return-Path: <netdev+bounces-123876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892F5966B62
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 23:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACEAC1C2238E
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 21:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D824D1BF31D;
	Fri, 30 Aug 2024 21:44:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546F01474C3
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 21:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725054257; cv=none; b=iz/TTznDhqp6qgD6salmuM6zFPixPckMtHPZrk38M4S/l4nA4WdzqByzZ60LCfooNol2u7Iwp6ja5AUN9FDmfvRy36PrqpVmAkfbqyPAoGceCiGt6HPp8+Z2j1PJDiWwsc7skmpsjXS95+VyEDGsM7Qk8vHTFl0WDDRCC2Q9YT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725054257; c=relaxed/simple;
	bh=SYSPKd1FX3isAQY6cZ0XVJ9SBnBlfCy0OA0fZkaxGVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k/tio9wqwOs5dXBimMJ3+/FDhtlD8h3Ha1yJEHMW5/+G8T9/AJIszwDUttEHRre9PzAblN1l7AeWVg/OQWMAqJ5gwK90uI7ybrB+FfWYdlKcJd/ZxpxKmYu9HhHoW8JKVTXBrddfQtTEWSnRLMbCpZGF0Oq8AbSDvXf4KTWx6Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk9Ph-0002cY-Pe
	for netdev@vger.kernel.org; Fri, 30 Aug 2024 23:44:13 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk9Ph-004FMC-9Z
	for netdev@vger.kernel.org; Fri, 30 Aug 2024 23:44:13 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id ECE0532E466
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 21:44:12 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id B86FD32E44E;
	Fri, 30 Aug 2024 21:44:11 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f2fabb05;
	Fri, 30 Aug 2024 21:44:10 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/6] pull-request: can-next 2024-08-30
Date: Fri, 30 Aug 2024 23:34:33 +0200
Message-ID: <20240830214406.1605786-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
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

this is a pull request of 6 patches for net-next/master.

The first patch is by Duy Nguyen and document the R-Car V4M support in
the rcar-canfd DT bindings.

Frank Li's patch converts the microchip,mcp251x.txt DT bindings
documentation to yaml.

A patch by Zhang Changzhong update a comment in the j1939 CAN
networking stack.

Stefan Mätje's patch updates the CAN configuration netlink code, so
that the bit timing calculation doesn't work on stale
can_priv::ctrlmode data.

Martin Jocic contributes a patch for the kvaser_pciefd driver to
convert some ifdefs into if (IS_ENABLED()).

The last patch is by Yan Zhen and simplifies the probe() function of
the kvaser USB driver by using dev_err_probe().

regards,
Marc

---


The following changes since commit cff69f72d33318f4ccfe7d5ff6c5616d00dd45a7:

  ethtool: pse-pd: move pse validation into set (2024-08-30 12:14:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-6.12-20240830

for you to fetch changes up to 0315c0b5ed253853a7b07dc97487522345110548:

  can: kvaser_usb: Simplify with dev_err_probe() (2024-08-30 22:40:23 +0200)

----------------------------------------------------------------
linux-can-next-for-6.12-20240830

----------------------------------------------------------------
Duy Nguyen (1):
      dt-bindings: can: renesas,rcar-canfd: Document R-Car V4M support

Frank Li (1):
      dt-bindings: can: convert microchip,mcp251x.txt to yaml

Martin Jocic (1):
      can: kvaser_pciefd: Use IS_ENABLED() instead of #ifdef

Stefan Mätje (1):
      can: netlink: avoid call to do_set_data_bittiming callback with stale can_priv::ctrlmode

Yan Zhen (1):
      can: kvaser_usb: Simplify with dev_err_probe()

Zhang Changzhong (1):
      can: j1939: use correct function name in comment

 .../bindings/net/can/microchip,mcp2510.yaml        |  70 ++++++++++++++
 .../bindings/net/can/microchip,mcp251x.txt         |  30 ------
 .../bindings/net/can/renesas,rcar-canfd.yaml       |  22 +++--
 drivers/net/can/dev/netlink.c                      | 102 ++++++++++-----------
 drivers/net/can/kvaser_pciefd.c                    |  26 +++---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   |  42 ++++-----
 net/can/j1939/transport.c                          |   8 +-
 7 files changed, 170 insertions(+), 130 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp2510.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt


