Return-Path: <netdev+bounces-116475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F2A94A8D6
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 15:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB98728729B
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 13:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AEC1EA0DC;
	Wed,  7 Aug 2024 13:46:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAF11EA0C3
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038368; cv=none; b=MRd121eLjev0ifoCiaFyZGW6sNEUubiUU6mzmaz/PgNGVS71Z9l/HDmepv/CMk0XObOlCZCm+l4D8F48ReoH4zfdssyV9tjFYIe5zPMDyNc+U5EtFaFY9dE+gEhZspCXqRHgcuWZxj+NzOHmUd3+Gqi7zbZjFRg+qiN9DhHFJFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038368; c=relaxed/simple;
	bh=uXWUVovSNKyzEgaxGgiSRlHiPM6sKgYto1c4mboUXS0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z0J2lrynjjCjb2akgtZSbLnTTLP51U+jM8vZb7qQhbxBzOKbs/zn9oxBYCw8lmGbbWjEWsMlTzggIa5k/gOJKf82KENtKuIA9+YdF/iea91AbylK49JXT5YkiqKHu5ADQDRDSZwg7S45XYi4Gl9FUeQl3QMMXaDUDZlJ1tyBLtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.71])
	by gateway (Coremail) with SMTP id _____8Cxe+qSerNmI3YKAA--.32708S3;
	Wed, 07 Aug 2024 21:45:54 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.71])
	by front1 (Coremail) with SMTP id qMiowMBxZOCFerNmgR0IAA--.41201S2;
	Wed, 07 Aug 2024 21:45:47 +0800 (CST)
From: Yanteng Si <siyanteng@loongson.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	fancer.lancer@gmail.com,
	diasyzhang@tencent.com
Cc: Yanteng Si <siyanteng@loongson.cn>,
	Jose.Abreu@synopsys.com,
	chenhuacai@kernel.org,
	linux@armlinux.org.uk,
	guyinggang@loongson.cn,
	netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com,
	si.yanteng@linux.dev
Subject: [PATCH net-next v17 00/14] stmmac: Add Loongson platform support
Date: Wed,  7 Aug 2024 21:45:27 +0800
Message-Id: <cover.1723014611.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxZOCFerNmgR0IAA--.41201S2
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9fXoW3tw43ur4fJw4rAr1UZr45twc_yoW8Gw1kZo
	WfuF4fZr4Yyw18uFs2gFyDJFy5XFy5X3Z5tFZ7Cw45AanavFWDJ3s8G393Xa45AFyFgFy3
	A34rG3y7trWxtF4rl-sFpf9Il3svdjkaLaAFLSUrUUUU5b8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYA7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8TCJPUUUUU==

v17:
* As Serge's comments:
    Add return 0 for _dt_config().
    Get back the conditional MSI-clear method execution.

v16:
* As Serge's comments:
   Move the of_node_put(plat->mdio_node) call to the DT-config/clear methods.
   Drop 'else if'.
* Modify the commit message of 7/14. (LS2K CPU -> LS2K SOC)

V15:
* Drop return that will not be executed.
* Move pdev from patch 12 to patch 13 to pass W=1 builds.

RFC v15:
* As Serge's comments:
   Extend the commit message.(patch 7 and patch 11)
   Add fixes tag for patch 8.
   Add loongson_dwmac_dt_clear() patch.
   Modify loongson_dwmac_msi_config().
   ...
* Pick Huacai's Acked-by tag.
* Pick Serge's Reviewed-by tag.
* I have already contacted the author(ZhangQing) of the module,
  so I copied her valid email: diasyzhang@tencent.com.

Note: 
I replied to the comments on v14 last Sunday, but all of Loongson's
email servers failed to deliver. The network administrator told me
today that he has fixed the problem and re-delivered all the failed
emails, but I did not see them on the mailing list. I hope they will
not suddenly appear in everyone's mailbox one day. I apologize for
this. (The email content mainly agrees with Serge's suggestion.)

v14:

Because Loongson GMAC can be also found with the 8-channels AV feature
enabled, we'll need to reconsider the patches logic and thus the
commit logs too. As Serge's comments and Russell's comments:
[PATCH net-next v14 01/15] net: stmmac: Move the atds flag to the stmmac_dma_cfg structure
[PATCH net-next v14 02/15] net: stmmac: Add multi-channel support
[PATCH net-next v14 03/15] net: stmmac: Export dwmac1000_dma_ops
[PATCH net-next v14 04/15] net: stmmac: dwmac-loongson: Drop duplicated hash-based filter size init
[PATCH net-next v14 05/15] net: stmmac: dwmac-loongson: Drop pci_enable/disable_msi calls
[PATCH net-next v14 06/15] net: stmmac: dwmac-loongson: Use PCI_DEVICE_DATA() macro for device identification
[PATCH net-next v14 07/15] net: stmmac: dwmac-loongson: Detach GMAC-specific platform data init
+-> Init the plat_stmmacenet_data::{tx_queues_to_use,rx_queues_to_use}
    in the loongson_gmac_data() method.
[PATCH net-next v14 08/15] net: stmmac: dwmac-loongson: Init ref and PTP clocks rate
[PATCH net-next v14 09/15] net: stmmac: dwmac-loongson: Add phy_interface for Loongson GMAC
[PATCH net-next v14 10/15] net: stmmac: dwmac-loongson: Introduce PCI device info data
+-> Make sure the setup() method is called after the pci_enable_device()
    invocation.
[PATCH net-next v14 11/15] net: stmmac: dwmac-loongson: Add DT-less GMAC PCI-device support
+-> Introduce the loongson_dwmac_dt_config() method here instead of
    doing that in a separate patch.
+-> Add loongson_dwmac_acpi_config() which would just get the IRQ from
    the pdev->irq field and make sure it is valid.
[PATCH net-next v14 12/15] net: stmmac: Fixed failure to set network speed to 1000.
+-> Drop the patch as Russell's comments, At the same time, he provided another
    better repair suggestion, and I decided to send it separately after the
    patch set was merged. See:
    <https://lore.kernel.org/netdev/ZoW1fNqV3PxEobFx@shell.armlinux.org.uk/>
[PATCH net-next v14 13/15] net: stmmac: dwmac-loongson: Add Loongson Multi-channels GMAC support
+-> This is former "net: stmmac: dwmac-loongson: Add Loongson GNET
    support" patch, but which adds the support of the Loongson GMAC with the
    8-channels AV-feature available.
+-> loongson_dwmac_intx_config() shall be dropped due to the
    loongson_dwmac_acpi_config() method added in the PATCH 11/15.
+-> Make sure loongson_data::loongson_id is initialized before the
    stmmac_pci_info::setup() is called.
+-> Move the rx_queues_to_use/tx_queues_to_use and coe_unsupported
    fields initialization to the loongson_gmac_data() method.
+-> As before, call the loongson_dwmac_msi_config() method if the multi-channels
    Loongson MAC has been detected.
+-> Move everything GNET-specific to the next patch.
[PATCH net-next v14 14/15] net: stmmac: dwmac-loongson: Add Loongson GNET support
+-> Everything Loonsgson GNET-specific is supposed to be added in the
    framework of this patch:
    + PCI_DEVICE_ID_LOONGSON_GNET macro
    + loongson_gnet_fix_speed() method
    + loongson_gnet_data() method
    + loongson_gnet_pci_info data
    + The GNET-specific part of the loongson_dwmac_setup() method.
    + ...
[PATCH net-next v14 15/15] net: stmmac: dwmac-loongson: Add loongson module author

Other's:
Pick Serge's Reviewed-by tag.

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

Yanteng Si (14):
  net: stmmac: Move the atds flag to the stmmac_dma_cfg structure
  net: stmmac: Add multi-channel support
  net: stmmac: Export dwmac1000_dma_ops
  net: stmmac: dwmac-loongson: Drop duplicated hash-based filter size
    init
  net: stmmac: dwmac-loongson: Drop pci_enable/disable_msi calls
  net: stmmac: dwmac-loongson: Use PCI_DEVICE_DATA() macro for device
    identification
  net: stmmac: dwmac-loongson: Detach GMAC-specific platform data init
  net: stmmac: dwmac-loongson: Init ref and PTP clocks rate
  net: stmmac: dwmac-loongson: Add phy_interface for Loongson GMAC
  net: stmmac: dwmac-loongson: Introduce PCI device info data
  net: stmmac: dwmac-loongson: Add DT-less GMAC PCI-device support
  net: stmmac: dwmac-loongson: Add Loongson Multi-channels GMAC support
  net: stmmac: dwmac-loongson: Add Loongson GNET support
  net: stmmac: dwmac-loongson: Add loongson module author

 drivers/net/ethernet/stmicro/stmmac/common.h  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 597 +++++++++++++++---
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |   4 +-
 .../ethernet/stmicro/stmmac/dwmac1000_dma.c   |  35 +-
 .../ethernet/stmicro/stmmac/dwmac100_dma.c    |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac_dma.h   |  27 +-
 .../net/ethernet/stmicro/stmmac/dwmac_lib.c   |  30 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |   2 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |   5 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  19 +-
 include/linux/stmmac.h                        |   1 +
 12 files changed, 605 insertions(+), 120 deletions(-)

-- 
2.31.4


