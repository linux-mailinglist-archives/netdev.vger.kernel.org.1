Return-Path: <netdev+bounces-114497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F83942BB4
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7960284854
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 10:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D641AC429;
	Wed, 31 Jul 2024 10:10:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF1D1AD9D4;
	Wed, 31 Jul 2024 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722420651; cv=none; b=mfrIca2z6d6pnfMzqJMWNYJIiO9xmLiTXNMCKLkG65bfek3FgFuTYRPSf/rpcsCyTs2ESJyNhv4zH2plUbh7AKPmd8KdX6SFY7nfz8oUDl9nqK6qfe1i3v+CtzKizlI54Ngeq+YhvYqhwqGUXSP+KbMylgEHCLjxIGTFoWzZd0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722420651; c=relaxed/simple;
	bh=1Ir4FkNGRHXOjCOfqaPa95tjPRQxv6Bfmh8P6afNwgE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aMXEcJoRKDLWQHNdnIEKPEfwKcuwAHTLvKPjO4VpDvnOo2wQfrVM8yq2hCoctQZycw8W3KHK5Bh0jjl19S1jAd6eJnatD9mVwCSz4RlIJHWlU0nJL5cnhcqzPX8AcTo8pk+Ug68dJ0LmNC5wMmrbvKJ1tMbw8AkhIAZjfPY3e1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WYnsk1Qhvz1L9Ff;
	Wed, 31 Jul 2024 18:10:34 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 7810C180AE5;
	Wed, 31 Jul 2024 18:10:45 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 31 Jul
 2024 18:10:44 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <dhowells@redhat.com>, <marc.dionne@auristor.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <linux-afs@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>, <horms@kernel.org>
Subject: [PATCH v2 net-next] rxrpc: Remove unused function declarations
Date: Wed, 31 Jul 2024 18:08:15 +0800
Message-ID: <20240731100815.1277894-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf500002.china.huawei.com (7.185.36.57)

commit 3cec055c5695 ("rxrpc: Don't hold a ref for connection workqueue")
left behind rxrpc_put_client_conn().
And commit 248f219cb8bc ("rxrpc: Rewrite the data and ack handling code")
removed rxrpc_accept_incoming_calls() but left declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/rxrpc/ar-internal.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 08de24658f4f..80d682f89b23 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -856,7 +856,6 @@ bool rxrpc_new_incoming_call(struct rxrpc_local *local,
 			     struct rxrpc_connection *conn,
 			     struct sockaddr_rxrpc *peer_srx,
 			     struct sk_buff *skb);
-void rxrpc_accept_incoming_calls(struct rxrpc_local *);
 int rxrpc_user_charge_accept(struct rxrpc_sock *, unsigned long);
 
 /*
@@ -969,7 +968,6 @@ void rxrpc_connect_client_calls(struct rxrpc_local *local);
 void rxrpc_expose_client_call(struct rxrpc_call *);
 void rxrpc_disconnect_client_call(struct rxrpc_bundle *, struct rxrpc_call *);
 void rxrpc_deactivate_bundle(struct rxrpc_bundle *bundle);
-void rxrpc_put_client_conn(struct rxrpc_connection *, enum rxrpc_conn_trace);
 void rxrpc_discard_expired_client_conns(struct rxrpc_local *local);
 void rxrpc_clean_up_local_conns(struct rxrpc_local *);
 
-- 
2.34.1


