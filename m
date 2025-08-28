Return-Path: <netdev+bounces-217629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1187B395A3
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 09:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A79B8682365
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 07:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDE12E4247;
	Thu, 28 Aug 2025 07:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1l9xJ56O"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E23D2D6410;
	Thu, 28 Aug 2025 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366775; cv=none; b=V14boqeDQvFmIJk9LD1WFwlAOHjMIt6uAH5eAXeqVUxYxC2t6q+QVgEw10dSQqIN6+lganmsj9644f+qF1gtkiI5ta7aHn0kkSxk6x1+SxgHU/oIzX9d/KdiMmFEo87WwbaJJH+yJn+T7JY8/I3iGprHJRDWk3yXFDzBmNtD7yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366775; c=relaxed/simple;
	bh=o+EoqxJqGnLGz3K1NwByfT4fimHfAWOCU2juWgwEIvY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CQjSWb/raAm8rCO3PXUyZuZF0ph8sdAO+kxRIti3gSisnNwu+kuENtuh7zJ4ffubWAWmEBjMxYrj0IBkgDiPK6oEDPxH915Kq48rSkLrnRogz/73ELXgypt+9n7ghY0YtdHqAtcaO40cvtQHiNT852QVWOeW8pymXRozo/K00H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1l9xJ56O; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756366773; x=1787902773;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o+EoqxJqGnLGz3K1NwByfT4fimHfAWOCU2juWgwEIvY=;
  b=1l9xJ56ODK32J0zjqiSWIdeaZ6cPePAbAh+YkrjfmrTSXKNUkvOu90oA
   StEQWlTeDuAeYgUg1+ULSbgOW1Bns6vXM51nZGhLxi0aKuqfTgjSypB9C
   w/2Kswd8jTY94jhkozh1EnZGsI5pUX8bqIx637HYpx30gRjf/a0JuHiwe
   Q+LNepl/XeNIXSc207NhDnarjqSJVkN6WxfnLzVBgO1TlIFiujZVwwp6u
   WSJtYdG6nolejdQmHRATmeL+7XKuNR7GGVGqGxM19gO8nafQO/m5jicrM
   U3m0C7dlvlp0FPtyYedsvV3cHHKS63c0Zav/AT3X1k9UEZNlMF11JaXsU
   Q==;
X-CSE-ConnectionGUID: HWERbbQDSnyZWniNoHOzXQ==
X-CSE-MsgGUID: qTlK2IoxR9uhkAcGyiJaKA==
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="46325943"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Aug 2025 00:39:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 28 Aug 2025 00:38:56 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 28 Aug 2025 00:38:54 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>,
	<Parthiban.Veerasooran@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next v4 0/2] net: phy: micrel: Add PTP support for lan8842
Date: Thu, 28 Aug 2025 09:34:23 +0200
Message-ID: <20250828073425.3999528-1-horatiu.vultur@microchip.com>
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


