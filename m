Return-Path: <netdev+bounces-196991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2DEAD73BD
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 16:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A057E3A49F3
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7559247DF9;
	Thu, 12 Jun 2025 14:25:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from glittertind.blackshift.org (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96E322126E
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.23.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749738314; cv=none; b=ie6Ik1Vky70bYRzVrjb3vTs2YC6ypXxpB1pw+vsJLwBX9Eee86k+aT6n+yy9JKAnB5WSm6bHIie9XXZFFtWEGShMduXxe36/hPu3Ma4Qs2LLDBWox8uevti2GA6yptSA1Y4+ORQ0veIRLHg8lHgauZQV/fsKD3IdMUzbmN6KjlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749738314; c=relaxed/simple;
	bh=cU0YxEDE2UjP6n/4f3vNPORMNpitnn9kuSiOsDU/GHY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U1R+XbIQcK7UbymlMUbHRcZ0OQv1oW+sAsQ2hKEn6atTKTtlyyS4o7EW0FGRDdWtAjpgg6bdAwBY+CMfgONNRG4mcQwk7LYsJnkDFwKDzyN/u6a2bl7z8Yr+bLCRNARzoT3A6HyrPG1z2HbVqcaoegwzoXioCkb72OBA1nDkpYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=none smtp.mailfrom=hardanger.blackshift.org; arc=none smtp.client-ip=116.203.23.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hardanger.blackshift.org
Received: from bjornoya.blackshift.org (unknown [IPv6:2003:e3:7f3d:bb00:e75c:5124:23a3:4f62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "bjornoya.blackshift.org", Issuer "R10" (verified OK))
	by glittertind.blackshift.org (Postfix) with ESMTPS id E6EC566BB9D
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 14:16:21 +0000 (UTC)
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id B3E4342646B
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 14:16:21 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id D98AA42641D;
	Thu, 12 Jun 2025 14:16:17 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 055e1c19;
	Thu, 12 Jun 2025 14:16:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next v2 00/10] net: fec: cleanups, update quirk, update
 IRQ naming
Date: Thu, 12 Jun 2025 16:15:53 +0200
Message-Id: <20250612-fec-cleanups-v2-0-ae7c36df185e@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABnhSmgC/1WNQQ6CMBBFr0Jm7Zi2tgiuvIdhAe0ATcxA2kIwh
 Ltb2bl8efnv7xApeIrwKHYItProJ86gLgXYseWB0LvMoITSolYGe7Jo39TyMke0dWeM1p2tjIY
 8mQP1fjtzL2BKyLQlaLIZfUxT+Jw/qzz9LymFLP+Tq0SBju7VrXPSUNk+Z+JhSWFiv10dQXMcx
 xfnBamrtwAAAA==
X-Change-ID: 20240925-fec-cleanups-c9b5544bc854
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=2076; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=cU0YxEDE2UjP6n/4f3vNPORMNpitnn9kuSiOsDU/GHY=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBoSuEbClArwX+nTRoEhDnrwcdDMtqdx3HQNnFzt
 SkZ3vNrzyGJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaErhGwAKCRAMdGXf+ZCR
 nLCoB/4pDPVR0Pde2JRt6ZBeDv4IAOBgoCmF67KSKDbUhFNXSkfmsoG3Vuu+oM1XEMNI/lHRzSJ
 qud67Uhl3tB4zFKBUzy0wyotA3p68oxoGMnuZxF5CtUanm+I9IKB0UgQJ/gC+GQFv18bFJN3NXb
 Qcu4cZhJhm/WnBWWA56asy2YUlZs1e+iWLvpz6+JnW0fZXZob/ipezoIXnPELz7UMkl22dZ8SOr
 J9iqVWH7Frjs8ghxAVOWRXP+G3Dv6hDP3d8r1H5uzW5fP9y0rJJa0Fo2QL0qzQxLo3/iRoxCIog
 5tPMojNoTgCqnF53Abhdaq+JdEEOBhuj3oqlnesUf5uXzFXC
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

This series first cleans up the fec driver a bit (typos, obsolete
comments, add missing header files, rename struct, replace magic
number by defines).

The next 2 patches update the order of IRQs in the driver and gives
them names that reflect their function.

The last 5 patches clean up the fec_enet_rx_queue() function,
including VLAN handling.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes in v2:
- removed patches 7, 8 for now
- rebased to recent net-next/main:
  dropped patch 6
- 2, 3: wrap patch description at 75 chars:
  (thanks Frank Li)
- 4, 5, 6, 7, 9: updated wording of patch description
  (thanks Frank Li)
- 10: move VLAN_header into the if statement (thanks Wei Fang)
- 10: mark several variables const
- collected Wei Fang's and Frank Li's Reviewed-by
- Link to v1: https://patch.msgid.link/20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de

---
Marc Kleine-Budde (10):
      net: fec: fix typos found by codespell
      net: fec: struct fec_enet_private: remove obsolete comment
      net: fec: add missing header files
      net: fec: rename struct fec_devinfo fec_imx6x_info -> fec_imx6sx_info
      net: fec: fec_restart(): introduce a define for FEC_ECR_SPEED
      net: fec: fec_enet_rx_queue(): use same signature as fec_enet_tx_queue()
      net: fec: fec_enet_rx_queue(): replace manual VLAN header calculation with skb_vlan_eth_hdr()
      net: fec: fec_enet_rx_queue(): reduce scope of data
      net: fec: fec_enet_rx_queue(): move_call to _vlan_hwaccel_put_tag()
      net: fec: fec_enet_rx_queue(): factor out VLAN handling into separate function fec_enet_rx_vlan()

 drivers/net/ethernet/freescale/fec.h      | 11 +++---
 drivers/net/ethernet/freescale/fec_main.c | 56 +++++++++++++++----------------
 drivers/net/ethernet/freescale/fec_ptp.c  |  4 +--
 3 files changed, 35 insertions(+), 36 deletions(-)
---
base-commit: 5d6d67c4cb10a4b4d3ae35758d5eeed6239afdc8
change-id: 20240925-fec-cleanups-c9b5544bc854

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



