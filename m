Return-Path: <netdev+bounces-250203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9B6D24FCE
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 15:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6875300A934
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 14:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1906D3A4F4F;
	Thu, 15 Jan 2026 14:38:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD9530DEBA
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487906; cv=none; b=Dn/YAM2rO6EUgyvd1GG93xhXXSuPBb40+4AbSNfiP2LtRL4EqQmqTf/j6NDYEnRqE21IiQWk4+uJxL6TJxSlRfVcxA3kn4HUuVE8jOI6XF34k3HqfwvZMixVPv5aj5FMvTky/vSaLnybELAeF7nyFKmZz0/zMSbprab7EX9efag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487906; c=relaxed/simple;
	bh=ODthTtJ6u9CDqhtIsZr1IcNyVtvAQXiNPRpZYOcZgN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IHk1KgXbRFZpTm4NezX/L/6EB6P5DngqvvEtc06lPyWj7fNBXTS+xZupjbtHQuWxjvjx0mazOgJy83hq5Xn4imcMJRGT6AWyf33kpFyJBpUPh3Bf5BcE1zkIjS860OQ9L15t4U6VwNntUy2njlnK5DsOU2qjfQYBxIW5Dgsc22Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7cfd2be567bso634093a34.2
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 06:38:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768487899; x=1769092699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y5CcBKd+oHd389nAO0f8lXHf2tMCfoqnx1fCEDJhaMY=;
        b=OwelRvUi3XoB9UcXOmDIP/00zGcW06llkmJDEQW7RpS0jlFDTDvdMmOXq4b8yl4rrH
         NjJZnRcJt2bP+kBwAdYQjvvDZISWJE58kqAKORE4qP6rHiNpMoe/EzB8QEvQa4aFUKvP
         ByWBxvqdGn64YIiJgM1R4PgjFC9KsEd6TZO8FukLIlsz+RXLTh4S3WaxWlt/wP941QaX
         kGBLcV++aMXpdKHn+SXvMc8X3JkKMQqc8uTHSJWZJMeaCVIMdbYbd7SnRvakd4GsYq+O
         djdfDEFCmvmmMpACSISTmvAZj3GuTcwuSrFVneQZBdydra2sOQ3IHncuEvmbhVJbFdJU
         VKXw==
X-Gm-Message-State: AOJu0Ywnp43cjsHogMsz8wHXqE5AHU4X8T2r+LYLsLMYOKUHeR05um2p
	tiamiODFW9a7C4kD9gzmXBX30X8KOwnKmI9UfuDtgCG4b6IVXQRRR1AL
X-Gm-Gg: AY/fxX5i/pz7ML5HRnMjXw+pO4zWvmK9nEDMKEUkuIXLmM3e+NwRLN+jjUA670pZmNL
	ZXUmbLiE2BC1Q4+Gaq6bMlhr2PrTaNCHyvtYiXLhBMjj2v+AKHv9bOpuDxB+YkcCtgLvgSwTIH+
	1ZmsOlSbxCN0ZbC5/t74ATPrnN/YLG41+Xsq4+kR++pb/tJgu8s8zWiIYyq79Y2Qs+m2s48nFIZ
	wVRyf1iH4Le6J40lk8M1bVNrnIo82MKIUNSlEsUDKyVOVZ5pN5kXeG20BeMmpv1fGfnqxekTJWU
	vzXM3627nHl+iuwbYjLVykdE9IK9FRAH8ZzjtAvMppJ3lGvNoKi+FMngjBK+doTz+LpjxUUc3iX
	kzYZFZ6rVSC4yqdxE7QGnIoIWNJdhxFPhoJw4MfuVE5K5DyHeiuGdr7lOVdiMB7JAwToalenOVf
	C/8De2H5nzxhoo
X-Received: by 2002:a05:6830:3143:b0:7c7:59a1:48d7 with SMTP id 46e09a7af769-7cfc8a7b0a9mr5415119a34.2.1768487899275;
        Thu, 15 Jan 2026 06:38:19 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:49::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfcc8428fesm3470134a34.0.2026.01.15.06.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 06:38:18 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 15 Jan 2026 06:37:53 -0800
Subject: [PATCH net-next 6/9] net: xgbe: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-grxring_big_v2-v1-6-b3e1b58bced5@debian.org>
References: <20260115-grxring_big_v2-v1-0-b3e1b58bced5@debian.org>
In-Reply-To: <20260115-grxring_big_v2-v1-0-b3e1b58bced5@debian.org>
To: Ajit Khaparde <ajit.khaparde@broadcom.com>, 
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, 
 Somnath Kotur <somnath.kotur@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Shay Agroskin <shayagr@amazon.com>, Arthur Kiyanovski <akiyano@amazon.com>, 
 David Arinzon <darinzon@amazon.com>, Saeed Bishara <saeedb@amazon.com>, 
 Bryan Whitehead <bryan.whitehead@microchip.com>, 
 UNGLinuxDriver@microchip.com, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Raju Rangoju <Raju.Rangoju@amd.com>, 
 Potnuri Bharat Teja <bharat@chelsio.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Jiawen Wu <jiawenwu@trustnetic.com>, 
 Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1681; i=leitao@debian.org;
 h=from:subject:message-id; bh=ODthTtJ6u9CDqhtIsZr1IcNyVtvAQXiNPRpZYOcZgN0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpaPvSl1WBMCgycevY3sZ6KOF/eZNfSYtIvURYg
 xosFId6dAeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaWj70gAKCRA1o5Of/Hh3
 bWs4EACw6OGGyvcIE93XAIfzg2CzJAI+6roCgCWsaka2YS45lxnXlbwqOUaG7IadxMkwZrlSPq5
 rZMbwhDnOfMfUj43ZHlAygHa22r3zGiNJlcc/aM58ao5yPNWj1t1K3snMLIrQu6vTnyposuMiyK
 cMSUnGE/YP5/Ak0GbPeDfxXvqDtkYKr7SIqHmTAXkJe14K9/ZVTQ4CViC1u+Rn3t1vu7R5kkyoD
 7tKutYVDqZvnFs0nrlVfuyCbGFwHGXyAtvLpzLk+7UBDFdlc47m8SoutLl48uKJFkpS5rzU3rIz
 7IRKwmOLyfc3OVyHMXRdlnRwJF1/LQmobFacLu6Y6cXjp5N0jvWZk+LtjfZhNeE0DNuzzs0KkDh
 npJBQfK61w/DNZVFKXuYvYHnlaBS2m9IrR9xhsZLqci5CAieOtQP+fmtMaKrnxeHeLJHIBov/0x
 Lo5Yy830q1kUDPSN8/ACV3Xdi4dP0KYZvupaEd2V6B0t1xsuq6tLh6kxKAchFRzGGTMGvXPGm22
 UNf3YWv7yGO07RsSahj8ov6UiDOx1GXjeb3JTFcKqU9DDVftbu45pCJ0dyj2kFn2QlH9yrBFjum
 6meVsAd5N2aKR20VPTfOLRMH0sIxloQw+e0LS17La28WyUdk54LQ0o4UvboqD5gO7RWEQW4Qf4n
 TRZv1QA516MJtEA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Since ETHTOOL_GRXRINGS was the only command handled by xgbe_get_rxnfc(),
remove the function entirely.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
index 0d19b09497a0..8ebf0de7a01b 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
@@ -414,20 +414,11 @@ static int xgbe_set_coalesce(struct net_device *netdev,
 	return 0;
 }
 
-static int xgbe_get_rxnfc(struct net_device *netdev,
-			  struct ethtool_rxnfc *rxnfc, u32 *rule_locs)
+static u32 xgbe_get_rx_ring_count(struct net_device *netdev)
 {
 	struct xgbe_prv_data *pdata = netdev_priv(netdev);
 
-	switch (rxnfc->cmd) {
-	case ETHTOOL_GRXRINGS:
-		rxnfc->data = pdata->rx_ring_count;
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
+	return pdata->rx_ring_count;
 }
 
 static u32 xgbe_get_rxfh_key_size(struct net_device *netdev)
@@ -752,7 +743,7 @@ static const struct ethtool_ops xgbe_ethtool_ops = {
 	.get_strings = xgbe_get_strings,
 	.get_ethtool_stats = xgbe_get_ethtool_stats,
 	.get_sset_count = xgbe_get_sset_count,
-	.get_rxnfc = xgbe_get_rxnfc,
+	.get_rx_ring_count = xgbe_get_rx_ring_count,
 	.get_rxfh_key_size = xgbe_get_rxfh_key_size,
 	.get_rxfh_indir_size = xgbe_get_rxfh_indir_size,
 	.get_rxfh = xgbe_get_rxfh,

-- 
2.47.3


