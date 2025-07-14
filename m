Return-Path: <netdev+bounces-206582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195E6B0388F
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 10:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688FE3B58A1
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 08:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911C523B62A;
	Mon, 14 Jul 2025 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUUqJAx/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E4323B605;
	Mon, 14 Jul 2025 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752480028; cv=none; b=b89i2I9w/q57VVaKRegGMzxFyOHtcqvvDgxaViHcccXzeQiprVh8QVohtybsrgoVy4Hv5II1KHb0Tg9VBbSq/v1Amlnc0hdkZxojFfFrLJXoZP9+j/qZxaaPTYCQ2huUeEgGPIcDO6MLD4ga+2vPDBmXfB3z8OMpQByfdj15N8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752480028; c=relaxed/simple;
	bh=x7tBS5TJxVqQ22cB02A2Vi0xzr6SLrJTnF6VPCHBuUc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mGSvNG8f3VWk83W9KWfu95hFjPJhHU1O9k76E7HAsjA1AHOHRT19bLPQEduKlMz2pS+0wLrV2KQOs+vXDwsFSnDQwligTx05TABhs31UU0h3CV6CxIaNW+1CqfALdg8d50M1a3Dp71HzfvSuxQP+rINTRJMuBWNQafQ7D/Dv9IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUUqJAx/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CAB46C4CEED;
	Mon, 14 Jul 2025 08:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752480027;
	bh=x7tBS5TJxVqQ22cB02A2Vi0xzr6SLrJTnF6VPCHBuUc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=WUUqJAx/sxPwfUHZBKTN/pEBNRu+2xugoe5P+8CKGVR9znodPsnWpP8n8QTKaP39h
	 kB/vr5SfJSW6bbAb8jt45oga+JRojaoB/ZziIDudTu8z0+ZDHDX3gVuAWxPKtP4lZZ
	 1v7qz4k4K6dL14tDN6S0ru2GXlQW37t41BQlHS9hN3V5kgVhniHvKSO9WfsmEjatvL
	 2Q7kbCF370XwJFdD6XpGxfnxb148k6Vc9qZt9e1SmEGxIXWs9jy7cazCYVsjVUwi68
	 NqXFTJLpYZPm6yLKSduqCnqVIZaDhTTwn75lVwe80WStfd/uxZVm4L0s9wLAevHtMr
	 Ie12TrVwJdsig==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7A9C83F1A;
	Mon, 14 Jul 2025 08:00:27 +0000 (UTC)
From: Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Subject: [PATCH net-next 0/3] net: stmmac: xgmac: Minor fixes
Date: Mon, 14 Jul 2025 15:59:16 +0800
Message-Id: <20250714-xgmac-minor-fixes-v1-0-c34092a88a72@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANS4dGgC/x3LQQqDMBBG4auEWTuQDBZLr1K6CPHXzsKxJCIBy
 d0NXX483kUFWVHo5S7KOLXobh1hcJS+0Vawzt0kXh5+CiPXdYuJN7U986IVhUcvz2kRCXMC9e+
 X8Q99e5PhYEM96NPaDauDp35tAAAA
X-Change-ID: 20250714-xgmac-minor-fixes-40287f221dce
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Serge Semin <fancer.lancer@gmail.com>, 
 Romain Gantois <romain.gantois@bootlin.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rohan G Thomas <rohan.g.thomas@altera.com>, 
 Matthew Gerlach <matthew.gerlach@altera.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752480026; l=990;
 i=rohan.g.thomas@altera.com; s=20250415; h=from:subject:message-id;
 bh=x7tBS5TJxVqQ22cB02A2Vi0xzr6SLrJTnF6VPCHBuUc=;
 b=eOyvh3AjlRrzHzO8kmZyoZOWk31VG+/F2coZiafOWwdLSJAK9xzmHqHbMMCpIaCjoQYXDcbwX
 o0FxciB5jAlCR/+aFZH/hv6+9wY3JRJfY2tV2ejIrqE2psmZwydwODO
X-Developer-Key: i=rohan.g.thomas@altera.com; a=ed25519;
 pk=TLFM1xzY5sPOABaIaXHDNxCAiDwRegVWoy1tP842z5E=
X-Endpoint-Received: by B4 Relay for rohan.g.thomas@altera.com/20250415
 with auth_id=460
X-Original-From: Rohan G Thomas <rohan.g.thomas@altera.com>
Reply-To: rohan.g.thomas@altera.com

This patch series includes following minor fixes for stmmac
dwxgmac driver:

    1. Disable Rx FIFO overflow interrupt for dwxgmac
    2. Correct supported speed modes for dwxgmac
    3. Check for coe-unsupported flag before setting CIC bit of
       Tx Desc3 in the AF_XDP flow

Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
---
Rohan G Thomas (3):
      net: stmmac: xgmac: Disable RX FIFO Overflow interrupts
      net: stmmac: xgmac: Correct supported speed modes
      net: stmmac: Set CIC bit only for TX queues with COE

 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 14 ++++++++++++--
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c  |  5 +----
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   |  6 ++++--
 3 files changed, 17 insertions(+), 8 deletions(-)
---
base-commit: b06c4311711c57c5e558bd29824b08f0a6e2a155
change-id: 20250714-xgmac-minor-fixes-40287f221dce

Best regards,
-- 
Rohan G Thomas <rohan.g.thomas@altera.com>



