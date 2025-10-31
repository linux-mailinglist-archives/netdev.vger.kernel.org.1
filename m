Return-Path: <netdev+bounces-234718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BD0C26563
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 18:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F8EA4E509F
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9794F30648A;
	Fri, 31 Oct 2025 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YezzmReo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD5E2FB0B9;
	Fri, 31 Oct 2025 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931636; cv=none; b=TnT5EDmEsltEIx/8NcIBpGC7ggv42Y7vancDaU0a/z07zkb3wg65aCG0uMX4HSW1lZKeC4B8S3dHFH6JIn6V++3rnT+FIAIsSC6LIKX8EN+8NpIL5lNeNugwKNB3PGEgGQMXIBzWXcNHfaizSTeCp1UppxLs8WsLBdSmlgTWDMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931636; c=relaxed/simple;
	bh=t4zIx4Z11X9zS02u+s0yDHEllOpDAKEqSMdLm4SCIRU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CrP9t78zJnfwHtRWBwHRG4F5MXCyhSsYZHwNAopccir1eYsrgkRU1N6E9gefZPwV5v5b/j8/gVz1CRO0q6HBuQVoyx5Axtll6f/K5d4JP5clXUzQMxxIqlu6uKGJNFdYpNuVWf8g/qanZvPyZX/jpOqedM415quX7WZG2rumTAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YezzmReo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6458C4CEE7;
	Fri, 31 Oct 2025 17:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761931636;
	bh=t4zIx4Z11X9zS02u+s0yDHEllOpDAKEqSMdLm4SCIRU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=YezzmReoBglXbbwmuX7vtp2Yo5fWl1KttjMuHVlFK4VMneRMnUbGJrpjNwcAAJWAv
	 wBBNW2CT8fXIxeK1SdB3sV/vmSNuC1LZ7O04Mk86aAGJHpEQ/jrqWDNUxj5oE4QiWs
	 exT7DjIq2vEm1+p3quxHp7VZRNfl7+VX+/h/ZOiinzitSJDqSeAjcggvv11zdcJiTn
	 xv6YMeUrySBTqXgwi892Ivh7Dvv/m0b4+v08+8AoHjzafHbhyId+B6+XsoZGyRj+ri
	 LC77rKbh7ewjJkAEmFCj6al2UmFsQl2V8TDo1mbaiQsv7d5CH/zBN6NdDmu9UI9AjB
	 xjNbYqGXrC5Og==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D82CCFA02;
	Fri, 31 Oct 2025 17:27:15 +0000 (UTC)
From: Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Subject: [PATCH net-next v2 0/4] net: stmmac: socfpga: Add Agilex5 platform
 support and enhancements
Date: Sat, 01 Nov 2025 01:27:06 +0800
Message-Id: <20251101-agilex5_ext-v2-0-a6b51b4dca4d@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGrxBGkC/22NwQqDMBBEf0X23JRsxEp66n8UKWmy6oKNkgRJk
 fx7g+cehzfz5oBIgSnCvTkg0M6RV1+DujRgZ+MnEuxqBiVVh1JpYSZeKHcvyklY7N+u77V1NEJ
 dbIFGzqftCZ6S8LUFQyUzx7SG73mz48n/GncUUqBuEVtVze72MEuiYK52/cBQSvkBxwC0UbEAA
 AA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761931634; l=1421;
 i=rohan.g.thomas@altera.com; s=20250815; h=from:subject:message-id;
 bh=t4zIx4Z11X9zS02u+s0yDHEllOpDAKEqSMdLm4SCIRU=;
 b=8tiYGEzN7w19aqajaofQRjkGf2F3m3eiOWWkDj28bjUqjQj6UIaO4zBm5kbVZIxDz1VNq8w2i
 dSp1UujxJ92AuHoJwtCC4A5HU1kp3nuDde1lw7H3PS28n7NfeQi3Q6x
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
Changes in v2:
- Fixed reduntant leftover tsis irq and use_ns changes from smtg_crosststamp
- Keep common platform config for socfpga platforms in socfpga_dwmac_probe
- Link to v1: https://lore.kernel.org/r/20251029-agilex5_ext-v1-0-1931132d77d6@altera.com

---
Rohan G Thomas (4):
      net: stmmac: socfpga: Agilex5 EMAC platform configuration
      net: stmmac: socfpga: Enable TBS support for Agilex5
      net: stmmac: socfpga: Enable TSO for Agilex5 platform
      net: stmmac: socfpga: Add hardware supported cross-timestamp

 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    | 166 ++++++++++++++++++++-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |   5 +
 2 files changed, 168 insertions(+), 3 deletions(-)
---
base-commit: 0d0eb186421d0886ac466008235f6d9eedaf918e
change-id: 20251029-agilex5_ext-c17bd779cdef

Best regards,
-- 
Rohan G Thomas <rohan.g.thomas@altera.com>



