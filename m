Return-Path: <netdev+bounces-153339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 427FF9F7B58
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 13:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE17916BDB2
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 12:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EA3224AEE;
	Thu, 19 Dec 2024 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Pok1uhVq"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5102225772;
	Thu, 19 Dec 2024 12:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611433; cv=none; b=IGMESJHEPdwW5e5sHbp9JKRcc6/vZZOmmH6xJI02wDvQc3hjzvaau73zh8vSkJ8CxvcQ9SWFL5tiM75zhYZjvJf4xhpCES8Ydfq9dBdSyz6XVEebb4zMBvuYKPcZLNdrKa2BnkzvwiEDk7Vfdy8ftweOh16tiwEJ7YVMfaXi6q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611433; c=relaxed/simple;
	bh=Vu4USrX2z+SLhBM87iY9NhK2Fv6wDI35CRObup6Jors=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g5RrpHKjB+Qgkhy1k1D2YeCA4D0yYnhpTBFBBYteYlIc+zc4RGABoW1JeNYLOmzI1YjP89aAurVQjAMkBZDJUYwI7+IqjylnCE2Y7p5H1t9Pzj+xhqH3v7ryVUXqQfeKp3pO62Yo01e9SvykuIonZwETqMrv0MJKwpTIzVqgTx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Pok1uhVq; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734611432; x=1766147432;
  h=from:to:subject:date:message-id:mime-version;
  bh=Vu4USrX2z+SLhBM87iY9NhK2Fv6wDI35CRObup6Jors=;
  b=Pok1uhVqsyYaTitk8965f04rjVADnxE/1HiQwDHLJ/RmcdsD3ntpAH6W
   kTuPOf3OA+5zEWwhdIMIYbidFc95dE+2zTsAZzZIFi6IsDONukbsBrFmT
   Rff2EOxia2E912jbQSe66YgXzgYxELS7PtKHNP99jxPUBZxWXPKBRGbZE
   A/fKabiVIf77NABK6mKNWzjQcB81fzvaXbj7bx4wIPoIei5P6Gi/u1iiK
   w/3YlR6skHOu6d8IeWwIIWp4XOKbD3Aj7KgLMiGFxZ+Jl4EyoD4gj5ALJ
   SQ92ph0HTM2ehzSL4LRilEGSYkpc8JlJvndynzltOfJ+kfO9N/Flb6pgt
   A==;
X-CSE-ConnectionGUID: fAJcK6EDT7m5zwyySMd1TA==
X-CSE-MsgGUID: 6wPVRp+4QFSsEqIikdn3QA==
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="36197111"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Dec 2024 05:30:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 19 Dec 2024 05:30:10 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 19 Dec 2024 05:30:06 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v8 0/5] Add rds ptp library for Microchip phys
Date: Thu, 19 Dec 2024 18:03:06 +0530
Message-ID: <20241219123311.30213-1-divya.koppera@microchip.com>
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
 drivers/net/phy/microchip_rds_ptp.c | 1039 +++++++++++++++++++++++++++
 drivers/net/phy/microchip_rds_ptp.h |  223 ++++++
 drivers/net/phy/microchip_t1.c      |   41 +-
 5 files changed, 1309 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/phy/microchip_rds_ptp.c
 create mode 100644 drivers/net/phy/microchip_rds_ptp.h

-- 
2.17.1


