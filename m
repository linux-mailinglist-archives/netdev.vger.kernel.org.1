Return-Path: <netdev+bounces-198876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A84F8ADE1C2
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 05:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A292A3BC33E
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 03:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BAE1E0B86;
	Wed, 18 Jun 2025 03:41:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C41F1D9A5D;
	Wed, 18 Jun 2025 03:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750218119; cv=none; b=Eyi86cKRFgFY2EPsTy9kCMCgQpeP6WUWE2mv70RQkw6VPEYO+1Mhbjt0tttxo1+wInralXF+l5PtaETbYuaKyfMC4OsvyNRv7voMdpf7pM2Es0Q9Qb+QUNwXQpYk8furqE3qXsbwVOrpu8j50okPlFl+dl0jIRTTFCkuH20z0yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750218119; c=relaxed/simple;
	bh=mClwktUuIUKCAi9FZnjiyUaJnofqGsQT3KVF0qvMQqU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hGF1GrhMaRIzWnHZbv73Pdxznc3ocE+xYFKo3IaSPVpYG4f0bDIXO9gacBawDD3mBmYeYsHZBu91A+WCAjJOfP51QRp/cEkJZRdMMsbre+Q07FFX8W0YrOq7t/SYSb+K0Mtyhn6nABH3Rk03cilHABGqDvZJRXTyQd05HVNPhcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [210.73.43.2])
	by APP-01 (Coremail) with SMTP id qwCowABnFtVpNVJoV95NBw--.6548S2;
	Wed, 18 Jun 2025 11:41:30 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Subject: [PATCH net-next v2 0/6] Add Ethernet MAC support for SpacemiT K1
Date: Wed, 18 Jun 2025 11:40:45 +0800
Message-Id: <20250618-net-k1-emac-v2-0-94f5f07227a8@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD01UmgC/1WP0W7CMAxFf6XK8xzF6RqgQoj/mHjIghnRaAp2V
 jGh/vtCgIc9Xl37HPumhDiSqL65KaYpShxTCfatUeHo0xdB3JesrLGdccZBogzfCDT4AC3hEju
 zJO/eVdk4Mx3itdI+1H0w0TWr3aNhuvwUfH7Wn14IwjgMMffN5DQ64IB3ykAivor7Zv3wYmsQs
 V1ptAYXxkI54LQn3nKUINmzLqRNNR2j5JF/60MTVtWL8e/2CcFACO6wog6Nc4ttQXnRPuiQ1G6
 e5z8eKFlJHAEAAA==
X-Change-ID: 20250606-net-k1-emac-3e181508ea64
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Vivian Wang <wangruikang@iscas.ac.cn>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Vivian Wang <uwu@dram.page>, Lukas Bulwahn <lukas.bulwahn@redhat.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-CM-TRANSID:qwCowABnFtVpNVJoV95NBw--.6548S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur1fZr1fXr47tFWxCrWxWFg_yoW5CF1xpa
	y8ZrZxuwnxJr47trs7uws7urWfWa1vy3W5WF1UtryrX3sF9FWUJrnakr15Gr1UZrWrJryS
	yr4kZw1fCFn8Ar7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9E14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK67AK6r48MxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sR_XTm7UUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

SpacemiT K1 has two gigabit Ethernet MACs with RGMII and RMII support.
Add a driver for them, as well as the supporting devicetree and bindings
updates.

Tested on BananaPi BPI-F3 and Milk-V Jupiter.

I would like to note that even though some bit field names superficially
resemble that of DesignWare MAC, all other differences point to it in
fact being a custom design.

Based on SpacemiT drivers [1]. This series depends on reset controller
support for K1 [2]. These patches can also be pulled from:

https://github.com/dramforever/linux/tree/k1/ethernet/v2

Note on patch 3: I am still fairly certain that such a bus with empty
ranges is allowed under both the spirit and the letter of simple-bus
bindings [3].  This also passes "make dtbs_check" with only unrelated
warnings that was already there.

[1]: https://github.com/spacemit-com/linux-k1x
[2]: https://lore.kernel.org/all/20250613011139.1201702-1-elder@riscstar.com
[3]: https://github.com/devicetree-org/dt-schema/commit/ed9190d20f146d13e262cc9138506326f7d4da91

---
Changes in v2:
- dts: Put eth0 and eth1 nodes under a bus with dma-ranges
- dts: Added Milk-V Jupiter
- Fix typo in emac_init_hw() that broke the driver (Oops!)
- Reformatted line lengths to under 80
- Addressed other v1 review comments
- Link to v1: https://lore.kernel.org/r/20250613-net-k1-emac-v1-0-cc6f9e510667@iscas.ac.cn

---
Vivian Wang (6):
      dt-bindings: net: Add support for SpacemiT K1
      net: spacemit: Add K1 Ethernet MAC
      riscv: dts: Add network-bus dma-ranges for SpacemiT K1
      riscv: dts: spacemit: Add Ethernet support for K1
      riscv: dts: spacemit: Add Ethernet support for BPI-F3
      riscv: dts: spacemit: Add Ethernet support for Jupiter

 .../devicetree/bindings/net/spacemit,k1-emac.yaml  |   81 +
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts    |   46 +
 arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts  |   46 +
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi       |   48 +
 arch/riscv/boot/dts/spacemit/k1.dtsi               |   31 +
 drivers/net/ethernet/Kconfig                       |    1 +
 drivers/net/ethernet/Makefile                      |    1 +
 drivers/net/ethernet/spacemit/Kconfig              |   29 +
 drivers/net/ethernet/spacemit/Makefile             |    6 +
 drivers/net/ethernet/spacemit/k1_emac.c            | 1934 ++++++++++++++++++++
 drivers/net/ethernet/spacemit/k1_emac.h            |  416 +++++
 11 files changed, 2639 insertions(+)
---
base-commit: d9946fe286439c2aeaa7953b8c316efe5b83d515
change-id: 20250606-net-k1-emac-3e181508ea64
prerequisite-message-id: <20250613011139.1201702-1-elder@riscstar.com>
prerequisite-patch-id: 2c73c63bef3640e63243ddcf3c07b108d45f6816
prerequisite-patch-id: 0faba75db33c96a588e722c4f2b3862c4cbdaeae
prerequisite-patch-id: 5db8688ef86188ec091145fae9e14b2211cd2b8c
prerequisite-patch-id: e0fe84381637dc888d996a79ea717ff0e3441bd1
prerequisite-patch-id: 2fc0ef1c2fcda92ad83400da5aadaf194fe78627
prerequisite-patch-id: bfa54447803e5642059c386e2bd96297e691d0bf

Best regards,
-- 
Vivian "dramforever" Wang


