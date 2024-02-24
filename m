Return-Path: <netdev+bounces-74677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E56CB862370
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 09:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F1BDB21E99
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 08:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A57510A2A;
	Sat, 24 Feb 2024 08:33:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7715812B6B
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708763600; cv=none; b=LbvDANqIKPy12/t+qyU6o33YoZMvdHCR/10+Oud63u+MM0B5fi1IUgTY2B5Z7Lwz1G1DGbsruvhWNk/TjPDeXQegHyEWj8eWgOvzBsE0SrjkfLViEbEEKyHGHgplzy00FX6Wf/bEx172d1qwBXtrOLNdWW3h+x+cUextKMR4N5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708763600; c=relaxed/simple;
	bh=WNmJDU810SMI9Awd2P3s2+h86lXCz4vNhkDVzrI7QXo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qdbG6KDQFZZGeR2weOkJmRoWqL+Qb37xqQWwJ354/iv6wcs5wgLtadnW9sA4+SBXldc/N4QCqCSAj56Zmeo7nZylE4djWiCrNItffSF/VLkkJWojCvx7maiQjxXOvwZ7mraPtxg1cEn9DX7LYSIQKyodvXt3JB8ve0S97qSYkVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Thg4Y2zSSz1FJlP;
	Sat, 24 Feb 2024 16:28:13 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 497081A016B;
	Sat, 24 Feb 2024 16:33:08 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 24 Feb
 2024 16:33:07 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
	<shaozhengchao@huawei.com>
Subject: [PATCH net-next] ipv6: raw: remove useless input parameter in rawv6_err
Date: Sat, 24 Feb 2024 16:41:21 +0800
Message-ID: <20240224084121.2479603-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500026.china.huawei.com (7.185.36.106)

The input parameter 'opt' in rawv6_err() is not used. Therefore, remove it.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 net/ipv6/raw.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 03dbb874c363..479c4c2c1785 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -288,8 +288,7 @@ static int rawv6_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 }
 
 static void rawv6_err(struct sock *sk, struct sk_buff *skb,
-	       struct inet6_skb_parm *opt,
-	       u8 type, u8 code, int offset, __be32 info)
+		      u8 type, u8 code, int offset, __be32 info)
 {
 	bool recverr = inet6_test_bit(RECVERR6, sk);
 	struct ipv6_pinfo *np = inet6_sk(sk);
@@ -344,7 +343,7 @@ void raw6_icmp_error(struct sk_buff *skb, int nexthdr,
 		if (!raw_v6_match(net, sk, nexthdr, &ip6h->saddr, &ip6h->daddr,
 				  inet6_iif(skb), inet6_iif(skb)))
 			continue;
-		rawv6_err(sk, skb, NULL, type, code, inner_offset, info);
+		rawv6_err(sk, skb, type, code, inner_offset, info);
 	}
 	rcu_read_unlock();
 }
-- 
2.34.1


