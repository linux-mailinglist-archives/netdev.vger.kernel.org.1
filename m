Return-Path: <netdev+bounces-98966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180668D3456
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 12:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295311C20D77
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506F115B138;
	Wed, 29 May 2024 10:17:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A03E16EC04
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 10:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716977865; cv=none; b=dahCqinxeSm/85hJFu/j7lg2IBE9gIDZM9qzyq6HaMugmIKwS9bP81CTNBu/NI98RI1vEsXRF/J/MCGUIOB376VdXmIDnGyreDoPVmTNvBdT+6t+360bgC+X7gLqFecvsb5CDZNeQk/K8z/E1oHX69Y+z7upqmLibYnNz/0daqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716977865; c=relaxed/simple;
	bh=FeB5vfMA90Z8lPQDs5S/2MS1P56oSGvmcUFd+J689kQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tbk+2YWDvPWQiGn8OFSqg3fjwILltleUKoLwi7vwe8TsENwRQcR4HJIBBvdnsj23KqG1AmzMGY5pLL7w9igzWuRdRM7V882ROqbppylVAMHamYXZOBSY9NhY6/2C+Hi5rJb8b8+b+mP0sulslM+FmkVCm+o/2E+5B1rEKmccDoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.247])
	by gateway (Coremail) with SMTP id _____8Bxb+vDAFdmjhgBAA--.4958S3;
	Wed, 29 May 2024 18:17:39 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.247])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxVcW+AFdmQN4MAA--.22938S2;
	Wed, 29 May 2024 18:17:35 +0800 (CST)
From: Yanteng Si <siyanteng@loongson.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	fancer.lancer@gmail.com
Cc: Yanteng Si <siyanteng@loongson.cn>,
	Jose.Abreu@synopsys.com,
	chenhuacai@kernel.org,
	linux@armlinux.org.uk,
	guyinggang@loongson.cn,
	netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com,
	si.yanteng@linux.dev
Subject: [PATCH net-next v13 00/15] stmmac: Add Loongson platform support
Date: Wed, 29 May 2024 18:17:22 +0800
Message-Id: <cover.1716973237.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxVcW+AFdmQN4MAA--.22938S2
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Aw4DKw15JFW3WrykWrWkKrX_yoWDXry7pF
	W3CFy3Gr4Dtr4fCan5Zw4UXry5ArWYy3y8Wa1xK34fCa98Cw1jqryF9ayFvry7ZrZ5ZF12
	qr409r1kCF4DC3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU4SoGDUUUU

v13:

* Sorry, we have clarified some things in the past 10 days. I did not
 give you a clear reply to the following questions in v12, so I need
 to reply again:

 1. The current LS2K2000 also have a GMAC(and two GNET) that supports 8
    channels, so we have to reconsider the initialization of
    tx/rx_queues_to_use into probe();

 2. In v12, we disagreed on the loongson_dwmac_msi_config method, but I changed
    it based on Serge's comments(If I understand correctly):
	if (dev_of_node(&pdev->dev)) {
		ret = loongson_dwmac_dt_config(pdev, plat, &res);
	}

	if (ld->loongson_id == DWMAC_CORE_LS2K2000) {
		ret = loongson_dwmac_msi_config(pdev, plat, &res);
	} else {
		ret = loongson_dwmac_intx_config(pdev, plat, &res);
	}

 3. Our priv->dma_cap.pcs is false, so let's use PHY_INTERFACE_MODE_NA;

 4. Our GMAC does not support Delay, so let's use PHY_INTERFACE_MODE_RGMII_ID,
    the current dts is wrong, a fix patch will be sent to the LoongArch list
    later.

Others:
* Re-split a part of the patch (it seems we do this with every version);
* Copied Serge's comments into the commit message of patch;
* Fixed the stmmac_dma_operation_mode() method;
* Changed some code comments.

v12:
* The biggest change is the re-splitting of patches.
* Add a "gmac_version" in loongson_data, then we only
  read it once in the _probe().
* Drop Serge's patch.
* Rebase to the latest code state.
* Fixed the gnet commit message.

v11:
* Break loongson_phylink_get_caps(), fix bad logic.
* Remove a unnecessary ";".
* Remove some unnecessary "{}".
* add a blank.
* Move the code of fix _force_1000 to patch 6/6.

The main changes occur in these two functions:
loongson_dwmac_probe();
loongson_dwmac_setup();

v10:
As Andrew's comment:
* Add a #define for the 0x37.
* Add a #define for Port Select.

others:
* Pick Serge's patch, This patch resulted from the process
  of reviewing our patch set.
* Based on Serge's patch, modify our loongson_phylink_get_caps().
* Drop patch 3/6, we need mac_interface.
* Adjusted the code layout of gnet patch.
* Corrected several errata in commit message.
* Move DISABLE_FORCE flag to loongson_gnet_data().

v9:
We have not provided a detailed list of equipment for a long time,
and I apologize for this. During this period, I have collected some
information and now present it to you, hoping to alleviate the pressure
of review.

1. IP core
We now have two types of IP cores, one is 0x37, similar to dwmac1000;
The other is 0x10.  Compared to 0x37, we split several DMA registers
from one to two, and it is not worth adding a new entry for this.
According to Serge's comment, we made these devices work by overwriting
priv->synopsys_id = 0x37 and mac->dma = <LS_dma_ops>.

1.1.  Some more detailed information
The number of DMA channels for 0x37 is 1; The number of DMA channels
for 0x10 is 8.  Except for channel 0, otherchannels do not support
sending hardware checksums. Supported AV features are Qav, Qat, and Qas,
and the rest are consistent with 3.73.

2. DEVICE
We have two types of devices,
one is GMAC, which only has a MAC chip inside and needs an external PHY
chip;
the other is GNET, which integrates both MAC and PHY chips inside.

2.1.  Some more detailed information
GMAC device: LS7A1000, LS2K1000, these devices do not support any pause
mode.
gnet device: LS7A2000, LS2K2000, the chip connection between the mac and
             phy of these devices is not normal and requires two rounds of
             negotiation; LS7A2000 does not support half-duplex and
multi-channel;
             to enable multi-channel on LS2K2000, you need to turn off
hardware checksum.
**Note**: Only the LS2K2000's IP core is 0x10, while the IP cores of other
devices are 0x37.

3. TABLE

device    type    pci_id    ip_core
ls7a1000  gmac    7a03      0x35/0x37
ls2k1000  gmac    7a03      0x35/0x37
ls7a2000  gnet    7a13      0x37
ls2k2000  gnet    7a13      0x10
-----------------------------------------------
Changes:

* passed the CI
  <https://github.com/linux-netdev/nipa/blob/main/tests/patch/checkpatch
  /checkpatch.sh>
* reverse xmas tree order.
* Silence build warning.
* Re-split the patch.
* Add more detailed commit message.
* Add more code comment.
* Reduce modification of generic code.
* using the GNET-specific prefix.
* define a new macro for the GNET MAC.
* Use an easier way to overwrite mac.
* Removed some useless printk.


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

Yanteng Si (15):
  net: stmmac: Move the atds flag to the stmmac_dma_cfg structure
  net: stmmac: Add multi-channel support
  net: stmmac: Export dwmac1000_dma_ops
  net: stmmac: dwmac-loongson: Drop duplicated hash-based filter size
    init
  net: stmmac: dwmac-loongson: Use PCI_DEVICE_DATA() macro for device
    identification
  net: stmmac: dwmac-loongson: Detach GMAC-specific platform data init
  net: stmmac: dwmac-loongson: Init ref and PTP clocks rate
  net: stmmac: dwmac-loongson: Add phy_interface for Loongson GMAC
  net: stmmac: dwmac-loongson: Introduce PCI device info data
  net: stmmac: dwmac-loongson: Add DT-less GMAC PCI-device support
  net: stmmac: dwmac-loongson: Add loongson_dwmac_dt_config
  net: stmmac: Fixed failure to set network speed to 1000.
  net: stmmac: dwmac-loongson: Drop pci_enable/disable_msi temporarily
  net: stmmac: dwmac-loongson: Add Loongson GNET support
  net: stmmac: dwmac-loongson: Add loongson module author

 drivers/net/ethernet/stmicro/stmmac/common.h  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 534 ++++++++++++++++--
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |   4 +-
 .../ethernet/stmicro/stmmac/dwmac1000_dma.c   |  35 +-
 .../ethernet/stmicro/stmmac/dwmac100_dma.c    |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac_dma.h   |  20 +-
 .../net/ethernet/stmicro/stmmac/dwmac_lib.c   |  30 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |   2 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |   5 +-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |   6 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  19 +-
 include/linux/stmmac.h                        |   2 +
 13 files changed, 552 insertions(+), 110 deletions(-)

-- 
2.31.4


