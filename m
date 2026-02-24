Return-Path: <netdev+bounces-260640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJm3H0AKnmnkTAQAu9opvQ
	(envelope-from <netdev+bounces-260640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 21:29:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCEF18C605
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 21:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 135C0301A918
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 20:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7362339B34;
	Tue, 24 Feb 2026 20:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QR7otJPY"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6874F34CDD;
	Tue, 24 Feb 2026 20:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771964988; cv=none; b=X3168mHYfqrZDmDSTes/PNEK9Hncobpng5AziQ/1Kj90cMRthbqy+pNTcMfVvzVQOeXihoapbllUIllXm9m/WCzILnWZd/LS5CHxAywtnQNBMLVmxvvi4T9c15mtYgTmh8ZkBpEqSubmWSyGqvbOZ5K+tOelNrI8DrHXCWnU6O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771964988; c=relaxed/simple;
	bh=GHZITxpGBIrzSl4sqFN8OOjlssn88njYBa4Fzhrh0Lg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bQbfAg4JMsbYcDIvZuP9otTlFa2QRrfnAvIqW2KkdAeqkxRKApdVe4bW8LAhsxacac89cWn26z51YJBQ6lFZ4j8K6dZwTWQIHkA1fNv6/xdTybcU0FWkl2QQF45osTDXiTMQ7WDkz8BQV+hA8QbsT2qFnldqyLlKDHoxj3tdsYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QR7otJPY; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1771964985; x=1803500985;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GHZITxpGBIrzSl4sqFN8OOjlssn88njYBa4Fzhrh0Lg=;
  b=QR7otJPY5R25GYlCiNJ4igNDDfr+up1N349kApTxDfdiDJ0lhuEudJYf
   QwaUjPFdag0ER4YWtxPtd6X2gGOOl4JEALgYqgnp358+cR/qHbAa+WQU9
   WnSHwbLUMf1r9x6SIcr+3ZZRNvtuLLO9d5f77Jixi54KJ8Sxp07mI7gTr
   64JmQjrnYNuEuiI1pYxn7E5sw+/yzCyTuCdCFkEyuCv4Yx59TK6SHo38V
   qJzP4p23FFhAHeabDxLbgiGqABccIwiIUqc5/LxIG6/qY/n2FfKzli24z
   rYjUibBU1JpxcEjW1MZnbpLQtor+ac9IabS2QGyPWH9BzD4ihT+MHzwg0
   Q==;
X-CSE-ConnectionGUID: CU6nEk3VSSKbTSpVLGI17Q==
X-CSE-MsgGUID: x7Q49HxWQ6Ss7PmxthoxTA==
X-IronPort-AV: E=Sophos;i="6.21,309,1763449200"; 
   d="scan'208";a="54233069"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 13:29:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 24 Feb 2026 13:29:18 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 24 Feb 2026 13:29:17 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, Sean Anderson
	<sean.anderson@linux.dev>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2 0/3] Support PHYs that have inband autoneg disabled with GEM
Date: Tue, 24 Feb 2026 12:28:51 -0800
Message-ID: <20260224202854.112813-1-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260640-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:mid,microchip.com:url,microchip.com:dkim]
X-Rspamd-Queue-Id: 8FCEF18C605
X-Rspamd-Action: no action

Changes in v2:
  * Add a cover-letter
  * Remove the spinlock in macb_pcs_config() (patch 1)
  * Add the macb_pcs_inband_caps() ops (patch 3)

I'm testing SGMII with a VSC8574 PHY [1] and microchip HPSC SoC [2].

The link can work with or without autoneg, as long as the MAC and the PHY
are configured the same way. This doesn't work with the current MAC driver
because the MAC inband autoneg is always enabled (in the ->mac_config()
phylink_mac_ops). More precisely, the PHY driver (mscc_main.c) has
phylink's ->config_inband() implemented while the MAC ->pcs_config() ops
has an empty body.

This is based on code written by Sean Anderson [3]. Let me know if I
should add a From: or Co-developed-by: tag.

Logs with inband autoneg (managed = "in-band-status"):

````````````````````````````````````````````````````````
root@p64h:~# ifconfig eth1 up 10.180.59.33
macb 40004184000.ethernet eth1: PHY 4000c21e000.mdio-mdio:02 doesn't supply possible interfaces
macb 40004184000.ethernet eth1: PHY [4000c21e000.mdio-mdio:02] driver [Microsemi GE VSC8574 SyncE] (irq=POLL)
macb 40004184000.ethernet eth1: phy: sgmii setting supported 00000000,00000000,00000000,000042ff advertising 00000000,00000000,00000000,000042ff
macb 40004184000.ethernet eth1: configuring for inband/sgmii link mode
macb 40004184000.ethernet eth1: major config, requested inband/sgmii
macb 40004184000.ethernet eth1: interface sgmii inband modes: pcs=03 phy=03
macb 40004184000.ethernet eth1: major config, active inband/inband,an-enabled/sgmii
macb 40004184000.ethernet eth1: phylink_mac_config: mode=inband/sgmii/none adv=00000000,00000000,00000000,000042ff pause=00
macb_pcs_config: PCSANADV=0x1 PCSCNTRL=0x1040
macb_pcs_get_state: PCSSTS=0x109 PCSANLPBASE=0x1
macb_pcs_get_state: PCSSTS=0x12d PCSANLPBASE=0x1801
macb 40004184000.ethernet eth1: phy link down sgmii/Unknown/Unknown/none/off/nolpi
macb_pcs_get_state: PCSSTS=0x12d PCSANLPBASE=0x1801
macb_pcs_get_state: PCSSTS=0x12d PCSANLPBASE=0x1801
macb 40004184000.ethernet eth1: phy link up sgmii/1Gbps/Full/none/tx/nolpi
macb_pcs_get_state: PCSSTS=0x129 PCSANLPBASE=0x9801
macb_pcs_get_state: PCSSTS=0x12d PCSANLPBASE=0x9801
macb 40004184000.ethernet eth1: Link is Up - 1Gbps/Full - flow control tx
````````````````````````````````````````````````````````

Logs without inband autoneg:

````````````````````````````````````````````````````````
root@p64h:~# ifconfig eth1 up 10.180.59.33
macb 40004184000.ethernet eth1: PHY 4000c21e000.mdio-mdio:02 doesn't supply possible interfaces
macb 40004184000.ethernet eth1: PHY [4000c21e000.mdio-mdio:02] driver [Microsemi GE VSC8574 SyncE] (irq=POLL)
macb 40004184000.ethernet eth1: phy: sgmii setting supported 00000000,00000000,00000000,000042ff advertising 00000000,00000000,00000000,000042ff
macb 40004184000.ethernet eth1: configuring for phy/sgmii link mode
macb 40004184000.ethernet eth1: major config, requested phy/sgmii
macb 40004184000.ethernet eth1: interface sgmii inband modes: pcs=03 phy=03
macb 40004184000.ethernet eth1: major config, active phy/outband/sgmii
macb 40004184000.ethernet eth1: phylink_mac_config: mode=phy/sgmii/none adv=00000000,00000000,00000000,00000000 pause=00
macb_pcs_config: PCSANADV=0x1 PCSCNTRL=0x40
macb 40004184000.ethernet eth1: phy link down sgmii/Unknown/Unknown/none/off/nolpi
macb 40004184000.ethernet eth1: phy link up sgmii/1Gbps/Full/none/tx/nolpi
macb 40004184000.ethernet eth1: Link is Up - 1Gbps/Full - flow control tx
````````````````````````````````````````````````````````

The above logs are generated with an additional printk() in macb_psc_config()
and macb_pcs_get_state() and "#define DEBUG" in phylink.c.

[1]: https://www.microchip.com/en-us/product/vsc8574
[2]: https://www.microchip.com/en-us/products/microprocessors/64-bit-mpus/pic64-hpsc
[3]: https://lore.kernel.org/all/20250610233547.3588356-1-sean.anderson@linux.dev/

Charles Perry (3):
  net: macb: fix SGMII with inband aneg disabled
  net: macb: add support for reporting SGMII inband link status
  net: macb: add the .pcs_inband_caps() callback for SGMII

 drivers/net/ethernet/cadence/macb_main.c | 50 ++++++++++++++++--------
 1 file changed, 33 insertions(+), 17 deletions(-)

-- 
2.47.3


