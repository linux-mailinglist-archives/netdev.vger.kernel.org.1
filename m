Return-Path: <netdev+bounces-148405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 324F99E1653
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 09:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECAD3280F39
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655651DDC26;
	Tue,  3 Dec 2024 08:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2Wgv/+Qe"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10761DDC0B;
	Tue,  3 Dec 2024 08:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733216004; cv=none; b=n3beAaG58tX0RZPC3TWEjRhWpgCDiTzMupvKYOZeUzPc/deRgE2xZ19QF7Cgw1q4YTkpTa8V9zhdzrGQNpXJY2c6k/0/nxxXJnqg1O3d+vROXGmWOkzC+tbQaW4AfLHPTlFGWIsexP+LdsaPRhSNrlRVWhZifs+PPqNuRxb78pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733216004; c=relaxed/simple;
	bh=1+Oht9w0/FE5QsO5SJj/3YQM87Ar4+UOgH2AsGDK5/4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d6kGOrO2/PNvO4KixgZeH80WH4hHhc6h0H+2ynh6MzdFUx1wIOdKpfx1BUo+kqIAZhQod4N6i1CL5YpQM6QyKs1xMy2bUK0+GTq+vd2XWHGUodjyPPsvtksYJY4bCcRSJiH0Nj3chJ0NBDJT/DTfv9aoEBIuIBXPxI9MZrqx37k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2Wgv/+Qe; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733216002; x=1764752002;
  h=from:to:subject:date:message-id:mime-version;
  bh=1+Oht9w0/FE5QsO5SJj/3YQM87Ar4+UOgH2AsGDK5/4=;
  b=2Wgv/+QeBL1tIb3WYCAEYCNoJtd77o4bSqkouGO7bm31LO1+pGlMuOOr
   /Zl6GJUbetfYbZAqWJVMZ56DnNI6JxIOeP0VTZSiNURwyystePt2BXLO2
   KRmNe/ExvW7wZy4DAmzZBagO4UX1afmpJfQ/raW4KU6p8IqNLajb9lPJ1
   BxxdLzx6LbzcgzxShZOCS5+5jaC40asdpMF1Bp53uQfNdBJ/PWvketfSN
   jaHpWjQFkGBvhQmLylHZV4x/ZmNuNHCyhy2/O52r0F5d0sKEEtURUjYHw
   HgVcPr8THtZe4UEW94Wn2HHeVIn69A/D9xiK7C5mf/gm3DhXVcgiOiVsg
   A==;
X-CSE-ConnectionGUID: PYHc5D2VTXmCViyiEXibzQ==
X-CSE-MsgGUID: +Wojx63rTc2DPE++qwSo3Q==
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="38706049"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Dec 2024 01:53:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 3 Dec 2024 01:52:50 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 3 Dec 2024 01:52:46 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v5 0/5] Add ptp library for Microchip phys
Date: Tue, 3 Dec 2024 14:22:43 +0530
Message-ID: <20241203085248.14575-1-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adds support of ptp library in Microchip phys

Divya Koppera (5):
  net: phy: microchip_ptp : Add header file for Microchip ptp library
  net: phy: microchip_ptp : Add ptp library for Microchip phys
  net: phy: Kconfig: Add ptp library support and 1588 optional flag in
    Microchip phys
  net: phy: Makefile: Add makefile support for ptp in Microchip phys
  net: phy: microchip_t1 : Add initialization of ptp for lan887x

 drivers/net/phy/Kconfig         |   9 +-
 drivers/net/phy/Makefile        |   1 +
 drivers/net/phy/microchip_ptp.c | 997 ++++++++++++++++++++++++++++++++
 drivers/net/phy/microchip_ptp.h | 216 +++++++
 drivers/net/phy/microchip_t1.c  |  40 +-
 5 files changed, 1259 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/phy/microchip_ptp.c
 create mode 100644 drivers/net/phy/microchip_ptp.h

-- 
2.17.1


