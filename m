Return-Path: <netdev+bounces-250207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 536BAD24FD7
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 15:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C75A53009279
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 14:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8508F3A7E07;
	Thu, 15 Jan 2026 14:38:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E583A4F2E
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487909; cv=none; b=TBOi13DBpnlxLJuTJOQyM3/o5QwLkzZnZkfsucPbz5ETdJVln6MS/NOsfBnyDWSdnjNJLIBIpSs+JbvKJa+HbdffrWYxBXhCT411G9QMuQMbHC65Lrx9W58kBpniQIuDPppAQqTYR0dxHRe50vqp+lVRTH8/1ToEdhNSR/27zx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487909; c=relaxed/simple;
	bh=OhOSJKzo23oetHtU1SAjOSl7/D+75LUpKZ4+ls31geY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PlMfaLsfSER1NoKTOUhzXL/ByXhW/UUEOKe2uCcrBXe+nL6Tokj19cXJ+nBBSIzaWkItYENUQBQtIC1SaC2VgEpTpRxeJY4UkuSshKqZwxAx4LEpSU5mIgH7GnIfIqV3zU7LY4xuoR/9rPtcKsyB3xUEwrvwhLQ97//e+eDEqEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-45c958d48a9so187021b6e.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 06:38:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768487902; x=1769092702;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DoyxLPjnBq1qhMQoPjoZ2qS39Mdd35mOR6xZOmQK8KY=;
        b=FsDHha0A+Ljw9jEOA0b8lzVeOVxcGrIDOSJz6F4kApyWc9sx/fpQjIsHzTzztM3FaJ
         RmcfrqIGEAzxfw8y1GFI6+E5OZvtMVc5PplNUt4MYqM96L5LwHYaIOfZmHN0dKt8RvET
         vnQ11EYr7kw53nDnBAnlTgb67xWTT8lZli9kvDF7fxWNCIbDDLzexpE1ijtkv0wR15n5
         XxD1CP/J3Z6QCX6C+Shh2/rVjlYHC/7IwCMOdSO1qHtHVzBCA6Jk5JbC9Kn2qQ8bMmwj
         Ck7212pjgo3rbkzIzSurOXZXGdx2ZkqdSDiPNmfplVt+JbzMbKnCkln2xqjB0pOiTCs7
         uzxg==
X-Gm-Message-State: AOJu0Ywqjy2gOfUUfdQZeelaVGnABl5HmGisqWxiRGtCkGlTOXTJyawl
	8us7hrCxYPPJ2cFgbK2VV+Pirw3+Hqe2c0W/SS3QWP2eu/5LD2LDvP64
X-Gm-Gg: AY/fxX6bejWbKvJPsl6AQjqWEg9SQ2LMuqDthKmhE61+2MGBmKJtxyYoudFcgLmthov
	dcmjkZ1vNt/SKEUPltOSLqXElsr8n86U/9KF8I6Xubb5OCsUkZA2wEfLt/8w+SeAs7x/mDlgCb4
	Q8sRgu89+uEmkXUipTIRxQ7r6X8QeNqkUCCKl1PbRut1kKld+B0OYnp8NgJeUDeaEtLHnHmn0p3
	tY3wb2sm28F/rZ6lCYOJm2IZWUntiC6pcNbSrgLjlKOH8P/OxsifdgkeNNEviwuZ7cCDncwEPNN
	MyvgyNHz1jpzq/ZZ35kwtY1woApWxzfwJLGhOwxMlbFhIf7mmUvfUX9vtyvcLqbiTJtLnYiZWGr
	K8DVxA8c3o0cxGJLfXJISulF4U6B/KlqtQ17SUogWsnQvcZhJUO4GuSUC52pYGWfl0RCeq5nKXC
	cwPg==
X-Received: by 2002:a05:6808:179d:b0:44d:aa8b:58f2 with SMTP id 5614622812f47-45c71463914mr4281989b6e.9.1768487896997;
        Thu, 15 Jan 2026 06:38:16 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:70::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e17cd0esm12818955b6e.3.2026.01.15.06.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 06:38:16 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 15 Jan 2026 06:37:51 -0800
Subject: [PATCH net-next 4/9] net: ena: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-grxring_big_v2-v1-4-b3e1b58bced5@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1976; i=leitao@debian.org;
 h=from:subject:message-id; bh=OhOSJKzo23oetHtU1SAjOSl7/D+75LUpKZ4+ls31geY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpaPvRzU90PVMm7MPekl/O3zK7Y+8MrR9aM6Y7x
 4TXeGAZZvqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaWj70QAKCRA1o5Of/Hh3
 bZVWD/9LbkqPQzVHwsSImpym9sTbJKoCskNG24AAU/IMLX779t9vMoqcv3HUHYI9fPsDoClHSFW
 ZYig157cl0LxDp8/sQMiNzWfVOqbu9DgkWg+IWhOcuyqGzB1F7aA0bAr3JS+reJxTm315r7l59y
 /vq+dBalf5swD1/jXnIjx6Ch8j0syo6aKxPV+8cCh62nQCdY9Zl9lowhAwhx/ofqUfIUM5v8Zsu
 xQ/TFsQV1f3VIFsZQnJaYHLj8B3CBjTxiO7D6QrvfcoBtpiDLTjV2z5qTD9I/vT76nuCRxsYMY9
 2VzsdpmKATfHo/26UJapwSiyM78vm3MBq9fd/vYEFWVGibmQ32ItSkThxx1MvUsK6pVFSbzuhg9
 JRuwcONTNvUzjDgI/uRe+0xDwSsvoDbmbQxkHlMDCcdSKDjpLLUyCM3CvpOXHB2jBORMqqS68Ap
 rIVwinqC+xedm/nDu7gX+ZmRf02xHlkUP0QDd/VhoLO4CL0gTp86/yl7cOIFz2z3DK6DcOwrb0I
 VYLloSJE6c/w4df5F5Kn1UAafUylUoCr0bhzXu9+xDC4YhUQwKL/G2p2a5zG738+SW8X8Mkkn6t
 ocFT0jZUdz2/fYxEXl+Cf+Z4xwPv+/JMPOHJaUjuJqNEDfiRCBoQGOnuxMiOaN1MLP8ekZ51eBs
 WW48ZocfUwPrT6A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Since ETHTOOL_GRXRINGS was the only useful command handled by
ena_get_rxnfc(), remove the function entirely.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/amazon/ena/ena_ethtool.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
index fe3479b84a1f..2455d6dddc26 100644
--- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
+++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
@@ -835,27 +835,11 @@ static int ena_set_rxfh_fields(struct net_device *netdev,
 	return ena_com_fill_hash_ctrl(ena_dev, proto, hash_fields);
 }
 
-static int ena_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *info,
-			 u32 *rules)
+static u32 ena_get_rx_ring_count(struct net_device *netdev)
 {
 	struct ena_adapter *adapter = netdev_priv(netdev);
-	int rc = 0;
 
-	switch (info->cmd) {
-	case ETHTOOL_GRXRINGS:
-		info->data = adapter->num_io_queues;
-		rc = 0;
-		break;
-	case ETHTOOL_GRXCLSRLCNT:
-	case ETHTOOL_GRXCLSRULE:
-	case ETHTOOL_GRXCLSRLALL:
-	default:
-		netif_err(adapter, drv, netdev,
-			  "Command parameter %d is not supported\n", info->cmd);
-		rc = -EOPNOTSUPP;
-	}
-
-	return rc;
+	return adapter->num_io_queues;
 }
 
 static u32 ena_get_rxfh_indir_size(struct net_device *netdev)
@@ -1096,7 +1080,7 @@ static const struct ethtool_ops ena_ethtool_ops = {
 	.get_sset_count         = ena_get_sset_count,
 	.get_strings		= ena_get_ethtool_strings,
 	.get_ethtool_stats      = ena_get_ethtool_stats,
-	.get_rxnfc		= ena_get_rxnfc,
+	.get_rx_ring_count	= ena_get_rx_ring_count,
 	.get_rxfh_indir_size    = ena_get_rxfh_indir_size,
 	.get_rxfh_key_size	= ena_get_rxfh_key_size,
 	.get_rxfh		= ena_get_rxfh,

-- 
2.47.3


