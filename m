Return-Path: <netdev+bounces-218296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764D4B3BCDD
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 15:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A2CA4530F
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 13:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC371EE7DD;
	Fri, 29 Aug 2025 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xT2zS7ME"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B792E8B9E;
	Fri, 29 Aug 2025 13:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756475593; cv=none; b=JYl3fxzPtbttPK+YsbiBBfKQd+t7AOFvuVDbTCRbZXMfnZuVz2H9RI0w2VgcZxYq0f5mCylTOr50psNbd3k12cfAQ6eJE2DWEjCOaQNlXrXROGJ6K/ZDKCUSI6dhjXD2PmOJyZF+yLSeVjAOY/rqfLazQZaSU1dmhi12f1boc7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756475593; c=relaxed/simple;
	bh=aAoUHUtk5oZ7nWbYD6AY3zmpX62pOyRMTVvY/aBHFfU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=isQ/OqYD+n8ypTevmX5WGT2WRhPfJZfqNBgwls4D0M9V+CtXKzLTdpjx5BeWJnLyMvU0lW1ALRDlgLxXgJg1rEsfbv5A8rDtYPfxXNm3dmHdYRg8P+UkIHIbcDsk2omw6DSoDSLDQzIjT/H+jJYdbqhcOPxlIRJNIAIMd8o5LP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xT2zS7ME; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756475591; x=1788011591;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aAoUHUtk5oZ7nWbYD6AY3zmpX62pOyRMTVvY/aBHFfU=;
  b=xT2zS7MEzJ/juObJnOgJrtg2YnAcpLgo9Zg5TVUNsiLYYtbaB7Vg089h
   020vpX8nwt2lyKhD7rPsngDQjMi2B8IaFkiDUMUg3SbV/NDSA8TrFxLKZ
   nUUeUswYURqitHvuvVuMaScRUgIHY3978auaUV8D8j6wPLaiO9HVtm4ZN
   5YQ5/1Nu2BTlePNWfZ6nzCRKDsFoLkNxV4vnTa0foUuXwZYtq++DTyS74
   4xVsOYUIo29exF/SFVNELaN0iQWtyqUqVoBrWkmrk9rdmyOSYUOiUar0X
   EBGCvTncs4l7QJZ/ThP6miBX4bDQKFir5x84V/brAmIPAo0V+UWdAs2DB
   w==;
X-CSE-ConnectionGUID: Wrsaw/F7SFCMcyL3Intb1w==
X-CSE-MsgGUID: 1Yqg6ADfRDaSFWz/Hk+lwQ==
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="46380521"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Aug 2025 06:53:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 29 Aug 2025 06:52:29 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Fri, 29 Aug 2025 06:52:27 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>,
	<Parthiban.Veerasooran@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next v5 0/2] net: phy: micrel: Add PTP support for lan8842
Date: Fri, 29 Aug 2025 15:48:34 +0200
Message-ID: <20250829134836.1024588-1-horatiu.vultur@microchip.com>
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

v4->v5:
- remove phydev from lan8842_priv as is not used
- change type for rev to be u16 and fix holes in the struct
- assign ret to priv->rev only after it is checked

v3->v4:
- when reading PHY addr first check return value and then mask it
- change the type of gpios in the declration of __lan8814_ptp_probe_once

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


