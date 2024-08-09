Return-Path: <netdev+bounces-117316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE0094D933
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 01:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABE71B2326C
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 23:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A19A16D4D2;
	Fri,  9 Aug 2024 23:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WYxWSqBE"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DE116D9AD;
	Fri,  9 Aug 2024 23:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723246726; cv=none; b=I7G4M9zC1djar6cAxeJrmuFRuPkyDtLQz7/ioZnk97xNKlYa8yd9k4M3UCqsVFiqKyedgGnpx1tGB8JoJgqwhbGZI5jET2qNYl2FMwCb0dCXbeKRBoIUQVr7UBpc0NWPyvIpSAnE4rJ5HpGERye7g/fFFZrTL/mFyPYmlafza7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723246726; c=relaxed/simple;
	bh=sFpHsawR4TOzmRP0Xi0QwZ/vnyE8lg6cCheuRS5jROE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KzxnqvCvxtuyhU7WrnlGBrbgVAErCV06Izphm0tGvg18VOXbEyn29jtm54X+yCwRTIdWL1FN6pYdBSjYgiB7gLBXZ0I73UxRMKMdJaHajbUGiLcneWV99ser0HSPG2JIJohDDdupfAEh9+seMCyLwxQc/6v35yGLGiZlX+B88rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WYxWSqBE; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723246724; x=1754782724;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sFpHsawR4TOzmRP0Xi0QwZ/vnyE8lg6cCheuRS5jROE=;
  b=WYxWSqBEgmOHac+9fzLy1fdhyBAwFjgmLGUr5UyOobOYncAao3smzzBx
   LQOWggwiN2TKqw2XpTg0dIIWAqSCtLtcbE1fTh2UeA3On9DDlbHVYa6b1
   bzr3IelXWz1WCLcxNLbWwhApAvfBGUcUGsIOgofB7pLM9xCQEq5uk4Ea1
   Z7ki1kQHWGL7YGZa32mTbELEDCP9utnwR0YnEOHRHWC/N5aT3weuMQt7q
   pjazSvToz5P6dzM2lONkaGyRT1yGUcdNtZcTilo1pJMAMsuZ1irrA8KHw
   OinIsHo6B36/H8rEQZOeHa2qVO89D/GxwRKACDA+KDlwhFDp4EQ9CS5nY
   g==;
X-CSE-ConnectionGUID: zHerXwjfR2qUoEM/PnTZ/A==
X-CSE-MsgGUID: DlxhWON7Sqm4jXNiNKaQ+g==
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="30988808"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Aug 2024 16:38:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Aug 2024 16:38:40 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 9 Aug 2024 16:38:40 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
	<f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Marek Vasut <marex@denx.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Tristram Ha <tristram.ha@microchip.com>
Subject: [PATCH net-next 0/4] net: dsa: microchip: add SGMII port support to KSZ9477 switch
Date: Fri, 9 Aug 2024 16:38:36 -0700
Message-ID: <20240809233840.59953-1-Tristram.Ha@microchip.com>
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

This series of patches is to add SGMII port support to KSZ9477 switch.

As the SGMII module has its own interrupt for link indication the common
code needs to be prepared to allow KSZ9477 to handle other interrupts
that are not passed to other drivers such as PHY.

The SGMII port is simulated as having a regular PHY as there is not much
to do with that port except reporting link on/off and connecting speed.

Tristram Ha (4):
  dt-bindings: net: dsa: microchip: add SGMII port support to KSZ9477
    switch
  net: dsa: microchip: support global switch interrupt in KSZ DSA driver
  net: dsa: microchip: handle most interrupts in KSZ9477/KSZ9893 switch
    families
  net: dsa: microchip: add SGMII port support to KSZ9477 switch

 .../bindings/net/dsa/microchip,ksz.yaml       |  12 +
 drivers/net/dsa/microchip/ksz9477.c           | 404 +++++++++++++++++-
 drivers/net/dsa/microchip/ksz9477.h           |   6 +-
 drivers/net/dsa/microchip/ksz9477_reg.h       |  10 +-
 drivers/net/dsa/microchip/ksz_common.c        |  45 +-
 drivers/net/dsa/microchip/ksz_common.h        |  11 +-
 6 files changed, 477 insertions(+), 11 deletions(-)

-- 
2.34.1


