Return-Path: <netdev+bounces-120421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65985959447
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 07:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF3C1F24149
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 05:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C371616A954;
	Wed, 21 Aug 2024 05:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SV+5W8qG"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9238248D;
	Wed, 21 Aug 2024 05:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724219942; cv=none; b=Zwx3ChVZCYMvtfXSgoIGFF6esTfmFcUNoPz/fUyE5fsnhgtjVEU5Gc7SVZXEBoaUUQKKTK4r6V4pX0RVBJomj1uxjLSSnUTdzVMwV56PZHd+HvQpHAU/FbY57v7gHu/K8NbWw21eqZ1E0i812d2pzkPZSPBAnls33XlBb2ZrEyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724219942; c=relaxed/simple;
	bh=AiczBgmYnpsHJsKxzKTQFCqblHyCq2/2FhExedQNxao=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KcoU7FO5yQbTuedUHMJ1K+g9S2/8rI4iMUrZ1l0FkRem/rx3Qa5iPYC96Dvq6rvEur9qBt9HIfSvspA4ndqurcMV7BaepbRR4GnZau6+PBd4IRBMOx4tLwDCvTayXt3bdoh0T6ZIRyAiiMxw0X6vKoS4OcxUJ+uJ5dAexfnV4wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SV+5W8qG; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1724219941; x=1755755941;
  h=from:to:subject:date:message-id:mime-version;
  bh=AiczBgmYnpsHJsKxzKTQFCqblHyCq2/2FhExedQNxao=;
  b=SV+5W8qGdTsV7i0FaJZQcQ2SIg6qBsII1abjKzQKIIzJcETAgffMcGlR
   UCMjOs4Tn+dDI+POUXLZoJzAF6kIL9QBcw9QQfkfW4E8Xch9hH9D83Q/N
   l7lMZsljFNXzDf9gU51XLiMbbehX5CGRbJiXJbJ4Ed5XRTV56CctQLG3S
   7RbIqVapdekYIRXx1Ph3r1FvganqJDke0nCcC1UkFXDU9PO1dTx3EjsbN
   Zw+hoGTVmwhOt6Q63XfjR3M++cWS5Y9OIWFwwz7zYPj4tig1sGpkMWK0x
   XPmMFa45nlXP9cJAgI07FC64ZSHhPIo2WXsTTz/bFGNjX7riTqk7aPbdh
   Q==;
X-CSE-ConnectionGUID: 7ZFFNiTYQ8msV6joUfqTDQ==
X-CSE-MsgGUID: KI+fd0+xTBGfDQhQ2NIerg==
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="261650675"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Aug 2024 22:58:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Aug 2024 22:58:12 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 20 Aug 2024 22:58:08 -0700
From: Divya Koppera <Divya.Koppera@microchip.com>
To: <arun.ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3 0/2] Adds support for lan887x phy
Date: Wed, 21 Aug 2024 11:29:04 +0530
Message-ID: <20240821055906.27717-1-Divya.Koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Divya Koppera <divya.koppera@microchip.com>

Adds support for lan887x phy and accept autoneg configuration in
phy driver only when feature is enabled in supported list.

v2 -> v3
https://lore.kernel.org/lkml/20240813181515.863208-1-divya.koppera@microchip.com
Removed extra braces for linkmode_test_bit in phy library.

v1 -> v2
https://lore.kernel.org/lkml/20240808145916.26006-1-Divya.Koppera@microchip.com
Addresed below review comments
- Added phy library support to check supported list when autoneg is
  enabled.
- Removed autoneg enabled check in lan887x phy.
- Removed of_mdio macro for LED initialization.
- Removed clearing pause frames support from supported list.

Divya Koppera (2):
  net: phy: Add phy library support to check supported list when autoneg
    is enabled
  net: phy: microchip_t1: Adds support for lan887x phy

 drivers/net/phy/microchip_t1.c | 577 ++++++++++++++++++++++++++++++++-
 drivers/net/phy/phy.c          |   5 +-
 2 files changed, 580 insertions(+), 2 deletions(-)

-- 
2.17.1


