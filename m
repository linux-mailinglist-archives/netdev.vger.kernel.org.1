Return-Path: <netdev+bounces-220432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54C1B45FA9
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 19:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 624447BE1CD
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 17:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CA237C103;
	Fri,  5 Sep 2025 17:07:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F40C374292;
	Fri,  5 Sep 2025 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092067; cv=none; b=bzpL/7KmKDawLIUl7NSI+LYgo7sVNmQa4v5vMy0Pp1wmWR+WTDmZpPr1i9FXJtSc94MIw/A66xqlaKxOa2qoi+sPiQXz1uBKJvOc9sx9RtQAYskWghjdnzphHKxhgcZu4GDN4miB9MtdTMxB4wLbueyTK563MltucSuvnzYchzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092067; c=relaxed/simple;
	bh=3aXidoCnjwjLlFAFt83SYhSNY9u5/DbQjFuEPX/ClMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qUhQziS7Hx7EI7TwfbOcaOlmM3bbNnppdLYZq4Xb5mU6YsgqHiIqa0y8I5U+Z62zZ0Z5/hdNKPpP68b5WVnIx1pmYC5D+nLrhath+/xO+m6LFuv1iXFG2BUN4mVCcUp+y7u4UAgYZtXuWor8A6HSZZk2P2qwdxPfA8tgUPs2mRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61a8c134533so4447944a12.3;
        Fri, 05 Sep 2025 10:07:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092064; x=1757696864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPOh83BwsxUoqeI+xJ5O/OzWhrMRpIrMTjO1JPoh9E0=;
        b=WChw8X0QAyFyJXC/Vt1tlQe7ixA5IAS+HQbV7dyezOCmXN1nj6bJczjrN2QWXQWhy3
         Tsqqra4jHcyCFAjxu+qZLdRPlX+rBLnXoMzewWB/aZIUdVA9VXcSjlnDZqinGT17GP2t
         XXsplGFYlXhDEKPadEgXLpThwQrc3Iw+zgettKiyIzvJUqVcCX91pNVi2/zVjQfRm8dW
         x7zUwiQdv6CEavLGKs3P27ZXxpTAXu1ttJrvCEdy5UGwzNLwmiXa1iXk1mhDuRR7A4+F
         zX8w9671RCwyYxS32io6TAcQXTvzzWTFuLGd+tgEOmbWtYPYvOlDJCzO2KvPmWdvKRwt
         kEvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr36u2Z4bxGDYxkVp28crRoDfns6Mu2ozV08qGs9FuWWtNBV03bcx8K9XozNIBvBdJ0hq5V9ayInbd/KA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfD7IDG+5kWclfOZ0VibJXo85MHuy3V7YR4huh0cxawmdiDRAM
	l/NhtJR+fwa+w/uTsTBmFwpWRfq+z9q5r/Xp9r/qttx2GVYuEy2Ni7df
X-Gm-Gg: ASbGnctATNBFzM9yGdu6ChxVJ48lOyVtIiLg4lh//wixrenyGGm313CHu0Zw1b/8nNm
	7WU8nODX5qXNugKsSgkq/W43Tq2WkvUcPNphE6QBWQ1cuTFWBrnRYp30TY8d8Yx+H0AGhqqJH3a
	gLipml80ERbIh5P8x6LU+CIUS+fiXIDWwT4yr6PZQ/8ZuQyH07XlmjmdKFZbKzvqA+miiI7N+wJ
	7svu7sh/OXJIKB/RIMmbswoUT/FX9z5v0PKF9p7Tmygk2MlwpkuKBnvapMgYV4zP2lJPpmjOmuy
	1O/R5zI4BB0uylTASzupJA8foUjq5YnQHtJx8wFne1u5mvUnK3RA/G12ChDrinVpLCZnlobr9Nk
	q3WR0mHnyIOJNmLquCJgu2972
X-Google-Smtp-Source: AGHT+IFHB/021clnQGQ9l2V/ebhPpnhyDNv4aANIU9IER24mAVYd7lakHWEK5C+0sF2ladD2UZSv7Q==
X-Received: by 2002:a05:6402:210c:b0:61e:a5c8:e830 with SMTP id 4fb4d7f45d1cf-61ea5c8e868mr16151197a12.1.1757092063706;
        Fri, 05 Sep 2025 10:07:43 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c77d0sm17028678a12.11.2025.09.05.10.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:07:43 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 05 Sep 2025 10:07:26 -0700
Subject: [PATCH RFC net-next 7/7] net: virtio_net: add get_rxrings ethtool
 callback for RX ring queries
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-gxrings-v1-7-984fc471f28f@debian.org>
References: <20250905-gxrings-v1-0-984fc471f28f@debian.org>
In-Reply-To: <20250905-gxrings-v1-0-984fc471f28f@debian.org>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 kuba@kernel.org, Simon Horman <horms@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 jdamato@fastly.com, kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1593; i=leitao@debian.org;
 h=from:subject:message-id; bh=3aXidoCnjwjLlFAFt83SYhSNY9u5/DbQjFuEPX/ClMk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBouxjSrAs1Sm+xxMdVGyejtHHGgv9lU+1AEZcr8
 HRgIm5+yvKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLsY0gAKCRA1o5Of/Hh3
 bSzdD/9VZrqjup5ByMvV1ARdrXaNOQAT0EzCwe6eGJSqbeLxU6C5ECSqaD2RYn6tKOwqGGwr0aK
 KNWlZc7acHG7tdwqHvzcctsE6HsC5bFDsVO7N4AdhNiZtz0b/U0FLDYas4mtVQyw68PRhffmMBX
 boWG8bfFtjAj4MvMwVbFlWNYsIbL/FNHgMx/7zj5pLzAWB4HFASzWEkpq2dgQdittZ05EpETn1u
 UMRVxB5cG7Gebm0jD0L86pan6rSQlaLr6VZDUN+zQkUsP9aO9YY99Zux7c+u16ZWaVS9AskwOze
 ce80xTgM9pgAz9S1WQyDCC0w1xLbw/zfZI2Y3xTUpD3oRC+QmRBzezdCnD3+6inNbf/QyNGqwpL
 30d8WBTuEcCMXqKPYwmWgaEL30ljXdjT89l4Q4xyzMgGLc3WMBxLXUlFVq4AfW8JeSeIpITb/lj
 9RX94ORn0vcc4wgenLBxht/1Y0JIRyWYr7JIz/CIfhlnbEl0VSaCNK0gFCMKf6u7DYpd29s5tZV
 l1WXHx3tdLMBIFtlbM2dAzS9eBBb8fbeh4QOju85Y4GOs5qozuuFsLZETAq1ZkJF1PdzeTWg+sP
 /1ig8EsSB8pIvbnuafh054c5DHfMc2I1IFr1eeVvrnu2Z3LzDJroipiBciPKHFPubblQW/PfxGa
 UOYSQ23i/cdj7GQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Replace the existing virtnet_get_rxnfc callback with a dedicated
virtnet_get_rxrings implementation to provide the number of RX rings
directly via the new ethtool_ops get_rxrings pointer.

This simplifies the RX ring count retrieval and aligns virtio_net with
the new ethtool API for querying RX ring parameters.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/virtio_net.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 975bdc5dab84b..942ae55e8897d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5610,20 +5610,11 @@ static int virtnet_set_rxfh(struct net_device *dev,
 	return 0;
 }
 
-static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info, u32 *rule_locs)
+static int virtnet_get_rxrings(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	int rc = 0;
 
-	switch (info->cmd) {
-	case ETHTOOL_GRXRINGS:
-		info->data = vi->curr_queue_pairs;
-		break;
-	default:
-		rc = -EOPNOTSUPP;
-	}
-
-	return rc;
+	return vi->curr_queue_pairs;
 }
 
 static const struct ethtool_ops virtnet_ethtool_ops = {
@@ -5651,7 +5642,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.set_rxfh = virtnet_set_rxfh,
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
-	.get_rxnfc = virtnet_get_rxnfc,
+	.get_rxrings = virtnet_get_rxrings,
 };
 
 static void virtnet_get_queue_stats_rx(struct net_device *dev, int i,

-- 
2.47.3


