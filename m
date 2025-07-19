Return-Path: <netdev+bounces-208299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0397B0AD42
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 03:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72F06588423
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 01:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7B71F3D58;
	Sat, 19 Jul 2025 01:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ux6+uGi/"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF03C1D9663;
	Sat, 19 Jul 2025 01:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752888102; cv=none; b=LaWDUmBqMIIxYnXohmAeezkWUzcmNRTS+xxW3QPo6DFE+QYP7k6HxhD/Mib3EaDE4EIEv1ASeSL2vPs5jwFMl6P79q/02nJ2g1eeDtqZKtoJb7JfA4j8ARwIfxYPV2cJB43IqjEMlJmw0afvdcFZ2Lo0506MA5InQ4hRL/zRw7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752888102; c=relaxed/simple;
	bh=+15FpSPkrACA+ciSacePLD07LJ6qgZseg7M8b2CYqv0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BxzDOGfWbn9c+9Hw+ATLKPWV6ZC0REq5UwRx3vG8fC8aSvOqwz1tYSf1tI7UUnfSjHF+mdjhGdSusC4aO5edMOXN88gfg/Q7XqAns2TUM6KZdDBrTkQOIR8q0We9lLPp+mKnV2ylk2u2SzWG1gLbSAG/XmBfMRL442hNuRGJGgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ux6+uGi/; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1752888101; x=1784424101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+15FpSPkrACA+ciSacePLD07LJ6qgZseg7M8b2CYqv0=;
  b=Ux6+uGi/o5N2yEZNwsn5hIgdOQYDzJ2xQdxHC4odkU6/XqlkHFEW76qT
   z9i2Fe7sZaO5dpByMe3cy+EKJzxjE1KATj0vZXpL3wMqp4JGaC8KSV+Nl
   Syqrc5s0xA+/4MTt6HG6iEXUcgNXBH3FwuqvEDN8t5gAsz2bmjueCYPwg
   8wJZtHJbiNF7dxdO3m4NuhQ/B79I4idCVhW9oML+yN+sRWxmLv8uJZ/rb
   Q8Gj+wHTg22dzZIy2Dgen/IJ0pt4/eIYPp0D1qxkiTwhnncH9CmZlLZyN
   dwDbejLPwdghuLD8+PtXN7Ql1WFDIMiI6CXv/4Wqu01HEaGHhU0xwsxPT
   A==;
X-CSE-ConnectionGUID: nNeMYTH9S7+QK+h8shmrqw==
X-CSE-MsgGUID: lGzN1hEtQlWgjPNfy49msA==
X-IronPort-AV: E=Sophos;i="6.16,323,1744095600"; 
   d="scan'208";a="44154238"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jul 2025 18:21:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 18 Jul 2025 18:21:07 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Fri, 18 Jul 2025 18:21:06 -0700
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
Subject: [PATCH net-next v4 7/7] net: dsa: microchip: Disable PTP function of KSZ8463
Date: Fri, 18 Jul 2025 18:21:06 -0700
Message-ID: <20250719012106.257968-8-Tristram.Ha@microchip.com>
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

The PTP function of KSZ8463 is on by default.  However, its proprietary
way of storing timestamp directly in a reserved field inside the PTP
message header is not suitable for use with the current Linux PTP stack
implementation.  It is necessary to disable the PTP function to not
interfere the normal operation of the MAC.

Note the PTP driver for KSZ switches does not work for KSZ8463 and is not
activated for it.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 drivers/net/dsa/microchip/ksz8.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 1fb0ebd0c50d..59e7960a754d 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1761,6 +1761,17 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
 					   reg16(dev, KSZ8463_REG_DSP_CTRL_6),
 					   COPPER_RECEIVE_ADJUSTMENT, 0);
 		}
+
+		/* Turn off PTP function as the switch's proprietary way of
+		 * handling timestamp is not supported in current Linux PTP
+		 * stack implementation.
+		 */
+		regmap_update_bits(ksz_regmap_16(dev),
+				   reg16(dev, KSZ8463_PTP_MSG_CONF1),
+				   PTP_ENABLE, 0);
+		regmap_update_bits(ksz_regmap_16(dev),
+				   reg16(dev, KSZ8463_PTP_CLK_CTRL),
+				   PTP_CLK_ENABLE, 0);
 	}
 }
 
-- 
2.34.1


