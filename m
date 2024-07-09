Return-Path: <netdev+bounces-110097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F08D92AFBA
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA89EB21DC4
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 06:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A11980604;
	Tue,  9 Jul 2024 06:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDQtGuKr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFFE376EC;
	Tue,  9 Jul 2024 06:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720505155; cv=none; b=B4BHuRbAJuMDyDFOqPBOGu7v57QzE31CVysuMB0uFf3tGI4qtWSEVtknv1eXC1krzL6yGyToGAW92sM4Lwq8cYkgDsu7exhQedJBoAvrBEvAVZgDcOCGJ+o7ds5bT/55iqOJFbEJiOp1rwY6NUD8qogjV3EJnriSdSaTYxtUaE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720505155; c=relaxed/simple;
	bh=KC3jL2Vs6jczH8bx3kG9i3v3EvH0EzoOd+MZySOXBG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PWfHqqh9ajkvg8hAU6Not6SolXI7ezI+leak545ctc+2fEDa3uVO5mW3gySPWOt4tCHQwfIypK1VeM2yiOuaKH7sg3C4iytas4BaFqU4LSkWOBDlZZUd8OgQK/XNifM6deSBLQrQsCg8+UVyzx/1XQaEVVCFmveGky7PpZ8G+PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDQtGuKr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5001DC32782;
	Tue,  9 Jul 2024 06:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720505154;
	bh=KC3jL2Vs6jczH8bx3kG9i3v3EvH0EzoOd+MZySOXBG8=;
	h=From:To:Cc:Subject:Date:From;
	b=rDQtGuKrMoiJLVzkLfQ+BkaRSBTmF7PRdGIEKqiH0X+t0kNK648/DxoJAYkYKzXy4
	 j0P9jE93RGSTai27C0ZMBvrjuypMFIEp6Jblr9hcOmvKwSERekShc8vx4rbu3GXQbw
	 ExgoXjT/Uz6Ox/7UWVFEKije1sU+4GoQm8ZLWCpNuZZLDHb+A6xhoud9Qdhxh44P5p
	 qRsmi4M4Pf+TC3ceCvcnZA2rLeNU/+thblhJA2psv7MZCvI7IwmHRpGWZB+dIx9E2+
	 KXDPzSA+rWBn3GNKSbUrSqfiL72OTIcmFLbbjNsSr+E8M/VOF0XMY3FgpDNEr20XuI
	 hxNydUHRCTUJQ==
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
Subject: [PATCH v6 net-next 0/2] Introduce EN7581 ethernet support
Date: Tue,  9 Jul 2024 08:05:20 +0200
Message-ID: <cover.1720504637.git.lorenzo@kernel.org>
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
 drivers/net/ethernet/mediatek/airoha_eth.c    | 2771 +++++++++++++++++
 5 files changed, 2934 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
 create mode 100644 drivers/net/ethernet/mediatek/airoha_eth.c

-- 
2.45.2


