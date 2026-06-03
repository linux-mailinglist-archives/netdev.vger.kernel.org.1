Return-Path: <netdev+bounces-294597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IGaBHsLVH2roqgAAu9opvQ
	(envelope-from <netdev+bounces-294597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:20:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C46E663523F
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:20:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ucloud.cn header.s=default header.b=aAqjcE9b;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294597-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294597-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=ucloud.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6188318CE2C
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA4540803E;
	Wed,  3 Jun 2026 06:59:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49218.qiye.163.com (mail-m49218.qiye.163.com [45.254.49.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E20407CEF;
	Wed,  3 Jun 2026 06:59:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469974; cv=none; b=V6J3kzI6pd2H+75TwXGa8mcNcO+LLxJoKHLoAgxCgbxjXr2/xjRsY02JgGBTqQ/o/UOra6ODRklmX3FBB3C3Snb4ARULy+SiPIwqK8QGFLbKccjR0dcsTJUyXOdJRX1LeZk8tlx7BTegU4T7MZ40xQxbtoIvpupiE2bj0WOuiXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469974; c=relaxed/simple;
	bh=YeDj+vW/ls6yG/Z6ri+CsMKidy6SP4mcnKYTvR1VFiU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ikjvX76lPXM1cR2GbA8J9M+0g+hoI0UuhhoyI03wkSuNIr3HpilAXElRUS/1r4rPHMdJmL1eSaKJD3eGEN0O7VAEQAP9at9bThtpgtiFc36FS5k8Y8LL3ywcy9nZ6QcSw4TBiVJ4YYmx+ENtZtT+7idKXUwKWWkQCA2icIR367I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucloud.cn; spf=pass smtp.mailfrom=ucloud.cn; dkim=pass (1024-bit key) header.d=ucloud.cn header.i=@ucloud.cn header.b=aAqjcE9b; arc=none smtp.client-ip=45.254.49.218
Received: from yuangap.. (unknown [106.75.220.2])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1af1378a7;
	Wed, 3 Jun 2026 14:54:13 +0800 (GMT+08:00)
From: "yuan.gao" <yuan.gao@ucloud.cn>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "yuan.gao" <yuan.gao@ucloud.cn>
Subject: [PATCH net] inet: frags: remove redundant assignment in inet_frag_reasm_prepare()
Date: Wed,  3 Jun 2026 14:53:23 +0800
Message-Id: <20260603065323.2736839-1-yuan.gao@ucloud.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e8c42dde20229kunmd0e242ac27f6d0
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTB1PVk1OGU5LHUNNTk9NTlYVFA
	kWGhdVGRETFhoSFyQUDg9ZV1kYEgtZQVlKS01VTE5VSUlLVUlZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=aAqjcE9b2RtgBRYrZeWK7KI+Q0ec+9y3ctph0zJnwT9hpO/bPKrmuHfrqFpA9LVK+KsWRCk+8/Likd5MbUGjhYh/UWh1I1jIbZFrlEAt5mPwpaWRqvRs+6pdMlSK0KiNTQ0pqYz9nkDlcNzw2L8EorMHWYdg0Al/t/b13bJlEwE=; s=default; c=relaxed/relaxed; d=ucloud.cn; v=1;
	bh=D4L5GolW8rHJvUx3aHc7MJIiUhRzbf8ezE0ovYk9o2I=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ucloud.cn,quarantine];
	R_DKIM_ALLOW(-0.20)[ucloud.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294597-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yuan.gao@ucloud.cn,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[yuan.gao@ucloud.cn,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuan.gao@ucloud.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ucloud.cn:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ucloud.cn:mid,ucloud.cn:dkim,ucloud.cn:from_mime,ucloud.cn:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C46E663523F

The assignment is redundant because skb_clone() already copies skb->cb.

Remove the unnecessary code.

Signed-off-by: yuan.gao <yuan.gao@ucloud.cn>
---
 net/ipv4/inet_fragment.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 496308c02..6119b660a 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -473,7 +473,6 @@ void *inet_frag_reasm_prepare(struct inet_frag_queue *q, struct sk_buff *skb,
 			head = skb;
 			goto out_restore_sk;
 		}
-		FRAG_CB(fp)->next_frag = FRAG_CB(skb)->next_frag;
 		if (RB_EMPTY_NODE(&skb->rbnode))
 			FRAG_CB(parent)->next_frag = fp;
 		else
@@ -488,7 +487,6 @@ void *inet_frag_reasm_prepare(struct inet_frag_queue *q, struct sk_buff *skb,
 			skb->destructor = NULL;
 		}
 		skb_morph(skb, head);
-		FRAG_CB(skb)->next_frag = FRAG_CB(head)->next_frag;
 		rb_replace_node(&head->rbnode, &skb->rbnode,
 				&q->rb_fragments);
 		consume_skb(head);
-- 
2.32.0


