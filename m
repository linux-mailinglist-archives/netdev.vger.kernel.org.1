Return-Path: <netdev+bounces-22540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B03F2767F14
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 14:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA62281986
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 12:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B9A156FA;
	Sat, 29 Jul 2023 12:21:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC183C20
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 12:21:10 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2773A9C;
	Sat, 29 Jul 2023 05:21:09 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RCk952wBdzrRft;
	Sat, 29 Jul 2023 20:20:09 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 29 Jul
 2023 20:21:06 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <bryantan@vmware.com>, <vdasa@vmware.com>, <pv-drivers@vmware.com>,
	<sgarzare@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <yuehaibing@huawei.com>
CC: <linux-kernel@vger.kernel.org>,
	<virtualization@lists.linux-foundation.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next] vsock: Remove unused function declarations
Date: Sat, 29 Jul 2023 20:20:36 +0800
Message-ID: <20230729122036.32988-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

These are never implemented since introduction in
commit d021c344051a ("VSOCK: Introduce VM Sockets")

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/vmw_vsock/vmci_transport.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/vmw_vsock/vmci_transport.h b/net/vmw_vsock/vmci_transport.h
index b7b072194282..dbda3ababa14 100644
--- a/net/vmw_vsock/vmci_transport.h
+++ b/net/vmw_vsock/vmci_transport.h
@@ -116,9 +116,6 @@ struct vmci_transport {
 	spinlock_t lock; /* protects sk. */
 };
 
-int vmci_transport_register(void);
-void vmci_transport_unregister(void);
-
 int vmci_transport_send_wrote_bh(struct sockaddr_vm *dst,
 				 struct sockaddr_vm *src);
 int vmci_transport_send_read_bh(struct sockaddr_vm *dst,
-- 
2.34.1


