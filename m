Return-Path: <netdev+bounces-248563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C46D0BBE8
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 18:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAC5130ACE32
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 17:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B223644D9;
	Fri,  9 Jan 2026 17:42:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46842877FC
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767980534; cv=none; b=LoNcnvCjLxcM+/wE2thxBbcaHtlszqlGd4v/XD3Y2fyVODbyZrJbbma7UZpGRtBaqL0oBK5MfLYrInyMXl74RVV3Bn6q4IgSa0aqGD8B3IBZDzkNtSowl0TfBckVCkBEEffsfuXHeVpiEQSQmo2UsZIjDbqv5VLNDyhSzBP4alQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767980534; c=relaxed/simple;
	bh=nSSmLKtyU1zlKP9DUyP3r37XriJLC9nOjHP570WhOzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ddi79S4Ga47rIoSZ1320idbOXcKnpg2PB7K+66IEWHjwfcC1XBl3aq9mLe2dxOQXlNF3WZMrjmUixR7iDG/Nhg455CBwRA3ME3WEpsJYpv0GWxOyd6fj4FB6g0XrVCV+J6ev2Bz9HrZatwLyykw3Cpicu5RMjniDQXTNZ32teJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7c6e815310aso3607652a34.0
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 09:42:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767980531; x=1768585331;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CbdIE9v0fa9ML9Z9sZ9loulF/PgXCckwh2pAu6KB+5E=;
        b=EsliqrjS7jtBKl9ROKoNP/7nqNvI4pP8UgOe4zMew0v85jz3tybWtwtqVsXJ1yCmNd
         8g/MGENNMwcNBFaXK7XH3jpmFQNsVSYq7AEtOiWCqYIJhIEiD8lV2OXHLsXU9bfyEc6S
         CMoBciIPWGBkf3TSaIDGpeSuuHBvSQhu1jvzHvaROjlXSFt2dAQ2o5d9rebAgFy550Db
         Zw0MffGAVAUwvNEpMpxHMN1ygaekXtmD+AWVOO479HkyFlUQdrAQvDadiAQ8DaBoI+P5
         u4DT6Dbaf2EEOT5hSA/PZ2wB+7TtOkZRbMw8hPv2bFkGbHPxGVu9UMsLryXq8d1hFmX9
         /UHg==
X-Gm-Message-State: AOJu0YwvV2eAV0FHoXCIC2Ryi1x9DqMiJGdbk3z9kt2E50Ly7wkIOYHm
	K3vBdqdz25tNtmGCAdYUDf7xivP54Wv/5zIBUcghitGXDaJFlsZd9ZKR
X-Gm-Gg: AY/fxX4wp21HYzz4xHQm6YLl/AkZpkanqLrIHx26pLQ2IMznRp2eFdWV9LigcY4pXcS
	i7kbCB/a55RnZs2aNB9IRgAlkto3Uf7NnmhId56xPaZW5schYTGv+TyKgcBERevmI7989Os3NEG
	b5csADlraZ62cTo0c1M51oeDGNTXygPirRC1V+fWZY4BLf8ZxxSDP502zeFz9cfx2a1drJ6lpgl
	zO4itmaz+CbjOlfCmHTL4ZQ0gi8s12FtumlkzUY8hj6lHLxf7bNPanmFU/I0tnejVyKHW+janOz
	UpgjnPIrF/SkzXcKo09lDZ3uWaevIJ4ZGIwo8H8zqybD0LSgCBf2aiu7j4sfP4jOr9ujtee5h22
	ucxCo7yD0iSbDHl+PmAZpxwqulNa/gjjk9I5YCwvdBSasXXAI/V9F6YFtVnhVuygQCRqL/24gIf
	qSgdvhmahBkka6
X-Google-Smtp-Source: AGHT+IGKx0GKrzFK9GaqAP6eokjpQCh4koDyXIEbvXkNNmoUPTe2yWkCNi8aKe+qUMah74mE/E0jQg==
X-Received: by 2002:a05:6830:7194:b0:7c7:54e1:a3ad with SMTP id 46e09a7af769-7ce50c00c51mr6786596a34.17.1767980531589;
        Fri, 09 Jan 2026 09:42:11 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:52::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478af63bsm7468893a34.16.2026.01.09.09.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 09:42:11 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 09 Jan 2026 09:40:52 -0800
Subject: [PATCH net-next 1/8] net: octeontx2: convert to use
 .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-grxring_big_v1-v1-1-a0f77f732006@debian.org>
References: <20260109-grxring_big_v1-v1-0-a0f77f732006@debian.org>
In-Reply-To: <20260109-grxring_big_v1-v1-0-a0f77f732006@debian.org>
To: Sunil Goutham <sgoutham@marvell.com>, 
 Geetha sowjanya <gakula@marvell.com>, 
 Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Cai Huoqing <cai.huoqing@linux.dev>, Christian Benvenuti <benve@cisco.com>, 
 Satish Kharat <satishkh@cisco.com>, 
 Dimitris Michailidis <dmichail@fungible.com>, 
 Manish Chopra <manishc@marvell.com>, Jian Shen <shenjian15@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>, Jijie Shao <shaojijie@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2059; i=leitao@debian.org;
 h=from:subject:message-id; bh=nSSmLKtyU1zlKP9DUyP3r37XriJLC9nOjHP570WhOzM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpYT3wgwvFwhQ3IeSuFMS7v132a8iUqj/ET/JxD
 9S2FuRQjp+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaWE98AAKCRA1o5Of/Hh3
 bVSbD/0VM6uSORFP1EJPOafmDKtFHK3IpY2Ds52XCBuUWAu3hhivFo+DrvmhcHxu1YopJHCBGk8
 JYKPxSd6cYSKBXk5PP28azfD9b0ExRXf0039IgbkPNbnIzkPKK7kC/OLcZcvpXaoc1bk5rhiYvs
 O8eyC4xMmJvMQWwEM3i+ximMY1amiKWcLpTDUSzcDhNcf+mUTSBQJshAbkkpEkP/0G7bry1YcDR
 QTNc6pCzeu/bczJ1fO9KEVjz56H54db9ArY/+I1FGB9UjmTBZ721/pP+oh7F6zTEz+ggIDa3pg7
 kkb3KRiEP5sMm4HpJ4WTxCaZ+v3sLhxKbQ+VQHDkmvBWyxvgKhzKc6FtrKUSmGdhrOFGUEqvyim
 3sWQKj8IDfg03RoOVLh7sbY8MT7TGvxFYmBTiWH3uWaSSiwEDd5wizWYFEYXxBHU7IPWGotwGiv
 BlteVtPnuxCONEyt5B6u7KNO62KgItMTa57OpLDMfqxScn1yzHWxuW8RzLQFbIV5TRe5xsg4Y3v
 iq08yjSgCIqk8Fczpof5ZwtMnGMoIwYjjudr+maQ7nMOY6sOfcPtmA1BF3Q6CGbz+pCjuXlfgfU
 FzExyuXs2K97aYtdjpWuRaLU2hw3jeHit4i+9i3XVOQL6bGfo55i7+fpAvCVziOup8J/Qlh2oiB
 xTpuJ+U9jq/6k8g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index b6449f0a9e7d..8918be3ce45e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -568,6 +568,13 @@ static int otx2_set_coalesce(struct net_device *netdev,
 	return 0;
 }
 
+static u32 otx2_get_rx_ring_count(struct net_device *dev)
+{
+	struct otx2_nic *pfvf = netdev_priv(dev);
+
+	return pfvf->hw.rx_queues;
+}
+
 static int otx2_get_rss_hash_opts(struct net_device *dev,
 				  struct ethtool_rxfh_fields *nfc)
 {
@@ -742,10 +749,6 @@ static int otx2_get_rxnfc(struct net_device *dev,
 	int ret = -EOPNOTSUPP;
 
 	switch (nfc->cmd) {
-	case ETHTOOL_GRXRINGS:
-		nfc->data = pfvf->hw.rx_queues;
-		ret = 0;
-		break;
 	case ETHTOOL_GRXCLSRLCNT:
 		if (netif_running(dev) && ntuple) {
 			nfc->rule_cnt = pfvf->flow_cfg->nr_flows;
@@ -1344,6 +1347,7 @@ static const struct ethtool_ops otx2_ethtool_ops = {
 	.set_coalesce		= otx2_set_coalesce,
 	.get_rxnfc		= otx2_get_rxnfc,
 	.set_rxnfc              = otx2_set_rxnfc,
+	.get_rx_ring_count	= otx2_get_rx_ring_count,
 	.get_rxfh_key_size	= otx2_get_rxfh_key_size,
 	.get_rxfh_indir_size	= otx2_get_rxfh_indir_size,
 	.get_rxfh		= otx2_get_rxfh,
@@ -1462,6 +1466,7 @@ static const struct ethtool_ops otx2vf_ethtool_ops = {
 	.get_channels		= otx2_get_channels,
 	.get_rxnfc		= otx2_get_rxnfc,
 	.set_rxnfc              = otx2_set_rxnfc,
+	.get_rx_ring_count	= otx2_get_rx_ring_count,
 	.get_rxfh_key_size	= otx2_get_rxfh_key_size,
 	.get_rxfh_indir_size	= otx2_get_rxfh_indir_size,
 	.get_rxfh		= otx2_get_rxfh,

-- 
2.47.3


