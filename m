Return-Path: <netdev+bounces-234958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC75C2A3C4
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 07:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8AAC4E2C97
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 06:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF007288502;
	Mon,  3 Nov 2025 06:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WBa9ENdC"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C8A235BE2;
	Mon,  3 Nov 2025 06:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762153122; cv=none; b=aeboBuusGAFt9W0MvrYqVj+rUV3yQm67d0XkKnxxznfXpTzdkw8F2GWup6w/o5FREn9kL1vtQQVgr/Hgwzr3AZS5gWy5LteJDkG1ZkuAYJZI1lhaiUH9JAzSF/UIwtv4UpigjFzboUWdhfNRKTvomcsuUpU1KED4/ydJ0u45NZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762153122; c=relaxed/simple;
	bh=UaWei8lA5myvGhZlKdywonEmJPyUfL8lNDin+Txy330=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YlxEZE6vbbYGhoIcJF+QnhkK8xL6mCL9WbECXh4aXsmlFOdWnAG9eUqwPcbSGGSmyLo5ctThmJgz7yZs/rLolmXxT5+ej7yN3M0pIrrxPark6FfPx9F6EgQo9+v/xfGOX9VCsRgBmtAAAB2Mg8e3Ck7zgFugzqHv8OOIDCvwQP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WBa9ENdC; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=yZVwZ3hFajFtTCfA4Oy9TngkmWmo1DVbMQCOxbEbPSk=;
	b=WBa9ENdCIusVS7Yn6PIdeLql7uY2GCW1aL0lcj1jm9rO+nbSQYlQVUaux0oob72av2hbwUS+Z
	CT9zAXozdi+9Icfm9EkN1LtD3JQFJ7OlHgRffRJolmd1FINddxWmvEFP9wVUarwLTpvq48SDg0X
	hrpo6puIIXkGpRf1u9HdbA4=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4d0Mny5S3LzRhTT;
	Mon,  3 Nov 2025 14:56:54 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 343AE1402C1;
	Mon,  3 Nov 2025 14:58:28 +0800 (CST)
Received: from huawei.com (10.50.85.128) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 3 Nov
 2025 14:58:27 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <almasrymina@google.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH net-next] net: devmem: Remove unused declaration net_devmem_bind_tx_release()
Date: Mon, 3 Nov 2025 15:20:46 +0800
Message-ID: <20251103072046.1670574-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit bd61848900bf ("net: devmem: Implement TX path") declared this
but never implemented it.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/core/devmem.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/core/devmem.h b/net/core/devmem.h
index 101150d761af..0b43a648cd2e 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -94,7 +94,6 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding);
 int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 				    struct net_devmem_dmabuf_binding *binding,
 				    struct netlink_ext_ack *extack);
-void net_devmem_bind_tx_release(struct sock *sk);
 
 static inline struct dmabuf_genpool_chunk_owner *
 net_devmem_iov_to_chunk_owner(const struct net_iov *niov)
-- 
2.34.1


