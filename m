Return-Path: <netdev+bounces-25254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6584477379D
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 05:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20FAB28160B
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 03:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02CB4433;
	Tue,  8 Aug 2023 03:20:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7776F1C29
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 03:20:45 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE7110D8
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 20:20:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bc1c1c68e2so32905935ad.3
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 20:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691464843; x=1692069643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9C7bHaMSd+SY+pPB7Vtx4/6UZIJ72tWmfxoauVOSVx0=;
        b=VHfxDg5QSz1PqjRWt9B9x6mNaS6RhCwH3kbVmHYf16gDy0fMcTjbQfLdJ1bUO9PgyF
         e858P0e+77eKT6XZAaPITT05KvwS75X5CChow28CxQevaNfwHO/a/b/Tjth6QhYmamUl
         D2koPxHSfUnNqjewXP7wEAFJPTs3dyQoX1v5vV3qDUxrlvdVl0KOQKfXzW86ewoVN7mA
         /80D4Vn2cmagGQlwfUnU6NadEKweg09+IK+04wQqqwm6DaEtzrp97grfGS8he+jLvx/k
         eWU21VDBsw4THoGugTPD0TDkYAr8PyGh2PllRIUx5Bm4PqGbt8R1AGICgsH1UV/Qg33Y
         IKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691464843; x=1692069643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9C7bHaMSd+SY+pPB7Vtx4/6UZIJ72tWmfxoauVOSVx0=;
        b=V5bEo7F92nHlUVCQ9QwvKo9E7TNKK1JrRnwMnLkbk0CZEEOXe2IcjafPwo6ytPgvot
         ruHlY82m0dv5Uv6tJlCi0Gga5rrBJe7sKnGg6ooZuHLPsB0oQDov68GO5089GGIfm2X0
         bfztBFOBuWDuCHXnFtDU8P2gTZ3cMMZG/St+UNaNgykQSIVHvayRMxXOsLK/n3YKtPqG
         H3SmxnLyt9O0mamsLKcNCxmzsJZ9zusUJq8yO1e88K7KDjHf39i3JSN4n3q+iRAjtMz4
         X/WuNShftuTaD+jNq1cP1GA4U9dakY8QiNuyfmRl82XF8AAgXSDOGvZ72CI2sTHH8W4r
         IRKQ==
X-Gm-Message-State: AOJu0YzFTLP8lXD5x5NF+fwNl7RmfHeYCE1dhoJLi58XKNX7dXMnhOl0
	3kdKegZAlMF/NGaSThQQI6AN3w==
X-Google-Smtp-Source: AGHT+IFT7mDq0JlyeShuwm6n4b9kapZWwkdRXEbqIpMukZkRiMaS8kGKuxgNgq0KI7HbhgNQsXCRbQ==
X-Received: by 2002:a17:902:c404:b0:1bb:a367:a77 with SMTP id k4-20020a170902c40400b001bba3670a77mr11633095plk.31.1691464843297;
        Mon, 07 Aug 2023 20:20:43 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2408:8656:30f8:e020::b])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c10d00b001b896686c78sm7675800pli.66.2023.08.07.20.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 20:20:42 -0700 (PDT)
From: Albert Huang <huangjie.albert@bytedance.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Albert Huang <huangjie.albert@bytedance.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Kees Cook <keescook@chromium.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: [RFC v3 Optimizing veth xsk performance 3/9] veth: add support for send queue
Date: Tue,  8 Aug 2023 11:19:07 +0800
Message-Id: <20230808031913.46965-4-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230808031913.46965-1-huangjie.albert@bytedance.com>
References: <20230808031913.46965-1-huangjie.albert@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

in order to support native af_xdp for veth. we
need support for send queue for napi tx.
the upcoming patch will make use of it.

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 drivers/net/veth.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 77e12d52ca2b..25faba879505 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -56,6 +56,11 @@ struct veth_rq_stats {
 	struct u64_stats_sync	syncp;
 };
 
+struct veth_sq_stats {
+	struct veth_stats	vs;
+	struct u64_stats_sync	syncp;
+};
+
 struct veth_rq {
 	struct napi_struct	xdp_napi;
 	struct napi_struct __rcu *napi; /* points to xdp_napi when the latter is initialized */
@@ -69,11 +74,25 @@ struct veth_rq {
 	struct page_pool	*page_pool;
 };
 
+struct veth_sq {
+	struct napi_struct	xdp_napi;
+	struct net_device	*dev;
+	struct xdp_mem_info	xdp_mem;
+	struct veth_sq_stats	stats;
+	u32 queue_index;
+	/* for xsk */
+	struct {
+		struct xsk_buff_pool __rcu *pool;
+		u32 last_cpu;
+	} xsk;
+};
+
 struct veth_priv {
 	struct net_device __rcu	*peer;
 	atomic64_t		dropped;
 	struct bpf_prog		*_xdp_prog;
 	struct veth_rq		*rq;
+	struct veth_sq		*sq;
 	unsigned int		requested_headroom;
 };
 
@@ -1495,6 +1514,15 @@ static int veth_alloc_queues(struct net_device *dev)
 		u64_stats_init(&priv->rq[i].stats.syncp);
 	}
 
+	priv->sq = kcalloc(dev->num_tx_queues, sizeof(*priv->sq), GFP_KERNEL);
+	if (!priv->sq)
+		return -ENOMEM;
+
+	for (i = 0; i < dev->num_tx_queues; i++) {
+		priv->sq[i].dev = dev;
+		u64_stats_init(&priv->sq[i].stats.syncp);
+	}
+
 	return 0;
 }
 
@@ -1503,6 +1531,7 @@ static void veth_free_queues(struct net_device *dev)
 	struct veth_priv *priv = netdev_priv(dev);
 
 	kfree(priv->rq);
+	kfree(priv->sq);
 }
 
 static int veth_dev_init(struct net_device *dev)
-- 
2.20.1


