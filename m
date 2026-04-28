Return-Path: <netdev+bounces-281864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEKTBmi68GmFXwEAu9opvQ
	(envelope-from <netdev+bounces-281864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:47:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A936486352
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD3C530C18C7
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD1D44D011;
	Tue, 28 Apr 2026 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qhQYdOpm"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB2F427A19;
	Tue, 28 Apr 2026 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381673; cv=none; b=ETgOfawmZTfAYtH7Txj7Um6T1lyUlaBt6C+qgT7WjJB5TtaERmsXW2yI1recHyPndxsUPoQjdypXGNcAnPJmeWOtvaGHTYEY4XbQYZM2qA7yLMIqDYwBgoCUSnNUEvz28tlBIH1vNpSA3nz/ALdm9LciIp5BzHWUVS5A18dsoS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381673; c=relaxed/simple;
	bh=7duLDrVj2RmWkjBsNSiSNGVKAZyjBtNnDGfP78t+cmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GMkp/PPFx6Od2V70KO8GnzFgi9OstYp40MNLmvHmiO234EEm0i+6ewKC+daFGVA4dI/ep8GhW98rfyAZ1kJghbuzodRXOkM5/C2f/6vFdiouNzUx248qWZwHWawPHvLQeYked7sB1EzCHVRgLM4hQTtmHV8osoqP+9X5rYWvBgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qhQYdOpm; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1777381671; x=1808917671;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=7duLDrVj2RmWkjBsNSiSNGVKAZyjBtNnDGfP78t+cmY=;
  b=qhQYdOpmVemNVVg1xSCQ52ufXPi/faUvhPdPacLv/vzjgSHNkYiYnOlB
   0affwTXnamFz6+j8mDkioINFf574jWZ4AklDLXVPfUKEnL+MFwK9+Ubr+
   W04JtPix2g+u/bsHLzUz8iCXa8YDdKgXbnMDJm7a6EMKj8lOk8eSJ8suV
   Bigf21H3ALAc4SAhq7wLq10YbMZyGwgl7a3A10vKJCRgskd4u4J4CwXM3
   DtHmKZpa20w8LwEL4HJ70a2GGekv8zs2xmq+sHhsa5/JwmDJHE13jZRQp
   vITQF93bTko37jP3qJUI88ftV0mA0QcnIMt9dbjf1HnLPPhTOFkMcenXU
   g==;
X-CSE-ConnectionGUID: CENtd9w4THuX/4XcjsKWMA==
X-CSE-MsgGUID: 5nBuXr09TciaTSdY3mIkXQ==
X-IronPort-AV: E=Sophos;i="6.23,204,1770620400"; 
   d="scan'208";a="64844152"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2026 06:07:50 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 28 Apr 2026 06:07:50 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 28 Apr 2026 06:07:47 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Tue, 28 Apr 2026 15:07:00 +0200
Subject: [PATCH net-next v2 11/13] net: lan966x: add PCIe FDMA XDP support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260428-lan966x-pci-fdma-v2-11-d3ec66e06202@microchip.com>
References: <20260428-lan966x-pci-fdma-v2-0-d3ec66e06202@microchip.com>
In-Reply-To: <20260428-lan966x-pci-fdma-v2-0-d3ec66e06202@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Steen Hegelund
	<steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Herve
 Codina <herve.codina@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Mohsin Bashir
	<mohsin.bashr@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 7A936486352
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281864-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,iogearbox.net,gmail.com,fomichev.me,bootlin.com,arndb.de,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:email,microchip.com:dkim,microchip.com:mid]

Add XDP support for the PCIe FDMA path. The implementation operates on
contiguous ATU-mapped buffers with memcpy-based XDP_TX, unlike the
platform path which uses page_pool.

Reserve XDP_PACKET_HEADROOM at the start of every RX/TX buffer and
account for it throughout the FDMA and XDP paths.

lan966x_fdma_pci_rx_check_frame() gains output arguments for the frame
pointer and length so lan966x_xdp_pci_run() can return the post-XDP
data/len to the caller.

Only XDP_ACT_BASIC is supported.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../ethernet/microchip/lan966x/lan966x_fdma_pci.c  | 193 ++++++++++++++++-----
 .../net/ethernet/microchip/lan966x/lan966x_main.c  |  11 +-
 .../net/ethernet/microchip/lan966x/lan966x_main.h  |  10 ++
 .../net/ethernet/microchip/lan966x/lan966x_xdp.c   |   9 +
 4 files changed, 179 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
index 61a62dbcc313..8d867b7edd39 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+#include <linux/bpf_trace.h>
+
 #include "fdma_api.h"
 #include "lan966x_main.h"
 
@@ -15,7 +17,8 @@ static int lan966x_fdma_pci_dataptr_cb(struct fdma *fdma, int dcb, int db,
 
 	addr = fdma_dataptr_dma_addr_contiguous(fdma, dcb, db);
 
-	*dataptr = fdma_pci_atu_translate_addr(fdma->atu_region, addr);
+	*dataptr = fdma_pci_atu_translate_addr(fdma->atu_region, addr) +
+		   XDP_PACKET_HEADROOM;
 
 	return 0;
 }
@@ -73,51 +76,164 @@ static int lan966x_fdma_pci_tx_alloc(struct lan966x_tx *tx)
 	return 0;
 }
 
-static int lan966x_fdma_pci_rx_check_frame(struct lan966x_rx *rx, u64 *src_port)
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
+	return -ENOSPC;
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
+	virt_addr = fdma_dataptr_virt_addr_contiguous(fdma, next_to_use, 0) +
+		    XDP_PACKET_HEADROOM;
+
+	/* Construct a fresh IFH in the TX slot. */
+	ifh = virt_addr;
+	memset(ifh, 0, IFH_LEN_BYTES);
+	lan966x_ifh_set_bypass(ifh, 1);
+	lan966x_ifh_set_port(ifh, BIT_ULL(port->chip_port));
+
+	/* Copy the (post-XDP) frame after the IFH. */
+	memcpy(virt_addr + IFH_LEN_BYTES, ptr, len);
+
+	fdma_dcb_add(fdma,
+		     next_to_use,
+		     0,
+		     FDMA_DCB_STATUS_INTR |
+		     FDMA_DCB_STATUS_SOF |
+		     FDMA_DCB_STATUS_EOF |
+		     FDMA_DCB_STATUS_BLOCKO(0) |
+		     FDMA_DCB_STATUS_BLOCKL(IFH_LEN_BYTES + len));
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
+			       u32 data_len, void **xdp_data, u32 *xdp_len)
+{
+	struct bpf_prog *xdp_prog = port->xdp_prog;
+	struct lan966x *lan966x = port->lan966x;
+	struct xdp_buff xdp;
+	u32 act;
+
+	xdp_init_buff(&xdp, lan966x->rx.max_mtu, &port->xdp_rxq);
+
+	xdp_prepare_buff(&xdp,
+			 data,
+			 XDP_PACKET_HEADROOM + IFH_LEN_BYTES,
+			 data_len,
+			 false);
+
+	act = bpf_prog_run_xdp(xdp_prog, &xdp);
+
+	*xdp_data = xdp.data;
+	*xdp_len = xdp.data_end - xdp.data;
+
+	switch (act) {
+	case XDP_PASS:
+		return FDMA_PASS;
+	case XDP_TX:
+		return lan966x_fdma_pci_xmit_xdpf(port, *xdp_data, *xdp_len) ?
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
+static int lan966x_fdma_pci_rx_check_frame(struct lan966x_rx *rx, u64 *src_port,
+					   void **data, u32 *data_len)
 {
 	struct lan966x *lan966x = rx->lan966x;
 	struct fdma *fdma = &rx->fdma;
+	struct lan966x_port *port;
+	struct fdma_db *db;
 	void *virt_addr;
+	void *ifh;
 
 	virt_addr = fdma_dataptr_virt_addr_contiguous(fdma,
 						      fdma->dcb_index,
 						      fdma->db_index);
+	ifh = virt_addr + XDP_PACKET_HEADROOM;
 
-	lan966x_ifh_get_src_port(virt_addr, src_port);
+	lan966x_ifh_get_src_port(ifh, src_port);
 
 	if (WARN_ON(*src_port >= lan966x->num_phys_ports))
 		return FDMA_ERROR;
 
-	return FDMA_PASS;
+	port = lan966x->ports[*src_port];
+	if (!port)
+		return FDMA_ERROR;
+
+	db = fdma_db_next_get(fdma);
+
+	/* Present the Ethernet frame (no IFH); may be overridden by XDP. */
+	*data = ifh + IFH_LEN_BYTES;
+	*data_len = FDMA_DCB_STATUS_BLOCKL(db->status) - IFH_LEN_BYTES;
+
+	if (!lan966x_xdp_port_present(port))
+		return FDMA_PASS;
+
+	return lan966x_xdp_pci_run(port, virt_addr, *data_len, data, data_len);
 }
 
 static struct sk_buff *lan966x_fdma_pci_rx_get_frame(struct lan966x_rx *rx,
-						     u64 src_port)
+						     u64 src_port, void *data,
+						     u32 data_len)
 {
 	struct lan966x *lan966x = rx->lan966x;
-	struct fdma *fdma = &rx->fdma;
 	struct sk_buff *skb;
-	struct fdma_db *db;
-	u32 data_len;
-
-	/* Get the received frame and create an SKB for it. */
-	db = fdma_db_next_get(fdma);
-	data_len = FDMA_DCB_STATUS_BLOCKL(db->status);
 
 	skb = napi_alloc_skb(&lan966x->napi, data_len);
 	if (unlikely(!skb))
 		return NULL;
 
-	memcpy(skb->data,
-	       fdma_dataptr_virt_addr_contiguous(fdma,
-						 fdma->dcb_index,
-						 fdma->db_index),
-						 data_len);
+	memcpy(skb->data, data, data_len);
 
 	skb_put(skb, data_len);
 
 	skb->dev = lan966x->ports[src_port]->dev;
-	skb_pull(skb, IFH_LEN_BYTES);
 
 	if (likely(!(skb->dev->features & NETIF_F_RXFCS)))
 		skb_trim(skb, skb->len - ETH_FCS_LEN);
@@ -138,24 +254,6 @@ static struct sk_buff *lan966x_fdma_pci_rx_get_frame(struct lan966x_rx *rx,
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
-	return -ENOSPC;
-}
-
 static int lan966x_fdma_pci_xmit(struct sk_buff *skb, __be32 *ifh,
 				 struct net_device *dev)
 {
@@ -180,9 +278,10 @@ static int lan966x_fdma_pci_xmit(struct sk_buff *skb, __be32 *ifh,
 
 	skb_tx_timestamp(skb);
 
-	virt_addr = fdma_dataptr_virt_addr_contiguous(fdma, next_to_use, 0);
+	virt_addr = fdma_dataptr_virt_addr_contiguous(fdma, next_to_use, 0) +
+		    XDP_PACKET_HEADROOM;
 	memcpy(virt_addr, ifh, IFH_LEN_BYTES);
-	memcpy((u8 *)virt_addr + IFH_LEN_BYTES, skb->data, skb->len);
+	memcpy(virt_addr + IFH_LEN_BYTES, skb->data, skb->len);
 
 	fdma_dcb_add(fdma,
 		     next_to_use,
@@ -213,6 +312,8 @@ static int lan966x_fdma_pci_napi_poll(struct napi_struct *napi, int weight)
 	struct sk_buff *skb;
 	int counter = 0;
 	u64 src_port;
+	u32 data_len;
+	void *data;
 
 	/* Wake any stopped TX queues if a TX DCB is available. */
 	spin_lock(&lan966x->tx_lock);
@@ -227,14 +328,26 @@ static int lan966x_fdma_pci_napi_poll(struct napi_struct *napi, int weight)
 		if (!fdma_has_frames(fdma))
 			break;
 		counter++;
-		switch (lan966x_fdma_pci_rx_check_frame(rx, &src_port)) {
+		switch (lan966x_fdma_pci_rx_check_frame(rx,
+							&src_port,
+							&data,
+							&data_len)) {
 		case FDMA_PASS:
 			break;
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
-		skb = lan966x_fdma_pci_rx_get_frame(rx, src_port);
+		skb = lan966x_fdma_pci_rx_get_frame(rx,
+						    src_port,
+						    data,
+						    data_len);
 		fdma_dcb_advance(fdma);
 		if (!skb)
 			goto allocate_new;
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index c08972797563..d3b52ce47f94 100644
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
index e7fdd4447fb6..8911825eab77 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
@@ -595,6 +595,16 @@ int lan966x_qsys_sw_status(struct lan966x *lan966x);
 
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
index 9ee61db8690b..06eb747de383 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c
@@ -27,6 +27,15 @@ static int lan966x_xdp_setup(struct net_device *dev, struct netdev_bpf *xdp)
 	if (old_xdp == new_xdp)
 		goto out;
 
+	/* PCIe FDMA uses contiguous buffers, so no page_pool reload
+	 * is needed. Still wait for NAPI to drop any cached xdp_prog
+	 * pointer before the old program is freed below.
+	 */
+	if (lan966x_is_pci(lan966x)) {
+		napi_synchronize(&lan966x->napi);
+		goto out;
+	}
+
 	err = lan966x_fdma_reload_page_pool(lan966x);
 	if (err) {
 		xchg(&port->xdp_prog, old_prog);

-- 
2.34.1


