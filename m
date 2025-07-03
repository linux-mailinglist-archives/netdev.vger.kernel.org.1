Return-Path: <netdev+bounces-203743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3F5AF6F10
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982F94E1A6D
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 09:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A522DA77F;
	Thu,  3 Jul 2025 09:44:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2322D9EF1;
	Thu,  3 Jul 2025 09:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751535874; cv=none; b=t6qxAPDD3nOH65aUF7fMhRq8zOss+ZOYWRqhW6bguBkM1zMN0g6PhhLCqdFZEv5onXuERfd7nVSaRzcCIHTK8h3IR9nI5iORNtIoRnWCJ5vOrzGVcc4rd+8XsJ6aDl3f3uX/5AXyB4Z53RAgbLjIXCJX+gjyTxJNiWqEw8NA78s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751535874; c=relaxed/simple;
	bh=KF1VSv/L3DD18N5w7Yh4+QaBemHVdr9M/1GmhGh0VUc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kjo8O3YzlpyQ6mWQK3W9xVZRF+V7JlKWgnmUAVlZ9e4kqFZlfy1UAtkHO/553ERMb/exO+cfTq7gphVJMfFoXdsWULetx/a/Ir2/BsI+esgvopBsVj8ZgUVnKHuy7Z8+oYsz2g535I09ZZIhGqcksuQHmhtZ9Z+C2m6RMaiAsvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [210.73.43.2])
	by APP-03 (Coremail) with SMTP id rQCowAAHX4DWUGZouhe1AA--.40630S2;
	Thu, 03 Jul 2025 17:43:51 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Subject: [PATCH net-next v4 0/2] Add Ethernet MAC support for SpacemiT K1
Date: Thu, 03 Jul 2025 17:42:01 +0800
Message-Id: <20250703-net-k1-emac-v4-0-686d09c4cfa8@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGlQZmgC/2XOTW7DIBAF4KtYrIvFv0lWvUfVBZ0MCaqMU6AoV
 eS7l5BIrZXlaN73Zq4kYwqYyX64koQ15LDENqiXgcDJxSPScGgzEUxoZpihEQv95BRnB1Qit1w
 zi84o0sQ5oQ+X3vZGbsGIl0Le75uEX9+tvjzWHy4jhWWeQ9kP1Yzc0AS8h08hlyX99J8q7+n7e
 S435yunjAIYv0PNmTHTa8jg8uhghNibqviv7VaLpnfKa88mISZnn7X80xMTWy2btlYcQGvFlJd
 bva7rL/PpObxbAQAA
X-Change-ID: 20250606-net-k1-emac-3e181508ea64
To: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Vivian Wang <wangruikang@iscas.ac.cn>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Vivian Wang <uwu@dram.page>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Simon Horman <horms@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-CM-TRANSID:rQCowAAHX4DWUGZouhe1AA--.40630S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur43Kw1ftw13Jry5Jr1DWrg_yoW5GryUpa
	y8AF9akw48trW2gFs7Aw4xuF4fXan5tw13WF13t395Xa1qyFyUJryFkw45Cr1UZrZ3Jry7
	tr45ZF1kCa4DA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBEb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkIecxEwVAFwV
	W8uwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jnb1nUUUUU
	=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

SpacemiT K1 has two gigabit Ethernet MACs with RGMII and RMII support.
Add devicetree bindings and driver for it. DTS changes will be submitted
separately.

Tested on BananaPi BPI-F3 and Milk-V Jupiter.

I would like to note that even though some bit field names superficially
resemble that of DesignWare MAC, all other differences point to it in
fact being a custom design.

Based on SpacemiT drivers [1].

For convenience of testing, these patches and related DTS changes are
also available at:

https://github.com/dramforever/linux/tree/k1/ethernet/v4

[1]: https://github.com/spacemit-com/linux-k1x

---
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
Vivian Wang (2):
      dt-bindings: net: Add support for SpacemiT K1
      net: spacemit: Add K1 Ethernet MAC

 .../devicetree/bindings/net/spacemit,k1-emac.yaml  |   81 +
 drivers/net/ethernet/Kconfig                       |    1 +
 drivers/net/ethernet/Makefile                      |    1 +
 drivers/net/ethernet/spacemit/Kconfig              |   29 +
 drivers/net/ethernet/spacemit/Makefile             |    6 +
 drivers/net/ethernet/spacemit/k1_emac.c            | 1891 ++++++++++++++++++++
 drivers/net/ethernet/spacemit/k1_emac.h            |  420 +++++
 7 files changed, 2429 insertions(+)
---
base-commit: d9946fe286439c2aeaa7953b8c316efe5b83d515
change-id: 20250606-net-k1-emac-3e181508ea64

Best regards,
-- 
Vivian "dramforever" Wang


