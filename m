Return-Path: <netdev+bounces-234334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3827EC1F80E
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 11:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D8EF23490CD
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C736350D4C;
	Thu, 30 Oct 2025 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CXz6YxhC"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE71A251795;
	Thu, 30 Oct 2025 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819818; cv=none; b=AMlkHBAnB8+BfzFmPw+oeGhMimXmHTL9zKFIBUGsCpuoegExXtvV1uflKy/mprR/JA86XHIHP7eM/eluKQsJYdMLKDMouiKxodRGgqv/O1J1vTf52teFDDrLPlXubm1HZKa6GnB1TRguLalA4FOiYo+EsV4V+oXWKnydFtoqlGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819818; c=relaxed/simple;
	bh=fuo8mVB1LJ1UJcAcfHOwfE0IREKq+lDaZM6IoRG/b40=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nmkcABpncMt3nMcIWT47peIJwWkfdUCsrHUk2uGqjzInOL9WxNEtL2E1Isp9HrlAflOQiZqE5GlicEEqzl9f3AwSNJJ9dNo0+bo2HdTSes0vyynys6v6NlWolsJx0r0MTqHxWJlahPp78CjfJRv2kx5tan2QT4yuHl/BGbHtEhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CXz6YxhC; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761819817; x=1793355817;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fuo8mVB1LJ1UJcAcfHOwfE0IREKq+lDaZM6IoRG/b40=;
  b=CXz6YxhCXUTCXYCgkF8cXVYmNN+X4bkEOdKj9fdPntPPJOYJe74v+QId
   XINNM3rVjNQNjNAxRspJtEQwhmGjojnT2k4EUxFa9R9qlDB9NoR9FJIlt
   VXNSGyvC+z1AOFlg/N1x0uOFNCQ9bDW093hMGftkqxIcXzlN+xedRczTV
   QQcFV4d2X3MQyadKfRV1kEllubmiehWLvgoPueTA9RmZHxM7xLshN1hUb
   lyBlqg6m5/DFJqxOWJURjSGJp6tVzVORanrNa/kWj6MuFY+sA4Ec6Uk19
   c5KI+hrVga1F0CFalAVszThXiu4Uii+CrD4qAUQlNH6RKBmhfwFjfhBE8
   g==;
X-CSE-ConnectionGUID: moOtIzkOTD2Ia0UYYeMXcg==
X-CSE-MsgGUID: mLpJK8PnQRONTeoUR90LeQ==
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="48460657"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2025 03:23:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 30 Oct 2025 03:23:05 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 30 Oct 2025 03:23:02 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <Parthiban.Veerasooran@microchip.com>, <andrew@lunn.ch>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Parthiban
 Veerasooran" <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next 0/2] net: phy: microchip_t1s: Add support for LAN867x Rev.D0 PHY
Date: Thu, 30 Oct 2025 15:52:56 +0530
Message-ID: <20251030102258.180061-1-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

This patch series adds support for the latest Microchip LAN8670/1/2 Rev.D0
10BASE-T1S PHYs to the microchip_t1s driver.

The new Rev.D0 silicon introduces updated initialization requirements and
link status handling behavior compared to earlier revisions (Rev.C2 and
below). These updates are necessary for full compliance with the OPEN
Alliance 10BASE-T1S specification and are documented in Microchip
Application Note AN1699 Revision G (DS60001699G – October 2025).

Summary of changes:
- Implements Rev.D0-specific configuration sequence as described in AN1699
  Rev.G.
- Introduces link status control configuration for LAN867x Rev.D0.

Parthiban Veerasooran (2):
  net: phy: microchip_t1s: add support for Microchip LAN867X Rev.D0 PHY
  net: phy: microchip_t1s: configure link status control for LAN867x
    Rev.D0

 drivers/net/phy/Kconfig         |  2 +-
 drivers/net/phy/microchip_t1s.c | 96 ++++++++++++++++++++++++++++++++-
 2 files changed, 96 insertions(+), 2 deletions(-)


base-commit: 1bae0fd90077875b6c9c853245189032cbf019f7
-- 
2.34.1


