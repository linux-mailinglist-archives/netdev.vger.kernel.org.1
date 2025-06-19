Return-Path: <netdev+bounces-199570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C30AE0BAD
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 19:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A95723B9DCD
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 17:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B0F28B519;
	Thu, 19 Jun 2025 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="s7knFhsk"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED71A23CB;
	Thu, 19 Jun 2025 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750352679; cv=none; b=W/quHBHDGMZzuh6hn0mWD0335EnPMdqy2xfwXwMKA4YvUJ8xXGekLz1Lpfs0A60IyPY/L+tebbK92Cumy6PVUa6atRDnav2Rb9NXrI2YPKr9SaDNnKwjX0bMMcPynXN3OjV2rY1uLL6BlBq1NQn/S5EsgsIeOccKBC6VMEsriXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750352679; c=relaxed/simple;
	bh=4fOkOVF5Q6tqqHRx/7aS8uzijJgUIpkCB4R9DJKSBi4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cZG4AZ3cgOqk/Bi/IBAZsKSY9hxuFVFI9CdkwuCm2oL0et5Ye+RwX96SuND8I1Whgl7vMVltHzCxuIR22EGBM/5bmbOR+l800ksWMP+kh+Vt60eMbtGshBfJgE0pKea9A1r+c+FmOMnClu22nEtxq1zNucq+MuMO4egJGdzyZBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=s7knFhsk; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1750352679; x=1781888679;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4fOkOVF5Q6tqqHRx/7aS8uzijJgUIpkCB4R9DJKSBi4=;
  b=s7knFhskS0Gt+jOTzaT4pe6DVSvp3HYJeqDDmJMp/BsuOXa8AgfWjFKQ
   zxUzuRSdNgGDcXYTNRPogGVECV56vror6EY2HPrWsdbdsbA8q9okJf1hz
   boAY8Q9AU195Fn2eU78+RLLT/dL9NXc613lsimTLFOWe7/izPycdid0Yi
   Dly+3wlh4pMjnYlivuSeOAqut3v04+9dach1s072TWYKxl9BDxa0sXyte
   zI2Mf+LWEQaedLLC4c0dV1MHYNnQKljjfORA2U9xGmP+Fjnb7UsHreEZv
   nx85w11zMC+bjrStz8BMdVM92ri/O6c4VxeY7nL3IpC9okOzdR55Ky8Bi
   Q==;
X-CSE-ConnectionGUID: pR/nkXtYSem+L1lGhth8FQ==
X-CSE-MsgGUID: h2NT2XivScK0gIiPDjtW6w==
X-IronPort-AV: E=Sophos;i="6.16,249,1744095600"; 
   d="scan'208";a="274392750"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2025 10:04:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 19 Jun 2025 10:04:01 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 19 Jun 2025 10:04:01 -0700
From: <Ryan.Wanner@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<claudiu.beznea@tuxon.dev>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH 0/3] Expose REFCLK for RMII and enable RMII
Date: Thu, 19 Jun 2025 10:04:12 -0700
Message-ID: <cover.1750346271.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

This set allows the REFCLK property to be exposed as a dt-property to
properly reflect the correct RMII layout. RMII can take an external or
internal provided REFCLK, since this is not SoC dependent but board
dependent this must be exposed as a DT property for the macb driver.

This set also enables RMII mode for the SAMA7 SoCs gigabit mac.

Ryan Wanner (3):
  dt-bindings: net: cdns,macb: Add external REFCLK property
  net: cadence: macb: Expose REFCLK as a device tree property
  net: cadence: macb: Enable RMII for SAMA7 gem

 Documentation/devicetree/bindings/net/cdns,macb.yaml | 7 +++++++
 drivers/net/ethernet/cadence/macb_main.c             | 6 ++++++
 2 files changed, 13 insertions(+)

-- 
2.43.0


