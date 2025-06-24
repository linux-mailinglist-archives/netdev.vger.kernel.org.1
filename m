Return-Path: <netdev+bounces-200477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B6BAE5929
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 03:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F550446E96
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 01:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1866B1714C6;
	Tue, 24 Jun 2025 01:24:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B927518641;
	Tue, 24 Jun 2025 01:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750728299; cv=none; b=WAh4e5GxrHoo37h11eYLAy56GSwWFUNcjD+6Tqg+HbUH9/x7/pIOvb0H5SrVTZ9ojsyxIjBAfCpcD7uE7PqXi3IRG0DYY2FI+IQz8V4mJVkD/Eq8BpdTmB5N/sl43Qi/nwVYh0ADxKYH8UceYtLXG8nhsD9qEfPEzvtm+Bc3fuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750728299; c=relaxed/simple;
	bh=Hn+0wwL8ZlhoJI/0juhHC2Xllu76w0znhfwXP9KXX30=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bhqh0giDIOzNgdJ2+2Z+clwY4KqKV96rNTVg9gVJu+eKADskDj7DGIrIA6rJgrfv2jv1HAU64rjN7CxG+7D9HfMYBtfnO/XF/qyjCE1VP3mqsLxwBtA0HFygAP0TLUZp45SPd9ztljWWi0rae5IoCm8M2Yor/7cBAaGIRPwsnrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bR6dy5h1cz2BdCN;
	Tue, 24 Jun 2025 09:23:18 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id E5BF4140296;
	Tue, 24 Jun 2025 09:24:53 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 24 Jun
 2025 09:24:53 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <gnaaman@drivenets.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH net-next] neighbour: Remove redundant assignment to err
Date: Tue, 24 Jun 2025 09:42:16 +0800
Message-ID: <20250624014216.3686659-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500002.china.huawei.com (7.185.36.57)

'err' has been checked against 0 in the if statement.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/core/neighbour.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 85a5535de8ba..8ad9898f8e42 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2055,10 +2055,8 @@ static int neigh_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	err = __neigh_update(neigh, lladdr, ndm->ndm_state, flags,
 			     NETLINK_CB(skb).portid, extack);
-	if (!err && ndm_flags & (NTF_USE | NTF_MANAGED)) {
+	if (!err && ndm_flags & (NTF_USE | NTF_MANAGED))
 		neigh_event_send(neigh, NULL);
-		err = 0;
-	}
 	neigh_release(neigh);
 out:
 	return err;
-- 
2.34.1


