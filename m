Return-Path: <netdev+bounces-233821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A43C18FA6
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 09:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A1246535F
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6E9320A32;
	Wed, 29 Oct 2025 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcRRDlLr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A6931D754;
	Wed, 29 Oct 2025 08:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725185; cv=none; b=P6wSoF5GeISOuQKS1vH4syDMKJzmuCbC3wCc2pSoS1yUrMvqbd2Nmh6lUyyw4OoGDerHQ4aHzXO2h10C2JTazR1BUQwOkX471WjliUbADVxbJEUjBT4pqIfXJ42RZ2mUy/xuFvphDusF/qLWc1M4xY7a2pDKf4Ub2HochdPdPvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725185; c=relaxed/simple;
	bh=lJ1JcnHdvyDKrgvkF/InxR6fht7QWyd7w3ZrjqQQ9h8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SAnpuNg+97MqbJC+NeCPEtyaCUf/7OS9zVQAJ8jcCSSKrsIIFtGdsxH3jH+SwnWYX9/Aw29IyCYlAppEAJZm9tJFvpuZ4nb2O1iQOL3MLWZlCTNSbIz9ncUspkhrZHP+6AnUtigqV+k05972Qb/+1mHzJVYjOFSRWVyUAf0OqMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcRRDlLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5BD8C4CEF7;
	Wed, 29 Oct 2025 08:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761725184;
	bh=lJ1JcnHdvyDKrgvkF/InxR6fht7QWyd7w3ZrjqQQ9h8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=BcRRDlLr5xYeb2Mi9o3YKmofKe4m49dtHv2WhfJJhMCgLbqSUY72233AvLmZvaUPy
	 3pT52UGo4jjBvn0oK3rM71NotBEsurzBX771VrzFnLMjXvB7lPJfqCWK5rPgbO5aYK
	 UbxKQAQ4NyQwlD6Sw89lrTjSXKpofVM0+T2saggVff9fDtySs0RbIB95sYPGe/CjN8
	 fi58wuMaymqN5D3Dego7LDDhJncmqRcFSExrJ9m+8EC+f4v8GhulkDYShhjdfHWvs7
	 t8dYGTL9FvLiMcC7Atix+vx6MATfrEohdsGsYzOvBju90ugre34WVuRpN4vs9VSMUo
	 teU0BawZxWQiA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A54CCF9EE;
	Wed, 29 Oct 2025 08:06:24 +0000 (UTC)
From: Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Subject: [PATCH net-next 0/4] net: stmmac: socfpga: Add Agilex5 platform
 support and enhancements
Date: Wed, 29 Oct 2025 16:06:12 +0800
Message-Id: <20251029-agilex5_ext-v1-0-1931132d77d6@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPXKAWkC/x2MUQqAIBAFrxL7nZBCSF0lIkxftRAWKiFId0/6H
 JiZQhGBEWlsCgU8HPnyFWTbkD2M3yHYVSbVqV52ahBm5xO5X5CTsFKvTuvBOmxUiztg4/zfJvJ
 IwleL5vf9AEtpE2pnAAAA
X-Change-ID: 20251029-agilex5_ext-c17bd779cdef
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rohan G Thomas <rohan.g.thomas@altera.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761725182; l=1154;
 i=rohan.g.thomas@altera.com; s=20250815; h=from:subject:message-id;
 bh=lJ1JcnHdvyDKrgvkF/InxR6fht7QWyd7w3ZrjqQQ9h8=;
 b=DlJCfseSUGZMDjXBw1VVh0mpCeu7xVTb3IZNFGwtIb2gtoPFVZd7U5fHRN6pO+qAd5Jjj6orE
 q/SIliAdApzAhEVmXtDQZjhmvj49K5KPSkeCRRyKCOfz2udKbhDaMSb
X-Developer-Key: i=rohan.g.thomas@altera.com; a=ed25519;
 pk=5yZXkXswhfUILKAQwoIn7m6uSblwgV5oppxqde4g4TY=
X-Endpoint-Received: by B4 Relay for rohan.g.thomas@altera.com/20250815
 with auth_id=494
X-Original-From: Rohan G Thomas <rohan.g.thomas@altera.com>
Reply-To: rohan.g.thomas@altera.com

This patch series adds support for the Agilex5 EMAC platform to the
dwmac-socfpga driver.

The series includes:
   - Platform configuration for Agilex5 EMAC
   - Enabling Time-Based Scheduling (TBS) for Tx queues 6 and 7
   - Enabling TCP Segmentation Offload(TSO)
   - Adding hardware-supported cross timestamping using the SMTG IP,
     allowing precise synchronization between MAC and system time via
     PTP_SYS_OFFSET_PRECISE.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
---
Rohan G Thomas (4):
      net: stmmac: socfpga: Agilex5 EMAC platform configuration
      net: stmmac: socfpga: Enable TBS support for Agilex5
      net: stmmac: socfpga: Enable TSO for Agilex5 platform
      net: stmmac: socfpga: Add hardware supported cross-timestamp

 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    | 194 +++++++++++++++++++--
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |   5 +
 2 files changed, 189 insertions(+), 10 deletions(-)
---
base-commit: a8abe8e210c175b1d5a7e53df069e107b65c13cb
change-id: 20251029-agilex5_ext-c17bd779cdef

Best regards,
-- 
Rohan G Thomas <rohan.g.thomas@altera.com>



