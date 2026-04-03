Return-Path: <netdev+bounces-274933-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qN51K15zz2n1wQYAu9opvQ
	(envelope-from <netdev+bounces-274933-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:59:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD7F391E00
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CB2D304C043
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 07:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11C035DA69;
	Fri,  3 Apr 2026 07:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FQHQgkGD";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FQHQgkGD"
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155A531A576
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 07:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775203017; cv=none; b=R4cairE/ZWb6CaQOq/PAIF5koODJRGyALLc2VGwMktXqRdmvGp5lPIX7ZuRYqIToshp5ihrFu0G+J/j7c72ugDpkn6GLpj2konQa2bZMtgR91iS23UVlj+1P/hhElV1BrisQIfRCie8dQUsAzIPH8+AOffXf03Xy/JUJEJCeX3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775203017; c=relaxed/simple;
	bh=eJafcqyShn6zsnIi/ObO6z6H4yfjUIinZ8w764X7Mu8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a+ZDNm14PVrORuydhTUlA4VL6FlsAUFv8Jx2ioN8F1Cn1UuRELZLpk/Ujl12yzfNOqPGaJ0vpO/yPMylCSWedNIR4kZvl+jiAI5oBjOI759htdO1PkOWSl+mubFYM8bDt1U3InW8T1cSPKcP4bTRyWyfHk7i5GCFnpUoJZ1VT30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FQHQgkGD; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FQHQgkGD; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=br9d4JbUaVtQzEF7juGqsOca/+CfbUyrV9n9guaVsy4=;
	b=FQHQgkGDnAkTfb+gFfk79Ujx1SbL3iO6MTiNA2DUpch9FnJOK+c9OPIs4PdiS0rtyQibpqUA8
	0TL+8+kzIxlPhsAWjuHvO+uMZgOw5hr43ChdCIiCyrybGuL0TGVIErjX4QTmRVYNFmQ0jNApfGI
	sfLssmO42Ios+PrUa7B7bHI=
Received: from canpmsgout01.his.huawei.com (unknown [172.19.92.178])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4fn9z60MBjz1BG77
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 15:56:34 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=br9d4JbUaVtQzEF7juGqsOca/+CfbUyrV9n9guaVsy4=;
	b=FQHQgkGDnAkTfb+gFfk79Ujx1SbL3iO6MTiNA2DUpch9FnJOK+c9OPIs4PdiS0rtyQibpqUA8
	0TL+8+kzIxlPhsAWjuHvO+uMZgOw5hr43ChdCIiCyrybGuL0TGVIErjX4QTmRVYNFmQ0jNApfGI
	sfLssmO42Ios+PrUa7B7bHI=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fn9rk5ddmz1T4Mc;
	Fri,  3 Apr 2026 15:51:02 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 6DD4340569;
	Fri,  3 Apr 2026 15:56:46 +0800 (CST)
Received: from kwepemq100012.china.huawei.com (7.202.195.195) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 3 Apr 2026 15:56:46 +0800
Received: from huawei.com (10.67.175.84) by kwepemq100012.china.huawei.com
 (7.202.195.195) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 3 Apr
 2026 15:56:41 +0800
From: Zicheng Qu <quzicheng@huawei.com>
To: <kernel@openeuler.org>
CC: <tanghui20@huawei.com>, <quzicheng@huawei.com>, <quzicheng315@163.com>,
	Kui-Feng Lee <thinker.li@gmail.com>, <netdev@vger.kernel.org>, "Martin KaFai
 Lau" <martin.lau@kernel.org>, Luo Gengkun <luogengkun2@huawei.com>
Subject: [PATCH OLK-6.6 086/451] bpf, net: validate struct_ops when updating value.
Date: Fri, 3 Apr 2026 07:27:21 +0000
Message-ID: <20260403073326.3096906-87-quzicheng@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260403073326.3096906-1-quzicheng@huawei.com>
References: <20260403073326.3096906-1-quzicheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq100012.china.huawei.com (7.202.195.195)
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274933-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[huawei.com,163.com,gmail.com,vger.kernel.org,kernel.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quzicheng@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:dkim,huawei.com:email,huawei.com:mid,atomgit.com:url];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 1AD7F391E00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kui-Feng Lee <thinker.li@gmail.com>

mainline inclusion
from mainline-v6.9-rc1
commit 73e4f9e615d7b99f39663d4722dc73e8fa5db5f9
category: feature
bugzilla: https://atomgit.com/openeuler/kernel/issues/8335
CVE: NA

Reference: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=73e4f9e615d7b99f39663d4722dc73e8fa5db5f9

----------------------------------------------------------------------

Perform all validations when updating values of struct_ops maps. Doing
validation in st_ops->reg() and st_ops->update() is not necessary anymore.
However, tcp_register_congestion_control() has been called in various
places. It still needs to do validations.

Cc: netdev@vger.kernel.org
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
Link: https://lore.kernel.org/r/20240224223418.526631-2-thinker.li@gmail.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Luo Gengkun <luogengkun2@huawei.com>
---
 kernel/bpf/bpf_struct_ops.c | 11 ++++++-----
 net/ipv4/tcp_cong.c         |  6 +-----
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 0d7be97a2411..c244ed5114fd 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -667,13 +667,14 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		*(unsigned long *)(udata + moff) = prog->aux->id;
 	}
 
+	if (st_ops->validate) {
+		err = st_ops->validate(kdata);
+		if (err)
+			goto reset_unlock;
+	}
+
 	if (st_map->map.map_flags & BPF_F_LINK) {
 		err = 0;
-		if (st_ops->validate) {
-			err = st_ops->validate(kdata);
-			if (err)
-				goto reset_unlock;
-		}
 		arch_protect_bpf_trampoline(st_map->image, PAGE_SIZE);
 		/* Let bpf_link handle registration & unregistration.
 		 *
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index 95dbb2799be4..48617d99abb0 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -145,11 +145,7 @@ EXPORT_SYMBOL_GPL(tcp_unregister_congestion_control);
 int tcp_update_congestion_control(struct tcp_congestion_ops *ca, struct tcp_congestion_ops *old_ca)
 {
 	struct tcp_congestion_ops *existing;
-	int ret;
-
-	ret = tcp_validate_congestion_control(ca);
-	if (ret)
-		return ret;
+	int ret = 0;
 
 	ca->key = jhash(ca->name, sizeof(ca->name), strlen(ca->name));
 
-- 
2.34.1


