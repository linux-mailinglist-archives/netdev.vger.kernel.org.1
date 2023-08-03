Return-Path: <netdev+bounces-24073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4129F76EB0B
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 15:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71C8B1C208C8
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F06A1F92C;
	Thu,  3 Aug 2023 13:45:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0090E18B0D
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 13:45:36 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A595278
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 06:45:25 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RGqnv0s6Rz1KC9j;
	Thu,  3 Aug 2023 21:44:19 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 21:45:22 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <sgarzare@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <bobby.eshleman@bytedance.com>,
	<yuehaibing@huawei.com>
CC: <virtualization@lists.linux-foundation.org>, <netdev@vger.kernel.org>
Subject: [PATCH -next] af_vsock: Remove unused declaration vsock_release_pending()/vsock_init_tap()
Date: Thu, 3 Aug 2023 21:45:07 +0800
Message-ID: <20230803134507.22660-1-yuehaibing@huawei.com>
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
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit d021c344051a ("VSOCK: Introduce VM Sockets") declared but never implemented
vsock_release_pending(). Also vsock_init_tap() never implemented since introduction
in commit 531b374834c8 ("VSOCK: Add vsockmon tap functions").

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/net/af_vsock.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 0e7504a42925..b01cf9ac2437 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -201,7 +201,6 @@ static inline bool __vsock_in_connected_table(struct vsock_sock *vsk)
 	return !list_empty(&vsk->connected_table);
 }
 
-void vsock_release_pending(struct sock *pending);
 void vsock_add_pending(struct sock *listener, struct sock *pending);
 void vsock_remove_pending(struct sock *listener, struct sock *pending);
 void vsock_enqueue_accept(struct sock *listener, struct sock *connected);
@@ -225,7 +224,6 @@ struct vsock_tap {
 	struct list_head list;
 };
 
-int vsock_init_tap(void);
 int vsock_add_tap(struct vsock_tap *vt);
 int vsock_remove_tap(struct vsock_tap *vt);
 void vsock_deliver_tap(struct sk_buff *build_skb(void *opaque), void *opaque);
-- 
2.34.1


