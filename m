Return-Path: <netdev+bounces-104395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9440490C66A
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 12:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25205B222DE
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 10:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE4F1849D4;
	Tue, 18 Jun 2024 07:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRjn7SIP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951441849CD;
	Tue, 18 Jun 2024 07:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718696986; cv=none; b=FdprCCzU2pjWcyWB5C5nu0KCCHX5V4zRzpLTWcJc8bzyzeeW8yqZGztuGvmPR/eylcrehQ72E7akGzLxDJCg5NhQvj0RGXlXGSi4TiC/O+gBg6NHwlg0MPSvkglaR02P+dgTQrUMwUVpx5B0xN+yaYCZIxb5BL1/MUqkTU4T1HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718696986; c=relaxed/simple;
	bh=00brJ40G8s7wdtc9hTYSuurYO4IZlFNVUi9Bu/7qFLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fQ4w/HaNJ+B7q3C7CCSZGHkBehBjlqADTeSOcf/quBSGZMYnJX8eNYbnAUxCKcYpGMOXm3bC0L3hefvjt8Saxm7XLwS7efEnQqnLCvLHYaEa+9JoxNpin9a425izpSUm3DRCEoUAFY+1XMicDVn2Mfx8iLYRHMca8Hm7onwHaz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRjn7SIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB05C4AF1A;
	Tue, 18 Jun 2024 07:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718696986;
	bh=00brJ40G8s7wdtc9hTYSuurYO4IZlFNVUi9Bu/7qFLk=;
	h=From:To:Cc:Subject:Date:From;
	b=iRjn7SIPptJfgdzD++1A543/qjnD493W3YUsiUT9YJRCF1cEbF44MjP6xIne7oHSO
	 1GDO8Ego59s2YxF/Z+tDkhDzEIq53KYRkdBV2b1NH4GcfJsCcQE69EnE8JuTH55hsN
	 K3vZ9wHEkP2IFgPkp7p/YFpilbHO+QZ7SkF1Y8zX64MaEmysuPFr44tK5+Z0lsUbfW
	 fmaHgrPwRJVNTVPYQG5YdMz5c1lJTYPaTRCV982cNjdDukVF5K+3LAX1UPJhkQfg7i
	 g9JAH30JHuvt1LUpMLO7KfVbcbcBlSZM+j+PhMHf0weowSqWnDpzV6jcwlLY+pKozj
	 tpGwMzFxyhz+g==
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
	linux-clk@vger.kernel.org,
	rkannoth@marvell.com,
	sgoutham@marvell.com,
	andrew@lunn.ch
Subject: [PATCH v2 net-next 0/2] Introduce EN7581 ethernet support
Date: Tue, 18 Jun 2024 09:49:01 +0200
Message-ID: <cover.1718696209.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.1
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

 .../bindings/net/airoha,en7581.yaml           |  106 +
 MAINTAINERS                                   |   10 +
 drivers/net/ethernet/mediatek/Kconfig         |   11 +-
 drivers/net/ethernet/mediatek/Makefile        |    1 +
 drivers/net/ethernet/mediatek/airoha_eth.c    | 1804 +++++++++++++++++
 drivers/net/ethernet/mediatek/airoha_eth.h    |  793 ++++++++
 6 files changed, 2724 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,en7581.yaml
 create mode 100644 drivers/net/ethernet/mediatek/airoha_eth.c
 create mode 100644 drivers/net/ethernet/mediatek/airoha_eth.h

-- 
2.45.1


