Return-Path: <netdev+bounces-216823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1742DB35518
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 09:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7FB6245AA6
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 07:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8382F6591;
	Tue, 26 Aug 2025 07:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uZ9KeB/o"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DE2295DA6;
	Tue, 26 Aug 2025 07:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192534; cv=none; b=VHDciCGutSzJVrHgn+1LRd18/Rg1hPU1BSh4JckYgrzyoFUsRBkz43doplLhaXjMnH8B93+/mu9YxZ+uh8n8apE7YkxLJXGPx54mV0fc9/nQwXQrcSLlkLpFTib5rwy+YtlVUDXMernGGVCCKzI3aKbQq+luxFfAF2yvfalt9lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192534; c=relaxed/simple;
	bh=a6J7kNbBz4t+F85YcCF2ZHveWGZCiCrfzKou6D3pXFc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EwKx8RGqmYpxNpOplgYtzimWxq9/C/txF+EiYi69nsU38wMwAi/xy2sWwhW2M/xi9r3oQgVFW/uLZFHjl9ZHe6S/pg+8jy7I89MYv8P6SEeqNoZb1KG+/rKWmZ32C83gaN/rjtfX08bA467hyxLKCiTsWrQlKsYCX86jOKhbXlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uZ9KeB/o; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756192532; x=1787728532;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a6J7kNbBz4t+F85YcCF2ZHveWGZCiCrfzKou6D3pXFc=;
  b=uZ9KeB/oGdVI7TJhyWeKKUKbCBWdHx0w+7cMJky82I8AFLAz+LXSL7MH
   0Xqnd9K6O/6l5tvimojoQAg0N5PNZRxwt5BGA+cVPbBvSEXiTg7M41Z9E
   JJZPE8UnpCfEX9+Kwx8fyq1lSVHlWKnlHdqlj0n6LdIUhpaTR5zCuAJ1P
   7xNkMLzcDWY6f1de6ae2VIXfPtBU7cWWtTpAcnoAliBzu+o0elGphIQOa
   lAXmNXj/d2cc8BlsHVD+OyHRuSlV7jkwzvJuBPiKaUSJcJO2+sjEmxDzA
   UWBji7wEVXe6I94TLBZAyscF5uzGGuhPYATJLg+8xW7zw9QdZcgEyk6ZW
   A==;
X-CSE-ConnectionGUID: 1L/2GLIuTqq74W58nlieXw==
X-CSE-MsgGUID: yyNCzSGcTymhbNL8NHKJuQ==
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="213069545"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Aug 2025 00:15:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 26 Aug 2025 00:15:01 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 26 Aug 2025 00:14:59 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>,
	<Parthiban.Veerasooran@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next v3 0/2] net: phy: micrel: Add PTP support for lan8842
Date: Tue, 26 Aug 2025 09:10:58 +0200
Message-ID: <20250826071100.334375-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The PTP block in lan8842 is the same as lan8814 so reuse all these
functions.  The first patch of the series just does cosmetic changes such
that lan8842 can reuse the function lan8814_ptp_probe. There should not be
any functional changes here. While the second patch adds the PTP support
to lan8842.

v2->v3:
- check return value of function devm_phy_package_join

v1->v2:
- use reverse x-mas notation
- replace hardcoded value with define

Horatiu Vultur (2):
  net: phy: micrel: Introduce function __lan8814_ptp_probe_once
  net: phy: micrel: Add PTP support for lan8842

 drivers/net/phy/micrel.c | 114 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 109 insertions(+), 5 deletions(-)

-- 
2.34.1


