Return-Path: <netdev+bounces-248568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FEAD0BBA6
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 18:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3FCD302B8C3
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 17:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEF336657D;
	Fri,  9 Jan 2026 17:42:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE89D366DDA
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 17:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767980539; cv=none; b=n3KU14SMntmokFaBdIyYu2N63at/3lNISI4PCVNl52Ly+Ej37R6SDq/vvfeaz6vTBT08eVjYWz8wfZGMnDe4tBj88ZH8BR0o1QtmQvoObLc1a911uRHzom56bAPbtx7aWsHHDz91EbURwHJczjhIrTl329KMy0nmgMgkarE7Jv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767980539; c=relaxed/simple;
	bh=HMSNJxCMyQJnjwP9Vi8R6ihLUN8j5UtDt4JQzxAdwSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HitmHWzh/JNF+gxv3mQQXRv3amouA0BkubsFJrZJERRC+jwywrtiGPtdidjGirYdw3PFazweDFr5MtN7OgcrCe7pZxM7rTEfG7E+oz+6VvF6UgwqOYQzHSZJGKVAfPY1i3zlPDCLK7z3e3HMx9buUYGAK51Psk1asHOmRuUnmLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7c6e815310aso3607728a34.0
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 09:42:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767980537; x=1768585337;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NaEh6cJxLtlYrpweCyDGNhGCl8srT8+pwREViLqGFxo=;
        b=Fk+rIk5TtZfmH1n1KWIQgksThF1Dr779zFdR0bBoBs8ywQfb2W3qiDR2og3BMxYepQ
         ogcKDP/YeizwJ9BbUZoDUANSstrwabazNIm6BodGjmiWiveHn7T+zbdbbD6MSdmXlChZ
         tEM5anX01vcK6uEne+3OJQ9mCw92y1SbNASQah3NcM5LmB04H7hLkMWI9jnlhdEzSGZ7
         qmtqKNb0kbSHz0++4cU87frFBUOzWiHxWFzXyyPgQJsc+4VpyitfMgfQDm+ED16irpfA
         LzmYtERoq+hAT57HCUO+KtXS2yclTxzXJolK3HEZ3se4Vil4QHwUwBM60JtorDIezl7O
         OQXw==
X-Gm-Message-State: AOJu0YxBXshl1vipR1oSYMhWJjaj7LY0CI1+dxbDTdY6o+raz7/uLHrn
	s8f7K7l5FwfFS2P3yQ7DdpMKcaR5Ll5BPXAW9QJCh0Ib7LnzV/AnXd7O
X-Gm-Gg: AY/fxX6oxdvLTiWoAWgciBTw8Oq0HGM4YgDgxTBx3C9rTKMHFQx/DBfKVAuJnVZUXjf
	K2EoxS2rNZf9JLz5Mln6jmIIddpViBK/ad5Zr69p3SA/n3MywL4+DDazm3zRhuzdmZbcvHVbtgZ
	yNewas5UrUHE6VfSxMZzONTLR8QjmlDntts3gTukoqItipz5eZT/AEa8sy1NGsg/1U+iwL4E+TQ
	sB9yC+orynhXK94c2HOk9JuMej2KNs1SFR8YlMd/6g/rDzfmvzEbAfCKcIGhaQcFWnpq0B7wnAh
	c7lm7ZNNAU0Y/UcUH7QhWctm5eW6s54L0edBsc4pE7nXLgjgeUVrGM7I24bBb1WB0kJV0k988Um
	xr9bRNVhliwMohp0HGOHgD73q+D6NghmnpnXIYtEycpLLVp4TKwBIJB6A+iB5f93bmQ117C13zP
	lTVA==
X-Google-Smtp-Source: AGHT+IFNeqMRLXaeZ/FlUPMWaSWYPUHKwN0UsvQ4VO173wkZ5BYlAu4VXY/o9qNzItHHjVkz+ioQWQ==
X-Received: by 2002:a05:6830:7194:b0:7c7:54e1:a3ad with SMTP id 46e09a7af769-7ce50c00c51mr6786742a34.17.1767980536766;
        Fri, 09 Jan 2026 09:42:16 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:52::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478af813sm7858243a34.19.2026.01.09.09.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 09:42:16 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 09 Jan 2026 09:40:57 -0800
Subject: [PATCH net-next 6/8] net: qede: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-grxring_big_v1-v1-6-a0f77f732006@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2026; i=leitao@debian.org;
 h=from:subject:message-id; bh=HMSNJxCMyQJnjwP9Vi8R6ihLUN8j5UtDt4JQzxAdwSY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpYT3xmb5BcnbRMkGzoZGEguVmG26s9fYL2MoVQ
 0UiDDKECI+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaWE98QAKCRA1o5Of/Hh3
 bc4aEACAFc4hkacr0Sd8PlEFtW46uub2TNOaw1BkYAFmcovah7pK7gHEpm8bNT0KZp+8QZkxW7D
 4ndsRrWk/inM91PZEDnDfcd7irM7BIhDnEEeoDXVwjE95QOZ+YDKBKw4kdDrFsODiseLfqQWWm+
 r90YyK3nTM7ux58S54XESynzTrfQWJUC6Qh1WDCMmKaWsdumBKqhps19uzsQ9a0UD33gwBPVbJd
 hy6h7vuzJbWw9RDtAdQqF7Ropm9f0IK+Ue/0UYT2nxBP5dIi3lgqzcJbnPHegbBjukt8saR2CWl
 sh5xwgtlEyuLeCB0HEILMKOMyyfEaSIykdmfuTEcR6JH+/4dqBnASnkcl6bbbAWXFhjhLpCwdKO
 7uc/12ExUjFHwSneH/XCWWUPxFeBo4olLOR86gdyebEwacQGMCc3RH7CDLibYI58ACVAgvm6meo
 C0isHQQSHnfdcgFz5WtVTcIAfQUSFzFcK1yUN7VQ4HnLZ5nbrEHv7/mclX7HYX/s8dHgtBXqBgj
 3C4f3pIiXZPuPOHqfFGpi76LrfTheD40u97ITyRRhQ26WE4CySKOJXY3mbcbYAmy2ahPyYY9hOs
 eEQDVk+zqvTsPNImdLLjuN3GgD4ZoDuaActbm250ygThHJw5NGPB4IVus+nqSCY1ccRkRQPDyj9
 HpI6Ev3bqPHN7cw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
index 23982704273c..647f30a16a94 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
@@ -1199,6 +1199,13 @@ static int qede_get_rxfh_fields(struct net_device *dev,
 	return 0;
 }
 
+static u32 qede_get_rx_ring_count(struct net_device *dev)
+{
+	struct qede_dev *edev = netdev_priv(dev);
+
+	return QEDE_RSS_COUNT(edev);
+}
+
 static int qede_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
 			  u32 *rule_locs)
 {
@@ -1206,9 +1213,6 @@ static int qede_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
 	int rc = 0;
 
 	switch (info->cmd) {
-	case ETHTOOL_GRXRINGS:
-		info->data = QEDE_RSS_COUNT(edev);
-		break;
 	case ETHTOOL_GRXCLSRLCNT:
 		info->rule_cnt = qede_get_arfs_filter_count(edev);
 		info->data = QEDE_RFS_MAX_FLTR;
@@ -2289,6 +2293,7 @@ static const struct ethtool_ops qede_ethtool_ops = {
 	.get_sset_count			= qede_get_sset_count,
 	.get_rxnfc			= qede_get_rxnfc,
 	.set_rxnfc			= qede_set_rxnfc,
+	.get_rx_ring_count		= qede_get_rx_ring_count,
 	.get_rxfh_indir_size		= qede_get_rxfh_indir_size,
 	.get_rxfh_key_size		= qede_get_rxfh_key_size,
 	.get_rxfh			= qede_get_rxfh,
@@ -2333,6 +2338,7 @@ static const struct ethtool_ops qede_vf_ethtool_ops = {
 	.get_sset_count			= qede_get_sset_count,
 	.get_rxnfc			= qede_get_rxnfc,
 	.set_rxnfc			= qede_set_rxnfc,
+	.get_rx_ring_count		= qede_get_rx_ring_count,
 	.get_rxfh_indir_size		= qede_get_rxfh_indir_size,
 	.get_rxfh_key_size		= qede_get_rxfh_key_size,
 	.get_rxfh			= qede_get_rxfh,

-- 
2.47.3


