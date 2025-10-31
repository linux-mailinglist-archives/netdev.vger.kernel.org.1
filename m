Return-Path: <netdev+bounces-234642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1062C24FC9
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 13:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C9740161C
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 12:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787EB330D2E;
	Fri, 31 Oct 2025 12:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="H67TcHMo"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D145E2236E1;
	Fri, 31 Oct 2025 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913450; cv=none; b=HDlA4zunBnwOLFSRrRduRbxi08W0l0x6yWgV/FP7u8bL/Ej2e8y8Uv0byLoetodsrYGMGQFBJuEFnGKyyPVZDDo23LDtQ5y8rrnmSvxfOON6IWz4elf+33UFpvWb6s7tnAprdj+uT+f+w8vH3LT/G43BNGXSSIP7dyqeGHbwCXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913450; c=relaxed/simple;
	bh=jh0ievyCPaq7Rd9ic7hTEjARghfv8f52fl/detu9jkA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mj8/p1qM+r9PDmFf4DetwI4ePIOizLS5LYMi2jANt5CdM4Fe1cJwqfeShzPsfvJZ+e64UDgDU4F1xblN0W2XAe3HPjNUYSzzBf0fziMRxwKDPawqbe/HFGTbYPDEW1U/wkV5OxYrykhqk7pTFLXInMHoZXQTDueVgHmQdxK4Po0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=H67TcHMo; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761913449; x=1793449449;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jh0ievyCPaq7Rd9ic7hTEjARghfv8f52fl/detu9jkA=;
  b=H67TcHMo9Gm/40f/G2bAy0zk58noGrc8nbD3m0i9ZdATrDUE/g4+vryp
   mqa/wY/r/H7xaZ96JuBRjqtpuUPYOzqkjFRnG5Le/Q6rLdrhIZmlq0uIK
   togtCGKTYIJ3OpxG7VHtWH8ehFUVD7HEeUzOQwFdYNVC7bP1USxNHmIxX
   QSSsfDWnLMtc5N9tUEd/0D/13CbfVJ1aXFxF7yxoMhPCXbJnA+EA+fFJg
   meGbnXothfdlQKuSjHKJlRzS8gUYVQpqrR5Ot2gIDUtFG0kNi2nwr3pii
   gQds+DO9BVHZgIvGH7Mx27SEYm/0bGDBF+l0tapWn9SnJCYRZReYetNxc
   g==;
X-CSE-ConnectionGUID: zcvDstULSmW/S2EHpEh+1w==
X-CSE-MsgGUID: QXH8zRPnRVC3Qy7Xuxx4WA==
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="49022898"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Oct 2025 05:24:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 31 Oct 2025 05:23:41 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 31 Oct 2025 05:23:39 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net v4 0/2] net: phy: micrel: lan8842 erratas
Date: Fri, 31 Oct 2025 13:16:27 +0100
Message-ID: <20251031121629.814935-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add two erratas to the lan8842. The errata document can be found here [1]
The two erratas are:
- module 2 ("Analog front-end not optimized for PHY-side shorted center taps").
- module 7 ("1000BASE-T PMA EEE TX wake timer is non-compliant")

v3->v4:
- introduce struct to contains all the register accesses
- fix commit message for second commit
v2->v3
- fix some register addresses
- add reviewed-by tag
v1->v2:
- split the patch in 2 patches, one patch for each errata
- rebase on net instead of net-next

Horatiu Vultur (2):
  net: phy: micrel: lan8842 errata
  net: phy: micrel: lan8842 errata

 drivers/net/phy/micrel.c | 163 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 163 insertions(+)

-- 
2.34.1


