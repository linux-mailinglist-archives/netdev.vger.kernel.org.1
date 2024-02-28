Return-Path: <netdev+bounces-75565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5413C86A8C7
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 08:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E914FB26428
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 07:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE74B2377A;
	Wed, 28 Feb 2024 07:17:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C830D22EED
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 07:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709104632; cv=none; b=Gos+VmJcs6SAG6DrebZnrk6lYEW12+U8FbNuj9bJkjnzP9tyibcUj6XBOcHTa7I5Fh/3pU/pIOnrEp8NMFtZRG3yERwEjeQksDBY78+TF7IVrOdJa52pnT+b3acFIgcCy8FT9NZhcss0TqU2qIOZ9KaJq4jdGzvhhcobDP0xPgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709104632; c=relaxed/simple;
	bh=BKvf31GtjFUMY8du1q/u0axen7DA6CP7iK1BBGEVDUI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fiMMVhzcrFmte9g4sLNoUAVxvYtZSVO32GyT4vXB2uj9jOtTXpBn+WD7KBqv4hXjs2LWPpJRUsI1TN69S6dyiDBnmQYfxpCiP6foD4yA+nehFX9bnhB0+7zRYn6UlKrt8io75F/vvX4LcW6+BNRjq3JFcpMSB5oMGVHWR/0cMrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Tl5Fz2bJwz2Bdsm;
	Wed, 28 Feb 2024 15:14:47 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 4146F18002F;
	Wed, 28 Feb 2024 15:17:02 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 28 Feb
 2024 15:17:01 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
	<shaozhengchao@huawei.com>
Subject: [PATCH net-next] ipv4: raw: remove useless input parameter in do_raw_set/getsockopt
Date: Wed, 28 Feb 2024 15:25:05 +0800
Message-ID: <20240228072505.640550-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500026.china.huawei.com (7.185.36.106)

The input parameter 'level' in do_raw_set/getsockopt() is not used.
Therefore, remove it.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 net/ipv4/raw.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index aea89326c697..7d2bdfd7e7d7 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -815,7 +815,7 @@ static int raw_geticmpfilter(struct sock *sk, char __user *optval, int __user *o
 out:	return ret;
 }
 
-static int do_raw_setsockopt(struct sock *sk, int level, int optname,
+static int do_raw_setsockopt(struct sock *sk, int optname,
 			     sockptr_t optval, unsigned int optlen)
 {
 	if (optname == ICMP_FILTER) {
@@ -832,11 +832,11 @@ static int raw_setsockopt(struct sock *sk, int level, int optname,
 {
 	if (level != SOL_RAW)
 		return ip_setsockopt(sk, level, optname, optval, optlen);
-	return do_raw_setsockopt(sk, level, optname, optval, optlen);
+	return do_raw_setsockopt(sk, optname, optval, optlen);
 }
 
-static int do_raw_getsockopt(struct sock *sk, int level, int optname,
-			  char __user *optval, int __user *optlen)
+static int do_raw_getsockopt(struct sock *sk, int optname,
+			     char __user *optval, int __user *optlen)
 {
 	if (optname == ICMP_FILTER) {
 		if (inet_sk(sk)->inet_num != IPPROTO_ICMP)
@@ -852,7 +852,7 @@ static int raw_getsockopt(struct sock *sk, int level, int optname,
 {
 	if (level != SOL_RAW)
 		return ip_getsockopt(sk, level, optname, optval, optlen);
-	return do_raw_getsockopt(sk, level, optname, optval, optlen);
+	return do_raw_getsockopt(sk, optname, optval, optlen);
 }
 
 static int raw_ioctl(struct sock *sk, int cmd, int *karg)
-- 
2.34.1


