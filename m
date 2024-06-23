Return-Path: <netdev+bounces-105944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6623F913CB0
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 18:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED97B283086
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 16:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436561822F2;
	Sun, 23 Jun 2024 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fa1ZVjra"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17765F9F0;
	Sun, 23 Jun 2024 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719159629; cv=none; b=i7sXoSc4FfhQ9mDy7gQCRLSHrbp7kJjmAaEbYUJOwOIMuNvWPRg6sKD8U4WdqXtyVtBrqeXcIdIRnHMNfJ4LGPA/EaTuq+m8XPVNm3zUvqt/7JHd3K0sicMqSanA//7zRcGfAz249Y2G8ddHlivrd10N8YyArn1NfdwBIkjaaPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719159629; c=relaxed/simple;
	bh=2W3n7QEpgfPvKDfZlzj4iobwCUXzXN/FvDR+WAOxruc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GZDu5S7+/AzAOrDPwRY0sPUu5fxeyl6GrH2ULQEhezPH7uvTtsOCMYGnLrkkd8WkarenhTnkG5NQV6yXJ9o5RFPuAawUov1MYXPrheoZSo0kUErWB+2hgf0w2LNIUkOyDD43ZyR+DtocMIdZwLHQ7L71z95wLVlAMouipCQB9l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fa1ZVjra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063A7C2BD10;
	Sun, 23 Jun 2024 16:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719159628;
	bh=2W3n7QEpgfPvKDfZlzj4iobwCUXzXN/FvDR+WAOxruc=;
	h=From:To:Cc:Subject:Date:From;
	b=Fa1ZVjraLovOEBQLOeN7wXzUeRRksZgqiKFwqR5dqpSppb+AhheE0hgDArkwbmK23
	 tIU44xm6k62ri2JLxLhce8NfCYu2uWHSnX0ibokica9LNg58AzF1xEm0qylVoNfwGG
	 /Yb3GK4t+DytrDXmWL2fLl6Mcc/ydNu31EYbo8221kvLHcigX1e1YWTWmxMhTwR/vS
	 VPlWXWoKjKJLzI5Ep3rFUoTEp0wCS9sOvJJqUyvStHnFPxG7uIyiW5Qgdktr/ru8Vu
	 SzDDrs96TLSsx3WJv58zocL66c1igs5MdkLQ87WqnsdllHSaBnHPF1xXWNOqB8XuOn
	 JfMfolHsel3kw==
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
	andrew@lunn.ch
Subject: [PATCH v3 net-next 0/2] Introduce EN7581 ethernet support
Date: Sun, 23 Jun 2024 18:19:55 +0200
Message-ID: <cover.1719159076.git.lorenzo@kernel.org>
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

 .../bindings/net/airoha,en7581-eth.yaml       |  108 +
 MAINTAINERS                                   |   10 +
 drivers/net/ethernet/mediatek/Kconfig         |   11 +-
 drivers/net/ethernet/mediatek/Makefile        |    1 +
 drivers/net/ethernet/mediatek/airoha_eth.c    | 1783 +++++++++++++++++
 drivers/net/ethernet/mediatek/airoha_eth.h    |  793 ++++++++
 6 files changed, 2705 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
 create mode 100644 drivers/net/ethernet/mediatek/airoha_eth.c
 create mode 100644 drivers/net/ethernet/mediatek/airoha_eth.h

-- 
2.45.2


