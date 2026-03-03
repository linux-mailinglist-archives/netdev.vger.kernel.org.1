Return-Path: <netdev+bounces-263347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAJ9J6Yjp2mMegAAu9opvQ
	(envelope-from <netdev+bounces-263347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:08:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B161F4FDA
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6AD0306B9D9
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 18:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52CA1D90DD;
	Tue,  3 Mar 2026 18:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="r18DtKyP"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7358E37F01A;
	Tue,  3 Mar 2026 18:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561083; cv=none; b=cDhHZK+aGv4eM0cPgGCUAoL13352sg3isksyO4G50Zl2iUpfMYDYwzYqyyl1rFtPd8+Tx6lHR4uX6L59vKWaIb1fxtIpzimfIFLdn3ZA/Eqh9OoAv+7PGoT4OeLWgI6WyIgG2+qp32bNqeEW7FiYKWrPHEKFy3JvrU0dVfmvXRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561083; c=relaxed/simple;
	bh=hioxzY+gEVd1ChDcz9lwQg5PKNGBcQMuxrI2BTfYFkc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J7qtncLuGBh+snK7651BQQkqIyV05aRzshsxo/uSjWs0B1JI9GROkhWUhvumYb62/aCKgXM2lsWAdIYETn70PDxM0ktO9D0JgYag6H7Ieoc8qwCV8xsRzv3n127W5qc6lzbKEn/m5Rd7M26HHAcaBo9cfJ71vpf6Hd6aBuZtYTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=r18DtKyP; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772561082; x=1804097082;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hioxzY+gEVd1ChDcz9lwQg5PKNGBcQMuxrI2BTfYFkc=;
  b=r18DtKyPJTy95SojHdqmeqN4DdysnnbbOvHRgJIw8OZ/VvT/0AWYDFHz
   kfxjxjiXlkl9CUl4ToANPCOZQL+SavPXJzD+kl2+8FQ3tBAJmlakwcUdX
   WUPF7so73hO6MlhlISUeVj1uRUo6tvF9x4qiHY1WueMcu9p07hmMTp+Cz
   8qW+J2w6WBBZopAWIUJ9Nztr4KBi2Ez7BRDiipkGRjabz9E2P1FEyKSkU
   7D+3VnnZQkCo5//DrB+GfLtYTIqHG7ajZChlz3W6tDHvBTdsI85vO2LW7
   FNgg7xpAdtkiOhcRFFO8Y0z5UIiMqxuSLjXDiJu09Sa39oR7TRZMCCLnS
   w==;
X-CSE-ConnectionGUID: R0Y1SJ/2TCKiAbvM64J+LA==
X-CSE-MsgGUID: p5mK4CBCSIyLdVY9U0Ug5Q==
X-IronPort-AV: E=Sophos;i="6.21,322,1763449200"; 
   d="scan'208";a="53419559"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Mar 2026 11:04:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 3 Mar 2026 11:04:09 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 3 Mar 2026 11:04:08 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 0/4] Initial support for p64h GEM
Date: Tue, 3 Mar 2026 10:03:14 -0800
Message-ID: <20260303180318.1814791-1-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 20B161F4FDA
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
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263347-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:dkim,microchip.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello,

This series add basic support for Microchip "PIC64-HPSC" and "PIC64HX"
(abbreviated "p64h") Ethernet endpoint. Both MPUs contain 4 GEM IP with
support for MII/RGMII/SGMII/USXGMII at rates of 10M to 10G. Only RGMII and
SGMII at a rate of 1G is tested for now. Each GEM IP has 8 priority queues
and the revision register reads 0x220c010e.

One particularity of this instantiation of GEM is that the MDIO controller
within the GEM IP is disconnected from any physical pin and p64h rely on
another standalone MDIO controller. For that reason, I've added a dt
binding rule to forbid phys from being added under the gem DT node. See
patch 2.

The maximum jumbo frame size also seems to be different on p64h (16383)
than what most other platforms use (10240). I've found that I need to
tweak a bit the MTU calculation for this, otherwise the RXBS field of the
DMACFG register overflows. See patch 3 for more details.

p64h also supports other features guarded behind CAPS bit like
MACB_CAPS_QBV but I've omitted those intentionally because I didn't test
these.

Thanks,
Charles

Charles Perry (4):
  dt-bindings: net: cdns,macb: add a compatible for Microchip p64h
  dt-bindings: net: cdns,macb: forbid phy nodes for Microchip p64h
  net: macb: add safeguards for jumbo frame larger than 10240
  net: macb: add support for Microchip p64h ethernet endpoint

 .../devicetree/bindings/net/cdns,macb.yaml       | 12 ++++++++++++
 drivers/net/ethernet/cadence/macb_main.c         | 16 ++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

-- 
2.47.3


