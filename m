Return-Path: <netdev+bounces-209923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BDEB11527
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 02:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768A9AE4A09
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 00:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D201A5B96;
	Fri, 25 Jul 2025 00:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="A4SZpy6I"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC1B19CC27;
	Fri, 25 Jul 2025 00:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753402698; cv=none; b=Ak3KYVApsPGeN4x6U6n2Uu/PetsPmuzTn2WfFNJ0sx3fbwaVk/KGr5Sk8z7b7rj8etVKX7M+iDhiQoHWPxT4EhYvTm6glToliA1aZCb/dkOyb6tRP0Vv/j/Lu0X4QQU9WDGoQXBheFRMPdRG6o8K6882dbLd1JQX0E8sWCuP4xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753402698; c=relaxed/simple;
	bh=KV62NoXC9aWiyFqUrd583Tuwhbt7qTYtiziCYEan+zg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+3uSEDYKeBEE9xhph/NpQwBSMgRpoC5PxtCjGgpAcKSaUavk9TLYpUw4fxf2oNG3hbHzD8Q1OH4xEOigtw2b4Jksvpbvze82Abb7tpLc56fEjTGpUA5+FVsk1xEv/H+l0cS7jD4SloKnH813IaCX8PmJqTZqPsjj/RhfJHlY8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=A4SZpy6I; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1753402697; x=1784938697;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KV62NoXC9aWiyFqUrd583Tuwhbt7qTYtiziCYEan+zg=;
  b=A4SZpy6ITNRtHioJgDOO8jgf6Yz0wMzT+M1VhyYQQN/vE3PMRxDGityI
   IZPUTB46lmdBZNUstu2F2lEcBMP9bFTmnh78g9oPxrzVxaET+yjOCvdVQ
   fnD6zFEuPSNC+O8yotIj1YQM6Dbz5BnZ+CEs6vYyzUqP3ekBoAH7Q9IX1
   rfOvnqVY1CZyBMfy2IHZ60qmtJ98CErKazLcbM4Mybj6onRCEG4+sSl3D
   e/YpMVCu3HUFyh7jZ79J2XcAFqqeIB7Tr1wjrDDlVItGXwESbC9X4+/D1
   Lz9zpqT3yh9RBHmfLhMl8WAG+qdfzdlg3JJm1Z20kqF2QjGOhNiadk90f
   g==;
X-CSE-ConnectionGUID: pRt2tG6dTs6yrFFGZ+6lXw==
X-CSE-MsgGUID: M4iAdzUXSJqV72C4LyzTjg==
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="43875719"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jul 2025 17:18:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 24 Jul 2025 17:17:55 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 24 Jul 2025 17:17:54 -0700
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
Subject: [PATCH net-next v6 6/6] net: dsa: microchip: Disable PTP function of KSZ8463
Date: Thu, 24 Jul 2025 17:17:53 -0700
Message-ID: <20250725001753.6330-7-Tristram.Ha@microchip.com>
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
index 62224426a9bd..c400e1c0369e 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1760,6 +1760,17 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
 					   KSZ8463_REG_DSP_CTRL_6,
 					   COPPER_RECEIVE_ADJUSTMENT, 0);
 		}
+
+		/* Turn off PTP function as the switch's proprietary way of
+		 * handling timestamp is not supported in current Linux PTP
+		 * stack implementation.
+		 */
+		regmap_update_bits(ksz_regmap_16(dev),
+				   KSZ8463_PTP_MSG_CONF1,
+				   PTP_ENABLE, 0);
+		regmap_update_bits(ksz_regmap_16(dev),
+				   KSZ8463_PTP_CLK_CTRL,
+				   PTP_CLK_ENABLE, 0);
 	}
 }
 
-- 
2.34.1


