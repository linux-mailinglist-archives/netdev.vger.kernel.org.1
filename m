Return-Path: <netdev+bounces-242558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE67C92160
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 14:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376283AF366
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 13:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A717632E75F;
	Fri, 28 Nov 2025 13:11:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78FD32D0F3
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764335518; cv=none; b=hF1dRnGJCujFsPypmtZX2Ww+pBK8FVUF6LbTwuTPRRBquNpvAwej7G4MAa209EnFPsxSPndk8aJqgRW102JTJ3VGQQGCo3AF5ICOpa8nY6SiTE6bG0Z6zA6MveXXh3Lh2QzdZH5uIFbJwn1rYLMaW0XiZNdupzz+whHL5F8bYqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764335518; c=relaxed/simple;
	bh=HiLQX29b5guv03Xa2F9dczNRdVutcFxPYhQoC6d936I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sLqslHllJiLjAHzn9IXiTMFSGKcdU9VOoeMLCsFOskd9iTYROwCJrMcxIxRLmn3XWzzRoC197V7LLAPE+FmtU0G9E9cP6CVNX2eMyG3rU1EV4Tkkzti9+dY0rFhX3rP5XbPD7dgwk64+i8eRBOCJhooBAi98ujqxCtQOOPIoCAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3f0cbfae787so1298285fac.3
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 05:11:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764335516; x=1764940316;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S8uFw/PujVTH/oHeKrVPdOpFhoSGuPIY79hEVzuk/E0=;
        b=VJWS9D82wRRRMtAT5YxJk4QOoaBSt7IU+xZsF47TRKEAlV1emVoYlbxVoVgXiPpt1C
         SQteMw7px+JooqlUfWQorl+/zeJRYSZV6kn48x/42tWhxSi/bvf0WDpeh3amsOaFvdff
         1X/y9H9WE1Xww+PibreGaak2Bbth9FGODliY9UcgPwvuO/OPiK+7aF+vBdiWuvMXM08i
         DpV74fBn/p2y/vmNurGVaFN47JbTWsCkZT9qY3w+junb/ZEaGXDPZW+WyIdskEWbzGP+
         N8h/YHaQ+0wpmO15iLnm6UHXAKLGas+t/TNVMleCgcLBlP0qTSjb2d6dotPKUwwIa5qz
         ye0Q==
X-Gm-Message-State: AOJu0YzucgLanN3FOoQ42gh84hwsevg2Gn1pMv9EvOIUOD4BCfkqBvB2
	E2vf0mQ/l1a06WmzPZCYAN4jyU+Vhe/0qARWxDrx+cGd+D2o+byX4rzG
X-Gm-Gg: ASbGncv26FXXlZhM+kVXu6XVjjGUzK3ulCt2Rib+oH5Cx8UGrNhxyX0C5gZ+d8bhCOf
	L8A+3ditOhAwGtOxU4Rq7/tBlCYfmVu4+uJ9HJ+lzdIq5ryDj8DuF/kwKcPoSANqeG6rXnY/bWX
	jCopfIMYWFMC9qM4l2qSZEuqhYYINWmMqDvdXMUQINhSPcVN5AxQcyggrQUSYpNgGUzPasY3o9d
	UV+MARKrbxqjQf2wxLvfuM9S2b7PhS7E3MzHgndM3BTak0/4ul5p2sO+/ps+SNhh0ddLHd0i6gx
	SeQ4Qpi9jswKheBInB7xai8y0CBcYBtwdQTPDPsiGWJJqaLlCFpDf195rN+MuHeiPrJzG+HMT23
	1mOQNuZ1MKmlajkhR3f/9ygZ8/2gwbL/PutEH5O5FWddsJ8DvlVkbwM3cwnuOO9x4Hxuzy1l7kM
	KcJON3DzGSnVf/tw==
X-Google-Smtp-Source: AGHT+IFBWHNf82+ULMr9U1nzWRrRHHaPVEV1BeMSqdhxpkXed25KiTLYCHDZPov1Zae2zfsdagAxdA==
X-Received: by 2002:a05:6870:8303:b0:3ec:2fe5:2b44 with SMTP id 586e51a60fabf-3ecbe57e931mr12197828fac.26.1764335515545;
        Fri, 28 Nov 2025 05:11:55 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:4b::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f0dcfdba71sm1748612fac.12.2025.11.28.05.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 05:11:55 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 28 Nov 2025 05:11:46 -0800
Subject: [PATCH net-next 2/3] net: dpaa2: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-gxring_freescale-v1-2-22a978abf29e@debian.org>
References: <20251128-gxring_freescale-v1-0-22a978abf29e@debian.org>
In-Reply-To: <20251128-gxring_freescale-v1-0-22a978abf29e@debian.org>
To: Claudiu Manoil <claudiu.manoil@nxp.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Ioana Ciornei <ioana.ciornei@nxp.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2015; i=leitao@debian.org;
 h=from:subject:message-id; bh=HiLQX29b5guv03Xa2F9dczNRdVutcFxPYhQoC6d936I=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpKZ+XV22COGsOLITZ0lkbHuNzbbAaJN2GXBGn+
 /E0fAnmGUaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSmflwAKCRA1o5Of/Hh3
 beJqD/94vMrgnJ2jURPp+1ZIJV9lbvrVc6p10TeXxyPaB4P5iQ+RS9+y1pVEhMZw6EpFBGzVe4g
 InvmdUTudeW77ioI8EAYyZgSa0Bp47JT3fkTCQyBLsVQ7+nVO4E4rU6v9XecqSSzscg68mUOmSw
 HS4EUnKyenXxV6TaXmGG2JNmroiHrJ040MdMEXjQoAcBoWYf9Qav1ih47fEbey+zXX+Mcw7RQgP
 g/n6c8bkxSk3HTc+KrNsDZIQ7xuVCc5Ab6663ERHDyJJeqs+4Eh4D00m0kawhIPYOqn+KoTorag
 hPkanv6hPv58aPsV0ZSyMvj87pXtaRVOg7M4D/daCwpXaPf2PCWtU91l7WbtUo55gBG8b+R6RGx
 a/hsxuafNW4duAWThw2i2BI8h/ZaDoZzX+wJfKKEYwkhL/fvn4q30nxtSDgyaY3WMw/jcoreS1N
 BpTbCSvtZ8IvIa1Nib5hzQjE5XthiIni/vtbqYXCrVWqVVVMUXqUYdyuQ2kgD64uVCtAw26rm5y
 al4gwwe9zTooh+V+NwbA+rFX0oLtm4ENbKzMtovD89BH838cV17Tm6vQo60iTtfDdfr0Jz4/cTH
 U0VGRIMiQ8mE9zyOtjPwQS2KI+DGfVCcLO6pUnVGRZ8HNEj1mRcm4W5zPRMXx93AAyolX4j2rJy
 1zIrrwzotdXAsFA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Convert the dpaa2 driver to use the new .get_rx_ring_count
ethtool operation instead of implementing .get_rxnfc for handling
ETHTOOL_GRXRINGS command. This simplifies the code by removing the
ETHTOOL_GRXRINGS case from the switch statement and replacing it with
a direct return of the queue count.

The driver still maintains .get_rxnfc for other commands including
ETHTOOL_GRXCLSRLCNT, ETHTOOL_GRXCLSRULE, and ETHTOOL_GRXCLSRLALL.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
index 00474ed11d53..baab4f1c908d 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
@@ -711,6 +711,13 @@ static int dpaa2_eth_update_cls_rule(struct net_device *net_dev,
 	return 0;
 }
 
+static u32 dpaa2_eth_get_rx_ring_count(struct net_device *net_dev)
+{
+	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
+
+	return dpaa2_eth_queue_count(priv);
+}
+
 static int dpaa2_eth_get_rxnfc(struct net_device *net_dev,
 			       struct ethtool_rxnfc *rxnfc, u32 *rule_locs)
 {
@@ -719,9 +726,6 @@ static int dpaa2_eth_get_rxnfc(struct net_device *net_dev,
 	int i, j = 0;
 
 	switch (rxnfc->cmd) {
-	case ETHTOOL_GRXRINGS:
-		rxnfc->data = dpaa2_eth_queue_count(priv);
-		break;
 	case ETHTOOL_GRXCLSRLCNT:
 		rxnfc->rule_cnt = 0;
 		rxnfc->rule_cnt = dpaa2_eth_num_cls_rules(priv);
@@ -949,6 +953,7 @@ const struct ethtool_ops dpaa2_ethtool_ops = {
 	.get_strings = dpaa2_eth_get_strings,
 	.get_rxnfc = dpaa2_eth_get_rxnfc,
 	.set_rxnfc = dpaa2_eth_set_rxnfc,
+	.get_rx_ring_count = dpaa2_eth_get_rx_ring_count,
 	.get_rxfh_fields = dpaa2_eth_get_rxfh_fields,
 	.set_rxfh_fields = dpaa2_eth_set_rxfh_fields,
 	.get_ts_info = dpaa2_eth_get_ts_info,

-- 
2.47.3


