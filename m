Return-Path: <netdev+bounces-269498-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLoIHGUWvGnbrwIAu9opvQ
	(envelope-from <netdev+bounces-269498-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:29:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DFC2CDBD1
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A33283075ED1
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C013E275E;
	Thu, 19 Mar 2026 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="MwSlKnYW"
X-Original-To: netdev@vger.kernel.org
Received: from mout-b-107.mailbox.org (mout-b-107.mailbox.org [195.10.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456FB3DFC66;
	Thu, 19 Mar 2026 15:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933592; cv=none; b=Pr1l+Msm2ixeqzUrDICkaa41DHnp1Y/PflwNFAvzo0HgoMuQl28me/JBR/uywCNbwpw+hC7gmjzjfEl0ynpr3O3CI0Suq2iITdtjKkgxXMrLDGzn4T5BgJ1CFwJwf3pHr65243kwjtAhTkdB5J9LvrberEYB/BHqeD2TwGfT6/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933592; c=relaxed/simple;
	bh=wuZQ9vTbz8UTXtHV3/zPGSw68fibhsPS+1RYice2eLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bqE4+DktGTKRxqajlJD3+j4pGH/rYiHHuVA5af3l3RTYQ/eEpUqO1QpzqSBQUiUBxI8ADZp34sqovOi2yxsA0REc+a0nwkKu1MEiIVIxN2Fi19CjLcu9ztHU/dBkq1q971mYeLMMnGFyxJ8g3EodjNHrMs3yj2RvqzFQ1p0p+0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=MwSlKnYW; arc=none smtp.client-ip=195.10.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4fc8MT0fdwzDs2m;
	Thu, 19 Mar 2026 16:12:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1773933173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VRiQAbmOZNBrKYT2ZwQeh5CazEoSH0MkUOjWXENOVH4=;
	b=MwSlKnYWblA6TOpAuxURZTRB9f1ESXp+itO/3t5phIySsfR1GDQHK1CzYKVtSCIgExodBn
	RkOqp3nx4I4vr66H0nlSd1WAD3dMcvD83M3H2GRzhBU3VmymFaYd5taQThTWJOqOLoYKUr
	MZuugdo43ER7Q8Bf+U08scfgv8WpXLIeCN3/NRiZJmyqxlEDuX9E/UrvBPW7fU3Ef67htF
	RT9v28l4E1jQrZCKv77qe+ZUHeXRMI67k93+of4w6L3HCkERNi6HIGQYAgb1Ejz7e6ngCB
	QcnycTM1WOEV2TIZ5gFgHqcZcCy9q6hrkFwGUUswkd3uyjsu8IC92C7DPTCPXA==
From: Ralf Lici <ralf@mandelbit.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>,
	Ralf Lici <ralf@mandelbit.com>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next 01/15] drivers/net: add ipxlat netdevice skeleton and build plumbing
Date: Thu, 19 Mar 2026 16:12:10 +0100
Message-ID: <20260319151230.655687-2-ralf@mandelbit.com>
In-Reply-To: <20260319151230.655687-1-ralf@mandelbit.com>
References: <20260319151230.655687-1-ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[mandelbit.com:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269498-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mandelbit.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ralf@mandelbit.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mandelbit.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mandelbit.com:dkim,mandelbit.com:email,mandelbit.com:mid,darkboxed.org:email]
X-Rspamd-Queue-Id: 72DFC2CDBD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ipxlat is a virtual netdevice implementing stateless IPv4/IPv6
translation (SIIT). The translation model follows RFC 7915 behavior and
RFC 6052 address embedding rules.

The netdevice form is intentional: it provides per-instance lifecycle,
MTU/statistics semantics and explicit routing integration, so translated
traffic can be steered through a dedicated device and configured per
namespace.

This series targets ipxlat as a reusable kernel building block for SIIT
deployments and for NAT64-style setups when combined with existing
nftables rules in userspace policy.

This first patch introduces only the driver scaffolding:
- drivers/net/ipxlat/ directory and build integration
- Kconfig/Makefile entries
- basic private structures and defaults
- rtnl_link_ops and netdevice skeleton needed to create/register links

No translation logic is added in this patch yet. Follow-up patches add
packet validation, transport/ICMP translation, error handling,
fragmentation handling, generic netlink control plane, selftests and
documentation.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/Kconfig           |  13 ++++
 drivers/net/Makefile          |   1 +
 drivers/net/ipxlat/Makefile   |   7 ++
 drivers/net/ipxlat/ipxlpriv.h |  53 +++++++++++++
 drivers/net/ipxlat/main.c     | 137 ++++++++++++++++++++++++++++++++++
 drivers/net/ipxlat/main.h     |  27 +++++++
 6 files changed, 238 insertions(+)
 create mode 100644 drivers/net/ipxlat/Makefile
 create mode 100644 drivers/net/ipxlat/ipxlpriv.h
 create mode 100644 drivers/net/ipxlat/main.c
 create mode 100644 drivers/net/ipxlat/main.h

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index b2fd90466bab..a3b28f294d95 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -117,6 +117,19 @@ config OVPN
 	  This module enhances the performance of the OpenVPN userspace software
 	  by offloading the data channel processing to kernelspace.
 
+config IPXLAT
+	tristate "IPv6<>IPv4 packet translation virtual device (SIIT)"
+	depends on NET && INET && IPV6
+	help
+	  Virtual network device driver for Stateless IP/ICMP Packet
+	  Translation (RFC 7915). Useful for IPv6 focused networks.
+	  Particularly NAT64, SIIT-DC, 464XLAT network architectures.
+
+	  See also <file:Documentation/networking/ipxlat.rst>.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ipxlat.
+
 config EQUALIZER
 	tristate "EQL (serial line load balancing) support"
 	help
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 5b01215f6829..4f982c9e6585 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_NET) += loopback.o
 obj-$(CONFIG_NETDEV_LEGACY_INIT) += Space.o
 obj-$(CONFIG_NETCONSOLE) += netconsole.o
 obj-$(CONFIG_NETKIT) += netkit.o
+obj-$(CONFIG_IPXLAT) += ipxlat/
 obj-y += phy/
 obj-y += pse-pd/
 obj-y += mdio/
diff --git a/drivers/net/ipxlat/Makefile b/drivers/net/ipxlat/Makefile
new file mode 100644
index 000000000000..bd48c2700bf5
--- /dev/null
+++ b/drivers/net/ipxlat/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# IPXLAT - Stateless IP/ICMP Translation (SIIT) virtual device driver
+
+obj-$(CONFIG_IPXLAT) := ipxlat.o
+
+ipxlat-objs += main.o
diff --git a/drivers/net/ipxlat/ipxlpriv.h b/drivers/net/ipxlat/ipxlpriv.h
new file mode 100644
index 000000000000..5027d8377bdd
--- /dev/null
+++ b/drivers/net/ipxlat/ipxlpriv.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*  IPXLAT - Stateless IP/ICMP Translation (SIIT) virtual device driver
+ *
+ *  Copyright (C) 2024- Alberto Leiva Popper <ydahhrk@gmail.com>
+ *  Copyright (C) 2026- Mandelbit SRL
+ *  Copyright (C) 2026- Daniel Gröber <dxld@darkboxed.org>
+ *
+ *  Author:	Alberto Leiva Popper <ydahhrk@gmail.com>
+ *		Antonio Quartulli <antonio@mandelbit.com>
+ *		Daniel Gröber <dxld@darkboxed.org>
+ *		Ralf Lici <ralf@mandelbit.com>
+ */
+
+#ifndef _NET_IPXLAT_IPXLPRIV_H_
+#define _NET_IPXLAT_IPXLPRIV_H_
+
+#include <linux/mutex.h>
+#include <linux/netdevice.h>
+#include <net/gro_cells.h>
+
+/**
+ * struct ipv6_prefix - IPv6 prefix definition
+ * @addr: prefix address (host bits may be non-zero)
+ * @len: prefix length in bits
+ */
+struct ipv6_prefix {
+	struct in6_addr addr;
+	u8 len;
+};
+
+/**
+ * struct ipxlat_priv - private state stored in netdev priv area
+ * @dev: owning netdevice
+ * @xlat_prefix6: RFC 6052 prefix used for stateless v4<->v6 mapping
+ * @lowest_ipv6_mtu: LIM threshold used by 4->6 pre-fragment planning
+ * @cfg_lock: serializes control-plane updates
+ * @gro_cells: receive-side reinjection queue used by forward path
+ *
+ * Datapath reads config without taking @cfg_lock to keep per-packet overhead
+ * low. Writers serialize updates under @cfg_lock. During reconfiguration,
+ * readers may transiently observe mixed old/new values; this may cause a small
+ * number of drops and is an accepted tradeoff for a lightweight datapath.
+ */
+struct ipxlat_priv {
+	struct net_device *dev;
+	struct ipv6_prefix xlat_prefix6;
+	u32 lowest_ipv6_mtu;
+	/* serializes control-plane updates */
+	struct mutex cfg_lock;
+	struct gro_cells gro_cells;
+};
+
+#endif /* _NET_IPXLAT_IPXLPRIV_H_ */
diff --git a/drivers/net/ipxlat/main.c b/drivers/net/ipxlat/main.c
new file mode 100644
index 000000000000..26b7f5b6ff20
--- /dev/null
+++ b/drivers/net/ipxlat/main.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  IPXLAT - Stateless IP/ICMP Translation (SIIT) virtual device driver
+ *
+ *  Copyright (C) 2024- Alberto Leiva Popper <ydahhrk@gmail.com>
+ *  Copyright (C) 2026- Mandelbit SRL
+ *  Copyright (C) 2026- Daniel Gröber <dxld@darkboxed.org>
+ *
+ *  Author:	Alberto Leiva Popper <ydahhrk@gmail.com>
+ *		Antonio Quartulli <antonio@mandelbit.com>
+ *		Daniel Gröber <dxld@darkboxed.org>
+ *		Ralf Lici <ralf@mandelbit.com>
+ */
+
+#include <linux/module.h>
+
+#include <net/ip.h>
+
+#include "ipxlpriv.h"
+#include "main.h"
+
+MODULE_AUTHOR("Alberto Leiva Popper <ydahhrk@gmail.com>");
+MODULE_AUTHOR("Antonio Quartulli <antonio@mandelbit.com>");
+MODULE_AUTHOR("Daniel Gröber <dxld@darkboxed.org>");
+MODULE_AUTHOR("Ralf Lici <ralf@mandelbit.com>");
+MODULE_DESCRIPTION("IPv6<>IPv4 translation virtual netdev support (SIIT)");
+MODULE_LICENSE("GPL");
+
+static int ipxlat_dev_init(struct net_device *dev)
+{
+	struct ipxlat_priv *ipxlat = netdev_priv(dev);
+	int err;
+
+	ipxlat->dev = dev;
+	/* default xlat-prefix6 is 64:ff9b::/96 */
+	ipxlat->xlat_prefix6.addr.s6_addr32[0] = htonl(0x0064ff9b);
+	ipxlat->xlat_prefix6.addr.s6_addr32[1] = 0;
+	ipxlat->xlat_prefix6.addr.s6_addr32[2] = 0;
+	ipxlat->xlat_prefix6.addr.s6_addr32[3] = 0;
+	ipxlat->xlat_prefix6.len = 96;
+	ipxlat->lowest_ipv6_mtu = 1280;
+	mutex_init(&ipxlat->cfg_lock);
+
+	err = gro_cells_init(&ipxlat->gro_cells, dev);
+	if (unlikely(err))
+		return err;
+
+	return 0;
+}
+
+static void ipxlat_dev_uninit(struct net_device *dev)
+{
+	struct ipxlat_priv *ipxlat = netdev_priv(dev);
+
+	gro_cells_destroy(&ipxlat->gro_cells);
+}
+
+static int ipxlat_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	dev_dstats_tx_dropped(dev);
+	kfree_skb(skb);
+	return NETDEV_TX_OK;
+}
+
+static const struct net_device_ops ipxlat_netdev_ops = {
+	.ndo_init = ipxlat_dev_init,
+	.ndo_uninit = ipxlat_dev_uninit,
+	.ndo_start_xmit = ipxlat_start_xmit,
+};
+
+static const struct device_type ipxlat_type = {
+	.name = "ipxlat",
+};
+
+static void ipxlat_setup(struct net_device *dev)
+{
+	const netdev_features_t feat = NETIF_F_SG | NETIF_F_FRAGLIST |
+				       NETIF_F_HW_CSUM | NETIF_F_HIGHDMA |
+				       NETIF_F_GSO_SOFTWARE;
+
+	dev->type = ARPHRD_NONE;
+	dev->flags = IFF_NOARP;
+	dev->priv_flags |= IFF_NO_QUEUE;
+	dev->hard_header_len = 0;
+	dev->addr_len = 0;
+
+	dev->lltx = true;
+	dev->features |= feat;
+	dev->hw_features |= feat;
+	dev->hw_enc_features |= feat;
+
+	dev->netdev_ops = &ipxlat_netdev_ops;
+	dev->needs_free_netdev = true;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
+	dev->max_mtu = IP_MAX_MTU - sizeof(struct ipv6hdr) -
+		       sizeof(struct iphdr);
+	dev->min_mtu = IPV6_MIN_MTU;
+	dev->mtu = ETH_DATA_LEN;
+
+	/* keep skb->dst up to ndo_start_xmit so ICMP error emission can
+	 * reuse routing metadata from ingress when available
+	 */
+	netif_keep_dst(dev);
+
+	SET_NETDEV_DEVTYPE(dev, &ipxlat_type);
+}
+
+static struct rtnl_link_ops ipxlat_link_ops = {
+	.kind = "ipxlat",
+	.priv_size = sizeof(struct ipxlat_priv),
+	.setup = ipxlat_setup,
+};
+
+bool ipxlat_dev_is_valid(const struct net_device *dev)
+{
+	return dev->rtnl_link_ops == &ipxlat_link_ops;
+}
+
+static int __init ipxlat_init(void)
+{
+	int err;
+
+	err = rtnl_link_register(&ipxlat_link_ops);
+	if (err) {
+		pr_err("ipxlat: failed to register rtnl link ops: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static void __exit ipxlat_exit(void)
+{
+	rtnl_link_unregister(&ipxlat_link_ops);
+}
+
+module_init(ipxlat_init);
+module_exit(ipxlat_exit);
diff --git a/drivers/net/ipxlat/main.h b/drivers/net/ipxlat/main.h
new file mode 100644
index 000000000000..fb78f910b2e2
--- /dev/null
+++ b/drivers/net/ipxlat/main.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*  IPXLAT - Stateless IP/ICMP Translation (SIIT) virtual device driver
+ *
+ *  Copyright (C) 2024- Alberto Leiva Popper <ydahhrk@gmail.com>
+ *  Copyright (C) 2026- Mandelbit SRL
+ *  Copyright (C) 2026- Daniel Gröber <dxld@darkboxed.org>
+ *
+ *  Author:	Alberto Leiva Popper <ydahhrk@gmail.com>
+ *		Antonio Quartulli <antonio@mandelbit.com>
+ *		Daniel Gröber <dxld@darkboxed.org>
+ *		Ralf Lici <ralf@mandelbit.com>
+ */
+
+#ifndef _NET_IPXLAT_MAIN_H_
+#define _NET_IPXLAT_MAIN_H_
+
+#include <linux/netdevice.h>
+
+/**
+ * ipxlat_dev_is_valid - tell whether a netdev is an ipxlat interface
+ * @dev: netdevice to inspect
+ *
+ * Return: true if @dev was created with ipxlat link ops.
+ */
+bool ipxlat_dev_is_valid(const struct net_device *dev);
+
+#endif /* _NET_IPXLAT_MAIN_H_ */
-- 
2.53.0


