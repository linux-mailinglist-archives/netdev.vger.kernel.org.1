Return-Path: <netdev+bounces-208297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B663DB0AD40
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 03:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A665F3B1C08
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 01:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A2E17C211;
	Sat, 19 Jul 2025 01:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uPV+N+rx"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C679F5464F;
	Sat, 19 Jul 2025 01:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752888100; cv=none; b=OlUrCx+E/rPk0BJu3JNmNwGK1yeqtGkqueTi8ICsoWXIKUcjpCBPY6hJ9ykmv+zIzd9vOlGc98JxFJceT7CpHhZ4QP/e6G21Pg/PwC649DVnNzuDIQ/2e36okfs0KDzp6/l6S+642vNbCxQ4/uX6q5vBu8igr2WfOzHJuD14Rks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752888100; c=relaxed/simple;
	bh=RSAwVzaIdcMNqIgXXE1U991nQuJifpNkAJ5L4wSSAVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JG7WC9CSAlH4p+CvlAITgJcx7sDLLHvc3U3kQFFRQTwLiNzkYauGJ/UFyKnpLNDXMBJVh6DiyzsWvhN3js0LWUAwXlpR+JeuMqE2tFoRoqXuzdUyM2nyXLmQRvtJOE2naEdT7ywYHYE3NpJEiHZ+TfPRdI0Q0XDwtX0ZUwpVkzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uPV+N+rx; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1752888099; x=1784424099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RSAwVzaIdcMNqIgXXE1U991nQuJifpNkAJ5L4wSSAVo=;
  b=uPV+N+rxkkpqq+I4/9WrE/xIRKRk1f05xof5PhaoxWmrYaozx8/tTLZH
   56Af6PIBL2oYP+1TwQlQzWxMG4YhCUDT3XFyPz8oE/ZAahiTbea1UAems
   nravtS9vyPEVQK9mk/azNpjQahTebu2FW/tXnMS2QFvC2hqbAg3ekIMBR
   gFZ/i+kkve40KPdHlm1EoWZrMCrZaOgUZpLXra2xmTwe3e1lQElVZ+fgp
   uJvyqRyv5dlumLRw6nLRiY/j8cplxiTcWbdlqJU657/fVI9YAUV1kB5e5
   Opn7o8YDduiYam5tFAqKdknQNRB5BMBZarduqeIgWANn0mrQRnSqkt3Iy
   w==;
X-CSE-ConnectionGUID: nNeMYTH9S7+QK+h8shmrqw==
X-CSE-MsgGUID: vSgMyiOqRyev21kyUHxUTw==
X-IronPort-AV: E=Sophos;i="6.16,323,1744095600"; 
   d="scan'208";a="44154235"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jul 2025 18:21:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 18 Jul 2025 18:21:06 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Fri, 18 Jul 2025 18:21:05 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Marek Vasut
	<marex@denx.de>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Tristram Ha <tristram.ha@microchip.com>
Subject: [PATCH net-next v4 5/7] net: dsa: microchip: Write switch MAC address differently for KSZ8463
Date: Fri, 18 Jul 2025 18:21:04 -0700
Message-ID: <20250719012106.257968-6-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250719012106.257968-1-Tristram.Ha@microchip.com>
References: <20250719012106.257968-1-Tristram.Ha@microchip.com>
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
index b78017abf0b8..0ef41f8d0066 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -4823,7 +4823,16 @@ int ksz_switch_macaddr_get(struct dsa_switch *ds, int port,
 
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


