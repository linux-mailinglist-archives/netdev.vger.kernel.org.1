Return-Path: <netdev+bounces-200589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD37AE6307
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 12:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AAF84A1C46
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 10:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D982528D859;
	Tue, 24 Jun 2025 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="PrtZEFV+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="jJg2hfgg"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8931728A708;
	Tue, 24 Jun 2025 10:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762476; cv=none; b=cuQHswggrCb80kmeGxVJR1QONdz7e7MkXAeHtC9J0jcbNhJMxK2vz0ZAGpMXOIfeQJQihV2lg/8oMpMbvtNl/K4NR3KbWp5MgXzW3PX2waLRHtqwn1n9i+nEl1u2QaBiWTNoMnAyXCzer+HZ027ZicL4xp1Hl3YoOz23Kj/eqhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762476; c=relaxed/simple;
	bh=UJ2YehioMZ1SsT+I66XgoDe5jyA+65tq4LB9sCof5GA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tySvFCJTvJEByAKZNFVsY6s2IyEpNWlJxuYzv8TXdvvDX8+REMTzFGv1jFKJ6GyxQCdfcXyGM4pkFNaeS9YpaJJdKlncua/vKMJNs/oK4gt06/4Ybyftp/mEtKos2mjABJWr96KyDYwmHwgnW2wvg76o+91psvGPTBABVHKiMpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=PrtZEFV+; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=jJg2hfgg reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1750762474; x=1782298474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZDrXoWnndqa2vP7h7oVAnPKn8tyXmeoTROzM7osLRaQ=;
  b=PrtZEFV+w3QaydbQPt3mg+LEU7QdV7VUUj5Svk+/EMiXWPjxSXTlzOyd
   GqjH4SxWi1kFDlsz35CUEgixJ41Rypo0PFeNYYAGHrNgK/BY5J+2WkRkz
   gseqF60a7gOIxEfTFAvmSkkcLHQbB1EeJyt53hyp88HkA9wyXg0Zq+u0+
   /+zVoNczMVcVMO1V5DRnRfJntKV0ElrDggR2LktIyo+39ykGKWJhTK7VH
   AjVuwH4p2Eq383m0TDwVb3ZRRXzN6Yk2q4zKUDt5B4S6s5zk02npcERJh
   Nwj84AwluwI5FTghpkljVicta1+EirzdcrbzycN9H3yBd4fDuQs057FtV
   w==;
X-CSE-ConnectionGUID: Y/2Wc9ADSIyEQrYh8V8o/Q==
X-CSE-MsgGUID: 1k+kQCi2QAmp/xf/Q3TUQg==
X-IronPort-AV: E=Sophos;i="6.16,261,1744063200"; 
   d="scan'208";a="44816894"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Jun 2025 12:54:32 +0200
X-CheckPoint: {685A83E8-18-ABFC28F4-D6731B76}
X-MAIL-CPID: 88C29F62DA19E3BAB304661456A96FB2_5
X-Control-Analysis: str=0001.0A006377.685A83F4.000A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A3FCB165D2D;
	Tue, 24 Jun 2025 12:54:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1750762468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZDrXoWnndqa2vP7h7oVAnPKn8tyXmeoTROzM7osLRaQ=;
	b=jJg2hfggHCq7Sw+mIkyHvnYh4/i0uwxuatemB8F1wswlM1Oms4HrGNv59UmxlguwbOys6u
	F5pg3LDXahas4XtUOGPQjjROiQRsQ9kH5rxLLR6aep6MljqRHeLUYPnjs01qMhjSNwCPEf
	VWk7idJ3uHXt+6VEc5qFqwE+B0/LP344Z2TDpXPjwfMd8iZWOXx/f5o8gC/qnIIbmlG9Gk
	qe1l2uszG1BQVMIRU87uywZo859O3blj096aVCi/ex/BPz3OQ2Tp7GE6LG34hLYcAGyB5Y
	HrGUdsLpcdIQbtXFthtk4Lolwn3m8jivYmb2OR0Tfz6LBMwfwd3SyKfq0db7xg==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Whitcroft <apw@canonical.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tero Kristo <kristo@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v2 2/3] net: ethernet: ti: am65-cpsw: fixup PHY mode for fixed RGMII TX delay
Date: Tue, 24 Jun 2025 12:53:33 +0200
Message-ID: <9b3fb1fbf719bef30702192155c6413cd5de5dcf.1750756583.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750756583.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1750756583.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

All am65-cpsw controllers have a fixed TX delay, so the PHY interface
mode must be fixed up to account for this.

Modes that claim to a delay on the PCB can't actually work. Warn people
to update their Device Trees if one of the unsupported modes is specified.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 27 ++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index f20d1ff192efe..519757e618ad0 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2602,6 +2602,7 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
 		return -ENOENT;
 
 	for_each_child_of_node(node, port_np) {
+		phy_interface_t phy_if;
 		struct am65_cpsw_port *port;
 		u32 port_id;
 
@@ -2667,14 +2668,36 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
 
 		/* get phy/link info */
 		port->slave.port_np = of_node_get(port_np);
-		ret = of_get_phy_mode(port_np, &port->slave.phy_if);
+		ret = of_get_phy_mode(port_np, &phy_if);
 		if (ret) {
 			dev_err(dev, "%pOF read phy-mode err %d\n",
 				port_np, ret);
 			goto of_node_put;
 		}
 
-		ret = phy_set_mode_ext(port->slave.ifphy, PHY_MODE_ETHERNET, port->slave.phy_if);
+		/* CPSW controllers supported by this driver have a fixed
+		 * internal TX delay in RGMII mode. Fix up PHY mode to account
+		 * for this and warn about Device Trees that claim to have a TX
+		 * delay on the PCB.
+		 */
+		switch (phy_if) {
+		case PHY_INTERFACE_MODE_RGMII_ID:
+			phy_if = PHY_INTERFACE_MODE_RGMII_RXID;
+			break;
+		case PHY_INTERFACE_MODE_RGMII_TXID:
+			phy_if = PHY_INTERFACE_MODE_RGMII;
+			break;
+		case PHY_INTERFACE_MODE_RGMII:
+		case PHY_INTERFACE_MODE_RGMII_RXID:
+			dev_warn(dev,
+				 "RGMII mode without internal TX delay unsupported; please fix your Device Tree\n");
+			break;
+		default:
+			break;
+		}
+
+		port->slave.phy_if = phy_if;
+		ret = phy_set_mode_ext(port->slave.ifphy, PHY_MODE_ETHERNET, phy_if);
 		if (ret)
 			goto of_node_put;
 
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


