Return-Path: <netdev+bounces-189012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F48AAFDD7
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 16:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BDFD1BA2BCB
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14D8278762;
	Thu,  8 May 2025 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="K5JwIVyr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-75.smtpout.orange.fr [80.12.242.75])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BDE2741CB;
	Thu,  8 May 2025 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716064; cv=none; b=Pz+Ny7IsqS3iI76F9DR+sJ8vlpdIM4834FiUcGDfcFDGXsLktIJRLdhTMpsWy8QOazbITbtvtv06L5Ukf6aZGvUWh2cA+Z2SoEHQiA3LY6NgnLsKS1LJFE5hJgydhEZxEaQz+DyGN30MSmm/ug/RqYfSfXl6IO3EJQujgvx3O+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716064; c=relaxed/simple;
	bh=1ONmakleqe1plbdupt6Kh9XABBF1Eeb8V1otE18wMtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Br5ugbvAn1z8sICMUcVTAYMRVaqJd5Q8ClUdHurmsE08pemezTUKJCJP7KM/pOkP9dZVBBY6xtQxx5Dj3YN4gVmuEKDP2bIqZeqs64jDW3wOUv7HCADn1vBoQhcofVj8py6pK7Qp2vdV7Aev/qcF0IGTTKQNMJk1dUa8tHSL+cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=K5JwIVyr; arc=none smtp.client-ip=80.12.242.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id D2cYuomdl816KD2cYuwCQe; Thu, 08 May 2025 16:53:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1746715992;
	bh=vArwvLV+DEZKEL8y1k44EnYo/gsnysUUsECWxXjPHCQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=K5JwIVyrFl6zcwMB6BQ36dIsDj2X5gjjP4iZB+SlpYmP2JtaxFRgYzcbuoxDx1kMf
	 QLsUE9nuRN4/kfeaOUkxWp9QjFslP7RYi0QCKfkVL8uaHvkszJcd8FH3S+B56O17L0
	 KzhGx6eyeL9rpqlvzvfh8mkXyQ7CYuMdw5sk6J2DiaQ+8XvshmxNa+0MsWQ4p+yfGF
	 2ECs5s8RVo4S1Qq5oMu9neMacarqYYtV7I+HJ1nFMw4TSOh9IeeOD537YlRCJwMFIq
	 GL1qcyEJUg1GFSwHDD5PzXriZSLsDQ2DTF9pGQ1CVtlbNEMv96yhLfyf67tWowAdXX
	 bMubNTgI5UJ3Q==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 08 May 2025 16:53:12 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 1/4] net: airoha: Fix an error handling path in airoha_alloc_gdm_port()
Date: Thu,  8 May 2025 16:52:25 +0200
Message-ID: <5c94b9b3850f7f29ed653e2205325620df28c3ff.1746715755.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If register_netdev() fails, the error handling path of the probe will not
free the memory allocated by the previous airoha_metadata_dst_alloc() call
because port->dev->reg_state will not be NETREG_REGISTERED.

So, an explicit airoha_metadata_dst_free() call is needed in this case to
avoid a memory leak.

Fixes: af3cf757d5c9 ("net: airoha: Move DSA tag in DMA descriptor")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Changes in v2:
  - New patch

Compile tested only.
---
 drivers/net/ethernet/airoha/airoha_eth.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 16c7896f931f..af8c4015938c 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2873,7 +2873,15 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 	if (err)
 		return err;
 
-	return register_netdev(dev);
+	err = register_netdev(dev);
+	if (err)
+		goto free_metadata_dst;
+
+	return 0;
+
+free_metadata_dst:
+	airoha_metadata_dst_free(port);
+	return err;
 }
 
 static int airoha_probe(struct platform_device *pdev)
-- 
2.49.0


