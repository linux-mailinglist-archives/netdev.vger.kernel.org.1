Return-Path: <netdev+bounces-267477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABUDM6kjtGl7hwAAu9opvQ
	(envelope-from <netdev+bounces-267477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:48:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B53F5285484
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 60ED830798B2
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC8C3A257B;
	Fri, 13 Mar 2026 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZbD8w8FK"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303403A2540;
	Fri, 13 Mar 2026 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773411755; cv=none; b=QB9Tl0M0gswhaxc+c/f25aStLoPJAfn9UPaNqkbz04rOgN9zyu+n9VpOUjvu3ZMkWTJLirKDg4Fzui+9ov757lSlMPV46yupuG81kF0bQBUHzMqk/wJ585el4kf+jyib0WQvD9Q/gtcsEk8g0c2cx2font9/D5jxdnbk/KgJXZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773411755; c=relaxed/simple;
	bh=OB1Ok78U0dWAFfF6QxBgw14OggYt8mEn6wXCPjrUltI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pjp/Jsqv8NbXDKKE1OXT0mm6z2BktRu/NYYAcZemLNwAp9zetZJXyeS2YrZxq3idGnMJyVrRKA8u+VYEeJ6YeLvp/mJ865RKqIg9GZeE9FLNvGYfq+MOZ8qlSh9TQ7NLkgjDtKcdRlax1UKZVYKKHtvBtAQxSjaQuC0pCuIqPfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZbD8w8FK; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1773411754; x=1804947754;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OB1Ok78U0dWAFfF6QxBgw14OggYt8mEn6wXCPjrUltI=;
  b=ZbD8w8FKigm/Incbuosloye0d6RXZQfqB0BHwG+Wx1mz6i8XvtaQjYvv
   xxNXIrTP+ZVHoNel7ZQazjllgDdlPvsusxuZfDCP+2zWpQX7dsInittPj
   7uO7bMPshbGxBb6VcnUDWHaAWjF4FIlnOB6jgm7D6o8+D7VwNoniblbSB
   Xrizfk3MyAwT97O+Z5gelhOqzfF+/G0HHv4NqLsvgWvLeyh4sLkUwelbn
   dEROgN7fLtljTu7sD1Xc44GtU7ThNJaLhKVaU+Cfa+7y6k+rq2keMEGms
   Hd3S4QmsCXu/ruedx94NdMAk7nwpavrZydDboe4GVeENj5n75QGHETBMj
   Q==;
X-CSE-ConnectionGUID: bWE3SVHzTOq0rvndQjznBw==
X-CSE-MsgGUID: +JycT2L2SfiC9F2fA4aqeg==
X-IronPort-AV: E=Sophos;i="6.23,118,1770620400"; 
   d="scan'208";a="62213712"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 07:22:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Fri, 13 Mar 2026 07:22:10 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 13 Mar 2026 07:22:09 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, Conor Dooley
	<conor.dooley@microchip.com>, "Russell King (Oracle)"
	<rmk+kernel@armlinux.org.uk>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2] net: macb: set default_an_inband to true for SGMII
Date: Fri, 13 Mar 2026 07:21:39 -0700
Message-ID: <20260313142140.4040647-1-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267477-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,kernel];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: B53F5285484
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Most platforms using GEM in SGMII mode use in-band autonegotiation
because it is on by default in GEM's 1G PCS and is always on since
commit e276e5e40e92 ("net: macb: Disable PCS auto-negotiation for SGMII
fixed-link mode"). Leave it on if possible using the "default_an_inband"
flag of "struct phylink_config" so that platforms that lack in-band
autonegotiation configurability at the PHY do not break with commit
1338cfef1ff1 ("net: macb: fix SGMII with inband aneg disabled") which
will turn off in-band autoneg for non hot pluggable PHYs.

Once the majority of the PHY drivers that support SGMII have the
->config_inband() callback, this commit could be reverted so that non
hot pluggable PHY use outband negotiation with macb, like its the case
for other MACs.

Fixes: 1338cfef1ff1 ("net: macb: fix SGMII with inband aneg disabled")
Reported-by: Conor Dooley <conor.dooley@microchip.com>
Closes: https://lore.kernel.org/r/20260304-nebulizer-rounding-40fbc81a2ba1@spud
Signed-off-by: Charles Perry <charles.perry@microchip.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---

Notes:
    Changes in v2:
      - Add a missing Reported-by: and fix the Tested-by: tag (Conor)

 drivers/net/ethernet/cadence/macb_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 963a5d4e1a88..d1fc6a9b9fe5 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -838,6 +838,12 @@ static int macb_mii_probe(struct net_device *dev)
 	if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
 		bp->phylink_config.poll_fixed_state = true;
 		bp->phylink_config.get_fixed_state = macb_get_pcs_fixed_state;
+		/* The PCSAUTONEG bit in PCSCNTRL is on out of reset. Setting
+		 * default_an_inband to true tells phylink to turn it off only
+		 * if necessary (e.g. a fixed link or a PHY that doesn't support
+		 * inband).
+		 */
+		bp->phylink_config.default_an_inband = true;
 	}
 
 	bp->phylink_config.mac_capabilities = MAC_ASYM_PAUSE |
-- 
2.47.3


