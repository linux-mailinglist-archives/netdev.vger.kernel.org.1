Return-Path: <netdev+bounces-216370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75019B33535
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 06:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6997E189EA26
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 04:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193E9281531;
	Mon, 25 Aug 2025 04:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSdhfPja"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37BD28150A;
	Mon, 25 Aug 2025 04:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756096630; cv=none; b=DPqjyKPv6Gh4axkAxcgJVNJ+tU2h62+H17IbsOdI/+lcxf58e9GC5uQbRbq1m/3Kly01yApGqzhASqieIyxtP0uyGTdUGZnCM9kdb9q0aSjTNFwfdB/8ov+7IwP/1IzRu9D2b/HqjCtTE1fqi3seqjo95q0nau0RCFOt7GdkKOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756096630; c=relaxed/simple;
	bh=qbmrznk8y3bTUpjqPLSvWYU8OwN7QufMMM55Yj86Gkw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=igivjEYF7aW4NbF9mooGoFTs5sEIMDDDdh5qjX0mRQ8IowH1AHl0EFf/ZA2zeR6BLuKWi8ZIeRz433d0rOP6428Nvk7GMpeFtm5rA6JsBX5O2jZ4RV/RekuDvdMmxYanReTSQZYY98O/ioddJJ2n3k58Qf2AaWZi4U+FM61gWqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSdhfPja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76E7AC4CEF4;
	Mon, 25 Aug 2025 04:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756096629;
	bh=qbmrznk8y3bTUpjqPLSvWYU8OwN7QufMMM55Yj86Gkw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=TSdhfPjaKUkCMfdZp6E1WGCCorVE09YvUlhgqThgPprHZL+GglTNpnY/9elKdcxEq
	 skgve9Ww+us2OO5HJSLbCFn041VBYSjkr49jiGsqAflvZEOInxo80fkB7kciOZnbLI
	 Ea1GDxhQIvWz5js7FSF2gzB4GtoZjV4yvOdlnwjYI+A9PZwNskiwzj+zcSy39ELASx
	 68DXrvRC9NCp4eZxhq1J81iGiPNNeGr4BbwszzYMBsqIfsqW7nZN/s66057Dd3htrz
	 lKjdmEeEvN+hvMEhrsgaD9C5pLFapiEXtti6xB0QL5KnBjb2T6GRJu03v7N7u7aol1
	 RDZTK6QZaUesQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FACCA0FE1;
	Mon, 25 Aug 2025 04:37:09 +0000 (UTC)
From: Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Subject: [PATCH net v3 0/3] net: stmmac: xgmac: Minor fixes
Date: Mon, 25 Aug 2025 12:36:51 +0800
Message-Id: <20250825-xgmac-minor-fixes-v3-0-c225fe4444c0@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGPoq2gC/33NTQrDIBAF4KuEWdeikz/TVe9RuhAzJkKjRYOkh
 Ny94qYUSpdvHu+bHSIFSxEu1Q6Bko3WuxzqUwV6Vm4iZsecATm2vBcN26ZFabZY5wMzdqPIGo6
 yN4hi1AR59wxUijy7gaMV7vk427j68Cp/kijVHzIJxpmuGz6gklL1eFWPlYI6a78ULuGHkKL7R
 WAmumFoW9QmE+aLOI7jDdEnumv7AAAA
X-Change-ID: 20250714-xgmac-minor-fixes-40287f221dce
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <Jose.Abreu@synopsys.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Serge Semin <fancer.lancer@gmail.com>, 
 Ong Boon Leong <boon.leong.ong@intel.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rohan G Thomas <rohan.g.thomas@altera.com>, 
 Matthew Gerlach <matthew.gerlach@altera.com>, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756096627; l=1399;
 i=rohan.g.thomas@altera.com; s=20250815; h=from:subject:message-id;
 bh=qbmrznk8y3bTUpjqPLSvWYU8OwN7QufMMM55Yj86Gkw=;
 b=wb6durDNB7EBHq2OkiLCdW7vqZM17yyaQFwyVzxklzowPsTG1zA8RPFzfe0pjDOg89l4lAE/C
 O0US6x4B5ujDW1ogpumfCPQOh67cwwuBN4pPnWn+WnqvUqBeK5LdVC5
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
Changes in v3:
- Keep variable declaration smallest to largest.
- Link to v2: https://lore.kernel.org/r/20250816-xgmac-minor-fixes-v2-0-699552cf8a7f@altera.com

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
base-commit: b1c92cdf5af3198e8fbc1345a80e2a1dff386c02
change-id: 20250714-xgmac-minor-fixes-40287f221dce

Best regards,
-- 
Rohan G Thomas <rohan.g.thomas@altera.com>



