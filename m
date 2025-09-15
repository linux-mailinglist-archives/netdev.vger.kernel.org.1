Return-Path: <netdev+bounces-222993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32931B57720
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 12:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B2804455F7
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 10:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A363009E5;
	Mon, 15 Sep 2025 10:47:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704A43002A8
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933266; cv=none; b=K8ouIjp6xx6Do8x7gmhYowBorHwtmmNRSWpWOAa5HhIS1xqImAGpuSOEkPyqfOgvJqImpBZ1qiZ4wLUicM1x9h4Cpa3JVt74uPq4O/cKrL/9pkq1+lyucsWpl332reI+cqrtP6by/v2VcE1Od9WqVUxBAN+hoRwFnApuwfgl33U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933266; c=relaxed/simple;
	bh=g5R+KO0zDOkxIkWQNfeVkn9e14oSE0vPMCqx5KVoKUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G/fCpYqJ6jvFflmZSS69OP6kBj01JCHBaShIluanZ1YxOAeGUoyGa7ooTYV7ZJQikMIf1h8MFPKMEybntaee5x8SiUpo3oB9Otw8CKzbl+wSp759207zTmrlewlTM9xEQ4sP5hqHxG2KhgVYgiOx3rwr3aKKcxa6bwZxm2JhIFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb7ae31caso713949966b.3
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 03:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933263; x=1758538063;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNdbybFK0ieLurW9tGv2v5Ky8Nf9YctW4a1t2pmLOlc=;
        b=qCqtu1xD2x2IO0KcB0kT1Y43RWONF4BXMwOQ3n4jfOVrujSLbcIcxv6Sf6RpU/h38u
         7L4xBO/hW6a7sVbXDJOzv1yDivwfErQ38VWtnb5KacLoLLBXPMid5Zm30R93Fa8UfM1a
         Dv9T5KtP2YjWjSmSl9k/jHCqnCZ1PGlJeL08itxwP6admHH6A86bIkT5z6lrv8yyRLAW
         lcqXtTVaBotMlKAot3rP+Ax//9hhFLqq7+cqchT3hgmiNMJKtw+CxVvmwpuoVh3RS2oj
         yY7HAwVsxQrrSkeiR0FGwX6kNvGpX81eMlj94Hk7Qv3GaQ/iCqWgUb9Ui0LItZwSnknG
         R5Uw==
X-Gm-Message-State: AOJu0Yyxcm3IJEC58aEjZs94Txaij2cY7woQuL16eduIgxZ3tnfA2yBz
	njoH1XAOOvRFhTj4FC+hoRAWAj8KjA+PB8c7mXeXUop15J5AiN0t4ihK
X-Gm-Gg: ASbGncuyOy9VuCyPCfnVmfAE9OPNHnD2DuQfiEXG/QXNyFzNBlAtBmX+PIh3aH7md4b
	UVz4c5UJ5IL8lTsyF2G4NBpSLvKff6t2H//LsGupD5Vy4BPR4hwkFfCOxXJwIHQX7AvRO50/uO6
	zkDxCOEgCCSwvedUqHdrUWmp1mU4Bp+E6oQc3wcfiXAgx1H+PvgnqMylPEpu0/CFzqniBPN/q7f
	1RbT6+aDzw7EaofDuLNHum32+sqdXmdmr56hUBPEV2gAs4AX8GzA4PBTYo0V0tdJzQWrKmBD4Ru
	KRV9YuusGb6fdCvsbEqUsbfdp/48NrYTxiQQrA7TtHqw4NPJhnENCsns0Bxt7xWLsYs6Whns0cP
	qTrRvdSPPrEqiHKDPWbMgG6IK
X-Google-Smtp-Source: AGHT+IEv9M1+XeyH4YaGcgM5JD/js2B92gnuLogt/kc1W1a14tJODp4LRaazcfABYgiJxEm71MSNiw==
X-Received: by 2002:a17:907:1df1:b0:b07:dacd:f981 with SMTP id a640c23a62f3a-b07dace06b9mr663196666b.28.1757933262660;
        Mon, 15 Sep 2025 03:47:42 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b3347a4fsm898294366b.103.2025.09.15.03.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:47:42 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 15 Sep 2025 03:47:28 -0700
Subject: [PATCH net-next v3 3/8] net: ethtool: remove the duplicated
 handling from ethtool_get_rxrings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-gxrings-v3-3-bfd717dbcaad@debian.org>
References: <20250915-gxrings-v3-0-bfd717dbcaad@debian.org>
In-Reply-To: <20250915-gxrings-v3-0-bfd717dbcaad@debian.org>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 kuba@kernel.org, Simon Horman <horms@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 Lei Yang <leiyang@redhat.com>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2140; i=leitao@debian.org;
 h=from:subject:message-id; bh=g5R+KO0zDOkxIkWQNfeVkn9e14oSE0vPMCqx5KVoKUc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBox+7HLk5bXOHgNvPiT5PsRW3BqaLieuawmdwFr
 ubyn3yCUy6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMfuxwAKCRA1o5Of/Hh3
 bYp0D/9KMm+eyNuQ0UcsobmG05pUWUug8aAkloEZ0u15EiwrwffFmvDg5SlDdWasTQMMs3pk1ar
 p8d4XJ+ZhuYz6GJor/r8TF1wppK1adTPbj+CbSzaN8GNtqKPr8EdW6N1J2VPPXxI4xl/wmX3KO+
 oHlyYVtux3Sbd3baDeBzxT1+R4VUvEwkiqcWycmcUI0fCFvSQtDbzFnEEdtG7kdgUbiE2asgrCf
 gIk2bQrOCEKyD2BahG0xQnl4sM9/kpqvAgH24TYih0I0JcIKXR8zJ/TqvfC8H7mHYzZEVpTPh4d
 VNAQmGNh7zUB5HFNZYhIRf/TapTUQ098xOJ3kjxl/Jl9HhRVaM246X/XzzUHJGBrPDas0929twW
 8xom2ZmCPKsV++PxGXGhcWZCga08zILBviYHnQ/prKzW8oxrPmDKEtoQPpJUycVmkO8ilPcmN1W
 yCygBfgcwWC9UTW7+9PAuihEcWga13V4COPOxN8as1GqleZN5LQ9ZrDUUHYiVfI7FJj4P0br2KU
 Sb5fLKqbxzZlKFZ6AOBSjrn7ETAdUyI8y2y5GZ3oQo09+tJhoeoxH/gSl9mC1HO3gwKWTjLgfgb
 Hh54mVP38tfx1exhUV67xI40wlP+11y/rPxO6kKnqqfYmAMzuyx0agOVuUv5Qor5IPS2msYllaq
 SZDDcphGmS0AqWw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

ethtool_get_rxrings() was a copy of ethtool_get_rxnfc(). Clean the code
that will never be executed for GRXRINGS specifically.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/ioctl.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 4214ab33c3c81..a0f3de76cea03 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1212,52 +1212,39 @@ static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
 						  u32 cmd,
 						  void __user *useraddr)
 {
-	struct ethtool_rxnfc info;
-	size_t info_size = sizeof(info);
 	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_rxnfc info;
+	size_t info_size;
 	int ret;
-	void *rule_buf = NULL;
 
 	if (!ops->get_rxnfc)
 		return -EOPNOTSUPP;
 
+	info_size = sizeof(info);
 	ret = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
 	if (ret)
 		return ret;
 
-	if (info.cmd == ETHTOOL_GRXCLSRLALL) {
-		if (info.rule_cnt > 0) {
-			if (info.rule_cnt <= KMALLOC_MAX_SIZE / sizeof(u32))
-				rule_buf = kcalloc(info.rule_cnt, sizeof(u32),
-						   GFP_USER);
-			if (!rule_buf)
-				return -ENOMEM;
-		}
-	}
-
-	ret = ops->get_rxnfc(dev, &info, rule_buf);
+	ret = ops->get_rxnfc(dev, &info, NULL);
 	if (ret < 0)
-		goto err_out;
-
-	ret = ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, rule_buf);
-err_out:
-	kfree(rule_buf);
+		return ret;
 
-	return ret;
+	return ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, NULL);
 }
 
 static noinline_for_stack int ethtool_get_rxnfc(struct net_device *dev,
 						u32 cmd, void __user *useraddr)
 {
-	struct ethtool_rxnfc info;
-	size_t info_size = sizeof(info);
 	const struct ethtool_ops *ops = dev->ethtool_ops;
-	int ret;
+	struct ethtool_rxnfc info;
 	void *rule_buf = NULL;
+	size_t info_size;
+	int ret;
 
 	if (!ops->get_rxnfc)
 		return -EOPNOTSUPP;
 
+	info_size = sizeof(info);
 	ret = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
 	if (ret)
 		return ret;

-- 
2.47.3


