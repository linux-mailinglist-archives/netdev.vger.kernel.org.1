Return-Path: <netdev+bounces-40610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 136DC7C7DBA
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 08:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E1C282B9D
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 06:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3B2110C;
	Fri, 13 Oct 2023 06:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="K7NPfzoo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDA6C8E2
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 06:33:56 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF5BB7
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 23:33:55 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c9daca2b85so13224755ad.1
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 23:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697178835; x=1697783635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wrh5eOkTQdzzRaA0+eIlvA+uCT3v/wg9JTwG/iC1Neo=;
        b=K7NPfzooF7r4is5QPvNz6ZF9N5qSbl4ZDyxdUxN69jQ/La+IZl/RcFIMLn7N7bhYkH
         O+06GoWJzVdkrh8m6gFdMlB18kSawVpHD0eM2WrvqnFLIatjzguJYibZrqDKMKj+bCdM
         ZHZkFHJWysufwdeiKDKrkIjJPUjBbDsFKrjMwPFKokZhVqmwRuk8DAN20NfZcbUth0Ti
         NdX+pw2TV/aSD9cFAd/0eDlQVrSLaSQgsuYMjSVVkHwQpaq6zQWggISJyy2bzsBDG/4s
         mmHHWMg5NNsyvHL/PEa++0a/Bf9jxsFU0QSQs5MsxB14JF715rENMSjhidRaQGI1YucR
         HHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697178835; x=1697783635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wrh5eOkTQdzzRaA0+eIlvA+uCT3v/wg9JTwG/iC1Neo=;
        b=gOurREStiaRFfLW3kDKWl7P4h945bwCGaJX0z7zJx9/CQvMsIsOFd/XduENXELBGs1
         Op6duM/9K1W1JaCLYfoGFr4firK2DFKU0pWrHu+gmG2xJdw5Syo+N4YKFTbo2bD32lFy
         wxjq2lCBg6Pl5qG0EshQqWO320aQASfQT2duLL3WSjCJmhMkA9E6mbOVoqGaZJ6F/yLQ
         E9VSyNHbJLGb7fTgLgRM6C3OWnQsXnWEMql4X+JRj1yRanM/PM6ourgcokDN4DHbXDx5
         3jYSGGxEoKUKei7uHnP1zOUzZ9/vUSNWXKDT8xks83EwVYFY9EKW+uuEDOvQAja6jO7O
         /UXw==
X-Gm-Message-State: AOJu0YzKlAQi+2o9qD3bh5ZWOOKiCejoaRKV1Um7Xtx+8Qm3OsCLV4hH
	v+Jmv0CJZ15AePaGo/Iuq2/+vA==
X-Google-Smtp-Source: AGHT+IFQWgsuLJj5jKAlRwd7Ga72SZZXlNEwJyo/+2vUnOBebDFN0UCZTxAfTVQgjd8YdsdtxNGy3g==
X-Received: by 2002:a17:903:22d0:b0:1c7:22ae:4080 with SMTP id y16-20020a17090322d000b001c722ae4080mr35178736plg.0.1697178834760;
        Thu, 12 Oct 2023 23:33:54 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([203.208.189.11])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902ec8600b001c44c8d857esm3042304plg.120.2023.10.12.23.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 23:33:54 -0700 (PDT)
From: Albert Huang <huangjie.albert@bytedance.com>
To: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>
Cc: Albert Huang <huangjie.albert@bytedance.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] xsk: Avoid starving xsk at the end of the list
Date: Fri, 13 Oct 2023 14:33:31 +0800
Message-Id: <20231013063332.38189-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In the previous implementation, when multiple xsk sockets were
associated with a single xsk_buff_pool, a situation could arise
where the xsk_tx_list maintained data at the front for one xsk
socket while starving the xsk sockets at the back of the list.
This could result in issues such as the inability to transmit packets,
increased latency, and jitter. To address this problem, we introduced
a new variable called tx_budget_cache, which limits each xsk to transmit
a maximum of MAX_XSK_TX_BUDGET tx descriptors. This allocation ensures
equitable opportunities for subsequent xsk sockets to send tx descriptors.
The value of MAX_XSK_TX_BUDGET is temporarily set to 16.

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 include/net/xdp_sock.h |  6 ++++++
 net/xdp/xsk.c          | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 69b472604b86..f617ff54e38c 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -44,6 +44,7 @@ struct xsk_map {
 	struct xdp_sock __rcu *xsk_map[];
 };
 
+#define MAX_XSK_TX_BUDGET 16
 struct xdp_sock {
 	/* struct sock must be the first member of struct xdp_sock */
 	struct sock sk;
@@ -63,6 +64,11 @@ struct xdp_sock {
 
 	struct xsk_queue *tx ____cacheline_aligned_in_smp;
 	struct list_head tx_list;
+	/* Record the actual number of times xsk has transmitted a tx
+	 * descriptor, with a maximum limit not exceeding MAX_XSK_TX_BUDGET
+	 */
+	u32 tx_budget_cache;
+
 	/* Protects generic receive. */
 	spinlock_t rx_lock;
 
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f5e96e0d6e01..bf964456e9b1 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -413,16 +413,25 @@ EXPORT_SYMBOL(xsk_tx_release);
 
 bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
 {
+	u32 xsk_full_count = 0;
 	struct xdp_sock *xs;
 
 	rcu_read_lock();
+again:
 	list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
+		if (xs->tx_budget_cache >= MAX_XSK_TX_BUDGET) {
+			xsk_full_count++;
+			continue;
+		}
+
 		if (!xskq_cons_peek_desc(xs->tx, desc, pool)) {
 			if (xskq_has_descs(xs->tx))
 				xskq_cons_release(xs->tx);
 			continue;
 		}
 
+		xs->tx_budget_cache++;
+
 		/* This is the backpressure mechanism for the Tx path.
 		 * Reserve space in the completion queue and only proceed
 		 * if there is space in it. This avoids having to implement
@@ -436,6 +445,13 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
 		return true;
 	}
 
+	if (unlikely(xsk_full_count > 0)) {
+		list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
+			xs->tx_budget_cache = 0;
+		}
+		goto again;
+	}
+
 out:
 	rcu_read_unlock();
 	return false;
@@ -1230,6 +1246,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 	xs->zc = xs->umem->zc;
 	xs->sg = !!(xs->umem->flags & XDP_UMEM_SG_FLAG);
 	xs->queue_id = qid;
+	xs->tx_budget_cache = 0;
 	xp_add_xsk(xs->pool, xs);
 
 out_unlock:
-- 
2.20.1


