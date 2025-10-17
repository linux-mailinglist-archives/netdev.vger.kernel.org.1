Return-Path: <netdev+bounces-230345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92858BE6D9E
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 08:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0549B508341
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 06:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F21312804;
	Fri, 17 Oct 2025 06:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hMGsVRd0"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B619E222578;
	Fri, 17 Oct 2025 06:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760684052; cv=none; b=jttHoMpDgBbw3XXiUQkcyx8wPZLxm2d2F3Y+w9yDMyJSbzG9erH28bQKHnOGYnyI2mPlGKaMgz+EoEZZqiecWimzGnBLrhibQZJCRGsGornuV6eFDTDcUBikA+hl9KgOeCy99UCut+HJyEeN66q4xAJntGpGb7jXyQRqkLgowDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760684052; c=relaxed/simple;
	bh=n8N515s/KBGxxKPtSDSRkOGEAFRIT2T+Tu0aFDfDoPQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k89pJ7AbvaRsmezyWYZDJjFzbKI3WRggqiqUKoyvTheHimVU/z3+4B8G8kSpznYOQeDka2PZYEJ1YsyDS2Dc6gsLk7hx3ws4ehKq8Z9oZOyDPSjwu2V5xYgK89gWzzNQEyjFK84tUsSWY+Y3pcX/7QEPl8Fxa/2xWyMO2ggTCz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hMGsVRd0; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1760684050; x=1792220050;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n8N515s/KBGxxKPtSDSRkOGEAFRIT2T+Tu0aFDfDoPQ=;
  b=hMGsVRd0lIxtX3XPkTQFeLrYyYCvjVyj3bYuVFOTOYfY+LvKQ34YvesJ
   Xl8TxzCtBJ6iokT1nnaSNVEAW+VHoP/2Au1yxQ5cxqS2rDs/SjFf3jPYp
   +rfLy5GwmAGKADi22XPwmmkFJr1yMEtsb9Zu92UMOQhye0KbNf4LPr8yG
   z3TrEXFHsqsMxHJ56g0To+Yll1Rfpd/7i8szq5RiyNFKw00J8FB6Xu595
   KEoeoO9VVvriMsqH2l/+ZvZpPphPPVIwjTb58ZQ9xPgRtqI/bFQPlI4Po
   BbOg1HZ3KQ/WonZ1Oc468d018M+YmteENHByqTBlO7jg7Fns+1AL086m8
   w==;
X-CSE-ConnectionGUID: +cWLnLSSQKWQk8EtywTa8g==
X-CSE-MsgGUID: FrSTrx4/QA2jz6W2jtDopw==
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="215250381"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2025 23:54:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 16 Oct 2025 23:53:43 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 16 Oct 2025 23:53:40 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <vladimir.oltean@nxp.com>,
	<vadim.fedorenko@linux.dev>, <rmk+kernel@armlinux.org.uk>,
	<christophe.jaillet@wanadoo.fr>, <rosenp@gmail.com>,
	<steen.hegelund@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net v4 0/2] phy: mscc: Fix PTP for VSC8574 and VSC8572
Date: Fri, 17 Oct 2025 08:48:17 +0200
Message-ID: <20251017064819.3048793-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The first patch will update the PHYs VSC8584, VSC8582, VSC8575 and VSC856X
to use PHY_ID_MATCH_MODEL because only rev B exists for these PHYs.
But for the PHYs VSC8574 and VSC8572 exists rev A, B, C, D and E.
This is just a preparation for the second patch to allow the VSC8574 and
VSC8572 to use the function vsc8584_probe().

We want to use vsc8584_probe() for VSC8574 and VSC8572 because this
function does the correct PTP initialization. This change is in the second
patch.

v3->v4:
- rebase on net-main
v2->v3:
- split into a series, first patch will update VSC8584, VSC8582, VSC8575
  and VSC856X to use PHY_ID_MATCH_MODEL, second patch will do the actual
  fix
- improve commit message and start use vsc8584_probe()
v1->v2:
- rename vsc8574_probe to vsc8552_probe and introduce a new probe
  function called vsc8574_probe and make sure that vsc8504 and vsc8552
  will use vsc8552_probe.

Horatiu Vultur (2):
  phy: mscc: Use PHY_ID_MATCH_MODEL for VSC8584, VSC8582, VSC8575,
    VSC856X
  phy: mscc: Fix PTP for VSC8574 and VSC8572

 drivers/net/phy/mscc/mscc.h      |  8 ++++----
 drivers/net/phy/mscc/mscc_main.c | 29 +++++++----------------------
 2 files changed, 11 insertions(+), 26 deletions(-)

-- 
2.34.1


