Return-Path: <netdev+bounces-158422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA2CA11CB3
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90C527A03EB
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73829246A10;
	Wed, 15 Jan 2025 09:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QJ2WymP/"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C0B246A0A;
	Wed, 15 Jan 2025 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736931682; cv=none; b=Hw200hfTR9BHkdVERP+XILgsImpUpSeE9g06K9SyrHouFFZEpr1MLA4srZdTQ2Z6IleoNHAuARLJ6YeK5qtRdbdTptP9UWuyJM3ZxYKUCgzH+2NeLFjxm38ZMbB+E9iJ2QihcPZ3zkVzuhSEpuSMxOux9u0yeiG7mCVaQMYkdKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736931682; c=relaxed/simple;
	bh=q3HYT4ZHzpL87rBDQkzBwnE4mY7jF4YGkJyzWWDd+ug=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pd8IE7A9MHE20uKVX1rzBOKKF1C5ILk7JShJ1FEJe2ykytttMry1FiICPaV9LigYIWyPuyEwsKeAZ4YIB3zaXAwhjl6tFqtMLPUT3/WbTMD13GNYypkBJvpdL/fDNuKUrOIwju0WkMUgKC0NCpnaq6gDoDRQSnhJMVcw3Q3T/K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QJ2WymP/; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736931681; x=1768467681;
  h=from:to:subject:date:message-id:mime-version;
  bh=q3HYT4ZHzpL87rBDQkzBwnE4mY7jF4YGkJyzWWDd+ug=;
  b=QJ2WymP/X/4m0H9pkaExKv5lmF6R4BNeMos2+7G8xO9qJwtIcC+TvNuS
   vpcsfBkE9FGweCVUgYEChj5I3JE/GIbFNvP0/Q99ZAvuDa008QEcC1CNn
   8/KseYFpCUI35sgWm/xoi7jTacorTkuBFmZqhj4DXr58amAQr9mflbVwt
   Kjytf1xbQe+tEYkgbDAEd2ov0p0IFKv3WT/fB7NdffU89SIB6WjH3MsG0
   1m6ZgJZFiyUuCulXXjJhevvLF2+zyj6kl+sD4w+dYW0fn1YEEFd8+spBf
   pxidc0YUFWt1eXn9vGhJ/iVKEcmXb3bHfaGV2VZ8iBAUJjR71+h58a4dR
   g==;
X-CSE-ConnectionGUID: 7oHBm2DsQWu43T667TRqKQ==
X-CSE-MsgGUID: VLZEHSu4QvmsRO+YBIQX+g==
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="267831894"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jan 2025 02:01:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 Jan 2025 02:00:33 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 15 Jan 2025 02:00:29 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v3 0/3] Add PEROUT library for RDS PTP supported phys
Date: Wed, 15 Jan 2025 14:36:31 +0530
Message-ID: <20250115090634.12941-1-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adds support for PEROUT library, where phy can generate
periodic output signal on supported pin out.

Divya Koppera (3):
  net: phy: microchip_rds_ptp: Header file library changes for PEROUT
  net: phy: microchip_t1: Enable pin out specific to lan887x phy for
    PEROUT signal
  net: phy: microchip_rds_ptp : Add PEROUT feature library for RDS PTP
    supported Microchip phys

 drivers/net/phy/microchip_rds_ptp.c | 270 ++++++++++++++++++++++++++++
 drivers/net/phy/microchip_rds_ptp.h |  24 +++
 drivers/net/phy/microchip_t1.c      |  14 +-
 3 files changed, 307 insertions(+), 1 deletion(-)

-- 
2.17.1


