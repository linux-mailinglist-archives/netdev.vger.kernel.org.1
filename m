Return-Path: <netdev+bounces-111729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34F19325CE
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 13:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F79C282636
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 11:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85929198E60;
	Tue, 16 Jul 2024 11:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VeHkyn7f"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F03B15491;
	Tue, 16 Jul 2024 11:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129850; cv=none; b=hsKIls+v9AJoZPWOr6/81jP4BOE5iRGGIzIPmWsbnbsUo0/0iDu7DVO8dKoLMmwAeQ2ZTLEKMlqHYFZ8AGy0hsV+4kim0bZ4ksNzXke98GmrIokTMkHyy0UcdVynskl93C7ClgX7u42QWbOOku7mkrF2At721t6q4xtd7IjdMkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129850; c=relaxed/simple;
	bh=TGWgCjG/5BoPGM3gimHC4b/HxuCchSOPMuLNRzJfd+A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e47xdz9gPgnHMRxn2X1FgXZoP0LBkgw5WcEtmMcjVbnLyEazoWIRM69Tdpx474fB8JJK0HwAHDHmrVJlyqeg3Ht70qoYKN541aiYPapeKo/OL0d0ZOli5WPe3ZhTk3EyK98CtQYvIVfrkOfwieedb0D8MHm8gCCkJ+pz/VFH0+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VeHkyn7f; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721129848; x=1752665848;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TGWgCjG/5BoPGM3gimHC4b/HxuCchSOPMuLNRzJfd+A=;
  b=VeHkyn7fP/dsOf4pszbz0xRkIz1YyY1wpxqpgxfeuv8Be8zZoD9oVhSN
   +GJFREaEX/7xGVkb5kiBdoLJA5ROxGGreKdDNb7oTHl/UVofVTJ37ZOyj
   8CWsA0/nP5Ln+39jWa3reXDxiTHsGT8vVWuMCbkIDKCIeajM1ZWjZIsWb
   D7Mi206R97G2R4SL1BE8Of/kB12VIluOrXVYNdnULMB3z78KW7Kxz30jV
   yf96UAo6ujYFHuQm4QxocDOe8yN2+XvqoSmFcDpl67fqBWGxdtcMShvn7
   czWpzydBrm4ZXv2NQojv42zQQs4+gholVgI6HZ7zF6Daj5FIKYaYlWBXF
   A==;
X-CSE-ConnectionGUID: wiqq30pxTLCqYtWfMI+eUQ==
X-CSE-MsgGUID: GOwTssgcSxCfQ1NZAT7NdA==
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="196701708"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jul 2024 04:37:26 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jul 2024 04:37:15 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 16 Jul 2024 04:37:11 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <andrew@lunn.ch>,
	<horms@kernel.org>, <hkallweit1@gmail.com>, <richardcochran@gmail.com>,
	<rdunlap@infradead.org>, <linux@armlinux.org.uk>,
	<bryan.whitehead@microchip.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next V2 0/4] Add support to PHYLINK for LAN743x/PCI11x1x chips
Date: Tue, 16 Jul 2024 17:03:45 +0530
Message-ID: <20240716113349.25527-1-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This is the follow-up patch series of
https://lkml.iu.edu/hypermail/linux/kernel/2310.2/02078.html

Divide the PHYLINK adaptation and SFP modifications into two separate patch
series.

The current patch series focuses on transitioning the LAN743x driver's PHY
support from phylib to phylink.

Tested on chip PCI11010 Rev-B with Bridgeport Evaluation board Rev-1

Change List:
============
V1 ->V2:
  - Fix the Russell King's comments i.e. remove the speed, duplex update in 
    lan743x_phylink_mac_config( )
  - pre-March 2020 legacy support has been removed

V0 -> V1:
  - Integrate with Synopsys DesignWare XPCS drivers
  - Based on external review comments,
  - Changes made to SGMII interface support only 1G/100M/10M bps speed
  - Changes made to 2500Base-X interface support only 2.5Gbps speed
  - Add check for not is_sgmii_en with is_sfp_support_en support
  - Change the "pci11x1x_strap_get_status" function return type from void to
    int
  - Add ethtool phylink wol, eee, pause get/set functions


Raju Lakkaraju (4):
  net: lan743x: Create separate PCS power reset function
  net: lan743x: Create separate Link Speed Duplex state function
  net: lan743x: Migrate phylib to phylink
  net: lan743x: Add support to ethtool phylink get and set settings

 drivers/net/ethernet/microchip/Kconfig        |   5 +-
 .../net/ethernet/microchip/lan743x_ethtool.c  | 118 +---
 drivers/net/ethernet/microchip/lan743x_main.c | 657 +++++++++++-------
 drivers/net/ethernet/microchip/lan743x_main.h |   7 +
 4 files changed, 460 insertions(+), 327 deletions(-)

-- 
2.34.1


