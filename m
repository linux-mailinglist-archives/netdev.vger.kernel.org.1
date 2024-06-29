Return-Path: <netdev+bounces-107901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C0491CDAC
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 17:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 766B51C21075
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 15:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B227E572;
	Sat, 29 Jun 2024 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWO82SmD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B5729CEB;
	Sat, 29 Jun 2024 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719673309; cv=none; b=LbGg5Y71mY4Av3EYhdH94CvxbvgseEZf5agqOcYPNn5f/RiY7g5ojZbVUMB5l8CtDpATuQNq+OqlGEyKykIHh1m+uIE19UliNvRlAgqgx9JrhMFLPGUjaC7dd2hHwt3f5Yg9sFmfdPXXYXGUPGC+G1/LdUiOZmkFRqmy6bWjjt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719673309; c=relaxed/simple;
	bh=4Kstz9rsy+u94zzC1fazgssvBzjf5Jv06T1zq8qRh9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KdLk85/lFFcFJuiKCG9Hdjn0eMKohDWLsopcIBF36fsNwT7c5zUDXwID6JT2jsRexdqHtvQ+Ctvmjb77NpknaSxzQdxNAAq/RcF+mf6lUTDomnhqOB3oX6GMelsPcgY7zxmRvxjIsDxX2I3wGfYSKktWw6cHe+4HlI5jdOYMSmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWO82SmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34216C2BBFC;
	Sat, 29 Jun 2024 15:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719673308;
	bh=4Kstz9rsy+u94zzC1fazgssvBzjf5Jv06T1zq8qRh9k=;
	h=From:To:Cc:Subject:Date:From;
	b=dWO82SmDihja2S1ZRt8bxCKV9VHd9DbKmW2lphzgREznEo7hBpB67oouX1M+zYnxs
	 97x0ITucB3KqOOY/ocoS8O1T0QPZ8Lnfn5fiWs4+FvuDKoAoj0zVAaQ/TuMlcBbgx9
	 AAI4+k840W2Cqs8ivkwTC7CRzqUzqTxA+3NHOwWfHWD6/T/p6mKh+T+kEVQJNmPHQU
	 NSie2TYXfyT1sNKHUBOfc/cjqVfW/IjwTdpS4Ku4PX1c45WNFcTHCNLuxGZj2jBpub
	 7wvmyzcR8CNGlZMCGFfxHpWUoHgsgkGekY0U4MvNuCvu94v5nkel9vYyxZlj1e4sfL
	 foX65y1COWNiw==
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
Subject: [PATCH v4 0/2] Introduce EN7581 ethernet support
Date: Sat, 29 Jun 2024 17:01:36 +0200
Message-ID: <cover.1719672695.git.lorenzo@kernel.org>
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

 .../bindings/net/airoha,en7581-eth.yaml       |  171 ++
 MAINTAINERS                                   |    9 +
 drivers/net/ethernet/mediatek/Kconfig         |   11 +-
 drivers/net/ethernet/mediatek/Makefile        |    1 +
 drivers/net/ethernet/mediatek/airoha_eth.c    | 2709 +++++++++++++++++
 5 files changed, 2900 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
 create mode 100644 drivers/net/ethernet/mediatek/airoha_eth.c

-- 
2.45.2


