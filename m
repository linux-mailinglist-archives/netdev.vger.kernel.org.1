Return-Path: <netdev+bounces-283864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJToMeys+Gn2xgIAu9opvQ
	(envelope-from <netdev+bounces-283864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:27:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 434F84BF7DB
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF837308D262
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 14:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E253DEFFE;
	Mon,  4 May 2026 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0Yeg5kUr"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CE93DE45C;
	Mon,  4 May 2026 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904635; cv=none; b=UNFwTsY16nsYEBDFi0lYR316ArN9U82LvJEVFyE+t2gcb92r03owQegghtsXs1zkP0Ik0M9vlKiA5WH90F5zrhjNCsXw4WuGDSHkIkm44daTg1LlHypdb8MelYt6efAi+Jn4rAS/aat0GZwynTr8N+CDcEWNL4eLiFRLixx9Jxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904635; c=relaxed/simple;
	bh=hbSCgbZ3earEZLwKYCheg6AqjRDey4G5iRQfhuiZmME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=otpkZspsPGnyfPAlNMCOCmX52hl979umm73xEuhwmcGXveSopvSZLumSLcZ4pCWJw1yQBncwWuYdPqpiC8b1nH/JOFd2kzXLNmYP4jEZWE0HGkt4lrCI08eMSHT5u0SN8RTHlTCwnoKoY5RqEkZQj8K7inN7M5mt0UIc7NfqgGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0Yeg5kUr; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1777904634; x=1809440634;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=hbSCgbZ3earEZLwKYCheg6AqjRDey4G5iRQfhuiZmME=;
  b=0Yeg5kUr+CjPAkxt7HEir3YZ552ZKBimujvnTvZoMS35s594B/Lr5khc
   7xmSmxcwm2FoMbGRg5EikNHeFNzhBB3prP+i52H0v7woo7yuNd9TbmtBF
   IfWldV0FGJguurudWRHHH1NT7fM4mTcaoNSB40pJCVN4L0iM2/6wSLhKE
   iueg/ya6P8uqywymJwVVdcIjugM8hgEOmoirXjUMMko09JsYQDqkMpyZo
   VdmYYmtC85w3KfNmn9ybMq1n2OWETH1Y+5zh1C6SfAGYLA9NJV3GDfPFz
   9NzNQYhKNlCN4jWiQwqOUoGI5QIG+K9qc06U2Zfv1pPc9+jY5WeFOhS5N
   g==;
X-CSE-ConnectionGUID: 2SKBzV8GRRKToTJSKwV8PQ==
X-CSE-MsgGUID: +K97mOAOSFCxhROcREJ9eg==
X-IronPort-AV: E=Sophos;i="6.23,215,1770620400"; 
   d="scan'208";a="288370126"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 07:23:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Mon, 4 May 2026 07:23:46 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 4 May 2026 07:23:43 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 4 May 2026 16:23:16 +0200
Subject: [PATCH net-next v3 03/13] net: microchip: fdma: add PCIe ATU
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260504-lan966x-pci-fdma-v3-3-a56f5740d870@microchip.com>
References: <20260504-lan966x-pci-fdma-v3-0-a56f5740d870@microchip.com>
In-Reply-To: <20260504-lan966x-pci-fdma-v3-0-a56f5740d870@microchip.com>
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
X-Rspamd-Queue-Id: 434F84BF7DB
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
	TAGGED_FROM(0.00)[bounces-283864-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,iogearbox.net,gmail.com,fomichev.me,bootlin.com,arndb.de,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,microchip.com:dkim,microchip.com:mid,bootlin.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

When lan966x or lan969x operates as a PCIe endpoint, the internal FDMA
engine cannot directly access host memory. Instead, DMA addresses must
be translated through the PCIe Address Translation Unit (ATU). The ATU
provides outbound windows that map internal addresses to PCIe bus
addresses.

The ATU outbound address space (0x10000000-0x1fffffff) is divided into
six equally-sized regions (~42MB each). When FDMA buffers are allocated,
a free ATU region is claimed and programmed with the DMA target address.
The FDMA engine then uses the region's base address in its descriptors,
and the ATU translates these to the actual DMA addresses on the PCIe bus.

Add the required functions and helpers that combine the DMA allocation
with the ATU region mapping, effectively adding support for PCIe FDMA.

This implementation will also be used by the lan969x, when PCIe FDMA is
added for that platform in the future.

Tested-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/fdma/Makefile   |   4 +
 drivers/net/ethernet/microchip/fdma/fdma_api.c |  33 +++++
 drivers/net/ethernet/microchip/fdma/fdma_api.h |  16 +++
 drivers/net/ethernet/microchip/fdma/fdma_pci.c | 182 +++++++++++++++++++++++++
 drivers/net/ethernet/microchip/fdma/fdma_pci.h |  42 ++++++
 5 files changed, 277 insertions(+)

diff --git a/drivers/net/ethernet/microchip/fdma/Makefile b/drivers/net/ethernet/microchip/fdma/Makefile
index cc9a736be357..eed4df6f7158 100644
--- a/drivers/net/ethernet/microchip/fdma/Makefile
+++ b/drivers/net/ethernet/microchip/fdma/Makefile
@@ -5,3 +5,7 @@
 
 obj-$(CONFIG_FDMA) += fdma.o
 fdma-y += fdma_api.o
+
+ifdef CONFIG_MCHP_LAN966X_PCI
+fdma-y += fdma_pci.o
+endif
diff --git a/drivers/net/ethernet/microchip/fdma/fdma_api.c b/drivers/net/ethernet/microchip/fdma/fdma_api.c
index e78c3590da9e..e0c2b137afef 100644
--- a/drivers/net/ethernet/microchip/fdma/fdma_api.c
+++ b/drivers/net/ethernet/microchip/fdma/fdma_api.c
@@ -127,6 +127,39 @@ void fdma_free_phys(struct fdma *fdma)
 }
 EXPORT_SYMBOL_GPL(fdma_free_phys);
 
+#if IS_ENABLED(CONFIG_MCHP_LAN966X_PCI)
+/* Allocate coherent DMA memory and map it in the ATU. */
+int fdma_alloc_coherent_and_map(struct device *dev, struct fdma *fdma,
+				struct fdma_pci_atu *atu)
+{
+	struct fdma_pci_atu_region *region;
+	int err;
+
+	err = fdma_alloc_coherent(dev, fdma);
+	if (err)
+		return err;
+
+	region = fdma_pci_atu_region_map(atu, fdma->dma, fdma->size);
+	if (IS_ERR(region)) {
+		fdma_free_coherent(dev, fdma);
+		return PTR_ERR(region);
+	}
+
+	fdma->atu_region = region;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fdma_alloc_coherent_and_map);
+
+/* Free coherent DMA memory and unmap the memory in the ATU. */
+void fdma_free_coherent_and_unmap(struct device *dev, struct fdma *fdma)
+{
+	fdma_pci_atu_region_unmap(fdma->atu_region);
+	fdma_free_coherent(dev, fdma);
+}
+EXPORT_SYMBOL_GPL(fdma_free_coherent_and_unmap);
+#endif
+
 /* Get the size of the FDMA memory */
 u32 fdma_get_size(struct fdma *fdma)
 {
diff --git a/drivers/net/ethernet/microchip/fdma/fdma_api.h b/drivers/net/ethernet/microchip/fdma/fdma_api.h
index 94f1a6596097..0e0f8af7463f 100644
--- a/drivers/net/ethernet/microchip/fdma/fdma_api.h
+++ b/drivers/net/ethernet/microchip/fdma/fdma_api.h
@@ -7,6 +7,10 @@
 #include <linux/etherdevice.h>
 #include <linux/types.h>
 
+#if IS_ENABLED(CONFIG_MCHP_LAN966X_PCI)
+#include "fdma_pci.h"
+#endif
+
 /* This provides a common set of functions and data structures for interacting
  * with the Frame DMA engine on multiple Microchip switchcores.
  *
@@ -109,6 +113,11 @@ struct fdma {
 	u32 channel_id;
 
 	struct fdma_ops ops;
+
+#if IS_ENABLED(CONFIG_MCHP_LAN966X_PCI)
+	/* PCI ATU region for this FDMA instance. */
+	struct fdma_pci_atu_region *atu_region;
+#endif
 };
 
 /* Advance the DCB index and wrap if required. */
@@ -234,9 +243,16 @@ int __fdma_dcb_add(struct fdma *fdma, int dcb_idx, u64 info, u64 status,
 
 int fdma_alloc_coherent(struct device *dev, struct fdma *fdma);
 int fdma_alloc_phys(struct fdma *fdma);
+#if IS_ENABLED(CONFIG_MCHP_LAN966X_PCI)
+int fdma_alloc_coherent_and_map(struct device *dev, struct fdma *fdma,
+				struct fdma_pci_atu *atu);
+#endif
 
 void fdma_free_coherent(struct device *dev, struct fdma *fdma);
 void fdma_free_phys(struct fdma *fdma);
+#if IS_ENABLED(CONFIG_MCHP_LAN966X_PCI)
+void fdma_free_coherent_and_unmap(struct device *dev, struct fdma *fdma);
+#endif
 
 u32 fdma_get_size(struct fdma *fdma);
 u32 fdma_get_size_contiguous(struct fdma *fdma);
diff --git a/drivers/net/ethernet/microchip/fdma/fdma_pci.c b/drivers/net/ethernet/microchip/fdma/fdma_pci.c
new file mode 100644
index 000000000000..1bd41eaa58a4
--- /dev/null
+++ b/drivers/net/ethernet/microchip/fdma/fdma_pci.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+#include "fdma_pci.h"
+
+/* When the switch operates as a PCIe endpoint, the FDMA engine needs to
+ * DMA to/from host memory. The FDMA writes to addresses within the endpoint's
+ * internal Outbound (OB) address space, and the PCIe ATU translates these to
+ * DMA addresses on the PCIe bus, targeting host memory.
+ *
+ * The ATU supports up to six outbound regions. This implementation divides
+ * the OB address space into six equally sized chunks.
+ *
+ * +-------------+------------+------------+-----+------------+
+ * | Index       | Region 0   | Region 1   | ... | Region 5   |
+ * +-------------+------------+------------+-----+------------+
+ * | Base addr   | 0x10000000 | 0x12aa0000 | ... | 0x1d500000 |
+ * | Limit addr  | 0x12a9ffff | 0x1553ffff | ... | 0x1ff9ffff |
+ * | Target addr | host dma   | host dma   | ... | host dma   |
+ * +-------------+------------+------------+-----+------------+
+ *
+ * Base addr is the start address of the region within the OB address space.
+ * Limit addr is the end address of the region within the OB address space.
+ * Target addr is the host DMA address that the base addr translates to.
+ */
+
+#define FDMA_PCI_ATU_REGION_ALIGN    BIT(16) /* 64KB */
+#define FDMA_PCI_ATU_OB_START        0x10000000
+#define FDMA_PCI_ATU_OB_END          0x1fffffff
+
+#define FDMA_PCI_ATU_ADDR            0x300000
+#define FDMA_PCI_ATU_IDX_SIZE        0x200
+#define FDMA_PCI_ATU_ENA_REG         0x4
+#define FDMA_PCI_ATU_ENA_BIT         BIT(31)
+#define FDMA_PCI_ATU_LWR_BASE_ADDR   0x8
+#define FDMA_PCI_ATU_UPP_BASE_ADDR   0xc
+#define FDMA_PCI_ATU_LIMIT_ADDR      0x10
+#define FDMA_PCI_ATU_LWR_TARGET_ADDR 0x14
+#define FDMA_PCI_ATU_UPP_TARGET_ADDR 0x18
+
+static u32 fdma_pci_atu_region_size(void)
+{
+	return round_down((FDMA_PCI_ATU_OB_END - FDMA_PCI_ATU_OB_START) /
+			  FDMA_PCI_ATU_REGION_MAX, FDMA_PCI_ATU_REGION_ALIGN);
+}
+
+static void __iomem *fdma_pci_atu_addr_get(void __iomem *addr, int offset,
+					   int idx)
+{
+	return addr + FDMA_PCI_ATU_ADDR + FDMA_PCI_ATU_IDX_SIZE * idx + offset;
+}
+
+static void fdma_pci_atu_region_enable(struct fdma_pci_atu_region *region)
+{
+	writel(FDMA_PCI_ATU_ENA_BIT,
+	       fdma_pci_atu_addr_get(region->atu->addr, FDMA_PCI_ATU_ENA_REG,
+				     region->idx));
+}
+
+static void fdma_pci_atu_region_disable(struct fdma_pci_atu_region *region)
+{
+	writel(0, fdma_pci_atu_addr_get(region->atu->addr, FDMA_PCI_ATU_ENA_REG,
+					region->idx));
+}
+
+/* Configure the address translation in the ATU. */
+static void
+fdma_pci_atu_configure_translation(struct fdma_pci_atu_region *region)
+{
+	struct fdma_pci_atu *atu = region->atu;
+	int idx = region->idx;
+
+	writel(lower_32_bits(region->base_addr),
+	       fdma_pci_atu_addr_get(atu->addr,
+				     FDMA_PCI_ATU_LWR_BASE_ADDR, idx));
+
+	writel(upper_32_bits(region->base_addr),
+	       fdma_pci_atu_addr_get(atu->addr,
+				     FDMA_PCI_ATU_UPP_BASE_ADDR, idx));
+
+	/* Upper limit register only needed with REGION_SIZE > 4GB. */
+	writel(region->limit_addr,
+	       fdma_pci_atu_addr_get(atu->addr, FDMA_PCI_ATU_LIMIT_ADDR, idx));
+
+	writel(lower_32_bits(region->target_addr),
+	       fdma_pci_atu_addr_get(atu->addr,
+				     FDMA_PCI_ATU_LWR_TARGET_ADDR, idx));
+
+	writel(upper_32_bits(region->target_addr),
+	       fdma_pci_atu_addr_get(atu->addr,
+				     FDMA_PCI_ATU_UPP_TARGET_ADDR, idx));
+}
+
+/* Find an unused ATU region. */
+static struct fdma_pci_atu_region *
+fdma_pci_atu_region_get_free(struct fdma_pci_atu *atu)
+{
+	struct fdma_pci_atu_region *regions = atu->regions;
+
+	for (int i = 0; i < FDMA_PCI_ATU_REGION_MAX; i++) {
+		if (regions[i].in_use)
+			continue;
+
+		return &regions[i];
+	}
+
+	return ERR_PTR(-ENOSPC);
+}
+
+/* Unmap an ATU region, clearing its translation and disabling it. */
+void fdma_pci_atu_region_unmap(struct fdma_pci_atu_region *region)
+{
+	if (IS_ERR_OR_NULL(region))
+		return;
+
+	region->target_addr = 0;
+	region->in_use = false;
+
+	fdma_pci_atu_region_disable(region);
+	fdma_pci_atu_configure_translation(region);
+}
+EXPORT_SYMBOL_GPL(fdma_pci_atu_region_unmap);
+
+/* Map a host DMA address into a free outbound region. */
+struct fdma_pci_atu_region *
+fdma_pci_atu_region_map(struct fdma_pci_atu *atu, u64 target_addr, int size)
+{
+	struct fdma_pci_atu_region *region;
+
+	if (!atu)
+		return ERR_PTR(-EINVAL);
+
+	if (size <= 0)
+		return ERR_PTR(-EINVAL);
+
+	if (size > fdma_pci_atu_region_size())
+		return ERR_PTR(-E2BIG);
+
+	region = fdma_pci_atu_region_get_free(atu);
+	if (IS_ERR(region))
+		return region;
+
+	region->target_addr = target_addr;
+	region->in_use = true;
+
+	/* Enable first, according to datasheet section 3.24.7.4.1 */
+	fdma_pci_atu_region_enable(region);
+	fdma_pci_atu_configure_translation(region);
+
+	return region;
+}
+EXPORT_SYMBOL_GPL(fdma_pci_atu_region_map);
+
+/* Translate a host DMA address to the corresponding OB address. */
+u64 fdma_pci_atu_translate_addr(struct fdma_pci_atu_region *region, u64 addr)
+{
+	return region->base_addr + (addr - region->target_addr);
+}
+EXPORT_SYMBOL_GPL(fdma_pci_atu_translate_addr);
+
+/* Initialize ATU, dividing the OB space into equally sized regions. */
+void fdma_pci_atu_init(struct fdma_pci_atu *atu, void __iomem *addr)
+{
+	struct fdma_pci_atu_region *regions = atu->regions;
+	u32 region_size = fdma_pci_atu_region_size();
+
+	atu->addr = addr;
+
+	for (int i = 0; i < FDMA_PCI_ATU_REGION_MAX; i++) {
+		regions[i].base_addr =
+			FDMA_PCI_ATU_OB_START + (i * region_size);
+		regions[i].limit_addr =
+			regions[i].base_addr + region_size - 1;
+		regions[i].idx = i;
+		regions[i].atu = atu;
+	}
+}
+EXPORT_SYMBOL_GPL(fdma_pci_atu_init);
diff --git a/drivers/net/ethernet/microchip/fdma/fdma_pci.h b/drivers/net/ethernet/microchip/fdma/fdma_pci.h
new file mode 100644
index 000000000000..eccfe5dc25e7
--- /dev/null
+++ b/drivers/net/ethernet/microchip/fdma/fdma_pci.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _FDMA_PCI_H_
+#define _FDMA_PCI_H_
+
+#include <linux/types.h>
+
+#define FDMA_PCI_ATU_REGION_MAX 6
+#define FDMA_PCI_DB_ALIGN 128
+#define FDMA_PCI_DB_SIZE(mtu) ALIGN(mtu, FDMA_PCI_DB_ALIGN)
+
+struct fdma_pci_atu;
+
+struct fdma_pci_atu_region {
+	struct fdma_pci_atu *atu;
+	u64 base_addr; /* Base addr of the OB window */
+	u64 limit_addr; /* Limit addr of the OB window */
+	u64 target_addr; /* Host DMA address this region maps to */
+	int idx;
+	bool in_use;
+};
+
+struct fdma_pci_atu {
+	void __iomem *addr;
+	struct fdma_pci_atu_region regions[FDMA_PCI_ATU_REGION_MAX];
+};
+
+/* Initialize ATU, dividing OB space into regions. */
+void fdma_pci_atu_init(struct fdma_pci_atu *atu, void __iomem *addr);
+
+/* Unmap an ATU region, clearing its translation and disabling it. */
+void fdma_pci_atu_region_unmap(struct fdma_pci_atu_region *region);
+
+/* Map a host DMA address into a free ATU region. */
+struct fdma_pci_atu_region *fdma_pci_atu_region_map(struct fdma_pci_atu *atu,
+						    u64 target_addr,
+						    int size);
+
+/* Translate a host DMA address to the OB address space. */
+u64 fdma_pci_atu_translate_addr(struct fdma_pci_atu_region *region, u64 addr);
+
+#endif

-- 
2.34.1


