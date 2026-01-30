Return-Path: <netdev+bounces-255006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHwFFbwnfGkiKwIAu9opvQ
	(envelope-from <netdev+bounces-255006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 04:38:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1F3B6DBB
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 04:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 696EA3013713
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438712DCF6C;
	Fri, 30 Jan 2026 03:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3P5Wun2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205AC3FF1;
	Fri, 30 Jan 2026 03:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769744312; cv=none; b=u953u4FjTh+YQwPIQzlcolhmASBSM/IKDJyuEaDIy4u2GHSyzwu//aRA1WpLvzpcQZqi+YV21IKXJMTNVCjjipT0tipMIXeT3diL5McDeu5lCwRRUPd657HEj9QehhPl0bR/UURDT5o4sS7j4uhkDFIwvN/d6T/NRk7fKxRfjrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769744312; c=relaxed/simple;
	bh=IF1Wqx2TIJcC5YIyg8xCcU6RmGU8W2yyLN215CmEcns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GwCDkuQZ+o0RIplktQixgF9r0MGDlRFUlETAKNJwpKJklGQ/6lsFcTrYpNu99VPuC+z7RVvalj1TbBbDZs04ePNf0TFLcLzS6jHddUVQMOyAkuZHqE5ryZ7EmCliIsbQoUxTK/hemhWSbIgXzSvcxOcsl/udccQuAgBgNHV6vLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3P5Wun2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19E1C4CEF7;
	Fri, 30 Jan 2026 03:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769744311;
	bh=IF1Wqx2TIJcC5YIyg8xCcU6RmGU8W2yyLN215CmEcns=;
	h=From:To:Cc:Subject:Date:From;
	b=N3P5Wun2RJzScLVeaMRsq72ND7Q4wbWzJWbHJYRvPyt803dvY5vYBgVp0cXRWUbmd
	 rzEQqYSjqp6ulP4WOpIUxXkDSK5eoQPE6K3Vu+7+S1xE0aEztmx0vlOOF2nguR+8a0
	 AyCXzoBuq5PkIJTxC4Lkn0iaHNJFRIWoL282tiqO8WA26upAQM6P/GSA3USxeZqcbx
	 7j0vC8qzl5LMW4O/bDFj1bM7xKkQ38YTm0Hvmzot7Gpn5lDFCbEWHdCQSRBK0Ed6NB
	 GpiCI6YfWobFOySnDTGdZXHmE7bX3YkzwBt6EHry4i2L6W9wHhH5YePVC9SNL5iOSL
	 leY7iKwXYpXHw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Gal Pressman <gal@nvidia.com>,
	ast@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	dsahern@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH net v2] net: don't touch dev->stats in BPF redirect paths
Date: Thu, 29 Jan 2026 19:38:27 -0800
Message-ID: <20260130033827.698841-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,iogearbox.net,nvidia.com,gmail.com,linux.dev,fomichev.me];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-255006-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,fomichev.me:email,iogearbox.net:email]
X-Rspamd-Queue-Id: BB1F3B6DBB
X-Rspamd-Action: no action

Gal reports that BPF redirect increments dev->stats.tx_errors
on failure. This is not correct, most modern drivers completely
ignore dev->stats so these drops will be invisible to the user.
Core code should use the dedicated core stats which are folded
into device stats in dev_get_stats().

Note that we're switching from tx_errors to tx_dropped.
Core only has tx_dropped, hence presumably users already expect
that counter to increment for "stack" Tx issues.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Reported-by: Gal Pressman <gal@nvidia.com>
Link: https://lore.kernel.org/c5df3b60-246a-4030-9c9a-0a35cd1ca924@nvidia.com
Fixes: b4ab31414970 ("bpf: Add redirect_neigh helper as redirect drop-in")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - add note on tx_dropped to the commit msg
v1: https://lore.kernel.org/20260128161030.39870-1-kuba@kernel.org

CC: ast@kernel.org
CC: eddyz87@gmail.com
CC: song@kernel.org
CC: yonghong.song@linux.dev
CC: john.fastabend@gmail.com
CC: kpsingh@kernel.org
CC: sdf@fomichev.me
CC: haoluo@google.com
CC: jolsa@kernel.org
CC: dsahern@gmail.com
CC: bpf@vger.kernel.org
---
 net/core/filter.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 616e0520a0bb..2c21735798a5 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2289,12 +2289,12 @@ static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
 
 	err = bpf_out_neigh_v6(net, skb, dev, nh);
 	if (unlikely(net_xmit_eval(err)))
-		DEV_STATS_INC(dev, tx_errors);
+		dev_core_stats_tx_dropped_inc(dev);
 	else
 		ret = NET_XMIT_SUCCESS;
 	goto out_xmit;
 out_drop:
-	DEV_STATS_INC(dev, tx_errors);
+	dev_core_stats_tx_dropped_inc(dev);
 	kfree_skb(skb);
 out_xmit:
 	return ret;
@@ -2396,12 +2396,12 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 
 	err = bpf_out_neigh_v4(net, skb, dev, nh);
 	if (unlikely(net_xmit_eval(err)))
-		DEV_STATS_INC(dev, tx_errors);
+		dev_core_stats_tx_dropped_inc(dev);
 	else
 		ret = NET_XMIT_SUCCESS;
 	goto out_xmit;
 out_drop:
-	DEV_STATS_INC(dev, tx_errors);
+	dev_core_stats_tx_dropped_inc(dev);
 	kfree_skb(skb);
 out_xmit:
 	return ret;
-- 
2.52.0


