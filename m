Return-Path: <netdev+bounces-182674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B04A899C1
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7E71670F8
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 10:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5CA28BABB;
	Tue, 15 Apr 2025 10:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="MWA3LcGB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="KK4EGTVu"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F273028E607;
	Tue, 15 Apr 2025 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744712358; cv=none; b=rlyU4GH/gnilUnz2AmCTlpPDDnJz4z5a5qF3M8Z024Udjo/5XQc0S40d1McQqAMYvJBs19CeyVNt7BejIHO5xpBeLDudxyyu/rsnMoIm4LgmIRgGs4e870CAxPPza78S1Fm05Cj0FAZn3UVgcvDehKofLayCm2iWtanMHHh4QJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744712358; c=relaxed/simple;
	bh=caRbKJERsJ8Yix2obZ63dxXCwKNp6CXhZffFOet+5gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NBD1XbfbFwR5eKEy719DILL9Y4b2WvNNdTR8HPNunvRKAsprjK+AqQCFulOGKm5YCmToPF6/MKuJhDdR8h27q7dQ0z+nuQXaEE47DUKzztalaKb9cb2ZgvNqGSl4vT3SAfZyeBCwMvreEKdn1Tvp4/ZREa3JvwN3SECM1WPDJPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=MWA3LcGB; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=KK4EGTVu reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1744712354; x=1776248354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=38wKAyJpUZ+v15BtZQhYo+REQajwTbN5pJiNx7WIgok=;
  b=MWA3LcGByujvZobC9XzNPycdlGymC1onzLA+eb5nQvNXd+QvQ5SsZ8j0
   gqPDeAIfG9NGXHTsZiLJIE8A8MUxFbJkj3EEAyo1v2I0CNoOIias26/Ks
   glDnylxQUxgfDCkDnZhCEHfmsvKXjJNRkVbD636a3Y9hlMi1i3tCwXxFZ
   IYPj2GVyW9RKaf4A+voAbig/WHCbf5WKWr/bEnB7FdZ1BqFRR42m9wsLU
   CwuTZbHIFJvOvu/FAZQDQYqHnihGH/G2+I3k9xBW9CwIuDUDk60t9y2dR
   gn5mMChDuXQ/xUHgtMEFFZdS9uqlAbONXuyc9c4oPvSxxGh7Wr2nSIwuf
   Q==;
X-CSE-ConnectionGUID: chtD1w7vRP6Ofi0sMP3uTA==
X-CSE-MsgGUID: LQIoltfBSHO2OCu1S8ThUw==
X-IronPort-AV: E=Sophos;i="6.15,213,1739833200"; 
   d="scan'208";a="43537787"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 15 Apr 2025 12:19:11 +0200
X-CheckPoint: {67FE32A0-0-903EAEAC-E04C76C8}
X-MAIL-CPID: 8CC79B74E1AFEF81D94ED3F9DF1A712D_5
X-Control-Analysis: str=0001.0A006399.67FE32A2.0015,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C055F164816;
	Tue, 15 Apr 2025 12:19:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1744712347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=38wKAyJpUZ+v15BtZQhYo+REQajwTbN5pJiNx7WIgok=;
	b=KK4EGTVu4CbxJVmujnwSirrfhq0EqShvSvfGWnE8LgSityWXXC5qLDANzGW0Eh7eJoZX3K
	Y+Otmv/TEVe/L6AsWh9ezRZAu9tr4rlqnCmBEcA2M9JJsfEsVLl8chv375o/WOhgrFCjFW
	39v2mwrodLOGB9+m0BN1zkWWHH6QUVOFkjKOCntAYQ6pMPpALEKIJkVITLw0KQspDB9EyI
	qCEKpd4vg/wlcIgg1gzByjLL8EES7FzHtp8LL6Gkdpa7gKZPqTFbqQ6Bf4ApS3P9QEgUQn
	idATjL60jpohE9Vxtz21552FBsfGMXiDgitQT54YkZIk8GS0sQY1EAXsDsJwnQ==
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
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH net-next 3/4] net: ethernet: ti: am65-cpsw: fixup PHY mode for fixed RGMII TX delay
Date: Tue, 15 Apr 2025 12:18:03 +0200
Message-ID: <32e0dffa7ea139e7912607a08e391809d7383677.1744710099.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
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
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 27 ++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index c9fd34787c998..a1d32735c7512 100644
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
 		port->slave.port_np = port_np;
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


