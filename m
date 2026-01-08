Return-Path: <netdev+bounces-248054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21485D0358D
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 15:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F7C83120D28
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 14:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDE33DA7C8;
	Thu,  8 Jan 2026 11:43:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4A047423C
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767872598; cv=none; b=YRZG4WyAq2N4QZgUuYaHPlVU9zi/w2NTOQoVLvyrZQkBfPtRDETKtEvZW20P6XC8SIQs3sVpv48wblnGP0zGl2EW+j6LdwW90OunI/ioIexHN1nuJVx0/DEOihIe95dTJKlCVVUKqRsrd94MB5PCmdCrRnXrJLFus9MND/lWHYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767872598; c=relaxed/simple;
	bh=8E1ysSUShJ8p6nlzz4eEEoUf1cDKgDwOfnAJUPcBZHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sL5oJgjMQhyLvPP3OrFh2Y4L9sLvkjrsMcoIys9G02Qbn8v79OtuAamoK6DrWX8eIYQoiZQhQFL/BaHcbNcQhIsKUd2jXWxOHhIbXlG5y83eTraMXXCk9xvWAvN1pvDHEII2hmD4008s4X+EKRjX3Tl8LEoH0905jK0Y/wT3psA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7c6cc44ff62so2369484a34.3
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 03:43:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767872593; x=1768477393;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLl2yTmIyk/u0fY0OTkeSRaVcVv4cgEfyMzNgksSQTs=;
        b=EFUzZbQSSXxC5Cc0APsOhhWPkc2bMJoIapTHJC98NzFG4BsnAQ6b6l1ENrMQBKaqCv
         1mwSSObhPgWfb2OBfHqPB1+GPrzKccFkokJfwFaHqv/xZ1bL0YlPwiz3mTyD+bUnmfk7
         +YbmV8jpaxQAr516DxwRQCvQtp47O+xBoJU6IRNOJnN1gpgyXHVbU0EVjas7op0V20dw
         mMLpagbAX9DBF1PwYHrkSVCNeoebI8WFGX6ldm+nT8BNbnt7oFBn/AVtQMAeZxkQPtKD
         Ia8WhxCZEqEqvR7AR2QtWp49F/gmCNuW4RD+xjiOSU75pfNAXuNy+7nOFQOIsCtaP7Ek
         MVnw==
X-Gm-Message-State: AOJu0Yx8P0QmxUXoXIAtrh0RtUSmavcGiahO5dWjWDPxmSqW8X3Q5KQd
	a0xVtvUV3sGaogDe9UHevPfj8P0Z7MzxE0tQKi25tOPEV7yOSwY+0saG
X-Gm-Gg: AY/fxX74lbgKTTyk7vnM8XgBEc27xAqTI+WnVCbtYFi5/bC9j1rWoC4gxDhYloivIzB
	6ZiP2FscGxRXye9XnKiAD93ALN0kNj9lxGeNC+AjKJA9IUN6HnFTb8OWeVputWjOUVl6jYpLd1H
	lUb82Qj8kJUqL/iH/+60DR6LAdXD0uXV7l+lhsPjgyhp4Ae8sd4kL/g4N+MC0qBaB0zXP9EMP7c
	plK89nKi3DeeANLEtmPrPF9/+T+NwW6/0gP6YQwXiLP+fXfzWLgjPa8Ms+/8PIrmLk906NXWqpT
	U3wdvY5G8lESZX9ac7/kJD4lxi3u1cSJ/aArf/VjCBy3dgPKltJ7de2dF99WpWZ2xCiQ+D32JCu
	JyEBpC3KDsiluP85NuMU+XWyhctSKzH3+4lpv+gQAYVHHWrtktBS1YfcSRFpWFEg7jIt6TnBkfT
	WI1g==
X-Google-Smtp-Source: AGHT+IHMFL4AvJOQLr+1gng3or268k0qffkqrhBJ29oEiScsZeINaFbiTYzQwVXPvQ6mp+IzqqnIIw==
X-Received: by 2002:a05:6830:3497:b0:7c7:53bc:54a7 with SMTP id 46e09a7af769-7ce50b8d191mr3288912a34.20.1767872592742;
        Thu, 08 Jan 2026 03:43:12 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:40::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce47802551sm5246754a34.1.2026.01.08.03.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 03:43:12 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 08 Jan 2026 03:43:00 -0800
Subject: [PATCH net-next v2] net: stmmac: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-gxring_stmicro-v2-1-3dcadc8ed29b@debian.org>
X-B4-Tracking: v=1; b=H4sIAEOYX2kC/3WNQQqDMBBFrxJmbYoJUcRV71GkxGSMU2hSJqlYx
 LsX7brr//57G2Rkwgy92IBxoUwpQi90JcDNNgaU5KEXoGvdKK21DCtTDPdcnuQ4SVOP1rWTs75
 roRLwYpxoPYU3iFhkxLXA8Fvye3ygK4fvYGfKJfHnbC/qfPzLLEoq6WvVWWVaY2xz9TiSjZfEA
 YZ937/b7rXEyQAAAA==
X-Change-ID: 20251222-gxring_stmicro-40bac6fcad86
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2253; i=leitao@debian.org;
 h=from:subject:message-id; bh=8E1ysSUShJ8p6nlzz4eEEoUf1cDKgDwOfnAJUPcBZHs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpX5hPLU4cUiB//lWOugf+MGfu+cH0iHAC/Z9et
 5lX/HdKFiOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaV+YTwAKCRA1o5Of/Hh3
 bfCWD/9SXn9wXZKcp9wRbju5Q8fSyNgRaLkqW8m5h2LlEGgOqu/ilvXA9i5lX0JnbrP0/O1keli
 JUSr1cH4l5PpOmv286HitihXQvP7lt8bJoZcy5hltW0wLcb1K+/JWMFo1VzmdYsSCG92+qJwSCE
 PJbNgYaTga9E3FZ/aT7zzWhnzGc9Uqmw61WG6CGb5j3izsECWhanLtzE8DF/EZy9Aa38zyKL11u
 lXjQW5YNTcEq2Siny2CHUq7ASWTD1PHOOch+65QgCoORg/h/lt9x0KX5vyBM6EmRr8+m/tqY6JY
 /+wUcCJuY+e4CZt6RIroC36WXI3mi0sn4I39ck67tx4QKCP7tBhZWAi3BMdBOy9TVnCMJY7th9J
 K6kjKS9fGGPjJAfvMlZFPC7y4Lg4Z7GYjLLvvzswOEhUwreNwCX/blmjqoQoLMqS9Plx1AfQxDp
 CvzgnEZRgOuRaC0Z7CBq4Pe58i+hCOGKUffcPGTU5lI4+zfpu2LexEm/4ncw9D0SIEcs1FL2L3D
 Njeitufk7bAe/KWYISJ0krP8Hom1kf0zev/wz4BGBz5C5T5h3s5eeiHFB8GCFXblnAs8VP7J+lJ
 f0bAfn17p0Q0fYxyk61dOhFvjq4+RR34v2SQLSM3P3AgqSbvSJJSrv9GBv1lEzdcLe2/ThWPzmq
 1jcp/YE2frbDlew==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Convert the stmmac driver to use the new .get_rx_ring_count
ethtool operation instead of implementing .get_rxnfc for handling
ETHTOOL_GRXRINGS command.

Since stmmac_get_rxnfc() only handled ETHTOOL_GRXRINGS (returning
-EOPNOTSUPP for all other commands), remove it entirely and replace
it with the simpler stmmac_get_rx_ring_count() callback.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- no change from v1. Basically resending it now that net-next is open.
- Link to v1: https://patch.msgid.link/20251222-gxring_stmicro-v1-1-d018a14644a5@debian.org
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index b155e71aac51..c1e26965d9b5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -914,20 +914,11 @@ static int stmmac_set_per_queue_coalesce(struct net_device *dev, u32 queue,
 	return __stmmac_set_coalesce(dev, ec, queue);
 }
 
-static int stmmac_get_rxnfc(struct net_device *dev,
-			    struct ethtool_rxnfc *rxnfc, u32 *rule_locs)
+static u32 stmmac_get_rx_ring_count(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
-	switch (rxnfc->cmd) {
-	case ETHTOOL_GRXRINGS:
-		rxnfc->data = priv->plat->rx_queues_to_use;
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
+	return priv->plat->rx_queues_to_use;
 }
 
 static u32 stmmac_get_rxfh_key_size(struct net_device *dev)
@@ -1121,7 +1112,7 @@ static const struct ethtool_ops stmmac_ethtool_ops = {
 	.get_eee = stmmac_ethtool_op_get_eee,
 	.set_eee = stmmac_ethtool_op_set_eee,
 	.get_sset_count	= stmmac_get_sset_count,
-	.get_rxnfc = stmmac_get_rxnfc,
+	.get_rx_ring_count = stmmac_get_rx_ring_count,
 	.get_rxfh_key_size = stmmac_get_rxfh_key_size,
 	.get_rxfh_indir_size = stmmac_get_rxfh_indir_size,
 	.get_rxfh = stmmac_get_rxfh,

---
base-commit: 8e7148b5602321be48614bcde048cbe1c738ce3e
change-id: 20251222-gxring_stmicro-40bac6fcad86

Best regards,
--  
Breno Leitao <leitao@debian.org>


