Return-Path: <netdev+bounces-247975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5353D014A0
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 07:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11C77302D397
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 06:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EDF27F171;
	Thu,  8 Jan 2026 06:47:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F7A26FD9A;
	Thu,  8 Jan 2026 06:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767854834; cv=none; b=sWy0UeIb4CbhUtMXkvzRlfsW5MPecawVy+ZGQmb5gPHDymW7JqKL9cM4PndQtOFzkUsPsXjP0DRpq5NbXUAkIfPs5f50MzKTrvDWUiR1UyWxNfkxoW4BWKHn7AyuTVnIrzI6JAzhSeVu4jTSsKPqRKLBiYysutie7TfOyJUSGRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767854834; c=relaxed/simple;
	bh=5FmDmQiqF35UR7MxgCzvyisBOZ2UU9X9Bu4ye1Eaejk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TEqLVNaiSTTtzfeV3vbVo/CZ2c+Efu2ZWZ0cA+UVGMSF0F1fntmRVcOvzo0NnCm2AAyqFatF4rn2ZOsJYiuNKjteVnvcwramRDWlavI5rcX0VqeR2rNGVRNfS6FKWCN8rYvEcawE3OQbyPZIzzonxVRRYJftAU7G7b6ljEEi+ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan3-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 08 Jan 2026 15:47:00 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by kinkan3-ex.css.socionext.com (Postfix) with ESMTP id 068AD20695EB;
	Thu,  8 Jan 2026 15:47:00 +0900 (JST)
Received: from kinkan3.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Thu, 8 Jan 2026 15:46:59 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan3.css.socionext.com (Postfix) with ESMTP id 979181757;
	Thu,  8 Jan 2026 15:46:59 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH net 1/2] net: ethernet: ave: Remove unnecessary 'out of memory' message
Date: Thu,  8 Jan 2026 15:46:40 +0900
Message-Id: <20260108064641.2593749-1-hayashi.kunihiko@socionext.com>
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


