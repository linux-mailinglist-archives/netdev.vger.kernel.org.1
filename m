Return-Path: <netdev+bounces-284396-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNjOATrv+WmcFQMAu9opvQ
	(envelope-from <netdev+bounces-284396-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:23:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AD04F4CE63E
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00AC53067EC2
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 13:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DAD335555;
	Tue,  5 May 2026 13:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dsad5MWq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24ED2DCF57;
	Tue,  5 May 2026 13:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987333; cv=none; b=s8RG88I4AbmkpnPHcQ7pXljrVxEDXOOmBnpLUVFvVvGgsBraLOzn2Vp8+5Z1+xBuj8+BuMJpPglDFEMf3C1BvjzJ8JR9nRX3O0qLjduIcSulrsigDWGZDUpIVGJZWrsO/pGA6fnlVBy5qXzxsmuHWvGbYHcnrcPLPvI4Z1yP9oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987333; c=relaxed/simple;
	bh=WEQYx7bcANEp6s1mQsv/tAU1eGF/YmHaIN40QsenZ2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UohiCyZhJY4CEVa9oE7m8KjoHkMYPxG85l5dqjZ6zfGTZT+RPwq7dKVmk6zFSNL5CL/cOxuPRySzQn9MKoHUQ+7eZXiEjB1fg2iWDDFS3SSdxM7xyK4a0HepvJGn9Vin/sTJhdlevo5YmVz+OGmlvk3kw9KPK7J1eAuZF5PckP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dsad5MWq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B63EC2BCB4;
	Tue,  5 May 2026 13:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777987332;
	bh=WEQYx7bcANEp6s1mQsv/tAU1eGF/YmHaIN40QsenZ2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dsad5MWqsogFvCYtlHH1Abi1OG90jcdiLYpOXCMLOOeazzPFc/KKpPnjI8fAlzGjL
	 ozLQUfEWeMPxoeV4TjLZqwbUxC3zOvYILssfh5C8mQ44Yxjx4RHg5ptGlbc09BeCOQ
	 bmQkP77njSWxRp+n/rsZruoh1pzvLVY6nwglcAorNVTZpOTgl0wpux19x/CRf4aWGY
	 //FjHiAPlwfw3sSO97hLftqel4KgU8KV1sRWYNSbeEjww4sYxhMeCKx7x6unM1kctX
	 UofRe//cGg3ir0Z+GeqjDnBUcktlj/Uf9VmDfDEvKY3nPztlKw076o6At/B9d2X4Bs
	 rn6WTmehfltgA==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: hawk@kernel.org,
	kernel-team@cloudflare.com,
	Sashiko <sashiko-bot@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Toshiaki Makita <toshiaki.makita1@gmail.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v5 1/5] veth: fix OOB txq access in veth_poll() with asymmetric queue counts
Date: Tue,  5 May 2026 15:21:53 +0200
Message-ID: <20260505132159.241305-2-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505132159.241305-1-hawk@kernel.org>
References: <20260505132159.241305-1-hawk@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AD04F4CE63E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,cloudflare.com,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-284396-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Jesper Dangaard Brouer <hawk@kernel.org>

XDP redirect into a veth device (via bpf_redirect()) calls
veth_xdp_xmit(), which enqueues frames into the peer's ptr_ring using
  smp_processor_id() % peer->real_num_rx_queues
as the ring index.  With an asymmetric veth pair where the peer has
fewer TX queues than RX queues, that index can exceed
peer->real_num_tx_queues.

veth_poll() then resolves peer_txq for the ring via:

  peer_txq = peer_dev ? netdev_get_tx_queue(peer_dev, queue_idx) : NULL;

where queue_idx = rq->xdp_rxq.queue_index.  When queue_idx exceeds
peer_dev->real_num_tx_queues this is an out-of-bounds (OOB) access
into the peer's netdev_queue array, triggering DEBUG_NET_WARN_ON_ONCE
in netdev_get_tx_queue().

The normal ndo_start_xmit path is not affected: the stack clamps
skb->queue_mapping via netdev_cap_txqueue() before invoking
ndo_start_xmit, so rxq in veth_xmit() never exceeds real_num_tx_queues.

Fix veth_poll() by clamping: only dereference peer_txq when queue_idx is
within bounds, otherwise set it to NULL.  The out-of-range rings are fed
exclusively via XDP redirect (veth_xdp_xmit), never via ndo_start_xmit
(veth_xmit), so the peer txq was never stopped and there is nothing to
wake; NULL is the correct fallback.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260502071828.616C3C19425@smtp.kernel.org/
Fixes: dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to reduce TX drops")
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 drivers/net/veth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index e35df717e65e..0cfb19b760dd 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -972,7 +972,8 @@ static int veth_poll(struct napi_struct *napi, int budget)
 
 	/* NAPI functions as RCU section */
 	peer_dev = rcu_dereference_check(priv->peer, rcu_read_lock_bh_held());
-	peer_txq = peer_dev ? netdev_get_tx_queue(peer_dev, queue_idx) : NULL;
+	peer_txq = (peer_dev && queue_idx < peer_dev->real_num_tx_queues) ?
+		   netdev_get_tx_queue(peer_dev, queue_idx) : NULL;
 
 	xdp_set_return_frame_no_direct();
 	done = veth_xdp_rcv(rq, budget, &bq, &stats);
-- 
2.43.0


