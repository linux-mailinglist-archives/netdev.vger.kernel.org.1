Return-Path: <netdev+bounces-110524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3521792CD79
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 10:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDDC11F24C93
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 08:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DE315D5D8;
	Wed, 10 Jul 2024 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONv8H2w7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE3016DEBB;
	Wed, 10 Jul 2024 08:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720601302; cv=none; b=XtS2zZHgwNo3siRIlaa9VFXTD8dDINvVL5FJ7/gfWKdyVoZ/VM8vL7vDrSvsVVJC8fXa+N2mSJ1e6HU2DzAh7bSFwzt0JVg1kZucAvEeFJ+320ojd7UPGTJmrGGHc6TieQWHbKRsf9Mth8Wl2xmbGCBTMKqCw6y48iO9AJ089mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720601302; c=relaxed/simple;
	bh=zQ/TiuB8t18dWU8pWhwlwsO0XHGfzZxYLg1qX75VWhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kxmRFvZaLwVDhcpum81QQ9kNVpRhftbgz+iL85yuP5CG+K2C/GU/9xlFjMbEzaBFvQZOSaOt7RldJDMghK62UYzcQWWhEen0zB9WYJjQ5IrJi40N+hh2ynvutGNImiei6oO4RNGVxFZwPREHRX+oL8nszIB21zNdzT/qiD0IQH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONv8H2w7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC41C32781;
	Wed, 10 Jul 2024 08:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720601300;
	bh=zQ/TiuB8t18dWU8pWhwlwsO0XHGfzZxYLg1qX75VWhA=;
	h=From:To:Cc:Subject:Date:From;
	b=ONv8H2w7xj6WuoGYeuZ4q2sKGVfujpD1yPRYjpK2TZ26ENPqiMfBest72vNJ+jlpu
	 6sdkIHpEnM0KQsmy5gbcVINlst53gN4sCmBm8wI/sRsySxDzLcTgw3h1jjE5Q/W+oE
	 S4eBlWWhw4lVfy41p92hZ6cJIYle4hYdwaObS5/rkRN5vJpfZ0lAqzYsJhxKYZc30p
	 VjLyXxWoTobXIUqQ7Kyp/FmG1Z5tMzYkq51pukDYUm1nH+wKRq7Fj1ho/CkLZ6+Kyp
	 K8CHrsSaLSwJ9AbxLToZf9eN/O119NESLKxOSl2/Yaknq69Ud07d/2+/PU0iufuJba
	 tLm84MJD2c9+g==
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
Subject: [PATCH v7 net-next 0/2] Introduce EN7581 ethernet support
Date: Wed, 10 Jul 2024 10:47:39 +0200
Message-ID: <cover.1720600905.git.lorenzo@kernel.org>
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
 drivers/net/ethernet/mediatek/Kconfig         |   11 +-
 drivers/net/ethernet/mediatek/Makefile        |    1 +
 drivers/net/ethernet/mediatek/airoha_eth.c    | 2768 +++++++++++++++++
 5 files changed, 2931 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
 create mode 100644 drivers/net/ethernet/mediatek/airoha_eth.c

-- 
2.45.2


