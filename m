Return-Path: <netdev+bounces-111158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 786A6930199
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 23:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 216B71F24068
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 21:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841354965E;
	Fri, 12 Jul 2024 21:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foaFQg4R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1FB51C21;
	Fri, 12 Jul 2024 21:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720819716; cv=none; b=uk7LYaS9PePV2igY26CtmiOanHyVWnf4OIYuCGD6ErqBF2TM/C6UnlOv61JaZ3o43L+kpWYrvz6HKazDFOHxcTj0IeEKGBixoHLM/Qt/rcgJsQA/YggoeABdwyiFYLImYY4fCrfUcNpJXssl7Si4BigD9DETcMoOwb1hY8sMDdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720819716; c=relaxed/simple;
	bh=prZR6aM4EKNdsOI/0jAAqiAVqZ+acG7FM9SplaNmqgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YQhCdzH31C4l8zNRJJBA2EEcVXEPBFXRw3vb3o52qrYZ2hIT8+Fz44PPILPlCze4YNAj0nE+mKzP4CjhbUri87ZcUswE1Iz0WsLojYDu5+6sFyADulo7VsRKMpREHmb0H23xXRQKfPq+8vcKxu/c7eNbkpMpH3l/3zF/VAtwcfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foaFQg4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F567C32782;
	Fri, 12 Jul 2024 21:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720819715;
	bh=prZR6aM4EKNdsOI/0jAAqiAVqZ+acG7FM9SplaNmqgk=;
	h=From:To:Cc:Subject:Date:From;
	b=foaFQg4R3sPKotlH2e0WErCEfM8YWPV04D3DsdBqfuxl1qinv1qLEjiRRfRxYVpU/
	 3iU8zx1JvQG2NNE95Yt+Es86bnoMvPI3tbGtJ9V+LdBr5kPKBDYqZwtVbk1KxJMNsT
	 YyMPcVYzY67jOmRDiRcuUJYsALsTrZ4MGosmTZ9eJjcwStGE3ApfaBvUtSERmFAMzY
	 VnHcanLNXsoUaJBcB1FuMmM62PBdEMTCKcca5okfLeZnQvqmDY8vzCaxek3LcAxq75
	 WIzoOY8rKciWMeoEhb1ZcMNlrnV8QpV712L5+Hg9nAS4q72xV5zuKTLk7HZJrJ2n7L
	 pXEBzN3EcKHOA==
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
Subject: [PATCH v8 net-next 0/2] Introduce EN7581 ethernet support
Date: Fri, 12 Jul 2024 23:27:56 +0200
Message-ID: <cover.1720818878.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Changes since v7:
- remove possible sleep while atomic dumping hw_stats
- move ethtool stats in ethtool_eth_mac_stats and ethtool_rmon_stats structures
  and get rid of .get_ethtool_stats() callback
- remove BQL
- add missing netif_tx_stop_queue() in airoha_dev_xmit()
- remove PAGE_POOL_STATS reporting for the moment
- add missing napi_disable() stopping the hw and move airoha_qdma_start_napi()
  before net_device registration
Changes since v6:
- set eth->ports[] before registering netdevice
- make page_pool_params const
Changes since v5:
- implement .ndo_get_stats64() callback and remove duplicated ethtool entries
- remove "ethernet-controller.yaml#" from parent node in device tree binding
- rename child node from "mac" to "ethernet" in device tree binding
- fix checkpatch errors
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

 .../bindings/net/airoha,en7581-eth.yaml       |  143 +
 MAINTAINERS                                   |    9 +
 drivers/net/ethernet/mediatek/Kconfig         |   10 +-
 drivers/net/ethernet/mediatek/Makefile        |    1 +
 drivers/net/ethernet/mediatek/airoha_eth.c    | 2730 +++++++++++++++++
 5 files changed, 2892 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
 create mode 100644 drivers/net/ethernet/mediatek/airoha_eth.c

-- 
2.45.2


