Return-Path: <netdev+bounces-144863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8249C8981
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 13:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FA31B23CE7
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69CC1F9EA0;
	Thu, 14 Nov 2024 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VA57TLOZ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB731F9A9A;
	Thu, 14 Nov 2024 12:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731585853; cv=none; b=rLFp5pBf3t5tNF1S/12TCZNOCKvhy6L5nqZNNdZJUH6BAh6ENfJZL3CLi6qnuZ6dSqXqsO9GyOgrlklJ2lxHn6KHBmM4TZUuWhXVGnTA21VHPN8ZE0id79fUSV/g9pqrhLQeYqAZ5pXv54KPUO8ubRUwRWfoDUIvMKAcowdpe0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731585853; c=relaxed/simple;
	bh=aknHulabPx2rj+q1pW5QUyUpb3Onivs2or2sEv4PMME=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hSPuxEimQ2jq/bUErLqrZs3fk3zSceMt2Gm0zU5sjBFOinKWmvXATz64ARkKkTleX+rqSm9dcNT5fuoCX4eb1jaiz9iZpahe/nFjfFf7CL0GE14JUw0P5nUglyZ/EnM6DHDrcs12CkkrBXR0SPywo6E8TSaehFSu4Fh7rcgbWxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VA57TLOZ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731585852; x=1763121852;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=aknHulabPx2rj+q1pW5QUyUpb3Onivs2or2sEv4PMME=;
  b=VA57TLOZfYHpKLx4JCBd+H5FICNqWHg+3QHeRVFUHODXZZ2LAXTitvy0
   Hu8Kc41i+n3I+1hH6knqOydKhpjaBPojiphWNxOrzJHSXZK1ZKzpV40s1
   lz3EZW0hadl3eg8Tk+QnZ4S6q7bW6ZgXs01X1LHWk6cuK7cjp4S4mzbuZ
   6znFV0gFR7DB1vsEWT3tymtkgKqPnAu/tFNfSmgy027FO8mIZxwFCbPfC
   VZfvNeNcQYjYYlCrzxUkn3Fe1V/bYGOMKArk4tAROEcvO9XYNKwhJD26q
   M0fhwA8N6BUdxFhujPYbggp43bL6vhdxieW1KbkjRBrVjb726XwVGlcmA
   Q==;
X-CSE-ConnectionGUID: R1m+lyWhTgaRIjoFVkjDnA==
X-CSE-MsgGUID: soMaqTLmTimq3Tj8fyMd3Q==
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="34821616"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2024 05:04:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Nov 2024 05:03:50 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 14 Nov 2024 05:03:45 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v4 3/5] net: phy: Kconfig: Add ptp library support and 1588 optional flag in Microchip phys
Date: Thu, 14 Nov 2024 17:34:53 +0530
Message-ID: <20241114120455.5413-4-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241114120455.5413-1-divya.koppera@microchip.com>
References: <20241114120455.5413-1-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Add ptp library support in Kconfig
As some of Microchip T1 phys support ptp, add dependency
of 1588 optional flag in Kconfig

Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
---
v1 -> v2 -> v3 -> v4
- No changes
---
 drivers/net/phy/Kconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 15828f4710a9..efa027b2bf69 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -287,8 +287,15 @@ config MICROCHIP_PHY
 
 config MICROCHIP_T1_PHY
 	tristate "Microchip T1 PHYs"
+	select MICROCHIP_PHYPTP if NETWORK_PHY_TIMESTAMPING
+	depends on PTP_1588_CLOCK_OPTIONAL
+	help
+	  Supports the LAN8XXX PHYs.
+
+config MICROCHIP_PHYPTP
+        tristate "Microchip PHY PTP"
 	help
-	  Supports the LAN87XX PHYs.
+	  Currently supports LAN887X T1 PHY
 
 config MICROSEMI_PHY
 	tristate "Microsemi PHYs"
-- 
2.17.1


