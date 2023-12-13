Return-Path: <netdev+bounces-56799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF42810DF5
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 11:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06DEB1C209BD
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 10:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FB3224F8;
	Wed, 13 Dec 2023 10:12:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5708E83
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 02:12:41 -0800 (PST)
Received: from loongson.cn (unknown [112.20.109.254])
	by gateway (Coremail) with SMTP id _____8DxS+mXg3llFaEAAA--.3895S3;
	Wed, 13 Dec 2023 18:12:39 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.254])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxguOPg3llXjMCAA--.15020S2;
	Wed, 13 Dec 2023 18:12:32 +0800 (CST)
From: Yanteng Si <siyanteng@loongson.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com
Cc: Yanteng Si <siyanteng@loongson.cn>,
	fancer.lancer@gmail.com,
	Jose.Abreu@synopsys.com,
	chenhuacai@loongson.cn,
	linux@armlinux.org.uk,
	guyinggang@loongson.cn,
	netdev@vger.kernel.org,
	loongarch@lists.linux.dev,
	chris.chenfeiyang@gmail.com
Subject: [PATCH v6 0/9] stmmac: Add Loongson platform support
Date: Wed, 13 Dec 2023 18:12:22 +0800
Message-Id: <cover.1702458672.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxguOPg3llXjMCAA--.15020S2
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCF45Wr45Wr47CFWDJr1UArc_yoW5CF18pF
	W7Aa4YgrZ7tr1xA3Z5Jw1DXFy5Wayayr47Wa1Iqw1Ska9rKryjqrya9FWYvFy7ArZ8uFy2
	qr1UCr1DCF1qk3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
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

v6:

* Refer to Serge's suggestion:
  - Add new platform feature flag:
    include/linux/stmmac.h:
    +#define STMMAC_FLAG_HAS_LGMAC			BIT(13)

  - Add the IRQs macros specific to the Loongson Multi-channels GMAC:
     drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h:
     +#define DMA_INTR_ENA_NIE_LOONGSON 0x00060000	/* Normal Loongson Tx/Rx Summary */
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

Yanteng Si (9):
  net: stmmac: Pass stmmac_priv and chan in some callbacks
  net: stmmac: dwmac-loongson: Refactor code for loongson_dwmac_probe()
  net: stmmac: dwmac-loongson: Add full PCI support
  net: stmmac: Add multi-channel supports
  net: stmmac: Add Loongson-specific register definitions
  net: stmmac: dwmac-loongson: Add MSI support
  net: stmmac: dwmac-loongson: Add GNET support
  net: stmmac: dwmac-loongson: Disable flow control for GMAC
  net: stmmac: Disable coe for some Loongson GNET

 drivers/net/ethernet/stmicro/stmmac/common.h  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 296 ++++++++++++++----
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |   2 +-
 .../ethernet/stmicro/stmmac/dwmac1000_dma.c   |  61 +++-
 .../ethernet/stmicro/stmmac/dwmac100_dma.c    |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac_dma.h   |  47 ++-
 .../net/ethernet/stmicro/stmmac/dwmac_lib.c   |  65 ++--
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |   2 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |   8 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  11 +-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |   6 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  13 +-
 include/linux/stmmac.h                        |   4 +
 14 files changed, 413 insertions(+), 107 deletions(-)

-- 
2.31.4


