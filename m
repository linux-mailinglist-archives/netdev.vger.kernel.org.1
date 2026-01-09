Return-Path: <netdev+bounces-248457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DACFD08A00
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 11:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 927AF302AB88
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 10:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C1E338F45;
	Fri,  9 Jan 2026 10:39:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B432C0F8C;
	Fri,  9 Jan 2026 10:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767955181; cv=none; b=K3uuccS54sigvGtdEQclq/rasCQPSsa6iwPHN9XDQDXSUGEAL0T1NlHwGnIpD6icS9cRqzWqQQ0fy1CjNAPcXFWFEOVFkNdW0PsOkk4PvaY0ZsnvyquE4DCU7lDlWXt1SRVTow/QSN/0F2rTik32juWeiiwusblpq0mBYkw8DUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767955181; c=relaxed/simple;
	bh=5FmDmQiqF35UR7MxgCzvyisBOZ2UU9X9Bu4ye1Eaejk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VKv6jYM6zD+/BnIK3A390LwhWhM51ffVnyCM4EwjqgxrYd5Z/gk7Zw2IhzNFJOcuhTH+esLBExBk/qFC8D67GLoyKJhxZ23++v2rNPdU72v9U/RlP8YrTEjLJWnqjFwdCtPiAYydf2fJ6d4B0sBryL+SJf3F0tRHjxaAHsoDfaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan3-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 09 Jan 2026 19:39:30 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by iyokan3-ex.css.socionext.com (Postfix) with ESMTP id 875012091484;
	Fri,  9 Jan 2026 19:39:30 +0900 (JST)
Received: from kinkan3.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Fri, 9 Jan 2026 19:39:30 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan3.css.socionext.com (Postfix) with ESMTP id D4AFF1757;
	Fri,  9 Jan 2026 19:39:29 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH RESEND net-next v1] net: ethernet: ave: Remove unnecessary 'out of memory' message
Date: Fri,  9 Jan 2026 19:39:15 +0900
Message-Id: <20260109103915.2764380-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow the warning from checkpatch.pl and remove 'out of memory' message.

    WARNING: Possible unnecessary 'out of memory' message
    #590: FILE: drivers/net/ethernet/socionext/sni_ave.c:590:
    +               if (!skb) {
    +                       netdev_err(ndev, "can't allocate skb for Rx\n");

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/net/ethernet/socionext/sni_ave.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
index 66b3549636f8..4700998c4837 100644
--- a/drivers/net/ethernet/socionext/sni_ave.c
+++ b/drivers/net/ethernet/socionext/sni_ave.c
@@ -586,10 +586,8 @@ static int ave_rxdesc_prepare(struct net_device *ndev, int entry)
 	skb = priv->rx.desc[entry].skbs;
 	if (!skb) {
 		skb = netdev_alloc_skb(ndev, AVE_MAX_ETHFRAME);
-		if (!skb) {
-			netdev_err(ndev, "can't allocate skb for Rx\n");
+		if (!skb)
 			return -ENOMEM;
-		}
 		skb->data += AVE_FRAME_HEADROOM;
 		skb->tail += AVE_FRAME_HEADROOM;
 	}
-- 
2.34.1


