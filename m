Return-Path: <netdev+bounces-154936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBA2A00676
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 10:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C061A3A3490
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 09:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A691CDFC2;
	Fri,  3 Jan 2025 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SQ2IWdKk"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C151CD210;
	Fri,  3 Jan 2025 09:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735895335; cv=none; b=PegnzUxZdN1PrAKms02f0347l3lIm3R1UhgVuT92FgaXNaoyhlQTO45+mix80TOT/L1t8kvSjnk5trog9GpFtestntsm7kONRf9J99jBNKjUXPeDBxoxUrbYIESztlG1/DlUcU6nFjlig04Wgt2FZcL4gmXEMdBv/4+CQ3rbLbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735895335; c=relaxed/simple;
	bh=Cy2jESlnYyuwXA7sssXsvJzc2f/h9kpIy8cZpD/RbZw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PidP8ntD24pthN5AIBqpuhDOcjgFdAM7zmiJXrL5Z9ehKnQIbcT1m4dRJ+cLv3KqQuZLQg+ysClg9hNgcCxH90gIqflBsUryjnghbLB/UoMjeSarNZrkKYPGLON+2EijoRfJxwS5m80gmD3l/y54Cgt3bd/7itYlMcYbtGXX1Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SQ2IWdKk; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1735895333; x=1767431333;
  h=from:to:subject:date:message-id:mime-version;
  bh=Cy2jESlnYyuwXA7sssXsvJzc2f/h9kpIy8cZpD/RbZw=;
  b=SQ2IWdKkTZBD6Gsb77XDE9usyH2KKcRvIZYuZyRxkMHYeHoSOOlZfozx
   pN/uTHQ5kAzFG4G7FvlqwHNlkHxUNtAPRqMPWvg4tsO28JinREPwbhGL3
   VC4X8bD/U5ioGVRslb3r7XK7clh29TCgia57jQ9MI8KTXYxgn8lpsDRdP
   trVV3oZPjsQfRUESDFGEEa+8Jb9IITve9QbBlAS5BZ1ov1fsfPGgn7D4A
   RefLqedv95BOPwvjoJ90BJHfvM6+35MlWOc8pqc1s5BE5VoTQ12VK1EIH
   TrG1+SUhsPaGubIbcReSjVpfszutdCTHBSspVrDYee7Iu8JprDOTp5vUD
   A==;
X-CSE-ConnectionGUID: mw4tOLDUT3aREIdU5k9GYA==
X-CSE-MsgGUID: 9SOwS3vFQ7mVWgjQiEA4Jw==
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="267389301"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jan 2025 02:07:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 Jan 2025 02:07:31 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 3 Jan 2025 02:07:27 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next 0/3] Add PEROUT library for RDS PTP supported phys
Date: Fri, 3 Jan 2025 14:37:28 +0530
Message-ID: <20250103090731.1355-1-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adds support for PEROUT library, where phys can generate
periodic output signals on supported GPIO pins.

Divya Koppera (3):
  net: phy: microchip_rds_ptp: Header file library changes for PEROUT
  net: phy: microchip_t1: Enable GPIO pins specific to lan887x phy for
    PEROUT signals
  net: phy: microchip_rds_ptp : Add PEROUT feature library for RDS PTP
    supported phys

 drivers/net/phy/microchip_rds_ptp.c | 320 ++++++++++++++++++++++++++++
 drivers/net/phy/microchip_rds_ptp.h |  47 ++++
 drivers/net/phy/microchip_t1.c      |  18 ++
 3 files changed, 385 insertions(+)

-- 
2.17.1


