Return-Path: <netdev+bounces-99676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F708D5CEA
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 10:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AD8BB28E36
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 08:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E7E14F9F8;
	Fri, 31 May 2024 08:38:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B871509A0;
	Fri, 31 May 2024 08:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144732; cv=none; b=ZlnX8HIhpcTulA4GKqORC3nsP1vYMngaBkK/r0dHQpuOxrl1EA437e28d5FRB2VRkyTOSS0oDtQiUGEGYIRtrozsVBwAjoKS0F7YtxX1oCZY0LmDz127uqoTVf4C6zjKuk5ir72JqnKmbhFPyUdt8p6+nqTZ5SCEIOpKDOyANGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144732; c=relaxed/simple;
	bh=EllydnyfeYldFu/EBpUAeZrS0zgaVpolpK1I6EowbuA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FmDhGOEPd6cJzN/hU3lPJNUp1hCerQkQzWpSpZYJs887D9/gNAeGns+eoYRLK3+9hBdnRy3iZQDK4Ui+7KwoTJKJxFtHeuapuSF/p7dYf+4bxzU3tsU+9GJHGJ6fah0aiBCxe3PZH2+H1RVr6ppXNCnLjRtAWhLW9WM1szM6vmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3061b1421f2911ef9305a59a3cc225df-20240531
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:c99a51ee-a07a-4200-805f-7e8eaae0afd6,IP:20,
	URL:0,TC:0,Content:0,EDM:-25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-20
X-CID-INFO: VERSION:1.1.38,REQID:c99a51ee-a07a-4200-805f-7e8eaae0afd6,IP:20,UR
	L:0,TC:0,Content:0,EDM:-25,RT:0,SF:-15,FILE:0,BULK:0,RULE:EDM_GE969F26,ACT
	ION:release,TS:-20
X-CID-META: VersionHash:82c5f88,CLOUDID:18d63e66079d3071e08c677f7dc8762d,BulkI
	D:240531163844I27RDKAM,BulkQuantity:0,Recheck:0,SF:19|44|66|24|17|102,TC:n
	il,Content:0,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 3061b1421f2911ef9305a59a3cc225df-20240531
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw.kylinos.cn
	(envelope-from <jiangyunshui@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1258249045; Fri, 31 May 2024 16:38:43 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 8160FE000EB9;
	Fri, 31 May 2024 16:38:43 +0800 (CST)
X-ns-mid: postfix-66598C93-390090898
Received: from kylin-pc.. (unknown [172.25.130.133])
	by mail.kylinos.cn (NSMail) with ESMTPA id 2C35DE000EB9;
	Fri, 31 May 2024 16:38:42 +0800 (CST)
From: Yunshui Jiang <jiangyunshui@kylinos.cn>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Yunshui Jiang <jiangyunshui@kylinos.cn>
Subject: [PATCH] net: caif: use DEV_STATS_INC() and DEV_STATS_ADD()
Date: Fri, 31 May 2024 16:38:40 +0800
Message-Id: <20240531083840.2644162-1-jiangyunshui@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

CAIF devices update their dev->stats fields locklessly. Therefore
these counters should be updated atomically. Adopt SMP safe DEV_STATS_INC=
()
and DEV_STATS_ADD() to achieve this.

Signed-off-by: Yunshui Jiang <jiangyunshui@kylinos.cn>
---
 net/caif/chnl_net.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/caif/chnl_net.c b/net/caif/chnl_net.c
index 47901bd4def1..376f5abba88d 100644
--- a/net/caif/chnl_net.c
+++ b/net/caif/chnl_net.c
@@ -90,7 +90,7 @@ static int chnl_recv_cb(struct cflayer *layr, struct cf=
pkt *pkt)
 		break;
 	default:
 		kfree_skb(skb);
-		priv->netdev->stats.rx_errors++;
+		DEV_STATS_INC(priv->netdev, rx_errors);
 		return -EINVAL;
 	}
=20
@@ -103,8 +103,8 @@ static int chnl_recv_cb(struct cflayer *layr, struct =
cfpkt *pkt)
 	netif_rx(skb);
=20
 	/* Update statistics. */
-	priv->netdev->stats.rx_packets++;
-	priv->netdev->stats.rx_bytes +=3D pktlen;
+	DEV_STATS_INC(priv->netdev, rx_packets);
+	DEV_STATS_ADD(priv->netdev, rx_bytes, pktlen);
=20
 	return 0;
 }
@@ -206,14 +206,14 @@ static netdev_tx_t chnl_net_start_xmit(struct sk_bu=
ff *skb,
 	if (skb->len > priv->netdev->mtu) {
 		pr_warn("Size of skb exceeded MTU\n");
 		kfree_skb(skb);
-		dev->stats.tx_errors++;
+		DEV_STATS_INC(dev, tx_errors);
 		return NETDEV_TX_OK;
 	}
=20
 	if (!priv->flowenabled) {
 		pr_debug("dropping packets flow off\n");
 		kfree_skb(skb);
-		dev->stats.tx_dropped++;
+		DEV_STATS_INC(dev, tx_dropped);
 		return NETDEV_TX_OK;
 	}
=20
@@ -228,13 +228,13 @@ static netdev_tx_t chnl_net_start_xmit(struct sk_bu=
ff *skb,
 	/* Send the packet down the stack. */
 	result =3D priv->chnl.dn->transmit(priv->chnl.dn, pkt);
 	if (result) {
-		dev->stats.tx_dropped++;
+		DEV_STATS_INC(dev, tx_dropped);
 		return NETDEV_TX_OK;
 	}
=20
 	/* Update statistics. */
-	dev->stats.tx_packets++;
-	dev->stats.tx_bytes +=3D len;
+	DEV_STATS_INC(dev, tx_packets);
+	DEV_STATS_ADD(dev, tx_bytes, len);
=20
 	return NETDEV_TX_OK;
 }
--=20
2.34.1


