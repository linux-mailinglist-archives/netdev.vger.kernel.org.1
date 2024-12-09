Return-Path: <netdev+bounces-150258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CD29E9A39
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 16:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A347918816F4
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 15:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CED1B423A;
	Mon,  9 Dec 2024 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Dj19mpQZ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2413A198831;
	Mon,  9 Dec 2024 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733757499; cv=none; b=EaqgaP4Nv8SziQkq7+EsO7jXCSHfrArwGcwpiBXPHr+ckZb4CFfSY4GuZPa3MGUAAzwxDcdKkfoOCU5HjmCs0zcehI7h/7zA1KDxhcBxkmhZRhDcXY1B3rNd1z6TRrtAweQM7Hy97KmhIZfxckMxQQ0xTmMJ43iSQnDVvhRYMN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733757499; c=relaxed/simple;
	bh=Xb/ZmS39i7KGvL8g4KNP0laPkSKSBTKqMY7jSvKZA/Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mf3rUFcaUmw7q8ZUxouGOmBAdLQFWNEjEKlcRp2oOEJPNMUKBh9bB5jX34r5b0gMV8JgxQgHCXKlYiOhrcrv44YHFhlIvsgZFFzaeurN7E3yBdrVZM58ib5wbqgOAInoIj8ezXzWkBy/cTYzQ9zgn5OhSBRxFAmp3tlZCZFE8Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Dj19mpQZ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733757498; x=1765293498;
  h=from:to:subject:date:message-id:mime-version;
  bh=Xb/ZmS39i7KGvL8g4KNP0laPkSKSBTKqMY7jSvKZA/Q=;
  b=Dj19mpQZnSVfG7LKdPVC3eeUJBgM6mu34vtRrsaI32IcMeAvSSWZcP7i
   0ypreFW3xC+/D4f15Spei+5WeCTVfgGWsWT8FI9C4E//i1x15kl6dmdA/
   9gYCw6CCiDbN1+ADy8UQljdWoE2PIkZE2EaWU1ozmqUYctCOwqO9igUCr
   fMVbx0lX0ZVq018iwmIt0D+M+SZTqVYJu6ptQzfqehBTZ83bXNwdf44AV
   LtPsso/9HNmty99JfmLwEzZgeCP/tenbUobMXQ3BzBsYNan700NavNDkV
   AN6WxJvNMMfDUjZhbn1C2N3zH7B7iKlhOAFINWHPldeTDLpG1/r0epJUe
   g==;
X-CSE-ConnectionGUID: fVcj29IcQ9C5yarZFzKSjw==
X-CSE-MsgGUID: wzH9YeAfRjKh/ZcVvxgfoQ==
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="35775867"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Dec 2024 08:18:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Dec 2024 08:17:34 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 9 Dec 2024 08:17:30 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v6 0/5] Add rds ptp library for Microchip phys
Date: Mon, 9 Dec 2024 20:47:37 +0530
Message-ID: <20241209151742.9128-1-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adds support for rds ptp library in Microchip phys, where rds is internal
code name for ptp IP or hardware. This library will be re-used in
Microchip phys where same ptp hardware is used. Register base addresses
and mmd may changes, due to which base addresses and mmd is made variable
in this library.

Divya Koppera (5):
  net: phy: microchip_rds_ptp: Add header file for Microchip rds ptp
    library
  net: phy: microchip_rds_ptp : Add rds ptp library for Microchip phys
  net: phy: Kconfig: Add rds ptp library support and 1588 optional flag
    in Microchip phys
  net: phy: Makefile: Add makefile support for rds ptp in Microchip phys
  net: phy: microchip_t1 : Add initialization of ptp for lan887x

 drivers/net/phy/Kconfig             |    9 +-
 drivers/net/phy/Makefile            |    1 +
 drivers/net/phy/microchip_rds_ptp.c | 1009 +++++++++++++++++++++++++++
 drivers/net/phy/microchip_rds_ptp.h |  218 ++++++
 drivers/net/phy/microchip_t1.c      |   41 +-
 5 files changed, 1274 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/phy/microchip_rds_ptp.c
 create mode 100644 drivers/net/phy/microchip_rds_ptp.h

-- 
2.17.1


