Return-Path: <netdev+bounces-209922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CED4B11524
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 02:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 070E67B4C32
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 00:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1EA1A0BD6;
	Fri, 25 Jul 2025 00:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zbqgie7o"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A7F4502A;
	Fri, 25 Jul 2025 00:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753402698; cv=none; b=ffn5CFOIl3jynP5qjOG2yjjjuXIZqPOPOU+/8ZquE+XmD5EjxMgSblxBRF3YQxuBAbX+enyloxqfALzKrvLd4WvyEDg8EF2iZV/ZGE1J5B/mbczG+vOiYnodh0LPeuUXVqovbodHe9oT0sK1TGc0w74G1ew3xy6NSx/WhlZeO7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753402698; c=relaxed/simple;
	bh=pPSPnAUdAXPzmJliXAKAtBQbetuWfffW22gbyAsJmag=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VehhEz9a1I4KZVzggyaf8nYhwp6LZ7Z06NFSFyRrkhhs4VKU/6VU6G9+C5tkmEKf1Y5uVDcgIGzneDkLSXFAEr0G3AKtUMiY9U4Ivx+jq3JyOZ6n3/BnmV33s75MHrdz0M8qUFAmLyccpGbpALm9NMFJkizmW0wiOa23I/edTSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zbqgie7o; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1753402696; x=1784938696;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pPSPnAUdAXPzmJliXAKAtBQbetuWfffW22gbyAsJmag=;
  b=zbqgie7oZ1GbANwj/ykpg+p5xKhHUtVX4/gu/OozQqRGigv7ZlQhViMO
   vtQdy5dBGYoUAf5TAMqwuvCPl3YKQENYtLJjXr2RODSj04MmeGpNsG1+l
   ioKh57NNd/y9PJs4RbdVRPQ6t0SLjePluOhD28WRFJx3a574Eg0kR/sv7
   Ar3wY5pnsDP+wxe7v9l6cL8DfDvMdiklh4cuYTZQ/iOXKtuZM+DuJ03XD
   iwAyIFAi87brip9H1GokX+5j9iDH8HGydg6OsXV4bRTuqEh2/r3gdnlZ1
   bD+8a7xsiGX23NSqKbdA5do73RgedLfH0W9rgsxIMLBpCtYgdHdjd+w0e
   Q==;
X-CSE-ConnectionGUID: pRt2tG6dTs6yrFFGZ+6lXw==
X-CSE-MsgGUID: vjCbKTJWQ/auAnrygT3Jmg==
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="43875718"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jul 2025 17:18:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 24 Jul 2025 17:17:54 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 24 Jul 2025 17:17:53 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>, Simon Horman
	<horms@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Marek Vasut <marex@denx.de>,
	<UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH net-next v6 4/6] net: dsa: microchip: Write switch MAC address differently for KSZ8463
Date: Thu, 24 Jul 2025 17:17:51 -0700
Message-ID: <20250725001753.6330-5-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250725001753.6330-1-Tristram.Ha@microchip.com>
References: <20250725001753.6330-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

KSZ8463 uses 16-bit register definitions so it writes differently for
8-bit switch MAC address.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/microchip/ksz_common.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 552c993b6519..e47c4a5aad6f 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -4821,7 +4821,16 @@ int ksz_switch_macaddr_get(struct dsa_switch *ds, int port,
 
 	/* Program the switch MAC address to hardware */
 	for (i = 0; i < ETH_ALEN; i++) {
-		ret = ksz_write8(dev, regs[REG_SW_MAC_ADDR] + i, addr[i]);
+		if (ksz_is_ksz8463(dev)) {
+			u16 addr16 = ((u16)addr[i] << 8) | addr[i + 1];
+
+			ret = ksz_write16(dev, regs[REG_SW_MAC_ADDR] + i,
+					  addr16);
+			i++;
+		} else {
+			ret = ksz_write8(dev, regs[REG_SW_MAC_ADDR] + i,
+					 addr[i]);
+		}
 		if (ret)
 			goto macaddr_drop;
 	}
-- 
2.34.1


