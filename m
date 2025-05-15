Return-Path: <netdev+bounces-190830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731CBAB9072
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 22:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77EE83A2A12
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 20:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6BC1F78E0;
	Thu, 15 May 2025 20:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ffImzayx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35931DE3A5;
	Thu, 15 May 2025 20:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339272; cv=none; b=H+eEPuuEe08r8VGXW9RwoQOdMSuzQXLEjqYPuTNOnjingCouwwYKxWibXuX/ekvqFfcAm1jcERu/Fy2qlc9TEw0AcmUQvgr8J89yeKA30ODvECz+mNU7BQQ8bY6Afb5hkpzp/QbrcL8I9ZOYuacoDfVzyWUALg7tEL+UR7RxJIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339272; c=relaxed/simple;
	bh=V8A6kL7k0T7FGuERctoH99KMK0UQUn9FlYtLbvWoCcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTnNvvKOn/t7rEIavqNfZbiLWLzW1EVieKmDh/Nhk1HoZDdhaljNmW/BqhKmJ7LnsZxEB0l/xN0d6qT0X/l/RkFPlel9leoL4gmlnekS7Fx40SkMVuBXHBH6fscQoe2g+OVaNjrVfiZfi5wiXjMnlFQ6ohRRwAwVAoz1hQGv4hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ffImzayx; arc=none smtp.client-ip=80.12.242.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id FekBuCN6oIqMPFekNugnlY; Thu, 15 May 2025 22:00:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1747339203;
	bh=syHX3ePlCOfAt9od3HD1QU5fZnKKQgenE6TOoaHBCO4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ffImzayxzCuQqUxZrUmLMtOQvWTsL5s8UxxZdZ55u6P628315zXwChazaAuvs5Qrp
	 LeAgU58fGl67+u6f34HzTj0NDa/Cwc79lSbvH9gMNenK6ng0Uq0Ag71rHG+3X3REX3
	 a9YInNI6m9KBwCHfNFKCVY4bJyBNmlZDziqv4JedkhDlQTIvpmNVUPG7UieArsMfaV
	 BJMzlxW6e21GtYPtM0lsTM456+aZHlWDHMdWdReK0rIaqq7d/nsvhL+0+nyaIAYcPe
	 P+ZJJPSDk+Pn32di25T4oJeer8jgwxQp48UkETzlzIOo8YBU0OEqUCwmmAjLKCBrqX
	 7NjKXKlU2pAjw==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 15 May 2025 22:00:03 +0200
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
Subject: [PATCH v3 2/4] net: airoha: Fix an error handling path in airoha_probe()
Date: Thu, 15 May 2025 21:59:36 +0200
Message-ID: <47910951a3fa3c3bd2a942210e821d9301362128.1746715755.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <5c94b9b345017f29ed653e2f05d25620d128c3f0.1746715755.git.christophe.jaillet@wanadoo.fr>
References: <5c94b9b345017f29ed653e2f05d25620d128c3f0.1746715755.git.christophe.jaillet@wanadoo.fr>
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
Changes in v3:
  - call airoha_ppe_deinit() and not airoha_ppe_init()   [Lorenzo Bianconi]

Changes in v2:
  - Call airoha_ppe_init() at the right place in the error handling path
    of the probe   [Lorenzo Bianconi]
v2: https://lore.kernel.org/all/3791c95da3fa3c3bd2a942210e821d9301362128.1746715755.git.christophe.jaillet@wanadoo.fr/

v1: https://lore.kernel.org/all/f4a420f3a8b4a6fe72798f9774ec9aff2291522d.1744977434.git.christophe.jaillet@wanadoo.fr/

Compile tested only.
---
 drivers/net/ethernet/airoha/airoha_eth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index af8c4015938c..d435179875df 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2967,6 +2967,7 @@ static int airoha_probe(struct platform_device *pdev)
 error_napi_stop:
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
 		airoha_qdma_stop_napi(&eth->qdma[i]);
+	airoha_ppe_deinit(eth);
 error_hw_cleanup:
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
 		airoha_hw_cleanup(&eth->qdma[i]);
-- 
2.49.0


