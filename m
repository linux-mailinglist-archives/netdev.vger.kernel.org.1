Return-Path: <netdev+bounces-269957-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cI7oGJFjvWlF9gIAu9opvQ
	(envelope-from <netdev+bounces-269957-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:11:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3AD2DC62C
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 564B33055DC7
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485F63CFF4D;
	Fri, 20 Mar 2026 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="oh/leBh4"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1503C2771;
	Fri, 20 Mar 2026 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018932; cv=none; b=c+kqYs7DGWEtAKMIyQK5pjI9zPgqALm5idk6F1shFqewecGh51pUwjkHe8xKkxXCfzim6s0l+jGM7wubS9VEW7CPzJhvcdgSnl22MaiCyM84Hzyh20WbLpW+EdAEATQFNgvSP7NHE0J67AlUhofxRUv+U7vysc4uGAaeJC/JHRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018932; c=relaxed/simple;
	bh=wNBL64KvMP8DwvSA3uWCR7p3ESGpmwk9JGc3ODc64+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Cfbf9QWL7Jts0x2OotTkU8uAvOAWnaFZ25QGhxlrok8O+1Oj6UNOtAAJtd0F6yXwrNjIInl/6h/vleuoduO9fB9Mn9F6/5eMV30DkEVecehaJgzXj0gOkBKOPA2yR05CLy24N+rWKXNQRrnwWwEIwlTZoLeMnQKK802/Ba2sDxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=oh/leBh4; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774018929; x=1805554929;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=wNBL64KvMP8DwvSA3uWCR7p3ESGpmwk9JGc3ODc64+0=;
  b=oh/leBh4i0Er+PmQn7eucXpX4ZCriEqci1WWc1L9R2CcrrtejedumoDz
   VIOHYjpthSFyngoaZGf/+NbK5TJZ9OytFC1l3m0o00o7dQPrSQ/TkS6sz
   6k0o/VjIu52C52jVroGW72ZyR0I0+TOU79owhKRWMGXxeLtfVnyRLitD0
   xLndrvNyU61H43AX8rVUCSUZLLgcEoDGa0NrOR2P/xDw3pfA4YaCTlPsM
   h7DlLbQ7n88vDJRsqDG7SFZx2pOR8JDmRHIXafkRkIE+TWK6Q/dIWjOmv
   7jBt7lADBjJOBkL7aUweuG7ROiSIRliYB471/erUV06Vw1pgeac9dXH0B
   A==;
X-CSE-ConnectionGUID: PI7UURBMS4qqPJi2jv9mYA==
X-CSE-MsgGUID: SR+szIOKQbWnRbpRpxZnQg==
X-IronPort-AV: E=Sophos;i="6.23,130,1770620400"; 
   d="scan'208";a="62637213"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 08:02:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Fri, 20 Mar 2026 08:01:43 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 20 Mar 2026 08:01:40 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 20 Mar 2026 16:01:04 +0100
Subject: [PATCH net-next 08/10] net: lan966x: add PCIe FDMA XDP support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260320-lan966x-pci-fdma-v1-8-ef54cb9b0c4b@microchip.com>
References: <20260320-lan966x-pci-fdma-v1-0-ef54cb9b0c4b@microchip.com>
In-Reply-To: <20260320-lan966x-pci-fdma-v1-0-ef54cb9b0c4b@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Steen Hegelund
	<steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Herve
 Codina <herve.codina@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269957-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,iogearbox.net,gmail.com,fomichev.me,bootlin.com,arndb.de,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:dkim,microchip.com:email,microchip.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA3AD2DC62C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add XDP support for the PCIe FDMA path. The PCIe XDP implementation
operates on contiguous ATU-mapped buffers with memcpy-based XDP_TX
transmit, unlike the platform path which uses page_pool.

Only XDP_ACT_BASIC (XDP_PASS, XDP_DROP, XDP_TX, XDP_ABORTED) is
supported; XDP_REDIRECT and NDO_XMIT are not available on the PCIe path,
as they, to my knowledge, require page_pool-backed buffers.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../ethernet/microchip/lan966x/lan966x_fdma_pci.c  | 136 ++++++++++++++++++---
 .../net/ethernet/microchip/lan966x/lan966x_main.c  |  11 +-
 .../net/ethernet/microchip/lan966x/lan966x_main.h  |  10 ++
 .../net/ethernet/microchip/lan966x/lan966x_xdp.c   |   6 +
 4 files changed, 140 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
index 4d69beb41c0c..f2c8c6aa3d4f 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+#include <linux/bpf_trace.h>
+
 #include "fdma_api.h"
 #include "lan966x_main.h"
 
@@ -68,10 +70,110 @@ static int lan966x_fdma_pci_tx_alloc(struct lan966x_tx *tx)
 	return 0;
 }
 
+static int lan966x_fdma_pci_get_next_dcb(struct fdma *fdma)
+{
+	struct fdma_db *db;
+
+	for (int i = 0; i < fdma->n_dcbs; i++) {
+		db = fdma_db_get(fdma, i, 0);
+
+		if (!fdma_db_is_done(db))
+			continue;
+		if (fdma_is_last(fdma, &fdma->dcbs[i]))
+			continue;
+
+		return i;
+	}
+
+	return -1;
+}
+
+static int lan966x_fdma_pci_xmit_xdpf(struct lan966x_port *port,
+				      void *ptr, u32 len)
+{
+	struct lan966x *lan966x = port->lan966x;
+	struct lan966x_tx *tx = &lan966x->tx;
+	struct fdma *fdma = &tx->fdma;
+	int next_to_use, ret = 0;
+	void *virt_addr;
+	__be32 *ifh;
+
+	spin_lock(&lan966x->tx_lock);
+
+	next_to_use = lan966x_fdma_pci_get_next_dcb(fdma);
+
+	if (next_to_use < 0) {
+		netif_stop_queue(port->dev);
+		ret = NETDEV_TX_BUSY;
+		goto out;
+	}
+
+	ifh = ptr;
+	memset(ifh, 0, IFH_LEN_BYTES);
+	lan966x_ifh_set_bypass(ifh, 1);
+	lan966x_ifh_set_port(ifh, BIT_ULL(port->chip_port));
+
+	/* Get the virtual addr of the next DB and copy frame to it. */
+	virt_addr = fdma_dataptr_virt_addr_contiguous(fdma, next_to_use, 0);
+	memcpy(virt_addr, ptr, len);
+
+	fdma_dcb_add(fdma,
+		     next_to_use,
+		     0,
+		     FDMA_DCB_STATUS_SOF |
+		     FDMA_DCB_STATUS_EOF |
+		     FDMA_DCB_STATUS_BLOCKO(0) |
+		     FDMA_DCB_STATUS_BLOCKL(len));
+
+	/* Start the transmission. */
+	lan966x_fdma_tx_start(tx);
+
+out:
+	spin_unlock(&lan966x->tx_lock);
+
+	return ret;
+}
+
+static int lan966x_xdp_pci_run(struct lan966x_port *port, void *data,
+			       u32 data_len)
+{
+	struct bpf_prog *xdp_prog = port->xdp_prog;
+	struct lan966x *lan966x = port->lan966x;
+	struct xdp_buff xdp;
+	u32 act;
+
+	xdp_init_buff(&xdp, lan966x->rx.max_mtu, &port->xdp_rxq);
+
+	xdp_prepare_buff(&xdp,
+			 data - XDP_PACKET_HEADROOM,
+			 IFH_LEN_BYTES + XDP_PACKET_HEADROOM,
+			 data_len - IFH_LEN_BYTES,
+			 false);
+
+	act = bpf_prog_run_xdp(xdp_prog, &xdp);
+	switch (act) {
+	case XDP_PASS:
+		return FDMA_PASS;
+	case XDP_TX:
+		return lan966x_fdma_pci_xmit_xdpf(port, data, data_len) ?
+		       FDMA_DROP : FDMA_TX;
+	default:
+		bpf_warn_invalid_xdp_action(port->dev, xdp_prog, act);
+		fallthrough;
+	case XDP_ABORTED:
+		trace_xdp_exception(port->dev, xdp_prog, act);
+		fallthrough;
+	case XDP_DROP:
+		return FDMA_DROP;
+	}
+}
+
 static int lan966x_fdma_pci_rx_check_frame(struct lan966x_rx *rx, u64 *src_port)
 {
 	struct lan966x *lan966x = rx->lan966x;
 	struct fdma *fdma = &rx->fdma;
+	struct lan966x_port *port;
+	struct fdma_db *db;
 	void *virt_addr;
 
 	virt_addr = fdma_dataptr_virt_addr_contiguous(fdma,
@@ -83,7 +185,15 @@ static int lan966x_fdma_pci_rx_check_frame(struct lan966x_rx *rx, u64 *src_port)
 	if (WARN_ON(*src_port >= lan966x->num_phys_ports))
 		return FDMA_ERROR;
 
-	return FDMA_PASS;
+	port = lan966x->ports[*src_port];
+	if (!lan966x_xdp_port_present(port))
+		return FDMA_PASS;
+
+	db = fdma_db_next_get(fdma);
+
+	return lan966x_xdp_pci_run(port,
+				   virt_addr,
+				   FDMA_DCB_STATUS_BLOCKL(db->status));
 }
 
 static struct sk_buff *lan966x_fdma_pci_rx_get_frame(struct lan966x_rx *rx,
@@ -133,24 +243,6 @@ static struct sk_buff *lan966x_fdma_pci_rx_get_frame(struct lan966x_rx *rx,
 	return skb;
 }
 
-static int lan966x_fdma_pci_get_next_dcb(struct fdma *fdma)
-{
-	struct fdma_db *db;
-
-	for (int i = 0; i < fdma->n_dcbs; i++) {
-		db = fdma_db_get(fdma, i, 0);
-
-		if (!fdma_db_is_done(db))
-			continue;
-		if (fdma_is_last(fdma, &fdma->dcbs[i]))
-			continue;
-
-		return i;
-	}
-
-	return -1;
-}
-
 static int lan966x_fdma_pci_xmit(struct sk_buff *skb, __be32 *ifh,
 				 struct net_device *dev)
 {
@@ -225,6 +317,12 @@ static int lan966x_fdma_pci_napi_poll(struct napi_struct *napi, int weight)
 		case FDMA_ERROR:
 			fdma_dcb_advance(fdma);
 			goto allocate_new;
+		case FDMA_TX:
+			fdma_dcb_advance(fdma);
+			continue;
+		case FDMA_DROP:
+			fdma_dcb_advance(fdma);
+			continue;
 		}
 		skb = lan966x_fdma_pci_rx_get_frame(rx, src_port);
 		fdma_dcb_advance(fdma);
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index fc14738774ec..b42e044da735 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -877,10 +877,13 @@ static int lan966x_probe_port(struct lan966x *lan966x, u32 p,
 
 	port->phylink = phylink;
 
-	if (lan966x->fdma)
-		dev->xdp_features = NETDEV_XDP_ACT_BASIC |
-				    NETDEV_XDP_ACT_REDIRECT |
-				    NETDEV_XDP_ACT_NDO_XMIT;
+	if (lan966x->fdma) {
+		dev->xdp_features = NETDEV_XDP_ACT_BASIC;
+
+		if (!lan966x_is_pci(lan966x))
+			dev->xdp_features |= NETDEV_XDP_ACT_REDIRECT |
+					     NETDEV_XDP_ACT_NDO_XMIT;
+	}
 
 	err = register_netdev(dev);
 	if (err) {
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
index 8fcc51133417..2491fe937e36 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
@@ -596,6 +596,16 @@ int lan966x_qsys_sw_status(struct lan966x *lan966x);
 
 #if IS_ENABLED(CONFIG_MCHP_LAN966X_PCI)
 extern const struct lan966x_fdma_ops lan966x_fdma_pci_ops;
+
+static inline bool lan966x_is_pci(struct lan966x *lan966x)
+{
+	return lan966x->ops == &lan966x_fdma_pci_ops;
+}
+#else
+static inline bool lan966x_is_pci(struct lan966x *lan966x)
+{
+	return false;
+}
 #endif
 
 int lan966x_lag_port_join(struct lan966x_port *port,
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c b/drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c
index 9ee61db8690b..9b3356ba6ba8 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c
@@ -27,6 +27,12 @@ static int lan966x_xdp_setup(struct net_device *dev, struct netdev_bpf *xdp)
 	if (old_xdp == new_xdp)
 		goto out;
 
+	/* PCIe FDMA uses contiguous buffers, so no page_pool reload
+	 * is needed.
+	 */
+	if (lan966x_is_pci(lan966x))
+		goto out;
+
 	err = lan966x_fdma_reload_page_pool(lan966x);
 	if (err) {
 		xchg(&port->xdp_prog, old_prog);

-- 
2.34.1


