Return-Path: <netdev+bounces-25922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3936A7762BC
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 16:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2E01C2129A
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 14:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE2518C1B;
	Wed,  9 Aug 2023 14:41:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3145C18AF6
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 14:41:54 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AC61FCC;
	Wed,  9 Aug 2023 07:41:52 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RLXm51Kl3zcbYx;
	Wed,  9 Aug 2023 22:40:37 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 22:41:49 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <santosh.shilimkar@oracle.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<rds-devel@oss.oracle.com>
Subject: [PATCH net-next] rds: tcp: Remove unused declaration rds_tcp_map_seq()
Date: Wed, 9 Aug 2023 22:41:48 +0800
Message-ID: <20230809144148.13052-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

rds_tcp_map_seq() is never implemented and used since
commit 70041088e3b9 ("RDS: Add TCP transport to RDS").

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/rds/tcp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/rds/tcp.h b/net/rds/tcp.h
index f8b5930d7b34..053aa7da87ef 100644
--- a/net/rds/tcp.h
+++ b/net/rds/tcp.h
@@ -56,7 +56,6 @@ void rds_tcp_restore_callbacks(struct socket *sock,
 			       struct rds_tcp_connection *tc);
 u32 rds_tcp_write_seq(struct rds_tcp_connection *tc);
 u32 rds_tcp_snd_una(struct rds_tcp_connection *tc);
-u64 rds_tcp_map_seq(struct rds_tcp_connection *tc, u32 seq);
 extern struct rds_transport rds_tcp_transport;
 void rds_tcp_accept_work(struct sock *sk);
 int rds_tcp_laddr_check(struct net *net, const struct in6_addr *addr,
-- 
2.34.1


