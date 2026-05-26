Return-Path: <netdev+bounces-291646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDPvCBh3FWrHVAcAu9opvQ
	(envelope-from <netdev+bounces-291646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:34:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 858DA5D4398
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA62E30038E8
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9074E3DD52E;
	Tue, 26 May 2026 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyKKdCFN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1F93DD510;
	Tue, 26 May 2026 10:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779791266; cv=none; b=H30C96DlGwVVrhXz+XlXANXrkv4zLq4yqErdzrrTNthy/mhTXsgfGSMaoY4ynkN09m5dBFuOGL6DRHGPrpi1LXu1KsZxBV356kiCwjWk9CR2+FQM+g2yvaawgNDCatAoRPv+ZT5ZU8MlAFdZYfsMivsE2r38yoX7nR2exnXXmgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779791266; c=relaxed/simple;
	bh=ZWnnCn/HKKEnSWR1mTix60hzeHLo3tkrKV6oYyB2nLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tu/7LdmkpQngDnLuH1o15PWicvSE0kHL6/Eeq8P934KpIlDK5Tn+YEngvUl39qCNLYHMr898MI0HePqk00k17CjE6OTdjYhXa1uvdJDHI7k5YWV9/ibFqMGRlaSaRRFsSu4Nqk9xZN0sVWrGD2diH2SOQIVuPsmAYXJLleTPf/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyKKdCFN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9501F00A3A;
	Tue, 26 May 2026 10:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779791265;
	bh=1BZk2y1KGNMX+ccHuEp6KWVVbr1Nr9TPnS/MltAXFTI=;
	h=From:To:Cc:Subject:Date;
	b=SyKKdCFN9GuMHt9XiHa/sVOfiYznVkXy51REaRbImzrnSeusFP4ZZH97TCZI3bhYy
	 NwMHKfeb0ufokz91E2VRVvKNojYtjNC8ITkf/cnzS4JRbSxd7wOHXOJpcNn0EvAjj1
	 e21iIdzG7x7CI9kmYC7lZbegajNZQ51RTPQRduko3ZU4/TykQb7lgfvSgvD7e6y7FS
	 XjFBFL+ZPlW6Ohwrg3X9cTyFUK68gsu9FpyfK9LRg5JNHn7AjcpdRnLpAfKk5cBfIR
	 pteTvV+A7+zqTXBjlwvNwaLfmH5daveHG2uIYkaa0ZB+U+ATPGHKpHSIppjn/dwzYs
	 qmBmaC1iWrt0Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Wei Fang <wei.fang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] [net-next] net: dsa: netc: fix enetc dependencies
Date: Tue, 26 May 2026 12:26:37 +0200
Message-Id: <20260526102708.2837129-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arndb.de,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,lists.linux.dev,vger.kernel.org,lists.ozlabs.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291646-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arndb.de:email]
X-Rspamd-Queue-Id: 858DA5D4398
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Arnd Bergmann <arnd@arndb.de>

The newly added netc dsa support has incorrect Kconfig dependencies,
leading to Kconfig and link failures:

WARNING: unmet direct dependencies detected for FSL_ENETC_MDIO
  Depends on [n]: NETDEVICES [=y] && ETHERNET [=n] && NET_VENDOR_FREESCALE [=n] && PCI [=y] && PHYLIB [=y]
  Selected by [y]:
  - NET_DSA_NETC_SWITCH [=y] && NETDEVICES [=y] && (ARM64 || COMPILE_TEST [=y]) && NET_DSA [=y] && PCI [=y]
WARNING: unmet direct dependencies detected for NXP_NTMP
  Depends on [n]: NETDEVICES [=y] && ETHERNET [=n] && NET_VENDOR_FREESCALE [=n]
  Selected by [m]:
  - NET_DSA_NETC_SWITCH [=m] && NETDEVICES [=y] && (ARM64 || COMPILE_TEST [=y]) && NET_DSA [=m] && PCI [=y]
ERROR: modpost: "enetc_mdio_read_c22" [drivers/net/dsa/netc/nxp-netc-switch.ko] undefined!
ERROR: modpost: "ntmp_fdbt_delete_entry" [drivers/net/dsa/netc/nxp-netc-switch.ko] undefined!
ERROR: modpost: "enetc_mdio_read_c45" [drivers/net/dsa/netc/nxp-netc-switch.ko] undefined!

Add the required 'NET_VENDOR_FREESCALE' dependency to make it possible
to select both the PHY and NTMP library modules. Originally this was
meant to be done through an 'IS_REACHABLE' check in the header file,
but that did not work because the drivers/net/ethernet/freescale
directory is not even entered in this case. IS_REACHABLE() is generally
counterproductive because even when it works as intended, it turns
a helpful link-time error into a silent runtime failure that is
harder to debug. In this case, it clearly did not even do anything.

Fixes: 187fbae024c8 ("net: dsa: netc: introduce NXP NETC switch driver for i.MX94")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/dsa/netc/Kconfig   |  1 +
 include/linux/fsl/enetc_mdio.h | 22 ----------------------
 2 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/net/dsa/netc/Kconfig b/drivers/net/dsa/netc/Kconfig
index d2f78d74ac23..eaad3cb5babe 100644
--- a/drivers/net/dsa/netc/Kconfig
+++ b/drivers/net/dsa/netc/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config NET_DSA_NETC_SWITCH
 	tristate "NXP NETC Ethernet switch support"
+	depends on NET_VENDOR_FREESCALE
 	depends on ARM64 || COMPILE_TEST
 	depends on NET_DSA && PCI
 	select NET_DSA_TAG_NETC
diff --git a/include/linux/fsl/enetc_mdio.h b/include/linux/fsl/enetc_mdio.h
index 623ccfcbf39c..7cd5be694cc4 100644
--- a/include/linux/fsl/enetc_mdio.h
+++ b/include/linux/fsl/enetc_mdio.h
@@ -35,8 +35,6 @@ struct enetc_mdio_priv {
 	int mdio_base;
 };
 
-#if IS_REACHABLE(CONFIG_FSL_ENETC_MDIO)
-
 int enetc_mdio_read_c22(struct mii_bus *bus, int phy_id, int regnum);
 int enetc_mdio_write_c22(struct mii_bus *bus, int phy_id, int regnum,
 			 u16 value);
@@ -45,24 +43,4 @@ int enetc_mdio_write_c45(struct mii_bus *bus, int phy_id, int devad, int regnum,
 			 u16 value);
 struct enetc_hw *enetc_hw_alloc(struct device *dev, void __iomem *port_regs);
 
-#else
-
-static inline int enetc_mdio_read_c22(struct mii_bus *bus, int phy_id,
-				      int regnum)
-{ return -EINVAL; }
-static inline int enetc_mdio_write_c22(struct mii_bus *bus, int phy_id,
-				       int regnum, u16 value)
-{ return -EINVAL; }
-static inline int enetc_mdio_read_c45(struct mii_bus *bus, int phy_id,
-				      int devad, int regnum)
-{ return -EINVAL; }
-static inline int enetc_mdio_write_c45(struct mii_bus *bus, int phy_id,
-				       int devad, int regnum, u16 value)
-{ return -EINVAL; }
-static inline struct enetc_hw *enetc_hw_alloc(struct device *dev,
-					      void __iomem *port_regs)
-{ return ERR_PTR(-EINVAL); }
-
-#endif
-
 #endif
-- 
2.39.5


