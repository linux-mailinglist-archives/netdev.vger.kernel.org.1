Return-Path: <netdev+bounces-89967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9A08AC580
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 09:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0F461C21DC7
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 07:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2135551C44;
	Mon, 22 Apr 2024 07:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aA6DlAXj"
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F5E5102B
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 07:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770663; cv=none; b=iazvMHwpewhIwpvM4Mu7Uv7RBFmLTkzrFut79DCmD6vjLBCR+1okVhep2nt7MyV84xIVQFWSFxfBcaHh9IH1cNJNOXYzwt0aq/xHbx+iT5rmwynApcegkzHm3vp79UvN7nAj+VPPsIZLlOaDd6O58oswUtlK8GuJ2FypPQN0oNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770663; c=relaxed/simple;
	bh=3oWT7AoYVZrze8Cj18fmZ5ho3Y/CFeJtjphsP3pahJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kjQYiueKW31kGR+rv0xqmIdoLjkMYNaF9MGTr1yAMGqEQzyS9V5MBUeibKSqtju/shJwUNWSz0P5IHghD7ftm9Uh4SPZyCS/LW4f7Od45A6tbc77HfB/mKXcueRss2l3kpjbKjsSUncqS627I+zIDcCwOOK+DGK5ax+da27aAj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aA6DlAXj; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713770659; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=QH7S8pMVCFt/6I21U1mohQsJuE0lv4rRBEhEbNpDji0=;
	b=aA6DlAXjdwASpkCE4tlmKVVMFr/ddouki8ttTexufnFohPFFjL5SA7PzdHT6oSz5zVKUR8EJ38yiTVQAYohvB0gGCMgSgHo6/AEUkM44W9kgNhdzQkBmaErtWz5rWldMhvT5EvFOJtZ2C10D8RqqOQFF7Q72ipGsBsdFd+h7Udo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W5.kZp3_1713770657;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W5.kZp3_1713770657)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 15:24:18 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH vhost v2 7/7] virtio_net: remove the misleading comment
Date: Mon, 22 Apr 2024 15:24:08 +0800
Message-Id: <20240422072408.126821-8-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240422072408.126821-1-xuanzhuo@linux.alibaba.com>
References: <20240422072408.126821-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: aa968d36d784
Content-Transfer-Encoding: 8bit

We call the build_skb() actually without copying data.
The comment is misleading. So remove it.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 848e93ccf2ef..ae15254a673b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -690,7 +690,6 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 
 	shinfo_size = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
-	/* copy small packet so we can reuse these pages */
 	if (!NET_IP_ALIGN && len > GOOD_COPY_LEN && tailroom >= shinfo_size) {
 		skb = virtnet_build_skb(buf, truesize, p - buf, len);
 		if (unlikely(!skb))
-- 
2.32.0.3.g01195cf9f


