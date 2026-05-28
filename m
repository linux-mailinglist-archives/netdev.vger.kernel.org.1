Return-Path: <netdev+bounces-292658-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJMKKechGGocdggAu9opvQ
	(envelope-from <netdev+bounces-292658-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:07:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C49F85F10D8
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8F8031CDAFA
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161663DEAC6;
	Thu, 28 May 2026 11:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="AivIB8Sz"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A553C09FC;
	Thu, 28 May 2026 11:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779966063; cv=none; b=dPniUWacXCLOpQRA74jWULWrNk7X8Xg8JiMDsscn2mK95onbhrLYcPFs3jvQMCRjwjWmGKtJURkS8Lg5eK43XjYZnara27hzCu0eKXboIzykzBoNS15rWtDnzLrB1FliIa4Am6WBgbURKohNHqCKk82FYLxt7YNb4Htnkg5hzPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779966063; c=relaxed/simple;
	bh=+ywZsCC6JKsvk+Ntlbd7Erqig69aid5ibtlS4HGF3iM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Puh1aA90hNBb5PcLE4nYZrSzM/fbaP6idyot8dll/XdKLSSB80McsV2+hWjGGViqxLNeS0+2FJP2DhHxihWM3uXxXpdMV1ev2ssnmGLV3MTqRabImfhjwjxgpVDkVvHb9z3po9YYoiBLnhA6j4pTffwlsqzQqqa7T2RvX7bEIOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=AivIB8Sz; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7c38d6ca5a8411f18dc8c9802ae25ab1-20260528
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=gXZ6VmHATIDJF/ddpM8O023vh0Uyqhny6zlESoVEa/Q=;
	b=AivIB8Sz0/bahbC1kVzwsBpV//S1e+rvF9a1Dnjt7Psxnr9P+5JvYhd2cpnnkYh7Xpel+EaVdydqpMMoRKr7gyjjpG3BW8rHeXGbvuNh/8kuFSl6SmTR+OozUg+I3dmQ3zXfR3ht0Ugk3lRcEcx00N8dZCjbpP1ZnGf6NBYuwbw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:b6a45ed2-7358-4a74-bd80-6ed6f8f607d8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:de3f87c9-9273-4096-a0ce-fc7a6a4f85f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|123|136|836|865|888|898,TC
	:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:
	-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7c38d6ca5a8411f18dc8c9802ae25ab1-20260528
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <jianyu.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1098549085; Thu, 28 May 2026 19:00:49 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 28 May 2026 19:00:48 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 28 May 2026 19:00:47 +0800
From: <jianyu.li@mediatek.com>
To: <kuniyu@google.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <willemb@google.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mediatek@lists.infrade>,
	<black-ch.chen@mediatek.com>, <ivan.tseng@mediatek.com>,
	<jianyu.li@mediatek.com>
Subject: [PATCH net v2 1/2] af_unix: Fix inq_len update problem in partial read
Date: Thu, 28 May 2026 19:00:32 +0800
Message-ID: <20260528110033.3327744-2-jianyu.li@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260528110033.3327744-1-jianyu.li@mediatek.com>
References: <20260528110033.3327744-1-jianyu.li@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[mediatek.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292658-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianyu.li@mediatek.com,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,mediatek.com:mid,mediatek.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C49F85F10D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jianyu Li <jianyu.li@mediatek.com>

Currently inq_len is updated only when the whole skb is consumed.
If only part of the data is read, following SIOCINQ query would
get value greater than what actually left.

This change update inq_len timely in unix_stream_read_generic(),
and adjust unix_stream_read_skb() accordingly to prevent
repetitive update.

Fixes: f4e1fb04c123 ("af_unix: Use cached value for SOCK_STREAM in unix_inq_len().")
Signed-off-by: Jianyu Li <jianyu.li@mediatek.com>
---
v2: Improve lock usage in unix_stream_read_generic()
---
 net/unix/af_unix.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index dc71ed79be..0d9cd977c7 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2886,7 +2886,7 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 		return -EAGAIN;
 	}
 
-	WRITE_ONCE(u->inq_len, u->inq_len - skb->len);
+	WRITE_ONCE(u->inq_len, u->inq_len - unix_skb_len(skb));
 
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
 	if (skb == u->oob_skb) {
@@ -3063,11 +3063,12 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 				unix_detach_fds(&scm, skb);
 			}
 
-			if (unix_skb_len(skb))
-				break;
-
 			spin_lock(&sk->sk_receive_queue.lock);
-			WRITE_ONCE(u->inq_len, u->inq_len - skb->len);
+			WRITE_ONCE(u->inq_len, u->inq_len - chunk);
+			if (unix_skb_len(skb)) {
+				spin_unlock(&sk->sk_receive_queue.lock);
+				break;
+			}
 			__skb_unlink(skb, &sk->sk_receive_queue);
 			spin_unlock(&sk->sk_receive_queue.lock);
 
-- 
2.45.2


