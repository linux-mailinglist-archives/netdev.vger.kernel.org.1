Return-Path: <netdev+bounces-127414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C54A9754E0
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBDB281E41
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 14:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484E8186E50;
	Wed, 11 Sep 2024 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="RSLBc0p7"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA2B41A80;
	Wed, 11 Sep 2024 13:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726063156; cv=pass; b=KpKiaPbDOPD860HZ38C742o+0soRzqOW0ApWF0iaB9jr/Zl5p+Ywf8p+y3tbrIDClknof0+wmWKLmRvfNsLdiMfoEWaIgx4c7JiYD086lpgR7bDayNYHgHf8+K4Ty2I7SekMj1EAA2x1sW7dVF/z+fVjr4lh6qwWQSuu7qSWbPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726063156; c=relaxed/simple;
	bh=tR0+qbQNlJJ2Qfag0JQ0CCv1cZ0/5uu0/3zrgWNBOUA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jeuxbkRN6R5nHCGqE3zLQ/bdilRHkwEgngW7SxrHnLKk7aRVmuI56S9E0w8vmAcXnv6IRi43gOtkJpSckGwpMqw2mZGrPFAJV0/ZfWsVJDJqe2d+ASxx7pbXexrcMxXH7cuU/6Ks4W4B+VSyeP5QL/0YIIerTO5QYDqJn/DvEro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=RSLBc0p7; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726063132; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Cz06d1eKf6RLRfSaw3RousMQrwvR8oVDvn9IvUoH4MRTm78a4nMnn5HwOd9LAJ5yMxaTbkv9KGrvjQBSSwRrmQw4DilkFFPoTNSMeUGUd77P+1w4o/rc3qUjN21IrK4RWrf+A24PypvUUlHLwWYj8Nk9vcUOsF4X7Gwb9A728oo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726063132; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FDi1oNGOwGoL1t3b9YdynYQnQAMFZgRgi9/q+B0Y13M=; 
	b=bktxxtZNauRkKIDKgI/4xidULTKX2xrHay+4824keC/nQN26vE/gsuAtunZhoc7HsTTxXTm8AjTn5SIIGgQ+rbNdVWEfsySLloOq7gPzd80syXFyV4JwJKMN41a3qSvYeAhrRg8b50+L5dTp97WIFISe/k7qdMOINdUpTDcQJ3M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726063132;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=FDi1oNGOwGoL1t3b9YdynYQnQAMFZgRgi9/q+B0Y13M=;
	b=RSLBc0p7tR09HKevOZjGkC8s5tpepxvaLIctPMnN4oEXWgxuZzvrtBCkIB/s7Q7W
	yWIS6X7TXhC1wjM/RDuvr1MaNAxDntIY8s/9wheDdlB7neCAA1sAILpVnsQX8n9VGwS
	P/X61m+hgA7IY+FQZNYr0wBKC0gPnryRIDbmh5mE=
Received: by mx.zohomail.com with SMTPS id 17260631313681018.8933079989365;
	Wed, 11 Sep 2024 06:58:51 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Chris Snook <chris.snook@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: ethernet: ag71xx: Remove dead code
Date: Wed, 11 Sep 2024 18:58:27 +0500
Message-Id: <20240911135828.378317-1-usama.anjum@collabora.com>
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

Move the rx_dropped counter above when skb isn't found.

Fixes: d51b6ce441d3 ("net: ethernet: add ag71xx driver")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v1:
- Move the rx_dropped counter above when skb isn't found.
---
 drivers/net/ethernet/atheros/ag71xx.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index db2a8ade62055..2effceeb191db 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1619,7 +1619,6 @@ static int ag71xx_rx_packets(struct ag71xx *ag, int limit)
 		unsigned int i = ring->curr & ring_mask;
 		struct ag71xx_desc *desc = ag71xx_ring_desc(ring, i);
 		int pktlen;
-		int err = 0;
 
 		if (ag71xx_desc_empty(desc))
 			break;
@@ -1643,20 +1642,16 @@ static int ag71xx_rx_packets(struct ag71xx *ag, int limit)
 		skb = napi_build_skb(ring->buf[i].rx.rx_buf, ag71xx_buffer_size(ag));
 		if (!skb) {
 			skb_free_frag(ring->buf[i].rx.rx_buf);
+			ndev->stats.rx_dropped++;
 			goto next;
 		}
 
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


