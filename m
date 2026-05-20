Return-Path: <netdev+bounces-289840-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mM7CIXxvDWrDxQUAu9opvQ
	(envelope-from <netdev+bounces-289840-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:23:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FF4589ACE
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8291308F0A4
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1833B3BE164;
	Wed, 20 May 2026 08:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mTQT+aKi"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6E33BD241;
	Wed, 20 May 2026 08:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264878; cv=none; b=Wiaw/NbQfj6xqtnW4khkLPyQEH3G6Vpy6YI3lWaMDdIdovdv6sYhBj7lFDEennliqqbJWDMGIzL8k02BdTFxY74SXSf+fUcMbUzKIJZkzvYNr8uzxLaVPbpd8T5lNz6dMb9w47iwYmDt/Gr2j5OTL4FFWZPqByWm1ah1jsJ7lTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264878; c=relaxed/simple;
	bh=xyn6DbImBQZkH/DheGVyhdAl/vlHxlhKkZ4K67sdPA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=acutA+7q3Qf9vsVXNkverZZV5LlI7tMKimLesJXST17bV3g5sBDHRPZG5We1nin+2DDb8nb2eAsaSt3UjPUYLKmlkXGK3biq1V+7OQeuGzUUrzzSGSqdGX1PednrWrOnHTlXjB29bhvxLp3T206+X55cj5RoplVqeKLnx4fahEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mTQT+aKi; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1779264876; x=1810800876;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=xyn6DbImBQZkH/DheGVyhdAl/vlHxlhKkZ4K67sdPA8=;
  b=mTQT+aKiDlLywP8s9XCLqy9v/2ejK3rNHI4+/xC8BMClbfdIWC429liS
   e3zHNa3IXC/IhCxbSTuEprv6D/lx50+aJzcHf4v7oVhQw3D2vuPWGA2YX
   9KLnBRgS4zRxz2fOi2TPJ3Sr26ce+PMcZmFVvZQz/QFIXG7WpOpEjy2VU
   vnzwUl/wBN5SVF2cH1q10QhMFeo85HFL2eUz6PsG9lI/cLL61b1t7TLlk
   3V2V3lIPhRFcc5187F2JjErfHYlNSIZ0yZ2rJ7LU37eTHIYt4mnAw7SFi
   ofj/jW9wB8RMOhHwpeEQH18Bx6b5EBGIbmKmGD34XxtfMSEUGTNJ2Puqa
   Q==;
X-CSE-ConnectionGUID: OZL637T5TrOk6wHqnbz1rw==
X-CSE-MsgGUID: +Fi3xsbOTIyXaKJruEQ+3w==
X-IronPort-AV: E=Sophos;i="6.23,243,1770620400"; 
   d="scan'208";a="66575379"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 May 2026 01:14:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 20 May 2026 01:14:35 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 20 May 2026 01:14:31 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 20 May 2026 10:12:22 +0200
Subject: [PATCH net-next v5 10/13] net: lan966x: add PCIe FDMA MTU change
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260520-lan966x-pci-fdma-v5-10-ca56197ae05b@microchip.com>
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
	TAGGED_FROM(0.00)[bounces-289840-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 01FF4589ACE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add MTU change support for the PCIe FDMA path. When the MTU changes,
the contiguous ATU-mapped RX and TX buffers are reallocated with the
new size. On allocation failure, the existing buffers are reused
after being reset.

Cap the PCIe DCB ring at 256 (FDMA_PCI_DCB_MAX) to keep the entire
contiguous allocation under MAX_PAGE_ORDER at jumbo MTU, which 512
DCBs would overflow.

Tested-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../ethernet/microchip/lan966x/lan966x_fdma_pci.c  | 157 ++++++++++++++++++++-
 1 file changed, 154 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
index c27d9e76e735..3ea6d22ee573 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
@@ -3,6 +3,11 @@
 #include "fdma_api.h"
 #include "lan966x_main.h"
 
+/* Ring must fit in one MAX_PAGE_ORDER DMA block; 512 DCBs overflows
+ * at jumbo MTU.
+ */
+#define FDMA_PCI_DCB_MAX	256
+
 static int lan966x_fdma_pci_dataptr_cb(struct fdma *fdma, int dcb, int db,
 				       u64 *dataptr)
 {
@@ -332,7 +337,7 @@ static int lan966x_fdma_pci_init(struct lan966x *lan966x)
 	lan966x->rx.lan966x = lan966x;
 	lan966x->rx.max_mtu = lan966x_fdma_get_max_frame(lan966x);
 	rx_fdma->channel_id = FDMA_XTR_CHANNEL;
-	rx_fdma->n_dcbs = FDMA_DCB_MAX;
+	rx_fdma->n_dcbs = FDMA_PCI_DCB_MAX;
 	rx_fdma->n_dbs = FDMA_RX_DCB_MAX_DBS;
 	rx_fdma->priv = lan966x;
 	rx_fdma->db_size = FDMA_PCI_DB_SIZE(lan966x->rx.max_mtu);
@@ -342,7 +347,7 @@ static int lan966x_fdma_pci_init(struct lan966x *lan966x)
 
 	lan966x->tx.lan966x = lan966x;
 	tx_fdma->channel_id = FDMA_INJ_CHANNEL;
-	tx_fdma->n_dcbs = FDMA_DCB_MAX;
+	tx_fdma->n_dcbs = FDMA_PCI_DCB_MAX;
 	tx_fdma->n_dbs = FDMA_TX_DCB_MAX_DBS;
 	tx_fdma->priv = lan966x;
 	tx_fdma->db_size = FDMA_PCI_DB_SIZE(lan966x->rx.max_mtu);
@@ -365,9 +370,155 @@ static int lan966x_fdma_pci_init(struct lan966x *lan966x)
 	return 0;
 }
 
+/* Reset existing rx and tx buffers. */
+static void lan966x_fdma_pci_reset_mem(struct lan966x *lan966x)
+{
+	struct lan966x_rx *rx = &lan966x->rx;
+	struct lan966x_tx *tx = &lan966x->tx;
+
+	memset(rx->fdma.dcbs, 0, rx->fdma.size);
+	memset(tx->fdma.dcbs, 0, tx->fdma.size);
+
+	fdma_dcbs_init(&rx->fdma,
+		       FDMA_DCB_INFO_DATAL(rx->fdma.db_size),
+		       FDMA_DCB_STATUS_INTR);
+
+	fdma_dcbs_init(&tx->fdma,
+		       FDMA_DCB_INFO_DATAL(tx->fdma.db_size),
+		       FDMA_DCB_STATUS_DONE);
+
+	lan966x_fdma_llp_configure(lan966x,
+				   tx->fdma.atu_region->base_addr,
+				   tx->fdma.channel_id);
+	lan966x_fdma_llp_configure(lan966x,
+				   rx->fdma.atu_region->base_addr,
+				   rx->fdma.channel_id);
+}
+
+/* Drain in-flight xmit callers and stop all TX queues on every port. */
+static void lan966x_fdma_pci_stop_netdev(struct lan966x *lan966x)
+{
+	for (int i = 0; i < lan966x->num_phys_ports; ++i) {
+		struct lan966x_port *port = lan966x->ports[i];
+
+		if (port)
+			netif_tx_disable(port->dev);
+	}
+}
+
+/* Wake all TX queues on every port (undoes lan966x_fdma_pci_stop_netdev). */
+static void lan966x_fdma_pci_wakeup_netdev(struct lan966x *lan966x)
+{
+	for (int i = 0; i < lan966x->num_phys_ports; ++i) {
+		struct lan966x_port *port = lan966x->ports[i];
+
+		if (port)
+			netif_tx_wake_all_queues(port->dev);
+	}
+}
+
+static int lan966x_fdma_pci_reload(struct lan966x *lan966x, int new_mtu)
+{
+	struct fdma tx_fdma_old = lan966x->tx.fdma;
+	struct fdma rx_fdma_old = lan966x->rx.fdma;
+	u32 old_mtu = lan966x->rx.max_mtu;
+	int err;
+
+	napi_synchronize(&lan966x->napi);
+	napi_disable(&lan966x->napi);
+	lan966x_fdma_pci_stop_netdev(lan966x);
+	lan966x_fdma_rx_disable(&lan966x->rx);
+	lan966x_fdma_tx_disable(&lan966x->tx);
+
+	lan966x->rx.max_mtu = new_mtu;
+
+	lan966x->tx.fdma.db_size = FDMA_PCI_DB_SIZE(lan966x->rx.max_mtu);
+	lan966x->tx.fdma.size = fdma_get_size_contiguous(&lan966x->tx.fdma);
+	lan966x->rx.fdma.db_size = FDMA_PCI_DB_SIZE(lan966x->rx.max_mtu);
+	lan966x->rx.fdma.size = fdma_get_size_contiguous(&lan966x->rx.fdma);
+
+	err = lan966x_fdma_pci_rx_alloc(&lan966x->rx);
+	if (err)
+		goto restore;
+
+	err = lan966x_fdma_pci_tx_alloc(&lan966x->tx);
+	if (err) {
+		fdma_free_coherent_and_unmap(lan966x->dev, &lan966x->rx.fdma);
+		goto restore;
+	}
+
+	/* Free and unmap old memory. */
+	fdma_free_coherent_and_unmap(lan966x->dev, &rx_fdma_old);
+	fdma_free_coherent_and_unmap(lan966x->dev, &tx_fdma_old);
+
+	/* Keep this order: rx_start, wakeup_netdev, napi_enable. */
+	lan966x_fdma_rx_start(&lan966x->rx);
+	lan966x_fdma_pci_wakeup_netdev(lan966x);
+	napi_enable(&lan966x->napi);
+
+	return err;
+restore:
+
+	/* No new buffers are allocated at this point. Use the old buffers,
+	 * but reset them before starting the FDMA again.
+	 */
+
+	memcpy(&lan966x->tx.fdma, &tx_fdma_old, sizeof(struct fdma));
+	memcpy(&lan966x->rx.fdma, &rx_fdma_old, sizeof(struct fdma));
+
+	lan966x->rx.max_mtu = old_mtu;
+
+	lan966x_fdma_pci_reset_mem(lan966x);
+
+	/* Keep this order: rx_start, wakeup_netdev, napi_enable. */
+	lan966x_fdma_rx_start(&lan966x->rx);
+	lan966x_fdma_pci_wakeup_netdev(lan966x);
+	napi_enable(&lan966x->napi);
+
+	return err;
+}
+
+static int __lan966x_fdma_pci_reload(struct lan966x *lan966x, int max_mtu)
+{
+	int err;
+	u32 val;
+
+	/* Disable the CPU port. */
+	lan_rmw(QSYS_SW_PORT_MODE_PORT_ENA_SET(0),
+		QSYS_SW_PORT_MODE_PORT_ENA,
+		lan966x, QSYS_SW_PORT_MODE(CPU_PORT));
+
+	/* Flush the CPU queues. */
+	readx_poll_timeout(lan966x_qsys_sw_status,
+			   lan966x,
+			   val,
+			   !(QSYS_SW_STATUS_EQ_AVAIL_GET(val)),
+			   READL_SLEEP_US, READL_TIMEOUT_US);
+
+	/* Add a sleep in case there are frames between the queues and the CPU
+	 * port
+	 */
+	usleep_range(USEC_PER_MSEC, 2 * USEC_PER_MSEC);
+
+	err = lan966x_fdma_pci_reload(lan966x, max_mtu);
+
+	/* Enable back the CPU port. */
+	lan_rmw(QSYS_SW_PORT_MODE_PORT_ENA_SET(1),
+		QSYS_SW_PORT_MODE_PORT_ENA,
+		lan966x, QSYS_SW_PORT_MODE(CPU_PORT));
+
+	return err;
+}
+
 static int lan966x_fdma_pci_resize(struct lan966x *lan966x)
 {
-	return -EOPNOTSUPP;
+	int max_mtu;
+
+	max_mtu = lan966x_fdma_get_max_frame(lan966x);
+	if (max_mtu == lan966x->rx.max_mtu)
+		return 0;
+
+	return __lan966x_fdma_pci_reload(lan966x, max_mtu);
 }
 
 static void lan966x_fdma_pci_deinit(struct lan966x *lan966x)

-- 
2.34.1


