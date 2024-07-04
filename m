Return-Path: <netdev+bounces-109127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4A992713A
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 10:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07FD41F21ACE
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 08:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC001A38FC;
	Thu,  4 Jul 2024 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAkXAZkk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BA31A38F2;
	Thu,  4 Jul 2024 08:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720080506; cv=none; b=VgjtwHVmYWVkd9BYqljXO856f+lvUUTzB6a17jPLSTr5Q/dW3xwf9AGytnh1p5bUqP6lbNi/FrXIrX5yAVCmUsVNJDWavET9qj+j8nUCbZKAxGetdubAHZcYWb6Cgv0TzvEUgOCba+O+iPbgZ2FPq7xdvYBKXMMU68ZOsdn2FMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720080506; c=relaxed/simple;
	bh=J/I/ZDCtfEc50f3py2WXkQJXNaJZrIWNnDDHj5sDshI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iXHDZI9OPU6Klb8YzMhOCvgFVcJVC9bHTMWbbNN/xsxE7YebUIalm484w/bouzwl9Gp/l7RV7EjF5A01Fdhx/11RbJn+DSQDwwxbK1icMsgyqowzKDCL3lIB54E+Ku13xsHHf1TeFE1MuStYBERQ9QvvGhExXCI5thLflItU3Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAkXAZkk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2358C3277B;
	Thu,  4 Jul 2024 08:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720080505;
	bh=J/I/ZDCtfEc50f3py2WXkQJXNaJZrIWNnDDHj5sDshI=;
	h=From:To:Cc:Subject:Date:From;
	b=bAkXAZkkVKFUTH4IK+UU2ZZzvBhwnvYnYAWAlwIUnrTewIBcIA2M4NMRrdC6WQdLm
	 lJPaf6UOFuxOguhjb98xSuqaFG/Q1wt2zGh87ys+w6tMol2MpnKdwCJ76Ehq4ey1AD
	 P/lKlI9KvivxCj5BpkphNQyBtv/fNP0cAjkPqYM0/nGgWklNF0M6PCafPXiFo6xm17
	 x6GQA9KD7VFs8FlG/O/YFzekcV+mfzAh+X4HxarUFq0SSD9fgHsEdGftU+40V/cs7M
	 k8TIBzrHgixQ3dUrVkKhSW0P7NRDmd+kyBEB2N/4ItrcD6NqbFrSJY03HVVLRfacrJ
	 EAlzxipNqBRAg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo.bianconi83@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	conor@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu,
	rkannoth@marvell.com,
	sgoutham@marvell.com,
	andrew@lunn.ch,
	arnd@arndb.de,
	horms@kernel.org
Subject: [PATCH v5 net-next 0/2] Introduce EN7581 ethernet support
Date: Thu,  4 Jul 2024 10:08:09 +0200
Message-ID: <cover.1720079772.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add airoha_eth driver in order to introduce ethernet support for
Airoha EN7581 SoC available on EN7581 development board.
EN7581 mac controller is mainly composed by Frame Engine (FE) and
QoS-DMA (QDMA) modules. FE is used for traffic offloading (just basic
functionalities are supported now) while QDMA is used for DMA operation
and QOS functionalities between mac layer and the dsa switch (hw QoS is
not available yet and it will be added in the future).
Currently only hw lan features are available, hw wan will be added with
subsequent patches.

Changes since v4:
- fix compilation warnings
- use airoha_qdma_rr() and not airoha_rr() in airoha_qdma_set_irqmask()
- add missing descriptions in dt-binding
- remove mdio node in binding example
Changes since v3:
- rework architecture to allow future gdm{1,4} support
- read REG_INT_ENABLE() register in airoha_qdma_set_irqmask() to guarantee
  airoha_qdma_wr() complete in the spinlock critical section - thx Arnd for
  the clarification
- remove unnecessary wmb()
- remove debugfs
- move register definitions in .c and remove .h
- fix warnings
- enable NAPI thread by default
Changes since v2:
- rename airoha,en7581.yaml in airoha,en7581-eth.yaml
- remove reset dependency in airoha,en7581-eth.yaml
- remove airoha_dev_change_mtu() callback
Changes since v1:
- drop patch 2/3
- remove queue lock for rx queues
- add bql support
- add ethtool stats support
- fix possible infinite loop in airoha_qdma_rx_process routine
- always destroy page_pool in case of error during initialization
- cosmetics

Lorenzo Bianconi (2):
  dt-bindings: net: airoha: Add EN7581 ethernet controller
  net: airoha: Introduce ethernet support for EN7581 SoC

 .../bindings/net/airoha,en7581-eth.yaml       |  146 +
 MAINTAINERS                                   |    9 +
 drivers/net/ethernet/mediatek/Kconfig         |   11 +-
 drivers/net/ethernet/mediatek/Makefile        |    1 +
 drivers/net/ethernet/mediatek/airoha_eth.c    | 2705 +++++++++++++++++
 5 files changed, 2871 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
 create mode 100644 drivers/net/ethernet/mediatek/airoha_eth.c

-- 
2.45.2


