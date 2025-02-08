Return-Path: <netdev+bounces-164246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8066CA2D1F3
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 01:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4A23AAF3E
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 00:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FB08F6B;
	Sat,  8 Feb 2025 00:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vwW4BW7Y"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165A12CA6;
	Sat,  8 Feb 2025 00:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974301; cv=none; b=lTd7wiDj2jBYexiEb0QklkSuUSz7qBGwL/d0QtWXZx9booFrgxcbeIg61I3BJ5eMVAjOT7UyX/vzaHtiw2rM+crRzbjE0y61KLNMTNzn/zOc5oZ28mWUKU4RxdnP60qf2GgArbmF7BAl8wUWtKMyzqVna9iX3u0A8oIJDVeyb9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974301; c=relaxed/simple;
	bh=tzqpNMyvQqy7elPkBBrZ8yH25S4Z/HEWXa++LxwYC6A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eiC3WcyEeQ5i0A9ZENLE0QHOLaM7wah+B4vksimEiRRHrQlnpSiot6xuXmjZnH62MqS/e4fLLPLH5J81IZMy+lWs5tgS2EKMdeCDQfIIf0fNmQXr3OopgOUAkskOEdSgyUOQNWXF2WajZ4aWKebdf0kk2Ziz9PBGrRonG4xOhlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vwW4BW7Y; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1738974300; x=1770510300;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tzqpNMyvQqy7elPkBBrZ8yH25S4Z/HEWXa++LxwYC6A=;
  b=vwW4BW7Yxhp5zHSAS4keJTnszgD3zvi8sKt8HGjim0DNxBypgyteZMdZ
   T89M2forsNUS5nmmyj5r4K+MThqqAtxouqcc53wD46dEfpfHQ7XrTQFjj
   eH7yurYhp5NKLYdYVymsN/ytKOGwiEGLH97B7MxLgzUGyppNBFc8ORNMW
   a9rVS8X5SsVMvd5/l7/m0EM2ZFjTf1DCfwy3yb6cO17NKNhWb5tr0yuEs
   /ng6zoJ5SVt0rWvzqBcKan8Rgtw1uZjfSVvYewv8jStJVXTWrir+cq3z2
   Z6s0NbSCqxkRJoMh9Gqw2pvp92jEiGtOZNsM5e4qWMI4IMJqn3pvuo0b8
   w==;
X-CSE-ConnectionGUID: 2UpbA36QSOK46l/Kq/YV8A==
X-CSE-MsgGUID: fvecig38SP6QT8KfdwC0CA==
X-IronPort-AV: E=Sophos;i="6.13,268,1732604400"; 
   d="scan'208";a="41465954"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Feb 2025 17:24:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 7 Feb 2025 17:24:18 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 7 Feb 2025 17:24:17 -0700
From: <Tristram.Ha@microchip.com>
To: Russell King <linux@armlinux.org.uk>, Woojung Huh
	<woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
	<olteanv@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, "Maxime
 Chevallier" <maxime.chevallier@bootlin.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH RFC net-next v3 0/2] Add SGMII port support to KSZ9477 switch
Date: Fri, 7 Feb 2025 16:24:15 -0800
Message-ID: <20250208002417.58634-1-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

The KSZ9477 switch DSA driver uses XPCS driver to operate its SGMII
port.  After the previous XPCS driver updates are added the XPCS patch
can be used to activate DW_XPCS_SGMII_MODE_MAC_MANUAL for KSZ9477.

The KSZ9477 driver will generate a special value for PMA device ids to
activate the new code.

This will require the previous 4 patches from Russell King about
"net: xpcs: cleanups and partial support for KSZ9477."

Tristram Ha (2):
  net: pcs: xpcs: Activate DW_XPCS_SGMII_MODE_MAC_MANUAL for KSZ9477
  net: dsa: microchip: Add SGMII port support to KSZ9477 switch

 drivers/net/dsa/microchip/Kconfig      |  1 +
 drivers/net/dsa/microchip/ksz9477.c    | 98 +++++++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz9477.h    |  4 +-
 drivers/net/dsa/microchip/ksz_common.c | 36 ++++++++--
 drivers/net/dsa/microchip/ksz_common.h | 22 +++++-
 drivers/net/pcs/pcs-xpcs.c             |  2 +
 include/linux/pcs/pcs-xpcs.h           |  1 +
 7 files changed, 157 insertions(+), 7 deletions(-)

-- 
2.34.1


