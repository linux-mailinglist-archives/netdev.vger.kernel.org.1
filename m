Return-Path: <netdev+bounces-292110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ffj/JyaVFmq1ngcAu9opvQ
	(envelope-from <netdev+bounces-292110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:54:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEE55E00DF
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93B3B3010D96
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 06:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC4E3ACEF4;
	Wed, 27 May 2026 06:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aKDxh7kc"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEEE3B530A
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 06:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779864850; cv=none; b=jRiIyHSrfSJwJyafTjMeusBNkh5JsfkDeXeKYzjFG2LDqKC6rfhn+j1qOS3uUEUPPRB/M0V+YHlhE4tkpMAGfk6O+vr4zKN1hY+C2pywFrXWuGpddD9igVlXwFaI6H3dsHN93v/Q66CcjpEktsLDi8rvdiBA2gawAza6/xTtJUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779864850; c=relaxed/simple;
	bh=N9YrrcRcU4IlTl71V528y7rLzY6u7a7cw9UoE9hu30w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pVbMWw1ksmSFTNtRtuWaQx9feD/hrhHzXUXSnx7XeMti5bEvceO4LG5ReQMkpMmFeNggQ5dPu4qacxC7SCyJ4dPmxYUfhqo5eZXw7m6J08n5avsTsymBzRNoHz+SAqcVx9NFr9HzcSWVZmNeR7KHMxuZ1rTjjFSOxIJ24RyBSrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=aKDxh7kc; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d4446484599811f1b1788b6acf885367-20260527
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jpb8BQaJV4TeZiNYtA/D7hpl39ikEQ9J636G+C49eSM=;
	b=aKDxh7kcsz04DACJFI4FShPln1kCS/FiF/J3LfjyyE1xPuHp6TBcymdjKwz/2AZpgLSTrwZtWFN74ZCgTJNkivUTnKdz1jD8j8dikjjpHgt5TSB2cpAzqAfxYTE/SKfHelzvGyk48u+rcBUXbtfdzRAMFbCOTNanB+UAMm22h58=;
X-CID-CACHE: Type:Local,Time:202605271431+08,HitQuantity:3
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:fb2170e0-dd77-4802-b41f-b34d98d2f498,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:24ffe8f9-9444-476a-bc04-9e12dce7d69c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|123|136|836|865|888|898,TC
	:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:
	-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d4446484599811f1b1788b6acf885367-20260527
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <jianyu.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1179258038; Wed, 27 May 2026 14:53:55 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 27 May 2026 14:53:54 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 27 May 2026 14:53:54 +0800
From: <jianyu.li@mediatek.com>
To: <kuniyu@google.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <black-ch.chen@mediatek.com>,
	<ivan.tseng@mediatek.com>, <jianyu.li@mediatek.com>
Subject: [PATCH net v1 1/2] af_unix: Fix inq_len update problem in partial read
Date: Wed, 27 May 2026 14:53:41 +0800
Message-ID: <20260527065342.2463433-2-jianyu.li@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260527065342.2463433-1-jianyu.li@mediatek.com>
References: <20260527065342.2463433-1-jianyu.li@mediatek.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292110-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[jianyu.li@mediatek.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4EEE55E00DF
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
 net/unix/af_unix.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index dc71ed79b..2f0b73598 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2886,7 +2886,7 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 		return -EAGAIN;
 	}
 
-	WRITE_ONCE(u->inq_len, u->inq_len - skb->len);
+	WRITE_ONCE(u->inq_len, u->inq_len - unix_skb_len(skb));
 
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
 	if (skb == u->oob_skb) {
@@ -3056,6 +3056,10 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 		if (!(flags & MSG_PEEK)) {
 			UNIXCB(skb).consumed += chunk;
 
+			spin_lock(&sk->sk_receive_queue.lock);
+			WRITE_ONCE(u->inq_len, u->inq_len - chunk);
+			spin_unlock(&sk->sk_receive_queue.lock);
+
 			sk_peek_offset_bwd(sk, chunk);
 
 			if (UNIXCB(skb).fp) {
@@ -3067,7 +3071,6 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 				break;
 
 			spin_lock(&sk->sk_receive_queue.lock);
-			WRITE_ONCE(u->inq_len, u->inq_len - skb->len);
 			__skb_unlink(skb, &sk->sk_receive_queue);
 			spin_unlock(&sk->sk_receive_queue.lock);
 
-- 
2.45.2


