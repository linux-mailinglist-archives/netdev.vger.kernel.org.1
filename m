Return-Path: <netdev+bounces-156636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DD6A072ED
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 11:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81FEE1665DA
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7DA217647;
	Thu,  9 Jan 2025 10:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AWm6+Rjy"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855E4216399;
	Thu,  9 Jan 2025 10:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736418199; cv=none; b=oh6OJvrsNoWc69ru0ZrQk686WHJLVU+rA86pJJMQSlIka8WXggirGvy5AgU9j/ully6jV/N5KbkcHQKkgP96WrvfGmsxb1dtt54bIgYL0nRVXzF6i33N6ohvGv7abTbpM6eco8ovZ7ThGk7VjVHYnWRMErFhNoWu1oGyydNzT90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736418199; c=relaxed/simple;
	bh=uGcxzumxmcurb7Ek662YFTXdJ2+Jyx8k8v/cXp3kHfc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=soqDJCszqMZMGszijh0L06wu0L0qMDbHl6fXuz23SXK69UaJaUHUt/4601j7A9bGb9K73R55ij5bEUbslZsPEn36Yx8fZL0NdDvdbRbsNDnt/Eg3NKfam9Cl+MuXLMUyZhgdA+LI/x1RonKULstayhIQttIcLd4834B68JKP53w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AWm6+Rjy; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736418197; x=1767954197;
  h=from:to:subject:date:message-id:mime-version;
  bh=uGcxzumxmcurb7Ek662YFTXdJ2+Jyx8k8v/cXp3kHfc=;
  b=AWm6+RjyITlher7HilUGdsg0onV4pk0jSO/2xkspCX1BkL+ONxnR0jZa
   u5pBBBZ/NTxWpR5OZaF40jsFRyUJhclDO25jjAB/QhS8Vd1hCvTIjsnME
   yxLucEgU0SXXK+hl7g3LO5IjWYT76ozqL3fjZy7/VwSUDbA3upLPBHkxK
   DRAhySPIDTd69MnJyxY+NaO+KW1g4zk3lUGjdO1ifpiVcGbTioAcoClPp
   xqm+qfWKTerMVqvZ7qAizdBY2v8uhDkar4NCXTTJMkx3asfvD+Hf23iUp
   5N/mlrVy0TPhP5mQTFPeiQpOYl6Ft940OO1IntgTfir0KFLO8LdxkNNqU
   g==;
X-CSE-ConnectionGUID: pKZMzjv2RsiFZGF8PKVKgw==
X-CSE-MsgGUID: xU0F8CadTkWjWqXNWhSPnw==
X-IronPort-AV: E=Sophos;i="6.12,301,1728975600"; 
   d="scan'208";a="40189012"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2025 03:23:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 Jan 2025 03:22:32 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 9 Jan 2025 03:22:25 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v2 0/3] Add PEROUT library for RDS PTP supported phys
Date: Thu, 9 Jan 2025 15:55:30 +0530
Message-ID: <20250109102533.15621-1-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adds support for PEROUT library, where phys can generate
periodic output signal on supported pin out.

Divya Koppera (3):
  net: phy: microchip_rds_ptp: Header file library changes for PEROUT
  net: phy: microchip_t1: Enable pin out specific to lan887x phy for
    PEROUT signal
  net: phy: microchip_rds_ptp : Add PEROUT feature library for RDS PTP
    supported phys

 drivers/net/phy/microchip_rds_ptp.c | 294 ++++++++++++++++++++++++++++
 drivers/net/phy/microchip_rds_ptp.h |  39 ++++
 drivers/net/phy/microchip_t1.c      |  12 ++
 3 files changed, 345 insertions(+)

-- 
2.17.1


