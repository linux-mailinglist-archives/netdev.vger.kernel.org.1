Return-Path: <netdev+bounces-219135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A08B400F1
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A56A62C39C9
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E0E28DB56;
	Tue,  2 Sep 2025 12:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AWfOKPLH"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F5F28CF4A;
	Tue,  2 Sep 2025 12:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816895; cv=none; b=Y+1xBQSNsnTdYVHn0s70xZ1bNwRR+OcMZCxDGux2mcUAj+pcDkdRiAsAfhgDSh3kj8FD4uNPmIHT6s8gDPfLoIV1C/0CPl4/vSHRkm7B+fMim/Dz3F6349LNVdaweFyzCipgFxEaibOOU4z6oFd+gQOzkxDI3dqT+XI39bSmqvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816895; c=relaxed/simple;
	bh=M4uI8aFAFfvb6PvO1EZR0WydjlQUd8lvqrrz0abedd4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LB7rM7r3My6bwvJ+d1VLj3E6BnZupuARUyTYiKC5dB8il5ywkOIkLCm5eaZwsXX1evnoxjbcf+fdZaov8ycOGHxy9O2UcKX81Wm9st6nt1t88c+we1fsUwsY8syeopdN6QXWiiyMBSdLZFNMtQTA2c4k6PocA9yzjnr2VhAYzuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AWfOKPLH; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756816894; x=1788352894;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M4uI8aFAFfvb6PvO1EZR0WydjlQUd8lvqrrz0abedd4=;
  b=AWfOKPLHdzxkjtcjnrgv2kQy1tYMJhVYLaYxsof4QLfgaiEF2Pvx4lL7
   BnRgr08tJ6Gye+3AsOUAjm3myT5mJEiY7ifof8CbmEI0Y7C7oe/jbxkEN
   ECxcWpc2hLxhYovPNAn9pF6gnCoFxw19bEbEZfdKo6nbHq3GF5b9KBCuQ
   yEE+tLhM3kZyHwmk4y283eLAY5A08Tzoda0B39Fbar3N6VcIOpon8Q3dw
   +vzqLnPJWkQ6IWTE7iZKhH0bafM2BzeuIAVN6U+XWkHmNjkNDshsIqfp3
   fyu4Vx4Bg38rhB3XHv3VsVRLry97TOdFWf1J4pKhQ8hREbo8FzQrEyX+B
   Q==;
X-CSE-ConnectionGUID: uSbTBh14QEunAdjSx76qwQ==
X-CSE-MsgGUID: M5dpYUY/Sd2bRQfknAEXmw==
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="213345453"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2025 05:41:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 2 Sep 2025 05:41:29 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 2 Sep 2025 05:41:27 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>,
	<Parthiban.Veerasooran@microchip.com>, <kory.maincent@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next v7 0/2] net: phy: micrel: Add PTP support for lan8842
Date: Tue, 2 Sep 2025 14:18:30 +0200
Message-ID: <20250902121832.3258544-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The PTP block in lan8842 is the same as lan8814 so reuse all these
functions.  The first patch of the series just does cosmetic changes such
that lan8842 can reuse the function lan8814_ptp_probe. There should not be
any functional changes here. While the second patch adds the PTP support
to lan8842.

v6->v7:
- the v6 was not sent by mistake to mailing lists, so this version just
  sends also to the mailing list

v5->v6:
- update commit message of the first commit to say that lan8842 had a
  different number of GPIOs
- add define for 0x8832
- threrefore -> therefore

v4->v5:
- remove phydev from lan8842_priv as is not used
- change type for rev to be u16 and fix holes in the struct
- assign ret to priv->rev only after it is checked

v3->v4:
- when reading PHY addr first check return value and then mask it
- change the type of gpios in the declration of __lan8814_ptp_probe_once

v2->v3:
- check return value of function devm_phy_package_join

v1->v2:
- use reverse x-mas notation
- replace hardcoded value with define

Horatiu Vultur (2):
  net: phy: micrel: Introduce function __lan8814_ptp_probe_once
  net: phy: micrel: Add PTP support for lan8842

 drivers/net/phy/micrel.c | 116 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 111 insertions(+), 5 deletions(-)

-- 
2.34.1


