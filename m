Return-Path: <netdev+bounces-117718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A1894EEA6
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 15:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C57861C20D92
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 13:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9700717C22A;
	Mon, 12 Aug 2024 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BTxCXn+L"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F5B1791ED;
	Mon, 12 Aug 2024 13:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470535; cv=none; b=jSLo9zTA31qDFKDInWCCyARaKFdNIO8b6D9MgBfeDqrhyrf4z/+VVmWgbXKv+8Qj/DsCdgwRrsd1KFCjOSB5PDGdawlt9lk/Y8dTHlkym6p60ZfRcngoN4vuCnnAP9VwKUTZxUBNUHhJgIBJ8rvjPVF2zftaj3ut3l9sQp7fk1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470535; c=relaxed/simple;
	bh=+64lpl9Zme+TwrhpCf7gGQM+HSnpkckpxzi1k/2x48M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JCc1Dow5HNeYphE3aDsVn9jCCoL0YPGVtu3X+BcripEgy7Lhu1I8/LPnoNwZuAsm6H0gAVb5T35qBn08DDlCGDmkavmIOafw7ZbWltu6N6EirumlDo262ImTHOEvRDObnVnRDuKSP0Fj+eM7cvCIMaCXhNaFLrWbQvIebEXzJwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BTxCXn+L; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723470533; x=1755006533;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+64lpl9Zme+TwrhpCf7gGQM+HSnpkckpxzi1k/2x48M=;
  b=BTxCXn+LxyxDd7Nx5ECayxMIuxmO8fXbED4hdnqxXNobJfp7R7fViH+7
   KPr+QQvYgIw9cciDWgeN7q/XjABNPUjE8LptUyUdcGcXJP2Hp6Z3WvGuI
   8n2f5EqZhzQO8TblxeKwRMEm3oi9i3AGkDJW70f4o0SCrsq0Wh/LonmRp
   WKfXBtmuP7C0NtzUHTqsZqEyWX1XQm2SsZJGkDyK/WFYHn4E5cVcLpq6D
   V9vOpPVIoHKQvBlrbHCc0GM1ZqZHe5P9C37HPz57VIzcfjtYcCdIbEj4v
   NC8ZjWA6Lcy2CUBpD4vOPm2bqCXV7KbDlhGuMNTm/jIALs67xEXGlZCDT
   Q==;
X-CSE-ConnectionGUID: tv2ynTUsSICLbryrEjW5ew==
X-CSE-MsgGUID: 7pg7LWoPQLe40vGstk8e4w==
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="30386629"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2024 06:48:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Aug 2024 06:48:44 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 12 Aug 2024 06:48:39 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parthiban.veerasooran@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next 0/7] microchip_t1s: Update on Microchip 10BASE-T1S PHY driver
Date: Mon, 12 Aug 2024 19:18:09 +0530
Message-ID: <20240812134816.380688-1-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series contain the below updates,

v1:
- Restructured lan865x_write_cfg_params() and lan865x_read_cfg_params()
  functions arguments to more generic.
- Updated new/improved initial settings of LAN865X Rev.B0 from latest
  AN1760.
- Added support for LAN865X Rev.B1 from latest AN1760.
- Moved LAN867X reset handling to a new function for flexibility.
- Added support for LAN867X Rev.C1/C2 from latest AN1699.
- Disabled/enabled collision detection based on PLCA setting.

Parthiban Veerasooran (7):
  net: phy: microchip_t1s: restructure cfg read/write functions
    arguments
  net: phy: microchip_t1s: update new initial settings for LAN865X
    Rev.B0
  net: phy: microchip_t1s: add support for Microchip's LAN865X Rev.B1
  net: phy: microchip_t1s: move LAN867X reset handling to a new function
  net: phy: microchip_t1s: add support for Microchip's LAN867X Rev.C1
  net: phy: microchip_t1s: add support for Microchip's LAN867X Rev.C2
  net: phy: microchip_t1s: configure collision detection based on PLCA
    mode

 drivers/net/phy/Kconfig         |   4 +-
 drivers/net/phy/microchip_t1s.c | 299 +++++++++++++++++++++++++-------
 2 files changed, 239 insertions(+), 64 deletions(-)


base-commit: ceb627435b00fe3bcee5957aeb3e5282a1f06eb6
-- 
2.34.1


