Return-Path: <netdev+bounces-184134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59012A936BD
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 13:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B25587AC54B
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 11:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BF32741B9;
	Fri, 18 Apr 2025 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="IINTY5fD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-77.smtpout.orange.fr [80.12.242.77])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E9120968E;
	Fri, 18 Apr 2025 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744977549; cv=none; b=i2iq3Div7G+IBPIgU89k/B07IMXCxrdSKjJy+2h06qhnZ/imF00b4gI8tur2TFSeeJfN9DIHCZT9zG3Khy4e+JkPp2HpmHOunZaNunqiPSmeXOFkPo+7ol6EUkbhN+fhp3/7OPHcwngCK8He2aYaXZeUK0QxTQsXwLdfDC/TUEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744977549; c=relaxed/simple;
	bh=mSrMqZMkoww9zIQR63Kt0ZNfCRFtVwKj2WuVPvC1Scg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rLsZfk0jjEed6XhLUhWlHjLrMfimorjzlrOcZdrz4uABtAr72WNQfEypEIsthvjIs8fFH35vtL5AfQZXaoz24IGSDCw4yAMiOPHUqKs2xCq41/7YJ/AH/3ioEmEMzH2mhVMQrifd1uEWX9htCvxv7YaeXtLvk1W0AUliLSX2OeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=IINTY5fD; arc=none smtp.client-ip=80.12.242.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 5kLrukPOCwRVI5kLvuhwOq; Fri, 18 Apr 2025 13:57:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1744977474;
	bh=/yv0q0yAiYrK7cZmfj6mkT6aQadrznpZkBjcoHK2bCU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=IINTY5fD5eE9X34gkUqcTpIp5tMMKToJugigViLAGf4AtTGY3QZOXd2wI9uhTvGD+
	 TpoeTrogvIVoGn5k00oxWtPAyYL5o0CitNncozgvTPip+N2K6g9RNsKQuHPioUGUC2
	 88SB/FjhYtEUg5qD9OaUJ95QSiWaToBOfFqC9gw50drFEBB3BV79yQbdxxqsl2JhD4
	 iLDPcWoshlYskqjEH/J+z9WkDunNg09uIL+ypQXL1DlRTr4OSaTjsrwar7Q/4aH+KP
	 L7xpMIjhJbJK7D6ZKUdN1qZ9w1HZ9cCP1ps6nEm2mJ0S0CBXec4uMfbafBza5I22EK
	 YVu+8pjf7hzag==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 18 Apr 2025 13:57:54 +0200
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
Subject: [PATCH] net: airoha: Fix an error handling path in airoha_probe()
Date: Fri, 18 Apr 2025 13:57:34 +0200
Message-ID: <f4a420f3a8b4a6fe72798f9774ec9aff2291522d.1744977434.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an error occurs after a successful airoha_hw_init() call,
airoha_ppe_deinit() needs to be called as already done in the remove
function.

Fixes: 00a7678310fe ("net: airoha: Introduce flowtable offload support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only
---
 drivers/net/ethernet/airoha/airoha_eth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 69e523dd4186..252b32ceb064 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2631,6 +2631,8 @@ static int airoha_probe(struct platform_device *pdev)
 		}
 	}
 	free_netdev(eth->napi_dev);
+
+	airoha_ppe_deinit(eth);
 	platform_set_drvdata(pdev, NULL);
 
 	return err;
-- 
2.49.0


