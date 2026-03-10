Return-Path: <netdev+bounces-266344-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAQROxqNsGkukgIAu9opvQ
	(envelope-from <netdev+bounces-266344-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:28:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7219725845D
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8670316D486
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6193D090C;
	Tue, 10 Mar 2026 21:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wl29lbmD"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9053E8C41;
	Tue, 10 Mar 2026 21:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177805; cv=none; b=HjVKEq0uPZ/uhQmt5B5WILf2uebQ+ZJikJ+akfDPyt53Gxt4LJ98YHA3K0erb4ouKf6GMt55F+xwDcBNFaLmgo9l6btDjkROV5FRpefbU35SNEtRQu4qfaM1WG8sCykppAxfDYBb8B9TqvREBbTW0Ywp59+cuh4P49U/b7xwDA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177805; c=relaxed/simple;
	bh=hkczP+cRn1ooydd+akAnJcSKxQz5P80wL/hb/h7uxDI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E05OZlk2MMdx0s03JbK0g3PtFIHAI+qUxe3XIoN8BOjl/evJz3AcMURX9J5Z/6UajXZzP3Ldqo/dsL4YlcfhBXks/D6/d2S++P/pYMPMgMMUbfpdiUXFzXPtfQAmmN0F+oKi6Ugxam5DjqAivv2e/LxLvuEypPrYw1fLe1mPhp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wl29lbmD; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1773177798; x=1804713798;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hkczP+cRn1ooydd+akAnJcSKxQz5P80wL/hb/h7uxDI=;
  b=wl29lbmDAKs85P6/emI+iuo+9SfWr0XInCXFgFxZDvktbbYCcZswRQr3
   G3KyqxUVZjUCJxWDY/q61SGH4OeHFAzXc2p1KunKgtyt4RSz1DMgMG4LQ
   VgqiM5khG5RnI319CpXuzH6f8B8TgY4/ZlgHeyZh7IBpCSzaZqtFCT+/n
   4rsSQe7kN2aRiG/M34QNn4ZXEWxCVZXOixHwZFej6m7wUsXmB3pCK+RPJ
   Ec1I0cTHVQ99rIEKhy/zn4eXN6Qg9c43DQFHbX1KAkcuORFe0WeE5CQYn
   SasBY8yYx/k8P1OzwHnDdjefA5tSJuNfDV6MpJilO7ceNOq+msjElZbAB
   g==;
X-CSE-ConnectionGUID: A5M1IvIGR8Kc/SXjbvrhaA==
X-CSE-MsgGUID: nzPHh1C4QD+X/xOpJMLlZw==
X-IronPort-AV: E=Sophos;i="6.23,112,1770620400"; 
   d="scan'208";a="54912636"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Mar 2026 14:23:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 10 Mar 2026 14:22:47 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 10 Mar 2026 14:22:46 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Simon Horman
	<horms@kernel.org>
Subject: [PATCH net-next v2 0/3] Initial support for PIC64-HPSC/HX Ethernet endpoint
Date: Tue, 10 Mar 2026 14:21:59 -0700
Message-ID: <20260310212202.3991199-1-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 7219725845D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266344-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,microchip.com:dkim,microchip.com:mid]
X-Rspamd-Action: no action

Hello,

This series add basic support for Microchip "PIC64-HPSC" and "PIC64HX"
Ethernet endpoint. Both SoCs contain 4 GEM IP with support for
MII/RGMII/SGMII/USXGMII at rates of 10M to 10G. Only RGMII and SGMII at a
rate of 1G is tested for now. Each GEM IP has 8 priority queues and the
revision register reads 0x220c010e.

One particularity of this instantiation of GEM is that the MDIO controller
within the GEM IP is disconnected from any physical pin and the SoC rely on
another standalone MDIO controller.

The maximum jumbo frame size also seems to be different on PIC64-HPSC/HX
(16383) than what most other platforms use (10240). I've found that I need
to tweak a bit the MTU calculation for this, otherwise the RXBS field of
the DMACFG register overflows. See patch 2 for more details.

PIC64-HPSC/HX also supports other features guarded behind CAPS bit like
MACB_CAPS_QBV but I've omitted those intentionally because I didn't test
these.

Thanks,
Charles

Changes in v2:
  - Use separate compatibles for PIC64-HPSC and PIC64HX
  - "p64h" -> "pic64hpsc"
  - Merge patch 2 into patch 1

Charles Perry (3):
  dt-bindings: net: cdns,macb: add a compatible for Microchip pic64hpsc
  net: macb: add safeguards for jumbo frame larger than 10240
  net: macb: add support for Microchip pic64hpsc ethernet endpoint

 .../devicetree/bindings/net/cdns,macb.yaml    | 19 +++++++++++++++++++
 drivers/net/ethernet/cadence/macb_main.c      | 16 ++++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

-- 
2.47.3


