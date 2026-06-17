Return-Path: <netdev+bounces-300034-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QzcNJYgxMmrxwQUAu9opvQ
	(envelope-from <netdev+bounces-300034-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 07:32:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C09696985
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 07:32:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=mchp header.b=ob4uccyB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300034-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300034-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7ECB9305BB6D
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 05:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2D630C360;
	Wed, 17 Jun 2026 05:32:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6777A1494A8;
	Wed, 17 Jun 2026 05:32:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781674373; cv=none; b=tLAhfBgcozA130xTVJXaNm6Pz+iSjShuOSscHzot9u4ot0RmCWB/X4jiHzzrmaSCOLWqP2Y2egl2LRGE08jmFnPk91ZA6XcfNy7OSNpULx0rZPYKI7wy6wRQulh2awVEnR2W4uxugYKK4a3D4D7n9RC4t8BA7lV/0669vNyea+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781674373; c=relaxed/simple;
	bh=nElNBNKAznnqaiVAP2gfcv9Ta7QLAyZqYembum2OjwY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nyRCa9g5ltk0U44SEIH/fKuEUYv5/GkfHG3MoCriYAPYaE00WFWPgpmTCeaohqYzEDSduF38JyIv23Ye4yA15aeeRassOE0jUa/xQCN3qq5Vw0wHtys0CdwXzdUI8Uqhj9qv9jTJA90mLbCBrQs8bMqsZEFeK5pNO08aq3YhVPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ob4uccyB; arc=none smtp.client-ip=68.232.153.233
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1781674372; x=1813210372;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nElNBNKAznnqaiVAP2gfcv9Ta7QLAyZqYembum2OjwY=;
  b=ob4uccyBdAW3HrWiqxqDWfMulDH804m1vtd10mPN3kbVse4M0w5aY1LJ
   4L41ebqqMjdYb7NTbcO2JeK3G8s9ymtF0JJOez6laf+PKmpx8lnPS8YNN
   X38JPe7d7sC3h+EoAdeS6xjBD8lpdFJJuBDLTfX5l2mJEmqvgzXH7sijF
   AzZzbC7sX9cRuNmhE/0AAqrxD03HoY/PFeaxObbZ+VQ4jqU+aIGnIeoQU
   cv35nkirECC2Xrx1NbJMm8NzVioTaLhBf9rJwdVLNM/K/keZFjjyGdsQ3
   Z0DQtLm+QSYjIxub7dGe5nmptMA5WQQc/3LR7fZnAlnnQDI67PCKX5XIC
   A==;
X-CSE-ConnectionGUID: ZaVTlC97TeWTd3HxEn153w==
X-CSE-MsgGUID: jtRd+cioQzG6JYwFcjsyEw==
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="68341228"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 22:32:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Tue, 16 Jun 2026 22:32:51 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 16 Jun 2026 22:32:47 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v4 0/2] net: lan743x: add RMII support for PCI11x1x
Date: Wed, 17 Jun 2026 11:02:39 +0530
Message-ID: <20260617053241.157932-1-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300034-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bryan.whitehead@microchip.com,m:UNGLinuxDriver@microchip.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[thangaraj.s@microchip.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[thangaraj.s@microchip.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D6C09696985

This series adds RMII interface support for the Microchip PCI11x1x
Ethernet controller.

The PCI11x1x device supports RMII as an alternative MAC-PHY interface,
selected via the STRAP_READ software strap register. Patch 1 reads the
RMII strap bits from this register and sets the is_rmii_en flag. Patch 2
uses this flag to configure the PHY interface mode, phylink supported
interfaces, and enables RMII in hardware via the RMII_CTL register.

Change Log:
===========
v3 -> v4:
  - Fix dev_dbg() in lan743x_mdiobus_init() to print "RMII operation"
    instead of "RGMII operation" when RMII is selected [Simon Horman]

v2 -> v3:
  - Update debug log to report selected interface (SGMII/RMII/RGMII)
    instead of only SGMII enable/disable state [patch 1/2]
  - Update commit message to document that EEE is disabled by setting
    lpi_capabilities = 0 [patch 2/2]

v1 -> v2:
  - Remove redundant mac_capabilities &= ~MAC_1000FD; phylink already
    handles capability reduction for RMII via phy_caps_from_interface()
    [patch 2/2]

Thangaraj Samynathan (2):
  net: lan743x: add RMII strap status detection for PCI11x1x
  net: lan743x: add support for RMII interface

 drivers/net/ethernet/microchip/lan743x_main.c | 34 ++++++++++++++++---
 drivers/net/ethernet/microchip/lan743x_main.h |  6 ++++
 2 files changed, 36 insertions(+), 4 deletions(-)

-- 
2.34.1


