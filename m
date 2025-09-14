Return-Path: <netdev+bounces-222835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5508CB566C0
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 06:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06EFC3A2408
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 04:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D6827FB2F;
	Sun, 14 Sep 2025 04:24:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239DC267B01;
	Sun, 14 Sep 2025 04:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757823873; cv=none; b=Jd1+TgvA7e9PWrs6ow2lDd8caleMhc/mg4ZHw5DMelDpl26wLmpNK8RHQVxgVVLuV4bTKPcG6dnjUoVgwkStjpQ8K+ARfG45Gnwq/4jyuOcdywkyMHu33dF1DbA49Rqfqgr8PaswdD/tOL8UMBm8G6rXbBIc6TFsmVn4LkGw44Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757823873; c=relaxed/simple;
	bh=yu2GhzBzgd4Yw9ErWiDgakwnnvnQtFUiso34s2tpZQ8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TCW574BkiEjZMvd5o3QL4GwHqAJOMcqIgst0XUR3118I5/uFXUtJiCXtdOEYvqUpJTKQu7XNWcJtdCuf4bteoXbc1jpWdf8D+DEuIq95e2WRKWQAW/xwsEjIu0yVdfdt0FKx4maYP7Y26GHoFlEfXyUv9Y7FUXNcuaoDZVB4sKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.87.235])
	by APP-03 (Coremail) with SMTP id rQCowAAndoBBQ8Zop+bBAg--.11749S2;
	Sun, 14 Sep 2025 12:23:30 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Subject: [PATCH net-next v12 0/5] Add Ethernet MAC support for SpacemiT K1
Date: Sun, 14 Sep 2025 12:23:11 +0800
Message-Id: <20250914-net-k1-emac-v12-0-65b31b398f44@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC9DxmgC/23SS07EMAwG4KuMuiYjO83DYcU9EIvUcaBC04G2V
 CA0dydTkKYPlm38+U+cfFeD9K0M1f3hu+plaof23JUP1HeHil9i9yyqTeVHpUFbcOBUJ6N6RSW
 nyKoWJLRAEp2pinjrJbefc7vH6lrYyedYPf2u9PL+UfqPf8tNHETx+XRqx/vD5I7oVc84F7+0w
 3juv+ZNTThX/8ZjvYqfUIFidjmIRXDOP7QDx+EY+cjd3GnSS01rrYsOJtsMXmsfaa/rm/ag17o
 umkgnttaAyfVem6Xe7NwU7cglCGw4/5dtb5pwk22LTgk9mwA2m7DXbqE1rLW7Tg1FU9YNNWL32
 i/1+sonX7RtGC0lIBdlr2mpNzOnoiWAtylpjgH2Otx0Odxah6IzOhOaQBED7zXCkm/CEa43Don
 AMyfj/pkbLp5b2I4dr+8txlrIZAJTN2t/uVx+AMrGiH5QAwAA
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
 Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.2
X-CM-TRANSID:rQCowAAndoBBQ8Zop+bBAg--.11749S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKF43WF4xXr1UtF1rGF13XFb_yoWxXr13pF
	W8CrZIvwsrtrWIgF4kCw47uF1xXan5t347WF1UK393Xa1DAFy8Z392kw43CFyDZrZ3Jryj
	ya1UZF1Dua4DA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0pRl_MsUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

SpacemiT K1 has two gigabit Ethernet MACs with RGMII and RMII support.
Add devicetree bindings, driver, and DTS for it.

Tested primarily on BananaPi BPI-F3. Basic TX/RX functionality also
tested on Milk-V Jupiter.

I would like to note that even though some bit field names superficially
resemble that of DesignWare MAC, all other differences point to it in
fact being a custom design.

Based on SpacemiT drivers [1]. These patches are also available at:

https://github.com/dramforever/linux/tree/k1/ethernet/v12

[1]: https://github.com/spacemit-com/linux-k1x

---
Changes in v12:
- Add aliases ethernet{0,1} to DTS
- Minor changes
  - Use FIELD_MODIFY to set duplex mode in HW based on phydev->duplex
  - Use FIELD_GET in emac_mii_read() to extract bits from MAC_MDIO_DATA
- Link to v11: https://lore.kernel.org/r/20250912-net-k1-emac-v11-0-aa3e84f8043b@iscas.ac.cn

Changes in v11:
- Use NETDEV_PCPU_STAT_DSTATS for tx_dropped
- Use DECLARE_FLEX_ARRAY for emac_hw_{tx,rx}_stats instead of cast
- More bitfields stuff to simplify code:
  - Define EMAC_MAX_DELAY_UNIT with FIELD_MAX
  - Use FIELD_{PREP,GET} in emac_mii_{read,write}()
  - Use FIELD_MODIFY in emac_set_{tx,rx}_fc()
- Minor changes:
  - Use lower_32_bits and such instead of casts and shifts
  - Extract emac_ether_addr_hash() helper
  - In emac_mdio_init(), 0xffffffff -> ~0
  - Minor comment changes
- Link to v10: https://lore.kernel.org/r/20250908-net-k1-emac-v10-0-90d807ccd469@iscas.ac.cn

Changes in v10:
- Use FIELD_GET and FIELD_PREP, remove some unused constants
- Remove redundant software statistics
  - In particular, rx_dropped should have been and is already tracked in
    rx_errors.
- Track tx_dropped with a percpu field
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
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts    |   48 +
 arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts  |   48 +
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi       |   48 +
 arch/riscv/boot/dts/spacemit/k1.dtsi               |   22 +
 drivers/net/ethernet/Kconfig                       |    1 +
 drivers/net/ethernet/Makefile                      |    1 +
 drivers/net/ethernet/spacemit/Kconfig              |   29 +
 drivers/net/ethernet/spacemit/Makefile             |    6 +
 drivers/net/ethernet/spacemit/k1_emac.c            | 2159 ++++++++++++++++++++
 drivers/net/ethernet/spacemit/k1_emac.h            |  416 ++++
 11 files changed, 2859 insertions(+)
---
base-commit: 062b3e4a1f880f104a8d4b90b767788786aa7b78
change-id: 20250606-net-k1-emac-3e181508ea64

Best regards,
-- 
Vivian "dramforever" Wang


