Return-Path: <netdev+bounces-234290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 387F5C1EDBA
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 08:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1074D4E405C
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 07:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B90337BBD;
	Thu, 30 Oct 2025 07:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rO0FTyqt"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4E9338586;
	Thu, 30 Oct 2025 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761810779; cv=none; b=KFytBVphMH2BGlm2jEpN7jkas2sdLZB9+o11qhfNeSThkZC+JwuQC+ULU1DOGhQZ4ARIBKN6EG2Kky9GDVSL1lRXfYqrpR0zsTin04QK+qfhjdkxwvF+VfvTHo1HY6vdg82iwaGnkunejOYyJq5k+grRSFnkOL4lijwRzXmhqJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761810779; c=relaxed/simple;
	bh=rd9E5iSzvxo33oLvaoktALb6LQdQLnxTmoWim2N+pGg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fqF21sCimJ+OBmKHUO/TzK9vexDRdHhU/JZCdLLB9kNfUJl163/OGLAWg+i3LfCHPflJYMvvg3z5KNulQg3b/IyACCAWaSqq1lu/CIRPLcHsdNw6KJO4wPsycQ4QLzNiWzfoHfIM3knNUmGAGJVcrmR6qCgRSbGtXqBG795wtqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rO0FTyqt; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761810778; x=1793346778;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rd9E5iSzvxo33oLvaoktALb6LQdQLnxTmoWim2N+pGg=;
  b=rO0FTyqtEzZg4puqbz86nMVI/e6AyOA4+Gi7CcxcgSH2FUecaCFHTXOT
   f9BbHIUdr2CEkjqBIgUJ29jFwD/HWTmL5WwglCIhpdMR7DJnOP6HxHx9O
   mRL8COteraHLPxQA7EQjvq4SZX1YEzLGJYEeTo+GA7QO8XqBwANaoLDmU
   34I3wnUCKH2MAteMa7jOaWNbqrde1wh7XRuzwBZtJNhunidH8V6g+vxuE
   YBSpidY/wHn7hcWA8G7yBUjoYb6b6opyVY9oHKNBzUPicOzhXhMr5PNEe
   EyZx1NJQBaKzHFcAXoUv9vL+CXDZbQ0vSyoPhYFCw6bQhntVznmqx0qxM
   A==;
X-CSE-ConnectionGUID: hWk4P1TPRtmfKCCnTJHFMw==
X-CSE-MsgGUID: l/orcjqpRh6gLPSU8cHzPA==
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="48455737"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2025 00:52:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 30 Oct 2025 00:52:25 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 30 Oct 2025 00:52:23 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net v3 0/2] net: phy: micrel: lan8842 erratas
Date: Thu, 30 Oct 2025 08:49:39 +0100
Message-ID: <20251030074941.611454-1-horatiu.vultur@microchip.com>
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

v2->v3
- fix some register addresses
- add reviewed-by tag
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


