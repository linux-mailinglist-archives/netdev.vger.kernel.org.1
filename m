Return-Path: <netdev+bounces-289839-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAw9LxFwDWroxQUAu9opvQ
	(envelope-from <netdev+bounces-289839-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:25:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56566589B5F
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BB64312BE76
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C69D3BCD09;
	Wed, 20 May 2026 08:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ERW1pzBK"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743273BB13D;
	Wed, 20 May 2026 08:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264874; cv=none; b=ZqpaqTpyHXFhR2m34Hh/zXP+XgZkcDLGVfUMfT2ESBKpJ/UC+7J9LMNg3lbbGIC3zP4kBvjQiuzGsz30aRbogh0ywlw0u9Nb5E6fOejvHm/MKJuIMC8zx4xozcJvTP46cbOoW3Rhd6nlxqtmZTUsYDVfHbWsrM5YMirTLEwH2ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264874; c=relaxed/simple;
	bh=Y/b/AWn+yxnEJ+Ve33g/5zQLPBtOk5uvSyOXIHF6njs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ob5L73e2/fOE9Wdtm+N9K7Ff7+JiYWODKRT45ebqZmFzcN86q7UISCXZgJPj7eizLpEyJtB3QlN5QdHG7bGPADSqQRG50uzZ0NbZSctZ6+zVY7519STBe4d3/YF2Vlfmyr34AKMalIX7SMTqTl2SDJWbRu9PYYnOAss0C3fFCEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ERW1pzBK; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1779264872; x=1810800872;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Y/b/AWn+yxnEJ+Ve33g/5zQLPBtOk5uvSyOXIHF6njs=;
  b=ERW1pzBKixjp8lDDNPzH5YEe+8tbCBFCNBkAigIF9oxtQaHUhAgIg7ac
   VUxe7UVxa96KSeMBFtyEBUvs/X6jE6BoHkeC52zJpLTTsY6fq9rpOaXRG
   XZArLeZn9Lwqkc4o8BhIRT5HLBBWYgr+VQ8FrJR6SqjHjtepwuL14egmQ
   2Z8CxQVawtSCKvw58LUxtEUPkAxf6Hxso+eGgwvgc3uKSWnCrbjeREJ9b
   ChcSb6o3+B4Ii/wF5xFvFBrrFe54AuclaoFSJTUUodPifk+TwoorYuXEk
   dLCfsy9n5i0utr2ho1bsalP8tyQs8rb4glk/XegjCu8qoYIHHZ5eEe9+y
   w==;
X-CSE-ConnectionGUID: vK4qKBbAQXe1sVW7HX3AuQ==
X-CSE-MsgGUID: xViO/4+eSdSwCm1ov28Evw==
X-IronPort-AV: E=Sophos;i="6.23,243,1770620400"; 
   d="scan'208";a="66575372"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 01:14:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Wed, 20 May 2026 01:14:31 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 20 May 2026 01:14:27 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 20 May 2026 10:12:21 +0200
Subject: [PATCH net-next v5 09/13] net: lan966x: add PCIe FDMA support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260520-lan966x-pci-fdma-v5-9-ca56197ae05b@microchip.com>
References: <20260520-lan966x-pci-fdma-v5-0-ca56197ae05b@microchip.com>
In-Reply-To: <20260520-lan966x-pci-fdma-v5-0-ca56197ae05b@microchip.com>
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
	<bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289839-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,iogearbox.net,gmail.com,fomichev.me,bootlin.com,arndb.de,linuxfoundation.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 56566589B5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add PCIe FDMA support for lan966x. The PCIe FDMA path uses contiguous
DMA buffers mapped through the endpoint's ATU, with memcpy-based frame
transfer instead of per-page DMA mappings.

With PCIe FDMA, throughput increases from ~33 Mbps (register-based I/O)
to ~620 Mbps on an Intel x86 host with a lan966x PCIe card.

Tested-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/lan966x/Makefile    |   4 +
 .../ethernet/microchip/lan966x/lan966x_fdma_pci.c  | 394 +++++++++++++++++++++
 .../net/ethernet/microchip/lan966x/lan966x_main.c  |  11 +
 .../net/ethernet/microchip/lan966x/lan966x_main.h  |  11 +
 .../net/ethernet/microchip/lan966x/lan966x_regs.h  |  10 +
 5 files changed, 430 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan966x/Makefile b/drivers/net/ethernet/microchip/lan966x/Makefile
index 4cdbe263502c..ac0beceb2a0d 100644
--- a/drivers/net/ethernet/microchip/lan966x/Makefile
+++ b/drivers/net/ethernet/microchip/lan966x/Makefile
@@ -18,6 +18,10 @@ lan966x-switch-objs  := lan966x_main.o lan966x_phylink.o lan966x_port.o \
 lan966x-switch-$(CONFIG_LAN966X_DCB) += lan966x_dcb.o
 lan966x-switch-$(CONFIG_DEBUG_FS) += lan966x_vcap_debugfs.o
 
+ifdef CONFIG_MCHP_LAN966X_PCI
+lan966x-switch-y += lan966x_fdma_pci.o
+endif
+
 # Provide include files
 ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/vcap
 ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/fdma
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
new file mode 100644
index 000000000000..c27d9e76e735
--- /dev/null
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
@@ -0,0 +1,394 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "fdma_api.h"
+#include "lan966x_main.h"
+
+static int lan966x_fdma_pci_dataptr_cb(struct fdma *fdma, int dcb, int db,
+				       u64 *dataptr)
+{
+	u64 addr;
+
+	addr = fdma_dataptr_dma_addr_contiguous(fdma, dcb, db);
+
+	*dataptr = fdma_pci_atu_translate_addr(fdma->atu_region, addr);
+
+	return 0;
+}
+
+static int lan966x_fdma_pci_nextptr_cb(struct fdma *fdma, int dcb, u64 *nextptr)
+{
+	u64 addr;
+
+	fdma_nextptr_cb(fdma, dcb, &addr);
+
+	*nextptr = fdma_pci_atu_translate_addr(fdma->atu_region, addr);
+
+	return 0;
+}
+
+static int lan966x_fdma_pci_rx_alloc(struct lan966x_rx *rx)
+{
+	struct lan966x *lan966x = rx->lan966x;
+	struct fdma *fdma = &rx->fdma;
+	int err;
+
+	err = fdma_alloc_coherent_and_map(lan966x->dev, fdma, &lan966x->atu);
+	if (err)
+		return err;
+
+	fdma_dcbs_init(fdma,
+		       FDMA_DCB_INFO_DATAL(fdma->db_size),
+		       FDMA_DCB_STATUS_INTR);
+
+	lan966x_fdma_llp_configure(lan966x,
+				   fdma->atu_region->base_addr,
+				   fdma->channel_id);
+
+	return 0;
+}
+
+static int lan966x_fdma_pci_tx_alloc(struct lan966x_tx *tx)
+{
+	struct lan966x *lan966x = tx->lan966x;
+	struct fdma *fdma = &tx->fdma;
+	int err;
+
+	err = fdma_alloc_coherent_and_map(lan966x->dev, fdma, &lan966x->atu);
+	if (err)
+		return err;
+
+	fdma_dcbs_init(fdma,
+		       FDMA_DCB_INFO_DATAL(fdma->db_size),
+		       FDMA_DCB_STATUS_DONE);
+
+	lan966x_fdma_llp_configure(lan966x,
+				   fdma->atu_region->base_addr,
+				   fdma->channel_id);
+
+	return 0;
+}
+
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
+/* TX slot layout (sizes in bytes):
+ *
+ *  +---------------------+-----+---------+-----+
+ *  | XDP_PACKET_HEADROOM | IFH | payload | FCS |
+ *  |         256         |  28 |   len   |   4 |
+ *  +---------------------+-----+---------+-----+
+ *  |<---------------- db_size ----------------->|
+ *
+ * Return true if the frame plus required overhead fits.
+ */
+static bool lan966x_fdma_pci_tx_size_fits(struct fdma *fdma, u32 len)
+{
+	return XDP_PACKET_HEADROOM + IFH_LEN_BYTES + len + ETH_FCS_LEN <=
+	       fdma->db_size;
+}
+
+/* Return true if blockl is a valid RX frame size. */
+static bool lan966x_fdma_pci_rx_size_fits(struct fdma *fdma, u32 blockl)
+{
+	return blockl >= IFH_LEN_BYTES + ETH_HLEN + ETH_FCS_LEN &&
+	       blockl <= fdma->db_size - XDP_PACKET_HEADROOM;
+}
+
+static int lan966x_fdma_pci_rx_check_frame(struct lan966x_rx *rx, u64 *src_port)
+{
+	struct lan966x *lan966x = rx->lan966x;
+	struct fdma *fdma = &rx->fdma;
+	struct lan966x_port *port;
+	struct fdma_db *db;
+	void *virt_addr;
+	u32 blockl;
+
+	/* virt_addr points to the IFH. */
+	virt_addr = fdma_dataptr_virt_addr_contiguous(fdma,
+						      fdma->dcb_index,
+						      fdma->db_index);
+
+	lan966x_ifh_get_src_port(virt_addr, src_port);
+
+	if (WARN_ON(*src_port >= lan966x->num_phys_ports))
+		return FDMA_ERROR;
+
+	port = lan966x->ports[*src_port];
+	if (!port)
+		return FDMA_ERROR;
+
+	db = fdma_db_next_get(fdma);
+
+	/* BLOCKL is a 16-bit HW-populated field; reject obviously-bad
+	 * values before they feed memcpy/XDP sizes.
+	 */
+	blockl = FDMA_DCB_STATUS_BLOCKL(db->status);
+	if (!lan966x_fdma_pci_rx_size_fits(fdma, blockl))
+		return FDMA_ERROR;
+
+	return FDMA_PASS;
+}
+
+static struct sk_buff *lan966x_fdma_pci_rx_get_frame(struct lan966x_rx *rx,
+						     u64 src_port)
+{
+	struct lan966x *lan966x = rx->lan966x;
+	struct fdma *fdma = &rx->fdma;
+	struct sk_buff *skb;
+	struct fdma_db *db;
+	u32 data_len;
+
+	/* Get the received frame and create an SKB for it. */
+	db = fdma_db_next_get(fdma);
+	data_len = FDMA_DCB_STATUS_BLOCKL(db->status);
+
+	skb = napi_alloc_skb(&lan966x->napi, data_len);
+	if (unlikely(!skb))
+		return NULL;
+
+	memcpy(skb->data,
+	       fdma_dataptr_virt_addr_contiguous(fdma,
+						 fdma->dcb_index,
+						 fdma->db_index),
+						 data_len);
+
+	skb_put(skb, data_len);
+
+	skb->dev = lan966x->ports[src_port]->dev;
+	skb_pull(skb, IFH_LEN_BYTES);
+
+	skb_trim(skb, skb->len - ETH_FCS_LEN);
+
+	skb->protocol = eth_type_trans(skb, skb->dev);
+
+	if (lan966x->bridge_mask & BIT(src_port)) {
+		skb->offload_fwd_mark = 1;
+
+		skb_reset_network_header(skb);
+		if (!lan966x_hw_offload(lan966x, src_port, skb))
+			skb->offload_fwd_mark = 0;
+	}
+
+	skb->dev->stats.rx_bytes += skb->len;
+	skb->dev->stats.rx_packets++;
+
+	return skb;
+}
+
+static int lan966x_fdma_pci_xmit(struct sk_buff *skb, __be32 *ifh,
+				 struct net_device *dev)
+{
+	struct lan966x_port *port = netdev_priv(dev);
+	struct lan966x *lan966x = port->lan966x;
+	struct lan966x_tx *tx = &lan966x->tx;
+	struct fdma *fdma = &tx->fdma;
+	int next_to_use;
+	void *virt_addr;
+
+	next_to_use = lan966x_fdma_pci_get_next_dcb(fdma);
+
+	if (next_to_use < 0) {
+		netif_stop_queue(dev);
+		return NETDEV_TX_BUSY;
+	}
+
+	if (skb_put_padto(skb, ETH_ZLEN)) {
+		dev->stats.tx_dropped++;
+		return NETDEV_TX_OK;
+	}
+
+	if (!lan966x_fdma_pci_tx_size_fits(fdma, skb->len)) {
+		dev_kfree_skb_any(skb);
+		dev->stats.tx_dropped++;
+		return NETDEV_TX_OK;
+	}
+
+	skb_tx_timestamp(skb);
+
+	/* virt_addr points to the IFH. */
+	virt_addr = fdma_dataptr_virt_addr_contiguous(fdma, next_to_use, 0);
+	memcpy(virt_addr, ifh, IFH_LEN_BYTES);
+	memcpy(virt_addr + IFH_LEN_BYTES, skb->data, skb->len);
+
+	/* Order frame write before DCB status write below. */
+	dma_wmb();
+
+	fdma_dcb_add(fdma,
+		     next_to_use,
+		     0,
+		     FDMA_DCB_STATUS_INTR |
+		     FDMA_DCB_STATUS_SOF |
+		     FDMA_DCB_STATUS_EOF |
+		     FDMA_DCB_STATUS_BLOCKO(0) |
+		     FDMA_DCB_STATUS_BLOCKL(IFH_LEN_BYTES + skb->len + ETH_FCS_LEN));
+
+	/* Start the transmission. */
+	lan966x_fdma_tx_start(tx);
+
+	dev->stats.tx_bytes += skb->len;
+	dev->stats.tx_packets++;
+
+	/* Safe to free: the PCIe DTBO does not enable the PTP interrupt,
+	 * so lan966x->ptp stays 0 and lan966x_port_xmit() never enqueues
+	 * this skb on port->tx_skbs for a TX timestamp.
+	 */
+	dev_consume_skb_any(skb);
+
+	return NETDEV_TX_OK;
+}
+
+static int lan966x_fdma_pci_napi_poll(struct napi_struct *napi, int weight)
+{
+	struct lan966x *lan966x = container_of(napi, struct lan966x, napi);
+	struct lan966x_rx *rx = &lan966x->rx;
+	struct fdma *fdma = &rx->fdma;
+	int dcb_reload, old_dcb;
+	struct sk_buff *skb;
+	int counter = 0;
+	u64 src_port;
+
+	/* Wake any stopped TX queues if a TX DCB is available. */
+	spin_lock(&lan966x->tx_lock);
+	if (lan966x_fdma_pci_get_next_dcb(&lan966x->tx.fdma) >= 0)
+		lan966x_fdma_wakeup_netdev(lan966x);
+	spin_unlock(&lan966x->tx_lock);
+
+	dcb_reload = fdma->dcb_index;
+
+	/* Get all received skbs. */
+	while (counter < weight) {
+		if (!fdma_has_frames(fdma))
+			break;
+		/* Order DONE read before DCB/frame reads below. */
+		dma_rmb();
+		counter++;
+		switch (lan966x_fdma_pci_rx_check_frame(rx, &src_port)) {
+		case FDMA_PASS:
+			break;
+		case FDMA_ERROR:
+			/* No rx_dropped increment here because src_port is
+			 * invalid.
+			 */
+			fdma_dcb_advance(fdma);
+			continue;
+		}
+		skb = lan966x_fdma_pci_rx_get_frame(rx, src_port);
+		fdma_dcb_advance(fdma);
+		if (!skb) {
+			lan966x->ports[src_port]->dev->stats.rx_dropped++;
+			continue;
+		}
+
+		napi_gro_receive(&lan966x->napi, skb);
+	}
+	while (dcb_reload != fdma->dcb_index) {
+		old_dcb = dcb_reload;
+		dcb_reload++;
+		dcb_reload &= fdma->n_dcbs - 1;
+
+		fdma_dcb_add(fdma,
+			     old_dcb,
+			     FDMA_DCB_INFO_DATAL(fdma->db_size),
+			     FDMA_DCB_STATUS_INTR);
+
+		lan966x_fdma_rx_reload(rx);
+	}
+
+	if (counter < weight && napi_complete_done(napi, counter))
+		lan_wr(0xff, lan966x, FDMA_INTR_DB_ENA);
+
+	return counter;
+}
+
+static int lan966x_fdma_pci_init(struct lan966x *lan966x)
+{
+	struct fdma *rx_fdma = &lan966x->rx.fdma;
+	struct fdma *tx_fdma = &lan966x->tx.fdma;
+	int err;
+
+	if (!lan966x->fdma)
+		return 0;
+
+	lan_wr(FDMA_CTRL_NRESET_SET(0), lan966x, FDMA_CTRL);
+	lan_wr(FDMA_CTRL_NRESET_SET(1), lan966x, FDMA_CTRL);
+
+	fdma_pci_atu_init(&lan966x->atu, lan966x->regs[TARGET_PCIE_DBI]);
+
+	lan966x->rx.lan966x = lan966x;
+	lan966x->rx.max_mtu = lan966x_fdma_get_max_frame(lan966x);
+	rx_fdma->channel_id = FDMA_XTR_CHANNEL;
+	rx_fdma->n_dcbs = FDMA_DCB_MAX;
+	rx_fdma->n_dbs = FDMA_RX_DCB_MAX_DBS;
+	rx_fdma->priv = lan966x;
+	rx_fdma->db_size = FDMA_PCI_DB_SIZE(lan966x->rx.max_mtu);
+	rx_fdma->size = fdma_get_size_contiguous(rx_fdma);
+	rx_fdma->ops.nextptr_cb = &lan966x_fdma_pci_nextptr_cb;
+	rx_fdma->ops.dataptr_cb = &lan966x_fdma_pci_dataptr_cb;
+
+	lan966x->tx.lan966x = lan966x;
+	tx_fdma->channel_id = FDMA_INJ_CHANNEL;
+	tx_fdma->n_dcbs = FDMA_DCB_MAX;
+	tx_fdma->n_dbs = FDMA_TX_DCB_MAX_DBS;
+	tx_fdma->priv = lan966x;
+	tx_fdma->db_size = FDMA_PCI_DB_SIZE(lan966x->rx.max_mtu);
+	tx_fdma->size = fdma_get_size_contiguous(tx_fdma);
+	tx_fdma->ops.nextptr_cb = &lan966x_fdma_pci_nextptr_cb;
+	tx_fdma->ops.dataptr_cb = &lan966x_fdma_pci_dataptr_cb;
+
+	err = lan966x_fdma_pci_rx_alloc(&lan966x->rx);
+	if (err)
+		return err;
+
+	err = lan966x_fdma_pci_tx_alloc(&lan966x->tx);
+	if (err) {
+		fdma_free_coherent_and_unmap(lan966x->dev, rx_fdma);
+		return err;
+	}
+
+	lan966x_fdma_rx_start(&lan966x->rx);
+
+	return 0;
+}
+
+static int lan966x_fdma_pci_resize(struct lan966x *lan966x)
+{
+	return -EOPNOTSUPP;
+}
+
+static void lan966x_fdma_pci_deinit(struct lan966x *lan966x)
+{
+	if (!lan966x->fdma)
+		return;
+
+	lan966x_fdma_rx_disable(&lan966x->rx);
+	lan966x_fdma_tx_disable(&lan966x->tx);
+
+	napi_synchronize(&lan966x->napi);
+	napi_disable(&lan966x->napi);
+
+	fdma_free_coherent_and_unmap(lan966x->dev, &lan966x->rx.fdma);
+	fdma_free_coherent_and_unmap(lan966x->dev, &lan966x->tx.fdma);
+}
+
+const struct lan966x_fdma_ops lan966x_fdma_pci_ops = {
+	.fdma_init = &lan966x_fdma_pci_init,
+	.fdma_deinit = &lan966x_fdma_pci_deinit,
+	.fdma_xmit = &lan966x_fdma_pci_xmit,
+	.fdma_poll = &lan966x_fdma_pci_napi_poll,
+	.fdma_resize = &lan966x_fdma_pci_resize,
+};
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index cc3c7b6c65ae..7036b1d937d5 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -7,6 +7,7 @@
 #include <linux/ip.h>
 #include <linux/of.h>
 #include <linux/of_net.h>
+#include <linux/pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
@@ -49,6 +50,9 @@ struct lan966x_main_io_resource {
 static const struct lan966x_main_io_resource lan966x_main_iomap[] =  {
 	{ TARGET_CPU,                   0xc0000, 0 }, /* 0xe00c0000 */
 	{ TARGET_FDMA,                  0xc0400, 0 }, /* 0xe00c0400 */
+#if IS_ENABLED(CONFIG_MCHP_LAN966X_PCI)
+	{ TARGET_PCIE_DBI,             0x400000, 0 }, /* 0xe0400000 */
+#endif
 	{ TARGET_ORG,                         0, 1 }, /* 0xe2000000 */
 	{ TARGET_GCB,                    0x4000, 1 }, /* 0xe2004000 */
 	{ TARGET_QS,                     0x8000, 1 }, /* 0xe2008000 */
@@ -1100,6 +1104,13 @@ static int lan966x_reset_switch(struct lan966x *lan966x)
 
 static const struct lan966x_fdma_ops *lan966x_get_fdma_ops(struct device *dev)
 {
+#if IS_ENABLED(CONFIG_MCHP_LAN966X_PCI)
+	for (struct device *p = dev->parent; p; p = p->parent) {
+		if (dev_is_pci(p))
+			return &lan966x_fdma_pci_ops;
+	}
+#endif
+
 	return &lan966x_fdma_ops;
 }
 
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
index 5f4dbeda17cd..e7fdd4447fb6 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
@@ -17,6 +17,9 @@
 #include <net/xdp.h>
 
 #include <fdma_api.h>
+#if IS_ENABLED(CONFIG_MCHP_LAN966X_PCI)
+#include <fdma_pci.h>
+#endif
 #include <vcap_api.h>
 #include <vcap_api_client.h>
 
@@ -288,6 +291,10 @@ struct lan966x {
 
 	void __iomem *regs[NUM_TARGETS];
 
+#if IS_ENABLED(CONFIG_MCHP_LAN966X_PCI)
+	struct fdma_pci_atu atu;
+#endif
+
 	int shared_queue_sz;
 
 	u8 base_mac[ETH_ALEN];
@@ -586,6 +593,10 @@ void lan966x_fdma_wakeup_netdev(struct lan966x *lan966x);
 int lan966x_fdma_get_max_frame(struct lan966x *lan966x);
 int lan966x_qsys_sw_status(struct lan966x *lan966x);
 
+#if IS_ENABLED(CONFIG_MCHP_LAN966X_PCI)
+extern const struct lan966x_fdma_ops lan966x_fdma_pci_ops;
+#endif
+
 int lan966x_lag_port_join(struct lan966x_port *port,
 			  struct net_device *brport_dev,
 			  struct net_device *bond,
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_regs.h b/drivers/net/ethernet/microchip/lan966x/lan966x_regs.h
index aba0d36ae6b5..4778ea217673 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_regs.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_regs.h
@@ -20,6 +20,7 @@ enum lan966x_target {
 	TARGET_FDMA = 21,
 	TARGET_GCB = 27,
 	TARGET_ORG = 36,
+	TARGET_PCIE_DBI = 40,
 	TARGET_PTP = 41,
 	TARGET_QS = 42,
 	TARGET_QSYS = 46,
@@ -1009,6 +1010,15 @@ enum lan966x_target {
 #define FDMA_CH_CFG_CH_MEM_GET(x)\
 	FIELD_GET(FDMA_CH_CFG_CH_MEM, x)
 
+/*      FDMA:FDMA:FDMA_CTRL */
+#define FDMA_CTRL                 __REG(TARGET_FDMA, 0, 1, 8, 0, 1, 428, 424, 0, 1, 4)
+
+#define FDMA_CTRL_NRESET                         BIT(0)
+#define FDMA_CTRL_NRESET_SET(x)\
+	FIELD_PREP(FDMA_CTRL_NRESET, x)
+#define FDMA_CTRL_NRESET_GET(x)\
+	FIELD_GET(FDMA_CTRL_NRESET, x)
+
 /*      FDMA:FDMA:FDMA_PORT_CTRL */
 #define FDMA_PORT_CTRL(r)         __REG(TARGET_FDMA, 0, 1, 8, 0, 1, 428, 376, r, 2, 4)
 

-- 
2.34.1


