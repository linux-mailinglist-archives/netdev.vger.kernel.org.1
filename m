Return-Path: <netdev+bounces-269403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAXbGNTWu2k4owIAu9opvQ
	(envelope-from <netdev+bounces-269403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 11:58:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5652C9D41
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 11:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77DEA3004D06
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 10:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AF63C13E1;
	Thu, 19 Mar 2026 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="TnzHBWPW";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="TnzHBWPW"
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DEF3A9616;
	Thu, 19 Mar 2026 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773917899; cv=none; b=GivTI6Ihj7WImy2ay6SHqWNlG6VRXkKdC9IzcSmgCIcWIz7Y5hNmZtWzIKjuxQYLTDUwEJ8OsDP5eSwBhHwgqD+C7ykc1bbreZfgstGPjUsJSRYxPZEV/e8V5nbReF9P4H+BE2jK9unnmlnG8+FadKMrDk2pxe+Apwya6zWt3NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773917899; c=relaxed/simple;
	bh=BWZlB5ieElyQI8GNk8aRWuD6EskIKpAd7O0l6vbF1mE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dnqHlxGMwQN+FMueKFLl3dlNGj6vKVjtc3AzGHjt2IVjVmk0C8dXr2ACXIvFUPs6dgJU9HwbBjFp48t4Io22BMnaNpLGSkNOC5dVYXAV9wn2zlJ8zKqr/pknwrPWnNjxUI6nYaj/TBFPaVTXiWHHzyGnHLjg5X6/NIHiRyYs7Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=TnzHBWPW; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=TnzHBWPW; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kyEMUQBF2YL05LT+fM2EoA0A+YLnbqzjV4JFMXehIJw=;
	b=TnzHBWPWddCUqhflGb0WRJZADh34kg0JarGUMDH10Kk2rFedQH/xjY9Qn8ZxZiuceN3DqNDIu
	YM0nn3OJ6nNug8RoIr1orLcR2zq46MIqaRWUZX0za3dfYnb3FyQ6l/ZzIyRoKnPthXs7sFgqyhk
	7WQJkth5sFJn3Q1gLk4IfRk=
Received: from canpmsgout03.his.huawei.com (unknown [172.19.92.159])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4fc2hW6G1sz1BFRg;
	Thu, 19 Mar 2026 18:57:15 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kyEMUQBF2YL05LT+fM2EoA0A+YLnbqzjV4JFMXehIJw=;
	b=TnzHBWPWddCUqhflGb0WRJZADh34kg0JarGUMDH10Kk2rFedQH/xjY9Qn8ZxZiuceN3DqNDIu
	YM0nn3OJ6nNug8RoIr1orLcR2zq46MIqaRWUZX0za3dfYnb3FyQ6l/ZzIyRoKnPthXs7sFgqyhk
	7WQJkth5sFJn3Q1gLk4IfRk=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fc2b90vT3zpSvC;
	Thu, 19 Mar 2026 18:52:37 +0800 (CST)
Received: from kwepemj500018.china.huawei.com (unknown [7.202.194.48])
	by mail.maildlp.com (Postfix) with ESMTPS id A0E4840569;
	Thu, 19 Mar 2026 18:58:02 +0800 (CST)
Received: from huawei.com (10.50.85.128) by kwepemj500018.china.huawei.com
 (7.202.194.48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 19 Mar
 2026 18:58:01 +0800
From: Li Xiasong <lixiasong1@huawei.com>
To: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
	<martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: <netdev@vger.kernel.org>, <mptcp@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>, <weiyongjun1@huawei.com>
Subject: [PATCH net] MPTCP: fix lock class name family in pm_nl_create_listen_socket
Date: Thu, 19 Mar 2026 19:21:59 +0800
Message-ID: <20260319112159.3118874-1-lixiasong1@huawei.com>
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
 kwepemj500018.china.huawei.com (7.202.194.48)
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269403-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lixiasong1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,huawei.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8E5652C9D41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In mptcp_pm_nl_create_listen_socket(), use entry->addr.family
instead of sk->sk_family for lock class setup. The 'sk' parameter
is a netlink socket, not the MPTCP subflow socket being created.

Fixes: cee4034a3db1 ("mptcp: fix lockdep false positive in mptcp_pm_nl_create_listen_socket()")
Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
---
 net/mptcp/pm_kernel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index b2b9df43960e..82e59f9c6dd9 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -838,7 +838,7 @@ static struct lock_class_key mptcp_keys[2];
 static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 					    struct mptcp_pm_addr_entry *entry)
 {
-	bool is_ipv6 = sk->sk_family == AF_INET6;
+	bool is_ipv6 = entry->addr.family == AF_INET6;
 	int addrlen = sizeof(struct sockaddr_in);
 	struct sockaddr_storage addr;
 	struct sock *newsk, *ssk;
-- 
2.34.1


