Return-Path: <netdev+bounces-130851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C36598BC37
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11DBEB21059
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE1F1C2307;
	Tue,  1 Oct 2024 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PmSuntD5"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BE919AD8C;
	Tue,  1 Oct 2024 12:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727786277; cv=none; b=dM1ocKqKhK5hoYekCTyryMB8J+QI6GTk4bjQsebnnXZD8jCERV99YaTxahcN2uZ1xsLXumP9p5ZOmK7TrjR/x/Ul73zpS56HwpZ+ZnH1mMhDkG6LMycNuLcCMH17+l8sBYdLEw/tVZjYckfLEiYyo5yfByQwvR1XIcpgvlDb8zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727786277; c=relaxed/simple;
	bh=aLAuXO5v8SKGDgJl25SQO7yyv06k5wTjx6Hn7p9wHoA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TMCM4Ll7k2lUgMv795/LQhxrHj6GmoSeTzyFvVeja67hqZ+pgPsmmhczGCPDeCjonkfTzxincJCJPh1gHWYiVhu753BHUpyNNIBIPJ7wOTUs3B3nCVAn6inorA0NFkaRhZ7sSlTUKVPPe6LPk34ScH6lc+p2F3P7+7NHVs3DDnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PmSuntD5; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727786275; x=1759322275;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aLAuXO5v8SKGDgJl25SQO7yyv06k5wTjx6Hn7p9wHoA=;
  b=PmSuntD5I7y6JA5zpHGJ//LIj5x+qV1QRCFSsilsr7iKFPSTHP4uW7R0
   VRw11bh0aZlv6MOJ6wt/DPu4zqyELyX/swqlJ7rnRSjQdHwgOw5QwMGtk
   oxeqne+NZEMY5xLvUqfMoS88fgc0VCwDdA/P9uf9OIiturQC3RAWDBoUV
   xSRddD2z2T0b3E7Riqz95ODoNJOgG9NTzm05zqqmUvEU86cXwdFjtjTuZ
   lynob0e2//jdP6DvII1PYCeUOCgIqZPcJsyE6QBZPviAPeM37i3zQqEZh
   5raY5IHmTUL0iFZv9RTD21ezi/RlSQdtZl/ThTbu6BQ73kZ5lt9/pvKeB
   g==;
X-CSE-ConnectionGUID: 1P5ioHTFSIe6+Bx3qmhD8Q==
X-CSE-MsgGUID: 2ief3kCGT4W2ak1kqZ+3yg==
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="35717386"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Oct 2024 05:37:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 1 Oct 2024 05:37:45 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 1 Oct 2024 05:37:41 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parthiban.veerasooran@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>
Subject: [PATCH net-next v3 0/7] microchip_t1s: Update on Microchip 10BASE-T1S PHY driver
Date: Tue, 1 Oct 2024 18:07:27 +0530
Message-ID: <20241001123734.1667581-1-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series contain the below updates:
- Restructured lan865x_write_cfg_params() and lan865x_read_cfg_params()
  functions arguments to more generic.
- Updated new/improved initial settings of LAN865X Rev.B0 from latest
  AN1760.
- Added support for LAN865X Rev.B1 from latest AN1760.
- Moved LAN867X reset handling to a new function for flexibility.
- Added support for LAN867X Rev.C1/C2 from latest AN1699.
- Disabled/enabled collision detection based on PLCA setting.

v2:
- Fixed indexing issue in the configuration parameter setup.

v3:
- Replaced 0x1F with GENMASK(4, 0).
- Corrected typo.
- Cover letter updated with proper details.
- All the patches commit messages changed to imperative mode.

Parthiban Veerasooran (7):
  net: phy: microchip_t1s: restructure cfg read/write functions
    arguments
  net: phy: microchip_t1s: update new initial settings for LAN865X
    Rev.B0
  net: phy: microchip_t1s: add support for Microchip's LAN865X Rev.B1
  net: phy: microchip_t1s: move LAN867X reset handling to a new function
  net: phy: microchip_t1s: add support for Microchip's LAN867X Rev.C1
  net: phy: microchip_t1s: add support for Microchip's LAN867X Rev.C2
  net: phy: microchip_t1s: configure collision detection based on PLCA
    mode

 drivers/net/phy/Kconfig         |   4 +-
 drivers/net/phy/microchip_t1s.c | 299 +++++++++++++++++++++++++-------
 2 files changed, 239 insertions(+), 64 deletions(-)


base-commit: c824deb1a89755f70156b5cdaf569fca80698719
-- 
2.34.1


