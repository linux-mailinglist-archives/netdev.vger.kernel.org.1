Return-Path: <netdev+bounces-75135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB292868529
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 01:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9C51F220D5
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 00:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13FE15CB;
	Tue, 27 Feb 2024 00:49:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014A34A1C
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 00:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708994985; cv=none; b=CDJMWnKfES3WEyNh3F+JmhCACFYdPBuZ0apem/L50qu6XjzkpJi0qo2UhmPNgjeIGROv+1WcBBt+8U5ugBvjWn3yKWeZdP0XrV0w45qhK9lKgKL7omf/Hc3WskRtd8HWalTwZOJO2PisuAJGl9jkp/kfnlXxzKT+DIsXjTDLKKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708994985; c=relaxed/simple;
	bh=qZYg42/r+uEK0fkTZWUAQSFNSxu9gwjWNJVKde8L8kM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FWHw2zarKiP/bp1ENaWZSStTxhBQvim9BLRmSHSMusRBmjDaueB+k8kVG5Y1V4cOOpbp94FhnFVmcQxyvA6BWj8d0N4h9U5YBXC0w/yE3iDRXyVIitJdGwrrbVi0EJ5XdY00rp768y1WRtEk45IxYthyJMvCOIrCen+d1u+RMGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TkJjb0sJwzvVxt;
	Tue, 27 Feb 2024 08:47:31 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B0661404FC;
	Tue, 27 Feb 2024 08:49:39 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 27 Feb
 2024 08:49:38 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
	<shaozhengchao@huawei.com>
Subject: [PATCH net-next] ipv6: raw: remove useless input parameter in rawv6_get/seticmpfilter
Date: Tue, 27 Feb 2024 08:57:45 +0800
Message-ID: <20240227005745.3556353-1-shaozhengchao@huawei.com>
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

The input parameter 'level' in rawv6_get/seticmpfilter is not used.
Therefore, remove it.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 net/ipv6/raw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 479c4c2c1785..76e6eb3b643d 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -934,7 +934,7 @@ static int rawv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	goto done;
 }
 
-static int rawv6_seticmpfilter(struct sock *sk, int level, int optname,
+static int rawv6_seticmpfilter(struct sock *sk, int optname,
 			       sockptr_t optval, int optlen)
 {
 	switch (optname) {
@@ -951,7 +951,7 @@ static int rawv6_seticmpfilter(struct sock *sk, int level, int optname,
 	return 0;
 }
 
-static int rawv6_geticmpfilter(struct sock *sk, int level, int optname,
+static int rawv6_geticmpfilter(struct sock *sk, int optname,
 			       char __user *optval, int __user *optlen)
 {
 	int len;
@@ -1037,7 +1037,7 @@ static int rawv6_setsockopt(struct sock *sk, int level, int optname,
 	case SOL_ICMPV6:
 		if (inet_sk(sk)->inet_num != IPPROTO_ICMPV6)
 			return -EOPNOTSUPP;
-		return rawv6_seticmpfilter(sk, level, optname, optval, optlen);
+		return rawv6_seticmpfilter(sk, optname, optval, optlen);
 	case SOL_IPV6:
 		if (optname == IPV6_CHECKSUM ||
 		    optname == IPV6_HDRINCL)
@@ -1098,7 +1098,7 @@ static int rawv6_getsockopt(struct sock *sk, int level, int optname,
 	case SOL_ICMPV6:
 		if (inet_sk(sk)->inet_num != IPPROTO_ICMPV6)
 			return -EOPNOTSUPP;
-		return rawv6_geticmpfilter(sk, level, optname, optval, optlen);
+		return rawv6_geticmpfilter(sk, optname, optval, optlen);
 	case SOL_IPV6:
 		if (optname == IPV6_CHECKSUM ||
 		    optname == IPV6_HDRINCL)
-- 
2.34.1


