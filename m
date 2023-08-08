Return-Path: <netdev+bounces-25255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9267737A0
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 05:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A90141C20E1B
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 03:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788CD6109;
	Tue,  8 Aug 2023 03:20:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B93E1FB0
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 03:20:52 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FC6138
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 20:20:50 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bc3d94d40fso45537985ad.3
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 20:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691464850; x=1692069650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhqzuKs8acODjWqieOr60TzQPrln+0aaO9utMxKEwXY=;
        b=OJL9LrbSgQt70QJMij8iZC+JU41pG03VeJ0y7Nl922F2ZaU7U87A5B753UGGc0Yzx1
         /bOWzzKWiz5MHCq3MgepwcOP88c3QaVKgVkTsFPHfIKsB1CIEy7ISR3PzFTQvfTVch3s
         WnjevnnH9SsiyAEF6GrygCCohR3vtxY6qtYmJVOnIJAzQC5P3SlBXIP0HPbiUcyU/Tpg
         WzO3Noh9RFrUXrGlfzBi0PbKEYMSibgslfmMf83UoYgMOmjvVh7T/nHKLh9NspmzZ0bp
         ZmzvtRNd6WNniQsh/hzTpgIkY/Il5uuKqN/T/P4pQ1UI1p7bI63YzkuOWTSh/Dn//l3M
         qjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691464850; x=1692069650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhqzuKs8acODjWqieOr60TzQPrln+0aaO9utMxKEwXY=;
        b=Ggdp98W3cVHfHF6ETYh+sg40BltgrUXCZi58DMFSEs6XZLv69CAsoMkjZBmHbVlbQ8
         r9InD+ICPohRo3BUQoyBq+agF/MDZ1qBfs9M0YG2KxORoH7uRLE/paPF4cNgWkGSGams
         OrWDq7bXW3hRzM2NrAbfFoMcgg0Ga1qd6CQ+rAzanKDZWewSFDXw0vIcjhvq7RKQjn+Q
         DQBW0IcAl3bslRLum3LQPxntU8p51EoLAPd+UxVfnKy4dWKd9a4nJkUHDIe8up6r6cwY
         1KyrfkPJe8/kfkLAv/SKcSG+0T7tDZEM8wxLJJBNp24TpGgB+HZotFCETUHQPCORy21u
         Ce+w==
X-Gm-Message-State: AOJu0YzML44y0fcheZoBx4lpQvVOgkKJvtE6rSqh/aiqSVaxCf6UdvQT
	thc0Co/UJswi3yexQEfN1R7G7Q==
X-Google-Smtp-Source: AGHT+IFJntj41Gt0ECRGUl7vLwT94BPvXtio+ZQROoGCzVRtLpUoICA2rzvmhhrD1xkeCfFkMSjNtw==
X-Received: by 2002:a17:902:eccc:b0:1b8:1335:b775 with SMTP id a12-20020a170902eccc00b001b81335b775mr13965313plh.0.1691464850307;
        Mon, 07 Aug 2023 20:20:50 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2408:8656:30f8:e020::b])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c10d00b001b896686c78sm7675800pli.66.2023.08.07.20.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 20:20:49 -0700 (PDT)
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
Subject: [RFC v3 Optimizing veth xsk performance 4/9] xsk: add xsk_tx_completed_addr function
Date: Tue,  8 Aug 2023 11:19:08 +0800
Message-Id: <20230808031913.46965-5-huangjie.albert@bytedance.com>
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Return desc to the cq by using the descriptor address.

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 include/net/xdp_sock_drv.h |  5 +++++
 net/xdp/xsk.c              |  6 ++++++
 net/xdp/xsk_queue.h        | 10 ++++++++++
 3 files changed, 21 insertions(+)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 1f6fc8c7a84c..de82c596e48f 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -15,6 +15,7 @@
 #ifdef CONFIG_XDP_SOCKETS
 
 void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries);
+void xsk_tx_completed_addr(struct xsk_buff_pool *pool, u64 addr);
 bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc);
 u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 max);
 void xsk_tx_release(struct xsk_buff_pool *pool);
@@ -188,6 +189,10 @@ static inline void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries)
 {
 }
 
+static inline void xsk_tx_completed_addr(struct xsk_buff_pool *pool, u64 addr)
+{
+}
+
 static inline bool xsk_tx_peek_desc(struct xsk_buff_pool *pool,
 				    struct xdp_desc *desc)
 {
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 4f1e0599146e..b2b8aa7b0bcf 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -396,6 +396,12 @@ void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries)
 }
 EXPORT_SYMBOL(xsk_tx_completed);
 
+void xsk_tx_completed_addr(struct xsk_buff_pool *pool, u64 addr)
+{
+	xskq_prod_submit_addr(pool->cq, addr);
+}
+EXPORT_SYMBOL(xsk_tx_completed_addr);
+
 void xsk_tx_release(struct xsk_buff_pool *pool)
 {
 	struct xdp_sock *xs;
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 13354a1e4280..3a5e26a81dc2 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -428,6 +428,16 @@ static inline void __xskq_prod_submit(struct xsk_queue *q, u32 idx)
 	smp_store_release(&q->ring->producer, idx); /* B, matches C */
 }
 
+static inline void xskq_prod_submit_addr(struct xsk_queue *q, u64 addr)
+{
+	struct xdp_umem_ring *ring = (struct xdp_umem_ring *)q->ring;
+	u32 idx = q->ring->producer;
+
+	ring->desc[idx++ & q->ring_mask] = addr;
+
+	__xskq_prod_submit(q, idx);
+}
+
 static inline void xskq_prod_submit(struct xsk_queue *q)
 {
 	__xskq_prod_submit(q, q->cached_prod);
-- 
2.20.1


