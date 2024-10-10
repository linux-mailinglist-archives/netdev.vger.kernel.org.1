Return-Path: <netdev+bounces-134104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F77998052
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 10:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55DDA1C22AC8
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 08:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470F61BDA97;
	Thu, 10 Oct 2024 08:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="iHJQl2Tn"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886CF29AF;
	Thu, 10 Oct 2024 08:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548587; cv=none; b=XsRhesnKpWtBMbWhAiHIWNnn4C/j73LvwTh8Z2p4LUYL219djH7l/+jUndhODcPkJ+aX+KRQwgSJuOtuNgiwNJOaqUx4VapJy6cCEs5nCftWNl403HfR07nT0JsYCJDOSclGsQ+VUQqZVmF0yNBMcX3lGN6FXmSyyK2P0jn2e0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548587; c=relaxed/simple;
	bh=TJYdYUWIaCsfY6opptDdB86/VBA/8p6URsH2BCkPorU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V5mvJF2LgRtbYJFdtGy9DRFZFGJZxuF68J8RfobF1AhsVpC53MpTOStxNbKOx+dQgzTlJae2wElbw0yryolIp7l5Ci1HQZ02HufyZQELt3pOTPYYXbsZlFWnw67g/v2odd0/32gsEoroic+AX6ZJ550M7FKOsppdbGR2muz4vUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=iHJQl2Tn; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728548585; x=1760084585;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TJYdYUWIaCsfY6opptDdB86/VBA/8p6URsH2BCkPorU=;
  b=iHJQl2Tnh79kuwxs0CPRixFVYO0zGzNr15H1OEyfyRqY1JTa3ODdJZW/
   L6Le0lfFaTXJY+BEzQK2nMlk5bk9V7qAY6Nxgnd2CR8JGxfC8HKjTzPOb
   nLRREW3DN1+02+duQU8P/zL4qq/hmeUiZL77Nn7ev/STY4oD1PnirnQyd
   xDak4gZlPLpQfmuhr5IVEYz1czZ59Nee/Ldy5SPUngwfHpczQRXqY/nkV
   B0eADQgXQB9sH8EKt9YTpamuPxQ+Ynd3habA5Uo8N4Ho/sU6xHT28ZHzZ
   zjPt29XnN9yxabSeheDnSDOrIDxIsag1sHFRvs+JvaTGyqalfs701AW34
   A==;
X-CSE-ConnectionGUID: x5SKfw9ZTYWBZMz1Nje/Ew==
X-CSE-MsgGUID: IJKZUi8sQICBJwnpaL37jQ==
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="36163250"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Oct 2024 01:22:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 10 Oct 2024 01:22:25 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 10 Oct 2024 01:22:21 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parthiban.veerasooran@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>
Subject: [PATCH net-next v4 0/7] microchip_t1s: Update on Microchip 10BASE-T1S PHY driver
Date: Thu, 10 Oct 2024 13:51:58 +0530
Message-ID: <20241010082205.221493-1-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series contain the below updates:
- Restructured lan865x_write_cfg_params() and lan865x_read_cfg_params()
  functions arguments to more generic.
- Updated new/improved initial settings of LAN865X Rev.B0 from latest
  AN1760.
- Added support for LAN865X Rev.B1 from latest AN1760.
- Moved LAN867X reset handling to a new function for flexibility.
- Added support for LAN867X Rev.C1/C2 from latest AN1699.
- Disabled/enabled collision detection based on PLCA setting.

v2:
- Fixed indexing issue in the configuration parameter setup.

v3:
- Replaced 0x1F with GENMASK(4, 0).
- Corrected typo.
- Cover letter updated with proper details.
- All the patches commit messages changed to imperative mode.

v4:
- Removed 0x3F masking in the configuration calculation and adjusted
  GENMASK() as FIELD_PREP() already masks.
- Added comment for 5-bit signed value calculation and handling.

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
 drivers/net/phy/microchip_t1s.c | 300 +++++++++++++++++++++++++-------
 2 files changed, 240 insertions(+), 64 deletions(-)


base-commit: 09cf85ef183a5603db49d542264ddbece3258e55
-- 
2.34.1


