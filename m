Return-Path: <netdev+bounces-204793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EA1AFC13B
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 05:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C7B4A73FB
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 03:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD68237A3B;
	Tue,  8 Jul 2025 03:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Da5Pn9Kl"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DC1230BEB;
	Tue,  8 Jul 2025 03:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751944641; cv=none; b=tKh6nllTK2KDaWDX2rmMA/WTXJMWVH68VGFzvKNCARrWpfGpHoYmArEw9FP7Lld+lgwXPau1LMdp9tYSEMi4bWMqSa0CMhPveype9h4pr9IU6kOaEcUCV7c9Gj8QrOtw5xD4BVK8bnMmniE5pTpC6OeEARqsPuM283iom9PRbBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751944641; c=relaxed/simple;
	bh=iN5fh+trLgbMvoKdItlJ3HldX49ue6jj1zJZbO2ZAnk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nARfxTHUBWR2JoG8Ml5p94eNM7w8am/xSa730dYs3h3PtmTbMt5FLPn3fk9OyjiuY3UlfpUH8zolX7km7a0jy7NK0WFV97ZciiOkGMQGerUMYb0X0qR15etuSVaHYC78qyUq9qJ4d35r1fDQemnKiANmgTlH7c3rGkXxiD3yMTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Da5Pn9Kl; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1751944639; x=1783480639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iN5fh+trLgbMvoKdItlJ3HldX49ue6jj1zJZbO2ZAnk=;
  b=Da5Pn9Kl0efLnll61T+vAQC0hs+DartvNZ1Ov5tc3/S4RJ8ePbQ4X+q8
   UNT8OkzKB1HJEKg4xrdv2sGOOb/ZAp2LWlQF3csX0t0F8d/4y6tCD99/9
   H14b87DWipKHfMMeYkU1VePQs/Iu8o9Ue8ziEswzOhC/qLEkwbaUMHWv8
   u9gwHvZ18XLcrdpIyPh/TNccAo6cS6exU50CtrKQkSlCNMlM9HFr7NiZy
   oa1/W/rt0t5lm5bpp4xeJChcmxKnvALNXMoHc0EBxZ5T5oj0sDNinxKvc
   JkDljsAzu9zxkX6oCH16X4OrtUNfiUxUrSfGMs7fkELYdTyR0dsU5wdyw
   g==;
X-CSE-ConnectionGUID: cVEISvaDRiehsZPvdpmZNg==
X-CSE-MsgGUID: 9lpJ/QtHQ6m7Y88gw/uvSA==
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="43198302"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jul 2025 20:17:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 7 Jul 2025 20:16:47 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 7 Jul 2025 20:16:46 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Marek Vasut <marex@denx.de>,
	<UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH net-next 5/6 v2] net: dsa: microchip: Write switch MAC address differently for KSZ8463
Date: Mon, 7 Jul 2025 20:16:47 -0700
Message-ID: <20250708031648.6703-6-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708031648.6703-1-Tristram.Ha@microchip.com>
References: <20250708031648.6703-1-Tristram.Ha@microchip.com>
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
---
 drivers/net/dsa/microchip/ksz_common.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 55108237180c..c08e6578a0df 100644
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


