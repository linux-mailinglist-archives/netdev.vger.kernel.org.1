Return-Path: <netdev+bounces-209869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE70B11201
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 22:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2562172768
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 20:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB0623ABB5;
	Thu, 24 Jul 2025 20:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cyyooH5S"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A6822173A;
	Thu, 24 Jul 2025 20:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753387930; cv=none; b=jGGFPulYTW+8eH4IItspi1ahG3NAI2dXeYqwUhXfd45yHh2wd3FVjIOkPP8MdlKprO9s/oBQwuRDViDfsP31OaiQW93voDtyf3dLsLNcyZ1k3DH8f9E22egFvnw7utns3YK8uc05iMIfvfzF+enNrp3CbGDB/Rw3s8HPUQcvn1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753387930; c=relaxed/simple;
	bh=FOF2ZUPzsIrWmpxjF8/IvQjXpVzNV6SG7wqmwUAXHjs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZlA1FBTnFNJkYq0mNhUeGRC8qxl7OMQLI9Lltu2xU2GYIBrGWA4S/k6yf29NOpAS5vYrAEgpNRMMgz2HKa6+GzgxBPlMEJFFA/l6xhWplSxiTUHXqQUiXY5leiw0bNdJxTf/Rn27qPLyyK+mNk0LG3yt78wX8hMlV5bbHEToSrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cyyooH5S; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1753387930; x=1784923930;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FOF2ZUPzsIrWmpxjF8/IvQjXpVzNV6SG7wqmwUAXHjs=;
  b=cyyooH5STsdPXCLiSv39MjQsc/WNf4V4miY5f1cA5cAlnTGHFERph/Xn
   NpJjgXz1lG79kU2m7/2CE0IjixSngrWUHMw2FpYTY4153ac8O+ELlWXYD
   6knjTvpx23GPwi1AOspSpzRV7YaY11I2/K7vP66TMuKEtO5PiGOnkOxJ7
   2UUbcgJ6m6veuOrnvgTm/odezBVc6vR5NW/iVD0x4OIZnRfWAfe7hx0tD
   N1NlgEx3K67SKks2MrtqBNVP0H6hMM+7ReyxsKkryodUY7PetxN7hECnD
   R1/vHihtyvf3gvad3nd/f+M9NFaMfox3OMR2pi868eAGhQ3hOEJBAY/wV
   g==;
X-CSE-ConnectionGUID: dPxjunYJTo2XkJR5vJWM1w==
X-CSE-MsgGUID: 6uIkbeiGQzuJn9APdrF0sg==
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="44383317"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jul 2025 13:12:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 24 Jul 2025 13:11:27 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 24 Jul 2025 13:11:25 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <o.rempel@pengutronix.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next v2 0/4] net: phy: micrel: Add support for lan8842
Date: Thu, 24 Jul 2025 22:08:22 +0200
Message-ID: <20250724200826.2662658-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for LAN8842 which supports industry-standard SGMII.
While add this the first 3 patches in the series cleans more the
driver, they should not introduce any functional changes.

v1->v2:
- add the first 3 patches to clean the driver
- drop fast link failure support
- implement reading the statistics in the new way

Horatiu Vultur (4):
  net: phy: micrel: Start using PHY_ID_MATCH_MODEL
  net: phy: micrel: Introduce lanphy_modify_page_reg
  net: phy: micrel: Replace hardcoded pages with defines
  net: phy: micrel: Add support for lan8842

 drivers/net/phy/micrel.c   | 727 +++++++++++++++++++++++++------------
 include/linux/micrel_phy.h |   1 +
 2 files changed, 497 insertions(+), 231 deletions(-)

-- 
2.34.1


