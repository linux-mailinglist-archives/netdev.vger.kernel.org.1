Return-Path: <netdev+bounces-220812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F159B48DB5
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 14:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E60B14401DA
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 12:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F14302147;
	Mon,  8 Sep 2025 12:36:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D412FF14C;
	Mon,  8 Sep 2025 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757334998; cv=none; b=t1Nd30oMBsMkHUFHm4Vu4+GOgeHVvWf//pG97s90Lm/koqBXbI9LFMUKccsam60YMyQOB6CDSIVkH6tdxbVluXw/N7awCZ8fktSLXqiaAx0+Awhmz3/u9/vqMlUR7Pv/cF0Hsy7IxyV9yHCUj6gHKebFRQ1JlNUOLYT6B+WNfJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757334998; c=relaxed/simple;
	bh=bbqROw0UtuKVdzFTBGydfq4s6kb9XufV8F5Dol5Us8M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QImLlUMUTmO8+9bNb+y74Kpd6YsoaTg9rztwjIlWD+qABlosIvedVLaXnWFfdBESMIKt8GJaCvdq+Kb0Ij9rKTtJy8wHd/vqpeY28+07eJ2cWHQn+hBjGcAZn8AfmLpccmOFaBF1/ZF7us8zqsc5jKjZJInqzjntFh9Yi5AOyAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.87.235])
	by APP-01 (Coremail) with SMTP id qwCowAAXbqCAzb5oCP2nAQ--.48996S2;
	Mon, 08 Sep 2025 20:35:13 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Subject: [PATCH net-next v10 0/5] Add Ethernet MAC support for SpacemiT K1
Date: Mon, 08 Sep 2025 20:34:24 +0800
Message-Id: <20250908-net-k1-emac-v10-0-90d807ccd469@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFDNvmgC/23RzU7DMAwA4FeZciaTneZ3J94DcUgdByK0DtpSg
 dDenaxDWrtyTOzPdpwfMXBfeBCH3Y/oeSpDOXX1gPCwE/QauxeWJdULoUAZsGBlx6N8Q8nHSLJ
 h9GjAc7RaVPHecy5fc7kncUns+GsUz9dIzx+ftf74F27jwJJOx2MZD7vJ7tHJnnBOfi3DeOq/5
 6EmnLOv7bFZtZ9QgiSyObBBsNY9loHisI+0p26uNKml9mutqg46mwxOKRf9Vjc37UCtdVO19yq
 RMRp0brZaL/Xd5Lpq622CQJryf73NTXu8622qTgkd6QAm67DVdqEVrLW9bA1Z+axa37LZarfU6
 y+fXNWmJTQ+gbeRt9ov9d3OfdUcwJmUFMUAWx1uuj5urUPVGa0ObfARA631+Xz+BRqMhCPQAgA
 A
X-Change-ID: 20250606-net-k1-emac-3e181508ea64
To: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Vivian Wang <wangruikang@iscas.ac.cn>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Vivian Wang <uwu@dram.page>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Simon Horman <horms@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
X-Mailer: b4 0.14.2
X-CM-TRANSID:qwCowAAXbqCAzb5oCP2nAQ--.48996S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GF15ArWrGFy3uw1rGw1xKrg_yoW7Zr18pF
	W8CrZI9w47JrWIgFs7uw47uF1fWan5Jw13W3W3K393Xa1DAFyUA3sakw43Cr1UZrZ3Jryj
	ya1UuF1DWa4DA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7sRiuWl3UUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

SpacemiT K1 has two gigabit Ethernet MACs with RGMII and RMII support.
Add devicetree bindings, driver, and DTS for it.

Tested primarily on BananaPi BPI-F3. Basic TX/RX functionality also
tested on Milk-V Jupiter.

I would like to note that even though some bit field names superficially
resemble that of DesignWare MAC, all other differences point to it in
fact being a custom design.

Based on SpacemiT drivers [1]. These patches are also available at:

https://github.com/dramforever/linux/tree/k1/ethernet/v10

[1]: https://github.com/spacemit-com/linux-k1x

---
Changes in v10:
- Use FIELD_GET and FIELD_PREP, remove some unused constants
- Remove redundant software statistics
  - In particular, rx_dropped should have been and is already tracked in
    rx_errors.
- Track tx_dropped with a percpu field
  - * Simon, Jakub: Using "dstats" gets hairy since dev_get_dstats64()
    isn't public, so I would have to recreate the logic in
    emac_get_stats64(). Instead I just DIY'd a percpu stat_tx_dropped.
- Minor changes
  - Simplified int emac_rx_frame_status() -> bool emac_rx_frame_good()
- Link to v9: https://lore.kernel.org/r/20250905-net-k1-emac-v9-0-f1649b98a19c@iscas.ac.cn

Changes in v9:
- Refactor to use phy_interface_mode_is_rgmii
- Minor changes
  - Use netdev_err in more places
  - Print phy-mode by name on unsupported phy-mode
- Link to v8: https://lore.kernel.org/r/20250828-net-k1-emac-v8-0-e9075dd2ca90@iscas.ac.cn

Changes in v8:
- Use devres to do of_phy_deregister_fixed_link on probe failure or
  remove
- Simplified control flow in a few places with early return or continue
- Minor changes
  - Removed some unneeded parens in emac_configure_{tx,rx}
- Link to v7: https://lore.kernel.org/r/20250826-net-k1-emac-v7-0-5bc158d086ae@iscas.ac.cn

Changes in v7:
- Removed scoped_guard usage
- Renamed error handling path labels after destinations
- Fix skb free error handling path in emac_start_xmit and emac_tx_mem_map
- Cancel tx_timeout_task to prevent schedule_work lifetime problems
- Minor changes:
  - Remove unnecessary timer_delete_sync in emac_down
  - Use dev_err_ratelimited in a few more places
  - Cosmetic fixes in error messages
- Link to v6: https://lore.kernel.org/r/20250820-net-k1-emac-v6-0-c1e28f2b8be5@iscas.ac.cn

Changes in v6:
- Implement pause frame support
- Minor changes:
  - Convert comment for emac_stats_update() into assert_spin_locked()
  - Cosmetic fixes for some comments and whitespace
  - emac_set_mac_addr() is now refactored
- Link to v5: https://lore.kernel.org/r/20250812-net-k1-emac-v5-0-dd17c4905f49@iscas.ac.cn

Changes in v5:
- Rebased on v6.17-rc1, add back DTS now that they apply cleanly
- Use standard statistics interface, handle 32-bit statistics overflow
- Minor changes:
  - Fix clock resource handling in emac_resume
  - Ratelimit the message in emac_rx_frame_status
  - Add ndo_validate_addr = eth_validate_addr
  - Remove unnecessary parens in emac_set_mac_addr
  - Change some functions that never fail to return void instead of int
  - Minor rewording
- Link to v4: https://lore.kernel.org/r/20250703-net-k1-emac-v4-0-686d09c4cfa8@iscas.ac.cn

Changes in v4:
- Resource handling on probe and remove: timer_delete_sync and
  of_phy_deregister_fixed_link
- Drop DTS changes and dependencies (will send through SpacemiT tree)
- Minor changes:
  - Remove redundant phy_stop() and setting of ndev->phydev
  - Fix error checking for emac_open in emac_resume
  - Fix one missed dev_err -> dev_err_probe
  - Fix type of emac_start_xmit
  - Fix one missed reverse xmas tree formatting
  - Rename some functions for consistency between emac_* and ndo_*
- Link to v3: https://lore.kernel.org/r/20250702-net-k1-emac-v3-0-882dc55404f3@iscas.ac.cn

Changes in v3:
- Refactored and simplified emac_tx_mem_map
- Addressed other minor v2 review comments
- Removed what was patch 3 in v2, depend on DMA buses instead
- DT nodes in alphabetical order where appropriate
- Link to v2: https://lore.kernel.org/r/20250618-net-k1-emac-v2-0-94f5f07227a8@iscas.ac.cn

Changes in v2:
- dts: Put eth0 and eth1 nodes under a bus with dma-ranges
- dts: Added Milk-V Jupiter
- Fix typo in emac_init_hw() that broke the driver (Oops!)
- Reformatted line lengths to under 80
- Addressed other v1 review comments
- Link to v1: https://lore.kernel.org/r/20250613-net-k1-emac-v1-0-cc6f9e510667@iscas.ac.cn

---
Vivian Wang (5):
      dt-bindings: net: Add support for SpacemiT K1
      net: spacemit: Add K1 Ethernet MAC
      riscv: dts: spacemit: Add Ethernet support for K1
      riscv: dts: spacemit: Add Ethernet support for BPI-F3
      riscv: dts: spacemit: Add Ethernet support for Jupiter

 .../devicetree/bindings/net/spacemit,k1-emac.yaml  |   81 +
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts    |   46 +
 arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts  |   46 +
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi       |   48 +
 arch/riscv/boot/dts/spacemit/k1.dtsi               |   22 +
 drivers/net/ethernet/Kconfig                       |    1 +
 drivers/net/ethernet/Makefile                      |    1 +
 drivers/net/ethernet/spacemit/Kconfig              |   29 +
 drivers/net/ethernet/spacemit/Makefile             |    6 +
 drivers/net/ethernet/spacemit/k1_emac.c            | 2156 ++++++++++++++++++++
 drivers/net/ethernet/spacemit/k1_emac.h            |  406 ++++
 11 files changed, 2842 insertions(+)
---
base-commit: 062b3e4a1f880f104a8d4b90b767788786aa7b78
change-id: 20250606-net-k1-emac-3e181508ea64

Best regards,
-- 
Vivian "dramforever" Wang


