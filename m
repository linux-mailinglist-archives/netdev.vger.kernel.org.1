Return-Path: <netdev+bounces-227117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348EEBA8902
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 11:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A71B73AFE95
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 09:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E502283FD0;
	Mon, 29 Sep 2025 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QM+gySSr"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948C9283FCB;
	Mon, 29 Sep 2025 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137260; cv=none; b=KgWc0NZT2kfSa3y4fNHeGMfiuDTBc9MF3aMTiDvq1kTuklNb0stQETzb0Nq1/rbCzSNjIIO2OA27TJhyxmVFbIvZWhjSB1ntc2eAgc9p1S2FMA2uQcsyKxn/YYEDuCHWo0fHyDldNWLdigchZPPTrqJwaXQk+gAcGbVizCEn4OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137260; c=relaxed/simple;
	bh=E8wDUmtkXtY0nCbESAutN8mDkg7pgIycI1po3zyl3Hk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e1HBSoxzP0QvMl+B9P95sas7LQH8R0EFByiPtPzu8nI7vOsepGeW/sZ9BRsdvZD+Zuesk17PQW4pbQRL21DBrrMxi6yhqqZozbGq/OEarmA5Jh+R1Dk2IG6MHowbE1qS93xeU+1i5q0oDirsTV0qfaHD8OaBMHTpIbiLz5sjfS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QM+gySSr; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1759137258; x=1790673258;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E8wDUmtkXtY0nCbESAutN8mDkg7pgIycI1po3zyl3Hk=;
  b=QM+gySSrsPBLh/f2TK9cctXqT8IMzJcafTAA7ZnDcOL8Y4/NuuSSSp59
   vJ1dTgbNeLkQmpk4AfqhK/d/UDrZeVdsT1TZ+nKUCHltEP1efja/V7Duo
   lDA4YjUu2If0c2dQbk/Dcs/2m/H7c2n8Q4FRkXvUog6cGF8HJ6HsaOwIm
   xiv49OQ1A99oe+TSOgqsUPkeiACb04e0pF/h8NQPlojOHvUy4pSX6C56m
   7OihAZWgPOVhoPt9wnCkj7tMlUXH/uFLKykPzZ4eT4dzCW8RbbZ/VJugj
   1nIc4ZlCqezD+qA7bvWLXaTDl/lCtzF84FgTDuU3DBq9uQHmV0OAviEOn
   Q==;
X-CSE-ConnectionGUID: chH5A82TS3e+SMlPN86uYQ==
X-CSE-MsgGUID: rTVbZpr5Q7eSfU2oUemsbw==
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="46507240"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Sep 2025 02:14:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 29 Sep 2025 02:13:48 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 29 Sep 2025 02:13:46 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <vladimir.oltean@nxp.com>,
	<vadim.fedorenko@linux.dev>, <rmk+kernel@armlinux.org.uk>,
	<rosenp@gmail.com>, <christophe.jaillet@wanadoo.fr>,
	<steen.hegelund@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net v3 0/2] phy: mscc: Fix PTP for VSC8574 and VSC8572
Date: Mon, 29 Sep 2025 11:13:00 +0200
Message-ID: <20250929091302.106116-1-horatiu.vultur@microchip.com>
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


