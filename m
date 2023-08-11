Return-Path: <netdev+bounces-26647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C217787BA
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 08:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FCB92820EA
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 06:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF21D5661;
	Fri, 11 Aug 2023 06:55:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE1353BA
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 06:55:28 +0000 (UTC)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9619E7E
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 23:55:27 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VpWGJHw_1691736923;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VpWGJHw_1691736923)
          by smtp.aliyun-inc.com;
          Fri, 11 Aug 2023 14:55:24 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next 8/8] virtio-net: a tiny comment update
Date: Fri, 11 Aug 2023 14:55:12 +0800
Message-Id: <20230811065512.22190-9-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230811065512.22190-1-hengqi@linux.alibaba.com>
References: <20230811065512.22190-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Update a comment because virtio-net now supports both
VIRTIO_NET_F_NOTF_COAL and VIRTIO_NET_F_VQ_NOTF_COAL.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index df7705ca05f0..6d07e496924f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3471,7 +3471,7 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
 {
 	/* usecs coalescing is supported only if VIRTIO_NET_F_NOTF_COAL
-	 * feature is negotiated.
+	 * or VIRTIO_NET_F_VQ_NOTF_COAL feature is negotiated.
 	 */
 	if (ec->rx_coalesce_usecs || ec->tx_coalesce_usecs)
 		return -EOPNOTSUPP;
-- 
2.19.1.6.gb485710b


