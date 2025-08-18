Return-Path: <netdev+bounces-214466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8A7B29B67
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 09:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD64189D59B
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 07:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B842D0C68;
	Mon, 18 Aug 2025 07:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yXONm58k"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95412C3262;
	Mon, 18 Aug 2025 07:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503758; cv=none; b=JICSgfnbEADy/HHUg+IGDvPuSCF3SrOvm+7h+Z5YM2EDvuBvXBKj3uDtECyjCgxRmxzdbCfrJ8DgkjZYdDJchz+yPu2XsVojVuoDWz7AxSrf5NERkXjOivHSYikuT1E0t1ANWygSkJ3Xp3NaJ56mgu88LDvDeBMmp6vkcTl3a80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503758; c=relaxed/simple;
	bh=GQkkLeFvDvDcSZjUfM4J36c5T1aM6E6EKupNTlQy3/Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BHIyYz52k+bzWcf0b+DHPaMFsBRB/s/VICGx/ufl1AjZmT8QjcJQCqBzyLhKzmOZ6d+l0dzUXXLdT87KdNuhzrJCZKtOBJNaZB417N3C3/q4AASUgGGf/dFc7mOuBezPKfSOYOB61h8yY70CBC/wpv3GMvX20ML+qZ0prGGJU2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yXONm58k; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755503757; x=1787039757;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GQkkLeFvDvDcSZjUfM4J36c5T1aM6E6EKupNTlQy3/Y=;
  b=yXONm58kAxGBHPaPDBtgyXp3JQ+UJbhLDFgcGybXp7v6yPnTgjPc6g6p
   GWKEoThL5Iaq7QggzH116YRJ4qaHKbTgQpgFMslxrHxAULMGBuOaR3s2T
   aXJ3r6TPVOv5Lh4xiwWOYiKFaw0axFAlafY7+h6Zz3B72i2eSmarraD2e
   DdwusW+GG3TfMLHb32pkmJ8PWsA42V3Q+Nrr7SErw5D2OAsrzwvaGzAU+
   ql1cvRIiTfVcCcHLOB5MtMrz9NUYTJZ4m7VXA3/GgX5LJiIIVCAbLI0tE
   9u1anSW+ahHS7kzxBnTT04LeXRe0IQKDDVmYVLxcx9wtFV33kN44sneRw
   w==;
X-CSE-ConnectionGUID: zvHPdPfMRrO82TK5qNmraQ==
X-CSE-MsgGUID: B2mJwjLyRMGK7HnxrZcgHw==
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="45303092"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Aug 2025 00:55:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 18 Aug 2025 00:55:15 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 18 Aug 2025 00:55:13 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <o.rempel@pengutronix.de>,
	<alok.a.tiwari@oracle.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next v5 0/4] net: phy: micrel: Add support for lan8842
Date: Mon, 18 Aug 2025 09:51:17 +0200
Message-ID: <20250818075121.1298170-1-horatiu.vultur@microchip.com>
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

v4->v5:
- implement inband_caps and config_inband ops
- remove unused defines
- use reverse x-mas tree in lan8842_get_stat function

v3->v4:
- add missing patch, the first patch was drop by mistake in previous
  version
- update lanphy_modify_page_reg to print err in readable form and outside
  of lock

v2->v3:
- add better defines for page numbers
- fix the statis->tx_errors, it was reading the rx_errors by mistake
- update lanphy_modify_page_reg to keep lock over all transactions

v1->v2:
- add the first 3 patches to clean the driver
- drop fast link failure support
- implement reading the statistics in the new way

Horatiu Vultur (4):
  net: phy: micrel: Start using PHY_ID_MATCH_MODEL
  net: phy: micrel: Introduce lanphy_modify_page_reg
  net: phy: micrel: Replace hardcoded pages with defines
  net: phy: micrel: Add support for lan8842

 drivers/net/phy/micrel.c   | 786 ++++++++++++++++++++++++++-----------
 include/linux/micrel_phy.h |   1 +
 2 files changed, 555 insertions(+), 232 deletions(-)

-- 
2.34.1


