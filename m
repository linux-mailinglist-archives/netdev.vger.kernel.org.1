Return-Path: <netdev+bounces-127325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E033975058
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15CA61F2240A
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB12186E4F;
	Wed, 11 Sep 2024 11:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="cl6W/o8+"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B849185B42;
	Wed, 11 Sep 2024 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726052409; cv=pass; b=XbEiX0LPeqhMhIxHWtNiM21HFMFkc5EtC7mW12Z3312ptQq3O9H3XbG+Z6L2/ji+9dTBYkj8H+jvmpyxxeuXac7ycM/uW5ZyEun6wUhYXHtImft9PY8ocLI3pqh7PhEUKHue29p98EI1/cDWIo4hJtiXeLXWNbiLNCTyum65XTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726052409; c=relaxed/simple;
	bh=Q2C48jeUh9GAAXa/UipFpoOJmtlF20nq9q1sZnfECOI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UKQTX0Ma8KgMcXR2e5XsaDQ94vyRiRy1477cQz38mGneWbGr5dg83rGcEDm/KHK9SBShindFdo4C7qlwJOZMhyDahu0sL1VZNzCQMSAeXsphCUml2gGpUUA26f/oKHvGGFt6Cfe7tw2ZpUUsaQMy+QpBLRoJn0KYatZnIAs/iyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=cl6W/o8+; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726052383; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=C13aku2Ns5KTPQ6QTr7s6rIwh3q7fWSpKQuXgRkkblDCQ+YadMUlFaC0/YMHxv1S5n9u1N/ILDsHJEi4Sk4bSdSanZHvdxWsjji5mGOLp0UkoA1FkrfUWsaNHonxrMRot50NZ/4g71/Ji1lULtF4uOKZDEFacEVc6rbrJU0NXCU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726052383; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kStjaEMg3PiBnNUf6GpKxxqL6ll8T7NBJDyR23ubwac=; 
	b=ngITzAGI/qSPOEhf4hSomnINxm7s0Dt7HMJSal3Uqg7+p2nv/MHhsbSf9t+nF/9HjkE/9+3uS0PvsTRpb7QtW476osiYqJ3EAXaan4P25gqxJrKvBpZtC7UgBxbeDlhlCtlrM3XJkEYZPcbYCbnHaVPDtrW84evGSeC1Gf6zmUA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726052383;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=kStjaEMg3PiBnNUf6GpKxxqL6ll8T7NBJDyR23ubwac=;
	b=cl6W/o8++XOzCMW5ZI0FUBup6OKhX6qBx5VAy8AtiXfzMzLoMz8pE7Vr8XSuoYLe
	4qpZH0Qy86rFxZWo0nGBftY6OCAOByulc4ffg3JlDBzMoWrTiTpCPvqesue5qxG3KK6
	72HBLeWIPwwucChGriQ9LyA9TtnMxjYRW6hvTToY=
Received: by mx.zohomail.com with SMTPS id 1726052381179761.9736664066929;
	Wed, 11 Sep 2024 03:59:41 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Chris Snook <chris.snook@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew@lunn.ch>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: ethernet: ag71xx: Remove dead code
Date: Wed, 11 Sep 2024 15:59:24 +0500
Message-Id: <20240911105924.4028423-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The err variable isn't being used anywhere other than getting
initialized to 0 and then it is being checked in if condition. The
condition can never be true. Remove the err and deadcode.

Fixes: d51b6ce441d3 ("net: ethernet: add ag71xx driver")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index db2a8ade62055..a90fc6834d53e 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1619,7 +1619,6 @@ static int ag71xx_rx_packets(struct ag71xx *ag, int limit)
 		unsigned int i = ring->curr & ring_mask;
 		struct ag71xx_desc *desc = ag71xx_ring_desc(ring, i);
 		int pktlen;
-		int err = 0;
 
 		if (ag71xx_desc_empty(desc))
 			break;
@@ -1649,14 +1648,9 @@ static int ag71xx_rx_packets(struct ag71xx *ag, int limit)
 		skb_reserve(skb, offset);
 		skb_put(skb, pktlen);
 
-		if (err) {
-			ndev->stats.rx_dropped++;
-			kfree_skb(skb);
-		} else {
-			skb->dev = ndev;
-			skb->ip_summed = CHECKSUM_NONE;
-			list_add_tail(&skb->list, &rx_list);
-		}
+		skb->dev = ndev;
+		skb->ip_summed = CHECKSUM_NONE;
+		list_add_tail(&skb->list, &rx_list);
 
 next:
 		ring->buf[i].rx.rx_buf = NULL;
-- 
2.39.2


