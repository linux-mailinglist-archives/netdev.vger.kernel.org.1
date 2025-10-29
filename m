Return-Path: <netdev+bounces-233804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C60EC18B0E
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5B874FEAF4
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 07:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD6328A3EF;
	Wed, 29 Oct 2025 07:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qlp1F6vB"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ED04C6D;
	Wed, 29 Oct 2025 07:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722916; cv=none; b=VuDsUOD3m7kty5jMwDEGmoEb5zilNoBW7MFNsq9TUETzhPYqbCU5LYmlNPD9bp8UIA5c+E1JaCq1fPEqEUns537ZRs6HVwsVY55kfRZcH5dpNn2d94hprRY3lCF0+3jWBJ90f5r5sB16FMhWXZVAvVnt8iA6ioepcbEKDbd1Opc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722916; c=relaxed/simple;
	bh=BLW0ILNWkyJ+FqWY4CRpq0Q7rnWy+gqra4+U8wqH3CA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YywhltqBw59Uh9AC+cn24GH7t87KUBVnRYZ5v6Xfl9La+UNjqQsdV50ZKcGnLSrcL5zAfZCt+NKyb672nJLXyWEiiIMAtaxa8jA+ZA6KNPsxBkhrX85AizaxOfrcs9X16Z0VvKsOGh6QvCAGBFF7SzCCBa4Me6Y/G+5+LJvsj5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qlp1F6vB; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761722915; x=1793258915;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BLW0ILNWkyJ+FqWY4CRpq0Q7rnWy+gqra4+U8wqH3CA=;
  b=qlp1F6vBugXAFAg2IuRZdVfONO84YPbRQeyf/xkdff9qjfrqnYscSUKI
   eErMybTRjJac/E3RN8yZCNlfuB8OMgKaaOI9oiSmExUpCWZWxGyqV5jwA
   5eypQlvoluddyjZ3tOR64b8o6whUzL9XNxFGbJxJ1a/FEZqms7nrDzAL8
   b391tBy+mUoiphTW85xD1jkJxgyRRCYJqSprE6PwQom/CtW9AziMCALe8
   F8vi5LCDIO90sqg25h5IJg9AkwjOVFGv2VMhQ5v4DcowOmEcPuBsp1Yqb
   qUYCHiAUjT+BE4mX9BQAZF2BZ6/mtFjkjflyoK44iMOxsjrhaPtd31y4o
   Q==;
X-CSE-ConnectionGUID: mbsbUSXvQeWZEXUB1v97vQ==
X-CSE-MsgGUID: w/JQLdZLRfmcODGqJLa4tw==
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="47773025"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 00:28:34 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 29 Oct 2025 00:28:12 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 29 Oct 2025 00:28:11 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net v2 0/2] net: phy: micrel: lan8842 erratas
Date: Wed, 29 Oct 2025 08:24:54 +0100
Message-ID: <20251029072456.392969-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add two erratas to the lan8842. The errata document can be found here [1]
The two erratas are:
- module 2 ("Analog front-end not optimized forPHY-side shorted center taps").
- module 7 ("1000BASE-T PMA EEE TX wake PHY-side shorted center taps")

v1->v2:
- split the patch in 2 patches, one patch for each errata
- rebase on net instead of net-next

Horatiu Vultur (2):
  net: phy: micrel: lan8842 errata
  net: phy: micrel: lan8842 errata

 drivers/net/phy/micrel.c | 166 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)

-- 
2.34.1


