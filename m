Return-Path: <netdev+bounces-141445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02399BAF19
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 10:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DE2A1C22406
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 09:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F17E1AA7BE;
	Mon,  4 Nov 2024 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ojaM3Bx2"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666E219D8BE;
	Mon,  4 Nov 2024 09:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730711283; cv=none; b=RhnnYCYJPeIg7HhjvxJADo60+hjxkluOCroG/0qWpZv1oZSxqR4hCqPUCFrsrUPPJHgcyo2ZfGr24y/F4F/cVvBKiY36syJTLn4TJdpxdsYHuRcX3BSqd19Sm4ARtAGQQqffZlYPi5fs8iSZn2m4hCoeUK6oCTXhDTsrhTG29uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730711283; c=relaxed/simple;
	bh=nvTvcMq87NAEajnxg84zXbjs+exdQHrT/KIDHDbHkJA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=alJtBdFh2/1E/4iukVNZV10AsS6/USk1LM0vYynxZg3QUqhap2KISKqZ+fUfusqdwh0wfmd+9fgd+/w4f0UAYFtJHiDzM1RS7TkH6m4GKG4xjBc1qzmFxSorZUIt5ArSpU63faic4/DveQRjmt7V+8WaJJqXKn/eZkmYjmYSmO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ojaM3Bx2; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1730711281; x=1762247281;
  h=from:to:subject:date:message-id:mime-version;
  bh=nvTvcMq87NAEajnxg84zXbjs+exdQHrT/KIDHDbHkJA=;
  b=ojaM3Bx2FoINjEIqF1QRHxDctgIhmVliOYwLfDs7OL7scajBF+1IlJZR
   Lk2kMNvRVdxw0ZnWlrPPd3YygkKhp2m2RicM08v9my2PLA99ZAtXjHWiO
   GZXXMFgN9bIDAJeVKJGBamMi3S7oLiLqnEIbRqthu7w+7QLmX+hM7o63D
   cCQ35ZsyNJ3lH+cIMP0x2VyW8sywPGFV42Cg/pYfHM8oRIVaOuDY+CIQz
   dwYusMqZ5GaivkBTguHFcJntIG2TvY2S5HQ94X5s1jguTjLVPzZhsFDXF
   aQ8hUa/yhFiwnW+FHfUkKxiNg2MlxsIimHXEIabvk+SNRRZy4Ree252UB
   Q==;
X-CSE-ConnectionGUID: b8mzosZWTB24zVJMTbB3MA==
X-CSE-MsgGUID: vs7EqtfEQX2zAGjHUUNH8Q==
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="201261156"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Nov 2024 02:08:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Nov 2024 02:07:56 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 4 Nov 2024 02:07:52 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>
Subject: [PATCH net-next 0/5] Add ptp library for Microchip phys
Date: Mon, 4 Nov 2024 14:37:45 +0530
Message-ID: <20241104090750.12942-1-divya.koppera@microchip.com>
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
  net: phy: Kconfig: Add ptp library support and  1588 optional flag in
    Microchip phys
  net: phy: Makefile: Add makefile support for ptp in Microchip phys
  net: phy: microchip_t1 : Add initialization of ptp for lan887x

 drivers/net/phy/Kconfig         |   9 +-
 drivers/net/phy/Makefile        |   1 +
 drivers/net/phy/microchip_ptp.c | 990 ++++++++++++++++++++++++++++++++
 drivers/net/phy/microchip_ptp.h | 217 +++++++
 drivers/net/phy/microchip_t1.c  |  29 +-
 5 files changed, 1242 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/phy/microchip_ptp.c
 create mode 100644 drivers/net/phy/microchip_ptp.h

-- 
2.17.1


