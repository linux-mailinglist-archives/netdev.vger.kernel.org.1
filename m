Return-Path: <netdev+bounces-215156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BE2B2D444
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 08:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AEE56283D3
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 06:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE7B2D027F;
	Wed, 20 Aug 2025 06:48:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4954C243367;
	Wed, 20 Aug 2025 06:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755672523; cv=none; b=NIRjOkUzLwgRjREOz9NYnGYxMGMyFLrqgWNUirbmpMQutGmzomiLyY+66R3lCyJlT1hj4J4hoduQzna90spF1k2IQ59gpweB06eXf74he2fPSPnIGTJOzCEYXNqfHR1bQ+UD6w3EBIFYTZO0vDrl0mZWZX3RBJhuqV9WUYX3UCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755672523; c=relaxed/simple;
	bh=obv/HLBfF+Fm7UDUxdSURRyNPPiH8cyXQkghiVYdvXY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ex0VLEPO63Qc6g/NdXpUjn0i3Zyx9/P78uNo12BIE4dTRj3YdaThKXr6dx/WdWXZ3F21bTPKkdp1JTIJ0KccjMzatP4ZoJWNF/xndKElrQ8AHUQ+4EILF5YpgsYm/DBLEvxkWzCNPnYsbmPQaNS+ovXjqygLE1N+1WH8o1nVE4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.87.235])
	by APP-03 (Coremail) with SMTP id rQCowABHoYKbb6Vozu+wDQ--.65205S2;
	Wed, 20 Aug 2025 14:47:57 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Subject: [PATCH net-next v6 0/5] Add Ethernet MAC support for SpacemiT K1
Date: Wed, 20 Aug 2025 14:47:49 +0800
Message-Id: <20250820-net-k1-emac-v6-0-c1e28f2b8be5@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJVvpWgC/23OTW6DMBAF4Ksgr2M0Nv4jq96j6sIdxo0VAalNU
 aqIu9cllRKSLkcz33tzYZlSpMz21YUlmmOO41AGs6sYHvzwQTx2ZWYSpAYDhg808aPg1HvkDQk
 nNDjyRrEiTolCPK9pr+z3cKDzxN6um0SfXyV++lu/+0wcx76P076aTS0sTyjW40PM05i+159ms
 V5f60WzqZ8FB45oQktagDH2JWb0ufZY47AmzfJeu62WRbcq6ABWSuvds25u2oLc6qZo52SHWit
 QoXnW6l4/fK6KNs500KLC8F+3vmknHrp10V0nLKoWdFDtVi/L8gN73Hae1wEAAA==
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
 Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
X-Mailer: b4 0.14.2
X-CM-TRANSID:rQCowABHoYKbb6Vozu+wDQ--.65205S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur4fXw18Jw18Jr15XF4UXFb_yoWrGF45pF
	W8AFZI9wsrJrWIgFs7uw47uF1fXan5t343WF15t395Xa1DAFy8Ar9akw4akr1UArWrJry2
	y3WUAFs7CFyDA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0pRl_MsUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

SpacemiT K1 has two gigabit Ethernet MACs with RGMII and RMII support.
Add devicetree bindings, driver, and DTS for it.

Tested primarily on BananaPi BPI-F3. Basic TX/RX functionality also
tested on Milk-V Jupiter.

I would like to note that even though some bit field names superficially
resemble that of DesignWare MAC, all other differences point to it in
fact being a custom design.

Based on SpacemiT drivers [1]. These patches are also available at:

https://github.com/dramforever/linux/tree/k1/ethernet/v6

[1]: https://github.com/spacemit-com/linux-k1x

---
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
 drivers/net/ethernet/spacemit/k1_emac.c            | 2179 ++++++++++++++++++++
 drivers/net/ethernet/spacemit/k1_emac.h            |  426 ++++
 11 files changed, 2885 insertions(+)
---
base-commit: 062b3e4a1f880f104a8d4b90b767788786aa7b78
change-id: 20250606-net-k1-emac-3e181508ea64

Best regards,
-- 
Vivian "dramforever" Wang


