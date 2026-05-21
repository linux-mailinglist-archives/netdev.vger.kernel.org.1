Return-Path: <netdev+bounces-290559-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCzSJXU9D2ocIQYAu9opvQ
	(envelope-from <netdev+bounces-290559-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:14:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 344005A9FBC
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04E9E303EF61
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E941372079;
	Thu, 21 May 2026 16:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LT8oEfb9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD7127144B;
	Thu, 21 May 2026 16:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779381168; cv=none; b=ePejU64Vz/9205XYsTIRq8Mri2f5kwjISEULEjRkzVkEfrlM7aWLOWdPaHTimeOw5ASxgZa01ghQOr1vVj3EVEMJ504zFrGHRA7KlgJHYScBujYpd9aLI2/yQbjqk7P+WflGR2xJ9MDf5pAwdNHZ/YQQmePALCGRMktgLKmtuDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779381168; c=relaxed/simple;
	bh=z3v6YO+0Wv56+AsTvqL7AMaNeB9qSJnJg6uwyLqlCXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Org022fU10gJ2UQsn+cFkaSZBWODbnLMynu30jdw1yFaV3SbCkWbzoMPIIKHzF3kQPi2T2BDrkP/eGMTDnAusnqqn9nOzhI6xul5fkHMvjHzcU5Nb60rWAi8yoZ2yULd8JECfYa/XV+mKsA5SD43nI2MKCyz9NCkDpdOwNrixbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LT8oEfb9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD768C2BCB4;
	Thu, 21 May 2026 16:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779381167;
	bh=z3v6YO+0Wv56+AsTvqL7AMaNeB9qSJnJg6uwyLqlCXQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=LT8oEfb9sI945gIfNB7Ll7i8odp/msHWe6c1V0v2SbCfPy5l4EAQkotx9Dudz3bCO
	 fcaL6onQCErdJZQZqWTUEWnnLvItCuEXY4JKKGHgDvP/6p7Kv8wYi8pygIxfewy/UN
	 PRJxNY8Dg1L8s/Vm1k+sWUfY4NqicvnoUBTb7w1DhfPK5hQ8EEhRfpl+h6xX3m1P/I
	 VlqWHbBJ0Nwwot6a1Y+t0ZRbE1Znq9c+rJtvCgElNglIic8at5gZ2kGjs4KsIgilrk
	 2obsJiYVWJzQPCyJPoH29Y/a9rfGMQOBVcXLE1UodFW44w+c0ASPjhVNoLxSDxnsjc
	 fhYSuNK2oa8Rw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C320CCD5BAF;
	Thu, 21 May 2026 16:32:47 +0000 (UTC)
From: Abid Ali via B4 Relay <devnull+dev.taqnialabs.gmail.com@kernel.org>
Date: Thu, 21 May 2026 16:32:46 +0000
Subject: [PATCH v2] net: stmmac: mmc: Remove duplicate mmc_rx crc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-xgmac-mmc_rx_crc-cleanup-v2-1-7d9de09f5898@gmail.com>
X-B4-Tracking: v=1; b=H4sIAK0zD2oC/42NUQ6CMBBEr0L67RpaAoJf3sMQsq5b2IQCaZVgS
 O9u5QR+vsnMm10F9sJBXbNdeV4lyDwlMKdM0YBTzyDPxMrkpspLk8PWOyRwjjq/deQJaGSc3gu
 gJcbKItb4UGm+eLayHep7m3iQ8Jr953ha9S/9Q7pq0HDRRWFL09RlY2+pKeOZZqfaGOMX/Bkb+
 8AAAAA=
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abid Ali <dev.taqnialabs@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779381166; l=1735;
 i=dev.taqnialabs@gmail.com; s=20260425; h=from:subject:message-id;
 bh=YT6MwxbT32LmsJ0Q4toXiSUGLZ0LUkCCQs3ZtA9Xc6A=;
 b=4nb99cKuWhzcka7MVU0baeVQGR1KS14hPy/Qj6o+FR+zkwGaooEwyN2rZln4L5Ctvpa4Fl4/0
 VoiHf/eHZF6CxH9tbvd1DO3g0ClGL8324bUtCG3NHSJgcWl2owhEIwL
X-Developer-Key: i=dev.taqnialabs@gmail.com; a=ed25519;
 pk=4Syx51HH/MOySSUpi79M2ToLOdwt1yiNb338eKZBJNk=
X-Endpoint-Received: by B4 Relay for dev.taqnialabs@gmail.com/20260425 with
 auth_id=752
X-Original-From: Abid Ali <dev.taqnialabs@gmail.com>
Reply-To: dev.taqnialabs@gmail.com
X-Spamd-Result: default: False [1.34 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290559-lists,netdev=lfdr.de,dev.taqnialabs.gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	HAS_REPLYTO(0.00)[dev.taqnialabs@gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 344005A9FBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Abid Ali <dev.taqnialabs@gmail.com>

MMC_XGMAC_RX_CRC_ERR is clear-on-read, and just a single read would
update the mmc_rx_crc_error counter.

[1] commit b6cdf09 ("net: stmmac: xgmac: Implement MMC counters").
The duplicate read appears to have been unintentionally introduced in
the intial MMC counter implementation. The databook does not mention
MMC_XGMAC_RX_CRC_ERR needing the additional read.

Fixes: b6cdf09 ("net: stmmac: xgmac: Implement MMC counters")
Signed-off-by: Abid Ali <dev.taqnialabs@gmail.com>
---
Changes in v2:
- Updated why the redundant read is removed based on feedback.
- Link to v1: https://lore.kernel.org/r/20260520-xgmac-mmc_rx_crc-cleanup-v1-1-7133f529859f@gmail.com
---
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
index 1b3b114e7..d81581dfa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
@@ -479,8 +479,6 @@ static void dwxgmac_mmc_read(void __iomem *mmcaddr, struct stmmac_counters *mmc)
 			     &mmc->mmc_rx_multicastframe_g);
 	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_CRC_ERR,
 			     &mmc->mmc_rx_crc_error);
-	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_CRC_ERR,
-			     &mmc->mmc_rx_crc_error);
 	mmc->mmc_rx_run_error += readl(mmcaddr + MMC_XGMAC_RX_RUNT_ERR);
 	mmc->mmc_rx_jabber_error += readl(mmcaddr + MMC_XGMAC_RX_JABBER_ERR);
 	mmc->mmc_rx_undersize_g += readl(mmcaddr + MMC_XGMAC_RX_UNDER);

---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260520-xgmac-mmc_rx_crc-cleanup-afcea6faa8ab

Best regards,
-- 
Abid Ali <dev.taqnialabs@gmail.com>



