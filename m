Return-Path: <netdev+bounces-250208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15788D25022
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 15:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71A6830490BF
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 14:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41362F5479;
	Thu, 15 Jan 2026 14:38:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C823A63E6
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487909; cv=none; b=kSmsIeTcJqkGs8fqG8P4dXGnsLuWU6Zbyyo/w4jBK5dgFFgiTI72kGPyx4ih4sqFJHaH9cWdm8D1THp9ZjnjFZlm1NEbRjIQiaJTmpTNjgfxyYVFevHhqdCClnOL1/GUZFxZsfZ7izxdE15YINTRi8Tosw6BeECkjDcPGyxzL7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487909; c=relaxed/simple;
	bh=iHjMCRl1osOPGeWzfnK2KNM/9EoiAxwpcSWI+XP02wM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WC9hBv2cXz2E7x2s38oaFy/IuV0iQ1Lfor8QUVWHSp/YMlKY2Wc8jbGXSc/IQASHoqlbocGrz3D1UhF/jZRcA3sFgn1r/ElOX7C0eHLLk5OJY5s2U3fYuPg/st2FeUGmyP7zx0pieFWIwVbtxLgNtZO69B3KEuC8IrC7dlpPLHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-3f5aaa0c8d7so777170fac.3
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 06:38:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768487903; x=1769092703;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a/GYuhAPyxh2VtKR9ECrwYwGFXjwcnfw71zewQTg4IU=;
        b=OS5difPLQ90x3Jbveb06qxSyOO7n9IRtmB577oo27rYsDHJ2rUE7RTHvUtHFk9yT0m
         cqF7lrePC+b2jDBBcRuwiFjmWcsjTsamQUq73XK+khZ8kjUlgsvdIHOwtrVHLyb6kQ4Q
         s9comNiGckRstgdyPcWUbyPvUFXNV+IIckvPKZE11syDPqu2Aes+8n/l5ceDmA2Tv24/
         3w1+fpiKktckRj73/WffuyQ7vC1dq8ykASGywzXY01f+UrzKpNgcQH0olq4YEn7FpuxG
         rxI9BxNhOyOaFZG8lWAonop2XclrlW7m5DR4Wh1XgnmEoIFKclp94gtpedMnDemNcAG+
         1yQA==
X-Gm-Message-State: AOJu0Yzti61KgrPKE+7MQuoJEYXK5WCuI1lx9HLZeEg+vOfjBM4KG69S
	078SfoGFcIqKkCsmQheaUQe8T6Q7axKAa4V/45DhNYTBXzOQrADD3UNY
X-Gm-Gg: AY/fxX5WyJPUwHqjC+lRBYtfIItvm+H3ZpawtAxXUtJ1ZbEWwXnWJgbMM61XgWZQS+8
	McNCj/p2O5mDBsCPLhQb492uoKxApuv3orzjIMlLv1WIGkfqXpj1eMewksKRi+tFcAQHGvM8uUd
	f6yY6zPDV0wfmGgFZ3i7fpkg1bmRl920WXrS7twkjcqomCQwazSlisynkqhfX8EwTFq6gP5diJJ
	CosNWm7Hx1ULyuGTs1YGGiN97sTdpeV7Y0MI4x7pWKfAhN74nkd4r/O3ZqfMlASCGlbC8ynz2dN
	/UszVG21oaoG1Mpg2ujwoC2p4mVLMegZl6Tvnea9FXnwX33U3SCy0WHYHBU5EdBPTkW5hlfMIze
	He+SAp+VPG+nQGiN/S5S5gCrkqy3ayCh5ps7fVAYRXVORWnVosIU0cqaCUCWBfeeWQdgYyaRw2r
	xCp33mJiRi4cU=
X-Received: by 2002:a05:6870:864b:b0:3f6:2118:2d37 with SMTP id 586e51a60fabf-40407155e60mr4009310fac.42.1768487902673;
        Thu, 15 Jan 2026 06:38:22 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:3::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4041a20051csm3187622fac.17.2026.01.15.06.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 06:38:22 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 15 Jan 2026 06:37:56 -0800
Subject: [PATCH net-next 9/9] net: txgbe: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-grxring_big_v2-v1-9-b3e1b58bced5@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1635; i=leitao@debian.org;
 h=from:subject:message-id; bh=iHjMCRl1osOPGeWzfnK2KNM/9EoiAxwpcSWI+XP02wM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpaPvS2jwDA4B5OVdm2pYfwE5wwEoA1TjfN+vFk
 Oq4iqdDPU6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaWj70gAKCRA1o5Of/Hh3
 baEtD/0e4jxGdtSnXlNdd3Ym+AmQnqmw+uQARxVH3fvJRkHoecl3Hzt6HnkNMpJ2bHcL+Ykuo+2
 bqDVJi17xCAxz/JJ+E5uhNl7rq1nzJiOdALOcbtS+q0vaAqaZANFIQTUTAtwvr8Vcykq8fnNkr0
 2xiADYMIU5s+WuQsMpxl097cT8oXChiukHlT6HsJ222668dm5nRiPA0evqv/2pWsVDaAywkAi6x
 aeiwdgG4iQxbfanDh2VKer1hvyDYRelxSgXXwz9N4xwcSk8Wfz5aDDHNrzSYqDMGdS+E+kjPat0
 t4kMwgKvDihLCIWfhFIASs4E9SQRkuqb8Jl9NPamj3g0kSm4VqPztopV3u/iPeb9hidjshOk1GS
 qxDrEiy97dK97aot5HKc9ujq+XVUI/Q51g0H3img2C95IaK5r7LWia1OALMEcV2cBy/rbsNPfas
 K0QBWLVLDq2PqiUc25Jxy+TG+ctt4emx4tKPDjc0Pe1pk1H3Tgi06WXLVavvwsW9ksgo8O7Sf6a
 Db19Wi8PouSxa3fu+u38JygBavrl/AFKs1l0aVN5h73ufNH1bOfS1xHmgvxnchF0HmnRm3G+CHb
 KvdDaYueCtvOsJYb1eivSnDKOoF+M7LQRcakwSN6tgiUiFJI8r9TH1aKmpkYtvWyA4rRbcHIk/q
 pdghbi7qVDQhMoQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index f3cb00109529..59d758acccf0 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -193,6 +193,13 @@ static int txgbe_get_ethtool_fdir_all(struct txgbe *txgbe,
 	return 0;
 }
 
+static u32 txgbe_get_rx_ring_count(struct net_device *dev)
+{
+	struct wx *wx = netdev_priv(dev);
+
+	return wx->num_rx_queues;
+}
+
 static int txgbe_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 			   u32 *rule_locs)
 {
@@ -201,10 +208,6 @@ static int txgbe_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 	int ret = -EOPNOTSUPP;
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = wx->num_rx_queues;
-		ret = 0;
-		break;
 	case ETHTOOL_GRXCLSRLCNT:
 		cmd->rule_cnt = txgbe->fdir_filter_count;
 		ret = 0;
@@ -587,6 +590,7 @@ static const struct ethtool_ops txgbe_ethtool_ops = {
 	.set_channels		= txgbe_set_channels,
 	.get_rxnfc		= txgbe_get_rxnfc,
 	.set_rxnfc		= txgbe_set_rxnfc,
+	.get_rx_ring_count	= txgbe_get_rx_ring_count,
 	.get_rxfh_fields	= wx_get_rxfh_fields,
 	.set_rxfh_fields	= wx_set_rxfh_fields,
 	.get_rxfh_indir_size	= wx_rss_indir_size,

-- 
2.47.3


