Return-Path: <netdev+bounces-24653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFD0770F5A
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 12:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51B0F1C20AD3
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 10:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3435D847F;
	Sat,  5 Aug 2023 10:48:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E4B8F41
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 10:48:16 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E185A10CF
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 03:48:14 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RHzmV3JqXz1KCD7;
	Sat,  5 Aug 2023 18:47:06 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 5 Aug
 2023 18:48:12 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <borisp@nvidia.com>, <john.fastabend@gmail.com>, <kuba@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH net-next] net/tls: Remove unused function declarations
Date: Sat, 5 Aug 2023 18:48:11 +0800
Message-ID: <20230805104811.45356-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 3c4d7559159b ("tls: kernel TLS support") declared but never implemented
these functions.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/tls/tls.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index 37539ac3ac2a..164d6a955e26 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -87,10 +87,6 @@ void tls_ctx_free(struct sock *sk, struct tls_context *ctx);
 void update_sk_prot(struct sock *sk, struct tls_context *ctx);
 
 int wait_on_pending_writer(struct sock *sk, long *timeo);
-int tls_sk_query(struct sock *sk, int optname, char __user *optval,
-		 int __user *optlen);
-int tls_sk_attach(struct sock *sk, int optname, char __user *optval,
-		  unsigned int optlen);
 void tls_err_abort(struct sock *sk, int err);
 
 int tls_set_sw_offload(struct sock *sk, struct tls_context *ctx, int tx);
-- 
2.34.1


