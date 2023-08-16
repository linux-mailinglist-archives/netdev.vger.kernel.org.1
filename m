Return-Path: <netdev+bounces-28062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2EF77E1B5
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F66F1C2108D
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 12:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983B0101C2;
	Wed, 16 Aug 2023 12:33:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BF6DF60
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 12:33:26 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA97E48
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 05:33:25 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6889078ee66so389659b3a.0
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 05:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692189204; x=1692794004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICiyZ/NSrSUKKCenFgbZnJVRy5+4/vqbSCb3+nFRl0I=;
        b=OJF56gCnLCHp48l0JWju7yLJcB1Z7MtQb5wKSqR7Erm6q3vbdhl1F1sZf6hUuC6Q/0
         McbaHxPLxhyBvv8aQYPyO02pOLvfPjwhM+jrF3bMRJlYPg4T3JZGibtf48ggvCEaSaYN
         MUio48bVU3Q1AWo/x/RYZidNFLPIFXO7k7QO7tFJ/pdsYVa9+Zkd5jWw0OGz7henAyJ1
         NBI3vbq0kNFxJ0sSWrjrjGWkj2Fjj/kzQ74CUCZ0N7rWx9efyEJQ3LR3F41TeL2PBFzo
         /j5q7Xfgy3ZTfm2AB3CJgihabKI2rxKsxC/Kfjr4DtUakkQJkaExpAFYP8dl8jmoU0je
         aRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692189204; x=1692794004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICiyZ/NSrSUKKCenFgbZnJVRy5+4/vqbSCb3+nFRl0I=;
        b=aGbvbAhCXbChy4fQVDhur+b2y1jmFmDEZNaAbLlsoF+v2MwJzJN9ssuzKweNIhMFZF
         CfSn42LhqHOKfs8YgRxKkZ8dmuFOhoXxWRTvmhlhvqXJMWf4bdpWZxFsrOlpFS+nZMiv
         C/5XgMwS3vCJlsHUVhjfsRVEwbH4SWYlb0yINbX4dDzIalm3vvZHDgRvSj9B6fOn0LIJ
         +b7qJ4UhOEvLaighbVzpgGMhqe8rj9vERfGDxbc1YoRlzN39Qz2EnIR8DoEsrV1tFMJy
         7JTx9rTcsz7qW9bCMfOlRPqUGJP6cTPkPXfZaVW1OR6QUWLSJQm19JLX+hHfHj9ULr3X
         NkMA==
X-Gm-Message-State: AOJu0YyTiiTeHABwoWorlglFl0Il+GVFAhJ2YP+LQRvuR01v4+uoIq1f
	3wScuGMs2zj55PwLDFa0vlo=
X-Google-Smtp-Source: AGHT+IEdVubLkUG4sgEmA6oQaZBF7wNq1m8IdG+HaWVZpXBvxIxyyKddBZ46MkMB1y5r3Iyi7dl4yg==
X-Received: by 2002:a17:902:d4c3:b0:1bb:c7e1:b43 with SMTP id o3-20020a170902d4c300b001bbc7e10b43mr1985227plg.14.1692189204572;
        Wed, 16 Aug 2023 05:33:24 -0700 (PDT)
Received: from localhost.localdomain ([50.7.159.34])
        by smtp.googlemail.com with ESMTPSA id x2-20020a170902ec8200b001bba669a7eesm13096539plg.52.2023.08.16.05.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 05:33:23 -0700 (PDT)
From: Liang Chen <liangchen.linux@gmail.com>
To: hawk@kernel.org,
	horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linyunsheng@huawei.com
Cc: ilias.apalodimas@linaro.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	netdev@vger.kernel.org,
	liangchen.linux@gmail.com
Subject: [RFC PATCH net-next v3 2/2] net: veth: Optimizing skb reuse in NAPI Context
Date: Wed, 16 Aug 2023 20:30:29 +0800
Message-Id: <20230816123029.20339-3-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816123029.20339-1-liangchen.linux@gmail.com>
References: <20230816123029.20339-1-liangchen.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In cases where the skb is reallocated by veth_convert_skb_to_xdp_buff,
we leverage the NAPI version of the "head stolen" function to enable
fast skb reuse. The following test results evaluate the performance
improvement resulting from reusing skb in the NAPI context with
pktgen-generated traffic.

Test environment setup:
ns1                 ns2
veth0   <-peer->    veth1
veth2   <-peer->    veth3

Test Results:
pktgen -> veth1 -> veth0(XDP_TX) -> veth1(XDP_DROP)
    without reusing skb: 2,033,439
    reusing skb: 2,167,749
    improvement: ~6%

pktgen -> veth1 -> veth0(XDP_TX) -> veth1(XDP_PASS)
    without reusing skb: 1,585,462
    reusing skb: 1,650,572
    improvement: ~4%

pktgen -> veth1 -> veth0(XDP_REDIRECT) -> veth2 -> veth3(XDP_DROP)
    without reusing skb: 1,787,342
    reusing skb: 1,848,516
    improvement: ~3%

pktgen -> veth1 -> veth0(XDP_REDIRECT) -> veth2 -> veth3(XDP_PASS)
    without reusing skb: 1,391,587
    reusing skb: 1,439,866
    improvement: ~3%

pktgen -> veth1 -> veth0(AF_XDP) -> user space(DROP)
    without reusing skb: 1,811,844
    with reusing skb: 1,861,027
    improvement: ~3%

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
---
 drivers/net/veth.c | 5 ++++-
 net/core/skbuff.c  | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 7234eb0297dd..4e1ee110ab84 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -838,9 +838,12 @@ static void __skb2xdp_steal_data(struct sk_buff *skb,
 	if (local_pp_alloc) {
 		/* This is the most common case where the skb was reallocated locally in
 		 * veth_convert_skb_to_xdp_buff, and it's safe to use the xdp_mem_pp model.
+		 * Since the skb is "reallocated" in the NAPI context of veth, it is possible
+		 * to use the NAPI version of the "head stolen" function to optimize the
+		 * reuse of skb as well.
 		 */
 		xdp->rxq->mem = rq->xdp_mem_pp;
-		kfree_skb_partial(skb, true);
+		napi_skb_free_stolen_head(skb);
 	} else if (!skb->pp_recycle) {
 		/* We can safely use kfree_skb_partial here because this cannot be an fclone
 		 * skb. Fclone skbs are allocated via __alloc_skb, with their head buffer
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a298992060e6..954ba1b94840 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1284,6 +1284,7 @@ void napi_skb_free_stolen_head(struct sk_buff *skb)
 	}
 	napi_skb_cache_put(skb);
 }
+EXPORT_SYMBOL(napi_skb_free_stolen_head);
 
 void napi_consume_skb(struct sk_buff *skb, int budget)
 {
-- 
2.40.1


