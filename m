Return-Path: <netdev+bounces-214100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B819B2847D
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 18:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D57E561F41
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 16:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC4C25782A;
	Fri, 15 Aug 2025 16:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+DXsfzw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D6219DF4F;
	Fri, 15 Aug 2025 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276926; cv=none; b=iA67O3QRmCNImAUIlfb+fGIWMjimaqnTA8/EhS/pOcZ8a3i8y9/qSSZMJaQ7SPlPqUpR64hntAaGmeGG/dRyFgx3fxKuBS8gAJ9lRmzPLXTGcqpLt20lor5no0IFNiCb45hwoEOzZ1mGZEI4KTRZbnEItmXHZ+/IyORKjgBFzBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276926; c=relaxed/simple;
	bh=zl87QclcDa3DKTevz342RWsdUkmKZ3kWOu2bPgZotaQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NwD2KdCqH3u6XWHSUZLofbR9KKd2iyu5ezCTeRUpSG5AIStwJzgN6dUsf/yAOastkZKnUy7fh0+EHufQL0PedcvdIPRCLhTbMAQYMk8kPj10k7fsUqRY2g0K1FioOWVgjNMxLC2c1+MSjor5OvTYlkzQ1lAnwFTt3E655MEfAPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+DXsfzw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF2B4C4CEF1;
	Fri, 15 Aug 2025 16:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755276925;
	bh=zl87QclcDa3DKTevz342RWsdUkmKZ3kWOu2bPgZotaQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=d+DXsfzwZz/1607mPnylsjSqtFkdljLyHXb1M+0KtScK3u3fJozABnYjf/4A3v1dF
	 /KPUafe1k1W61UwDtCQfnE5wiGCr3A+l9Ybnr+dqfTSmwFfmCV2e5xFUe7Lm73HaRu
	 TyWnrpEwdjBWkoRwatOzNR9m7qSTFV3YdiXTQ65CX8wDPk62E5/jdutbvOEGzM/MAz
	 vugEwC/22T+7oWvoqexFFvFGQajpA6+vMs+2ArxZ8aJxn7SkYj8wmIxoTNwIg6YdRN
	 hNkXmV+a4CNEuBjX0sB14Rfyd9B+dTcVWcrcUwghHkYuLhZS++QczJ3H30abbYPhKi
	 GG/a29Q1cf4NQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B349CCA0EE6;
	Fri, 15 Aug 2025 16:55:25 +0000 (UTC)
From: Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Subject: [PATCH net-next v2 0/3] net: stmmac: xgmac: Minor fixes
Date: Sat, 16 Aug 2025 00:55:22 +0800
Message-Id: <20250816-xgmac-minor-fixes-v2-0-699552cf8a7f@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHpmn2gC/32NQQqDMBBFryKz7pRkatF25T2KixBHHahJSYKki
 HdvyAG6fDze/wdEDsIRns0BgXeJ4l0BujRgV+MWRpkKAym6q063mJfNWNzE+YCzZI7YKuq7mUh
 PlqF0n8BVlOwFjhM6zgnGYlaJyYdvPdt19X92d40K7a1VDzJ9bzoazDtxMFfrNxjP8/wBtwHLZ
 70AAAA=
X-Change-ID: 20250714-xgmac-minor-fixes-40287f221dce
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Serge Semin <fancer.lancer@gmail.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Jose Abreu <Jose.Abreu@synopsys.com>, 
 Ong Boon Leong <boon.leong.ong@intel.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rohan G Thomas <rohan.g.thomas@altera.com>, 
 Matthew Gerlach <matthew.gerlach@altera.com>, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755276924; l=1234;
 i=rohan.g.thomas@altera.com; s=20250815; h=from:subject:message-id;
 bh=zl87QclcDa3DKTevz342RWsdUkmKZ3kWOu2bPgZotaQ=;
 b=e07IJKlqLpRHehRFXDj41qKkESxMxzz5NMzfNCTXpgPDuowY+O4sUC/gPBXEZ9NWseGEfNinm
 rkO9woTy9UxBhgwURhP+g6fPGdtebSJAlvhGr6DwzbJJ1lwj9/FqhuN
X-Developer-Key: i=rohan.g.thomas@altera.com; a=ed25519;
 pk=5yZXkXswhfUILKAQwoIn7m6uSblwgV5oppxqde4g4TY=
X-Endpoint-Received: by B4 Relay for rohan.g.thomas@altera.com/20250815
 with auth_id=494
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
Changes in v2:
- Added Fixes: tags to relevant commits.
- Added a check for synopsys version to enable 10Mbps, 100Mbps support.
- Link to v1: https://lore.kernel.org/r/20250714-xgmac-minor-fixes-v1-0-c34092a88a72@altera.com

---
Rohan G Thomas (3):
      net: stmmac: xgmac: Do not enable RX FIFO Overflow interrupts
      net: stmmac: xgmac: Correct supported speed modes
      net: stmmac: Set CIC bit only for TX queues with COE

 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 13 +++++++++++--
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c  |  9 +++++----
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   |  6 ++++--
 3 files changed, 20 insertions(+), 8 deletions(-)
---
base-commit: 88250d40ed59d2b3c2dff788e9065caa7eb4dba0
change-id: 20250714-xgmac-minor-fixes-40287f221dce

Best regards,
-- 
Rohan G Thomas <rohan.g.thomas@altera.com>



