Return-Path: <netdev+bounces-213199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDAEB241AB
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 08:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 880DA3B08FE
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 06:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E312C15B5;
	Wed, 13 Aug 2025 06:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1+Bwh4Ph"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27382D322C;
	Wed, 13 Aug 2025 06:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755066979; cv=none; b=T9Wn3BuDjDqwvQFysNi2GBhuRTGBWwV73A+UdqJ8+lng2z4KHpXcENknOujt+/NTdoWHBys8DC/CpQcYzHN9S+5DL6wpb+UxhL0Y2Ezm5baZKzAbkUyvorjVmJPCIyb8HtJjwljRRfvHp98QmC+TLvZl1AdYSIiBlNmAbF4rt08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755066979; c=relaxed/simple;
	bh=FXRUa4lKPS69dt9Qc7JVS5B7JK/C5ZUe6QlXxaG45ZI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sViQaVq5KNqUzSvSrEliJ//t5Bc9B77cDM4dl5nCkyW6UYaqUw0Npj77jHrbsFsUrFLyoAKNgexxVOTjCI70hiR01cM1TEJxdfBxIJr5v9XpI6cJow+3fy450TQeYaRAjlwwqoXAL5tklwleqXoCS4Hg2nk8/zDPYueDKxU84nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1+Bwh4Ph; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755066978; x=1786602978;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FXRUa4lKPS69dt9Qc7JVS5B7JK/C5ZUe6QlXxaG45ZI=;
  b=1+Bwh4PhLrDKYg++zweFNR57H+RoKDUCHTb4RqtiDGt6yfSEQWM1OwbV
   3FGpa1d93y5HZdkBbxMo7dwqlZ2NYuvLCUKkK1tFuKgrkW8i8C8RVz6DT
   flVe6tUoXH9CED3G2Iuunc4E59cNHTLWmlTl9sHywaMMSiP0D/FN2kZPz
   TOQJR7+4wubxy+Xw1rr/v1lQ/DGyFkFVVf6xWJzL51zh/necPoIPPg/+I
   S2kcjp2HO8SA8ZS7looSHZHweW6W/8k4LBv1s2AsgJiIyEIwJgwoWWvYB
   LM3GjRkHDQ4ntIlHak5F2F14KHgL1mqknnuGM3LP/tJ9PqCGAcFwHCKPG
   Q==;
X-CSE-ConnectionGUID: HLS0dFJYR22/6mpwumLuLw==
X-CSE-MsgGUID: hfcxXv1VSbywuJVPbYq8DA==
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="276526642"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2025 23:36:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 12 Aug 2025 23:35:50 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 12 Aug 2025 23:35:48 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <o.rempel@pengutronix.de>,
	<alok.a.tiwari@oracle.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next v3 0/3] net: phy: micrel: Add support for lan8842
Date: Wed, 13 Aug 2025 08:30:41 +0200
Message-ID: <20250813063044.421661-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for LAN8842 which supports industry-standard SGMII.
While add this the first 3 patches in the series cleans more the
driver, they should not introduce any functional changes.

v2->v3:
- add better defines for page numbers
- fix the statis->tx_errors, it was reading the rx_errors by mistake
- update lanphy_modify_page_reg to keep lock over all transactions

v1->v2:
- add the first 3 patches to clean the driver
- drop fast link failure support
- implement reading the statistics in the new way

Horatiu Vultur (3):
  net: phy: micrel: Introduce lanphy_modify_page_reg
  net: phy: micrel: Replace hardcoded pages with defines
  net: phy: micrel: Add support for lan8842

 drivers/net/phy/micrel.c   | 714 +++++++++++++++++++++++++++----------
 include/linux/micrel_phy.h |   1 +
 2 files changed, 522 insertions(+), 193 deletions(-)

-- 
2.34.1


