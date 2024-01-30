Return-Path: <netdev+bounces-67024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF432841E33
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 09:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48CAD1F2D63E
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 08:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDB759150;
	Tue, 30 Jan 2024 08:43:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB70D5914E
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 08:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604231; cv=none; b=pJVbmse1vYe+bWiwiiTlIO+6NZ7rIX18R08V6wvkFlgkNTDK2BvMyA19Zk0xNQZPLKsdkrvnUlkujPvbVxNKpUvRtyi6FXRfEesxJvMo4g1GejIFbUX+lE9zqFT2w+eA4NEjd4PgI8mqOm/jlNJRg7jUmXlybyZm/k7jnTbz8Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604231; c=relaxed/simple;
	bh=e47rzHCjnuGN2Y5ILV00Dwy8Cxh+z96ASqeJe0TLs5A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BMAhyEUy3YvPvAFlNfuz4RrWFoUBEFWWnIsRfefKagjRPifDLIUUutcONA0gqFrLutKVA9tZAHoAXGUgwNf7EbsPMXohpvxPqs/BEoo6eb2nJoWwhgPb26RYMdDDniUb/ameIOUb/3Anand2VrOG65L9hgLSUKSxDw5JmaO5x0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.150])
	by gateway (Coremail) with SMTP id _____8DxqejCtrhlr0MIAA--.6028S3;
	Tue, 30 Jan 2024 16:43:46 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.150])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxZMy+trhltK4nAA--.30345S2;
	Tue, 30 Jan 2024 16:43:43 +0800 (CST)
From: Yanteng Si <siyanteng@loongson.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	fancer.lancer@gmail.com
Cc: Yanteng Si <siyanteng@loongson.cn>,
	Jose.Abreu@synopsys.com,
	chenhuacai@loongson.cn,
	linux@armlinux.org.uk,
	guyinggang@loongson.cn,
	netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com
Subject: [PATCH net-next v8 00/11] stmmac: Add Loongson platform support
Date: Tue, 30 Jan 2024 16:43:20 +0800
Message-Id: <cover.1706601050.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxZMy+trhltK4nAA--.30345S2
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Ar1rZF4fCr4UZrykXw45CFX_yoW7XF4rpF
	W3Ca45Cr4ktr4fAan3Aw1UZry5ZryYyrW7Wan7KwnIka9xWw1jvrySgayYqF17ZrWDZF1I
	qr4F9w1DWF1qk3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU

v8:
* The biggest change is according to Serge's comment in the previous
  edition:
   Seeing the patch in the current state would overcomplicate the generic
   code and the only functions you need to update are
   dwmac_dma_interrupt()
   dwmac1000_dma_init_channel()
   you can have these methods re-defined with all the Loongson GNET
   specifics in the low-level platform driver (dwmac-loongson.c). After
   that you can just override the mac_device_info.dma pointer with a
   fixed stmmac_dma_ops descriptor. Here is what should be done for that:

   1. Keep the Patch 4/9 with my comments fixed. First it will be partly
   useful for your GNET device. Second in general it's a correct
   implementation of the normal DW GMAC v3.x multi-channels feature and
   will be useful for the DW GMACs with that feature enabled.

   2. Create the Loongson GNET-specific
   stmmac_dma_ops.dma_interrupt()
   stmmac_dma_ops.init_chan()
   methods in the dwmac-loongson.c driver. Don't forget to move all the
   Loongson-specific macros from dwmac_dma.h to dwmac-loongson.c.

   3. Create a Loongson GNET-specific platform setup method with the next
   semantics:
      + allocate stmmac_dma_ops instance and initialize it with
        dwmac1000_dma_ops.
      + override the stmmac_dma_ops.{dma_interrupt, init_chan} with
        the pointers to the methods defined in 2.
      + allocate mac_device_info instance and initialize the
        mac_device_info.dma field with a pointer to the new
        stmmac_dma_ops instance.
      + call dwmac1000_setup() or initialize mac_device_info in a way
        it's done in dwmac1000_setup() (the later might be better so you
        wouldn't need to export the dwmac1000_setup() function).
      + override stmmac_priv.synopsys_id with a correct value.

   4. Initialize plat_stmmacenet_data.setup() with the pointer to the
   method created in 3.

* Others:
  Re-split the patch.
  Passed checkpatch.pl test.

v7:
* Refer to andrew's suggestion:
  - Add DMA_INTR_ENA_NIE_RX and DMA_INTR_ENA_NIE_TX #define's, etc.

* Others:
  - Using --subject-prefix="PATCH net-next vN" to indicate that the
    patches are for the networking tree.
  - Rebase to the latest networking tree:
    <git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git>


v6:

* Refer to Serge's suggestion:
  - Add new platform feature flag:
    include/linux/stmmac.h:
    +#define STMMAC_FLAG_HAS_LGMAC			BIT(13)

  - Add the IRQs macros specific to the Loongson Multi-channels GMAC:
     drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h:
     +#define DMA_INTR_ENA_NIE_LOONGSON 0x00060000      /* ...*/
     #define DMA_INTR_ENA_NIE 0x00010000	/* Normal Summary */
     ...

  - Drop all of redundant changes that don't require the
    prototypes being converted to accepting the stmmac_priv
    pointer.

* Refer to andrew's suggestion:
  - Drop white space changes.
  - break patch up into lots of smaller parts.
     Some small patches have been put into another series as a preparation
     see <https://lore.kernel.org/loongarch/cover.1702289232.git.siyanteng@loongson.cn/T/#t>
     
     *note* : This series of patches relies on the three small patches above.
* others
  - Drop irq_flags changes.
  - Changed patch order.


v4 -> v5:

* Remove an ugly and useless patch (fix channel number).
* Remove the non-standard dma64 driver code, and also remove
  the HWIF entries, since the associated custom callbacks no
  longer exist.
* Refer to Serge's suggestion: Update the dwmac1000_dma.c to
  support the multi-DMA-channels controller setup.

See:
v4: <https://lore.kernel.org/loongarch/cover.1692696115.git.chenfeiyang@loongson.cn/>
v3: <https://lore.kernel.org/loongarch/cover.1691047285.git.chenfeiyang@loongson.cn/>
v2: <https://lore.kernel.org/loongarch/cover.1690439335.git.chenfeiyang@loongson.cn/>
v1: <https://lore.kernel.org/loongarch/cover.1689215889.git.chenfeiyang@loongson.cn/>


Yanteng Si (11):
  net: stmmac: Add multi-channel support
  net: stmmac: dwmac-loongson: Refactor code for loongson_dwmac_probe()
  net: stmmac: dwmac-loongson: Add full PCI support
  net: stmmac: dwmac-loongson: Move irq config to loongson_gmac_config
  net: stmmac: dwmac-loongson: Add Loongson-specific register
    definitions
  net: stmmac: dwmac-loongson: Add GNET support
  net: stmmac: dwmac-loongson: Add multi-channel supports for loongson
  net: stmmac: dwmac-loongson: Fix MAC speed for GNET
  net: stmmac: dwmac-loongson: Fix half duplex
  net: stmmac: dwmac-loongson: Disable flow control for GMAC
  net: stmmac: dwmac-loongson: Disable coe for some Loongson GNET

 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 561 ++++++++++++++++--
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |   2 +-
 .../ethernet/stmicro/stmmac/dwmac1000_dma.c   |  36 +-
 .../net/ethernet/stmicro/stmmac/dwmac_dma.h   |  19 +-
 .../net/ethernet/stmicro/stmmac/dwmac_lib.c   |  32 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |   2 +-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |   6 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  15 +-
 include/linux/stmmac.h                        |   3 +
 9 files changed, 582 insertions(+), 94 deletions(-)

-- 
2.31.4


