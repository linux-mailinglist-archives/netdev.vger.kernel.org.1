Return-Path: <netdev+bounces-90807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF2C8B040B
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 10:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CA6B2822E1
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 08:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F7D158875;
	Wed, 24 Apr 2024 08:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="b5C05YDu"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E037158871
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 08:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713946614; cv=none; b=HsyWJZ1/3z8htHVNkwTyMNGwZHuEIHmQ+Qwj62l6sYeflBvt6lDRzQsIr11RN+pnguFJnLY0gzl1l8pq39TREHowC9vxVYJTwilND+3MKMcZ38eUeDdYBWoMFodAISHFxlBHRRKXhNiy9dH01//l02LPMVbXrGi8jXdesU0Su4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713946614; c=relaxed/simple;
	bh=z8jerKRDUxs2eTUDwkeWnIYa4pVTDPiVI6jep0yvqhs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lZC5diIuzhM+d3q67ePP5LzsMmw7ippdpCRpXtVv0C6yrUytNl+B83/w7wPDwIGS2sncGnflNztj8hHjzeKosgqZMyysD05ki+/0pNB+H+yc3UcDulTxqXGAa/IqRmkBJJTe3wgCM2QN16yXlVvkkvA9nwNWK0TDjFEoKmDCSmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=b5C05YDu; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713946604; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=tWRTicwf67dXxyQhQVOHVww5BQsSp7CJZbGq1DNkb48=;
	b=b5C05YDu/V3N1qK8Chz0Re6foNqlDaTy8XIS58ZGnfV7OF2Y2FQQcMVnsxcCI8/XirJVYHRmLg2xQcucr035wVUWEhyPlZ47a10/fG2m3ZsfDJOaw0r0Lvf4XpsdrV3Hd1ehMJrTzKZ6OFRHqXfG2HmHWeSgOyvCXzvkxPwoA80=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W5BhZ5S_1713946602;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W5BhZ5S_1713946602)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 16:16:43 +0800
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
Subject: [PATCH vhost v3 4/4] virtio_net: remove the misleading comment
Date: Wed, 24 Apr 2024 16:16:36 +0800
Message-Id: <20240424081636.124029-5-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240424081636.124029-1-xuanzhuo@linux.alibaba.com>
References: <20240424081636.124029-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 55c7001bc45b
Content-Transfer-Encoding: 8bit

We call the build_skb() actually without copying data.
The comment is misleading. So remove it.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a4b924ba18d3..3e8694837a29 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -600,7 +600,6 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 
 	shinfo_size = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
-	/* copy small packet so we can reuse these pages */
 	if (!NET_IP_ALIGN && len > GOOD_COPY_LEN && tailroom >= shinfo_size) {
 		skb = virtnet_build_skb(buf, truesize, p - buf, len);
 		if (unlikely(!skb))
-- 
2.32.0.3.g01195cf9f


