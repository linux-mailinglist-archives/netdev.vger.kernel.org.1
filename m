Return-Path: <netdev+bounces-221397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E90B50706
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 22:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D615E6858
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 20:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCEC36CC67;
	Tue,  9 Sep 2025 20:24:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A56536C082;
	Tue,  9 Sep 2025 20:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757449470; cv=none; b=Gi4JzivoTglyYstm5/a8820lU18wDWXgxGokLBiH3tknz+w5PI8UNEu9BWKUQHaN5cwbgEN5yKyDY+RVqEwnOsnJgmzWEhTGNgzZx566wWLLNPB3wfqaTBkPTVoYAyVVXNhEgdXNBCmM47QmebccFDqY5kMfFzmFGzZFvf5H16g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757449470; c=relaxed/simple;
	bh=Y2hXfnHzSfKGpkRV/+ZGUekIkr1Gt4/QOQoMmnAXviE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=urz24ieOw2sC6fqJgbqbUg1S2yHpq4FAkdbWanOXixrTJYTbnrdVVj8sL3jt/LuEBqYtGcNkQC8px75z9Ih49duziEO51m7OxqLlgxQkWM7h/D7yq7EOqVMSlFsqCcUu2v+ogzXh7KwdlDHfHvrH9OX0dHPqms0OdF/XNH3I2dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b00a9989633so267200366b.0;
        Tue, 09 Sep 2025 13:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757449467; x=1758054267;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0gIuHH4FHMvq9oSF/Jigf17pZ9LbJklvlGco8PAXnY=;
        b=qy/iZYE5CD933wCLHvvoxh9+ItrPHaDI43t4DSQ9tqg3wIaYsI6dzChVptxM90MJLs
         u5uyqwJl77Vq3dm+PGR4Wzsa9xqrxq3bgSxFtx4IFOBZ0otQr8OT6nk1yUwWq3dmR+J9
         ouSRt3VImYTvLtqdSM1k4s3YQGfxoydY9adny3O7KfMAdInBQ9EBWv60viachcPPWFvn
         k2CP7SuOOQDswme2YfpWctSFdvFgwWxuYKlEujYOS6DwHPHZEjWdQORvcr6C+kCJFZlU
         6WkySGFaWiLyi2LYniBnKreYeKLqqVA4cil6KN7Rd31vgjC9jPA/bJl1UEc8SnUzDaS0
         HGXw==
X-Forwarded-Encrypted: i=1; AJvYcCWdTWa1537XaZ/xpsPokUlNyNmVrCBGGEOWeKyQxMDe72E4PAnXMM9nat8kkHminjlpmky7wLdwFx2HBg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDRfgjwFS9fwkuisVmkNxHU1xk+kgQU3Q0cA+1/M8zpmVRoCyS
	aI0zV9TbPg6ABiPlrkgxmy85F0r4RMr4mv4jPPdo815IvJ/xpkM+wAz7
X-Gm-Gg: ASbGncvT6R8/sEIt9plx1YXgmEN7vYi63MNuDU5FdFWO3Aj6Jswa4QiuJ//cx0+amga
	66Q+2cu+hdg1QRgiWJJP76NEUwcWy5pooXYTAyXREq3+PuQN4Ub98Sq5zgDphP8Nndss0O9EVgY
	BdqwH/Nfl8JgzRrlhWuThRo78lk2iarhBusZZBwrPkMngTp+PIsOUuKJU5/G0mmOOI00ypsCHzy
	/94/kv0N/3hc7FqDvVxMIKMjILb/lIvg9GLGibM5gpyHXbNE1aZ+viCXpSZ1Tiv1kyWleeYF6pa
	iBkpjitlDfmhOv6LfVxnD/OfEZ2r0F67EBQHcUDhZrv9FLfIW2+JUfWteJtmriRAZ/HPoxL45P7
	mx2XSm5iE5JOM
X-Google-Smtp-Source: AGHT+IEK3ZoFj8QYDAr4NlAPkp8aJUwqkx0FN+bwLBX7AEho7EnU/rHebPmVDrI+BtfXZ8uN0GJ4ng==
X-Received: by 2002:a17:907:1ca3:b0:b04:5bb5:2745 with SMTP id a640c23a62f3a-b04b1f0cfa0mr1239911266b.21.1757449466569;
        Tue, 09 Sep 2025 13:24:26 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07830a7598sm47470966b.24.2025.09.09.13.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 13:24:26 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 09 Sep 2025 13:24:05 -0700
Subject: [PATCH net-next 7/7] net: virtio_net: add get_rxrings ethtool
 callback for RX ring queries
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-gxrings-v1-7-634282f06a54@debian.org>
References: <20250909-gxrings-v1-0-634282f06a54@debian.org>
In-Reply-To: <20250909-gxrings-v1-0-634282f06a54@debian.org>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 kuba@kernel.org, Simon Horman <horms@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1617; i=leitao@debian.org;
 h=from:subject:message-id; bh=Y2hXfnHzSfKGpkRV/+ZGUekIkr1Gt4/QOQoMmnAXviE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBowIzuzfaQzetsofrcRbpnwuLrO1D7w86wY1TTU
 lrqGZgmCpuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMCM7gAKCRA1o5Of/Hh3
 bXNZEACcAE5R231Z7uNnKiyv2RPO6hJXjog8YhKoP/yzmIshYPJ0FAh+8o5piRpRtM6dIn3qeky
 Ve1yQ7Aw/Vn8l55/nTiEZPX665GmRsqep7Gba1AHM+74XOC+97c0zEQXxid9b+gICQ2Sstr7hbT
 soSkCyNxLHjMgPxyHxw0/L+GSL4cBJHIQKMvR+6uDBCNcZh9wYinG0rGorRBHPj+FCkX51WtHCp
 wJ+furxV5a/tIdO1ApWgVUcqhomico6t2mIziLg6dSgwljOTRH2bKpmwfhz2Z79sBLtNIW938GO
 6EV6K3X5TaY9wDymNRCMAHARFqNJFpBmdQcMRbNX0p+EP2jcpseYnh3XYx7rEwEdDC70lyYpdmP
 LSZrKK/bEAJq8ZhG9ONl0+B2fHP9xLZH+xNIXamgSlk6h6HASJ4mbrfpnRch4YmCQntT7asuCiM
 s41BTaQndV6gaP/m2Fyk9ByczEjdYeX/JRMg/VdlZUcppBm4q9VLrz5bTLji+suZPduq602SWhX
 rwDS8GDkRdHiUEB+Hc3JaxEVH5mSLPAxuQp84S/nkv7VVuQFgD/dPlaDTkvUK8X+rlOfEjb2TB7
 ZiI2uaLp8RpXRA+oz3+wnuVuWJ8gWcp//voZ+HEDBzlZpHcjLJ71zUzypcZXd6Zo4wZXP+2saHB
 NTHpOaRsFhQuJmQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Replace the existing virtnet_get_rxnfc callback with a dedicated
virtnet_get_rxrings implementation to provide the number of RX rings
directly via the new ethtool_ops get_rx_ring_count pointer.

This simplifies the RX ring count retrieval and aligns virtio_net with
the new ethtool API for querying RX ring parameters.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/virtio_net.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 975bdc5dab84b..e35b6ef015c05 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5610,20 +5610,11 @@ static int virtnet_set_rxfh(struct net_device *dev,
 	return 0;
 }
 
-static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info, u32 *rule_locs)
+static u32 virtnet_get_rx_ring_count(struct net_device *dev)
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
+	.get_rx_ring_count = virtnet_get_rx_ring_count,
 };
 
 static void virtnet_get_queue_stats_rx(struct net_device *dev, int i,

-- 
2.47.3


