Return-Path: <netdev+bounces-300789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZHYpBg1bNmrT+QYAu9opvQ
	(envelope-from <netdev+bounces-300789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 11:19:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED166A8A90
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 11:19:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dNuUYd3g;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300789-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300789-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ADC8302C92B
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 09:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128A33290DB;
	Sat, 20 Jun 2026 09:17:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBC53254B3;
	Sat, 20 Jun 2026 09:17:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781947066; cv=none; b=h4oGOViX2bygznpcRG6aMgaodvwZ+b2v/LyKdF9TFrGqD3h98ZEcN5tYYb5DStfiqP0DbZ5cAn62hxHyG5evatqTatQFuNnjTJK1wRuAiz7WdpdCrEdMEZtCDL/Dzc7AEg4hEbVLMXjgc9e9LvCKS0S+gV2MgWGGgq6v3VktoKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781947066; c=relaxed/simple;
	bh=fmO8Ugc0iyRTqFF+QGxReyHbIuFrpxhwdeElNAvrNMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUkXe8r/38cMxjxgEz9GQaP2uAcCqeTNxu5NVJ+HHEuN/MHmIBgmSgks9RO74XXlhMbIBE6tqHxRV6Hk+uiNQxSNrJ10VpaCsjTxa1MnFMHEK+8g+l1GaGZDNd5p0QsVzb/LznBbHIb5TX+KDe7wqinESh8S52eGne2nFuBw1/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNuUYd3g; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FDD1F000E9;
	Sat, 20 Jun 2026 09:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781947064;
	bh=3xX7OeBDIxD1X+S1oMgTF+KFAvOFKQhqFQZzenqeR+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dNuUYd3gYdhor2atPFx2bYBEV2qd4NcFITf9P/2v+Hzy9zTsbtm+OafL20kmvN3pV
	 uiXI8J40DTIOLvylA2FLVJ0uR1Molh1Eqiu9Fy83DDVTZ3ccnQani5Qht4xjFRVuUh
	 7J6OrjMEs0eqUSdDrg6Z6mVqvajIAJV9F5HMIDVrbCDTUxJDRcLhMD+RQqPLI9IYUR
	 jOQWFUNKFT+9I7ov92rEii4Ywub0g45y7yaHPOjwDiEwzAeHrPOqo52aH4eE14Ch/j
	 GS5qE5qC7wluHKKZMQb0siG4bnJqce3IGAXGapIZwQ5HeOmsvN8EczLa/dqSuALWO0
	 +rPd+ZMPs5bxQ==
From: Simon Horman <horms@kernel.org>
To: dhowells@redhat.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	marc.dionne@auristor.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jaltman@auristor.com,
	stable@kernel.org
Subject: Re: [PATCH net v2 07/10] rxrpc: Fix oob challenge leak in cleanup after notification failure
Date: Sat, 20 Jun 2026 10:17:39 +0100
Message-ID: <20260620091739.969563-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618134802.2477777-8-dhowells@redhat.com>
References: <20260618134802.2477777-8-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300789-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dhowells@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:marc.dionne@auristor.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-afs@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:jaltman@auristor.com,m:stable@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5ED166A8A90

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
rxrpc: Fix oob challenge leak in cleanup after notification failure

Fix rxrpc_notify_socket_oob() to return an indication of failure in the
event that it failed to queue a packet and fix rxrpc_post_challenge() to
clean up the connection ref in such an event.

Link: https://sashiko.dev/#/patchset/20260616155749.2125907-1-dhowells%40redhat.com

> diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
> index c96ca615b787c..611c790bc6d0c 100644
> --- a/net/rxrpc/conn_event.c
> +++ b/net/rxrpc/conn_event.c
> @@ -436,7 +436,7 @@ static bool rxrpc_post_challenge(struct rxrpc_connection *conn,
>  	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
>  	struct rxrpc_call *call = NULL;
>  	struct rxrpc_sock *rx;
> -	bool respond = false;
> +	bool respond = false, queued = false;

[Severity: Critical]
This is a pre-existing issue, but can the lockless read of
conn->channels[i].call in net/rxrpc/conn_event.c lead to a NULL pointer
dereference?

Looking at rxrpc_post_challenge(), the code does:

    if (conn->channels[i].call) {
        call = conn->channels[i].call;
        rx = rcu_dereference(call->socket);

Without READ_ONCE(), the compiler could issue two separate loads. If a
concurrent thread clears the channel's call pointer after the if-check but
before the assignment, call becomes NULL.

Does this cause the subsequent rcu_dereference(call->socket) to panic by
dereferencing NULL->socket?

[Severity: High]
This isn't a bug introduced by this patch, but does taking a connection
reference here in rxrpc_post_challenge() lead to a leak if the packet is
later discarded due to connection abort or teardown?

If rxrpc_process_event() in net/rxrpc/conn_event.c encounters 
conn->state == RXRPC_CONN_ABORTED, it returns -ECONNABORTED early:

    if (conn->state == RXRPC_CONN_ABORTED)
        return -ECONNABORTED;

This bypasses the cleanup, and the skb is consumed by
rxrpc_do_process_connection() without dropping the sp->chall.conn reference.

Similarly, during teardown, rxrpc_purge_queue() in net/rxrpc/skbuff.c
consumes skbs via:

    while ((skb = skb_dequeue((list))) != NULL) {
        ...
        consume_skb(skb);
    }

Since it doesn't inspect the cb scratch space, doesn't this permanently leak
the connection references stored in sp->chall.conn?

[ ... ]

>  	if (call)
> -		rxrpc_notify_socket_oob(call, skb);
> +		queued = rxrpc_notify_socket_oob(call, skb);

[Severity: High]
This is a pre-existing issue, but does failing to set skb->mark to
RXRPC_OOB_CHALLENGE here in rxrpc_post_challenge() break OOB challenge
processing?

The skb->mark remains RXRPC_SKB_MARK_PACKET as set during ingress.
When the application attempts to respond via rxrpc_respond_to_oob() or read
via rxrpc_recvmsg_oob(), won't the operation fail with -EPROTO because it
expects skb->mark == RXRPC_OOB_CHALLENGE?

Additionally, when the OOB message is freed via rxrpc_kernel_free_oob(),
doesn't the switch statement on oob->mark fail to match, bypassing
rxrpc_put_connection() and leaking the connection reference stored in
sp->chall.conn?

>  	rcu_read_unlock();
> +	if (call && !queued) {
> +		rxrpc_put_connection(conn, rxrpc_conn_put_challenge_input);
> +		sp->chall.conn = NULL;
> +		return false;
> +	}
>  
>  	if (!call)
>  		rxrpc_post_packet_to_conn(conn, skb);
> diff --git a/net/rxrpc/oob.c b/net/rxrpc/oob.c
> index 3318c8bd82ad5..c80ee2487d094 100644
> --- a/net/rxrpc/oob.c
> +++ b/net/rxrpc/oob.c

[ ... ]

> @@ -49,6 +50,7 @@ void rxrpc_notify_socket_oob(struct rxrpc_call *call, struct sk_buff *skb)
>  			skb->skb_mstamp_ns = rx->oob_id_counter++;
>  			rxrpc_get_skb(skb, rxrpc_skb_get_post_oob);
>  			skb_queue_tail(&rx->recvmsg_oobq, skb);
> +			queued = true;

[Severity: High]
This isn't a bug introduced by this patch, but does unbounded queuing of
challenge packets onto recvmsg_oobq risk a kernel OOM?

In net/rxrpc/oob.c, rxrpc_notify_socket_oob() uses skb_queue_tail() without
checking memory limits (like sk_rmem_alloc vs sk_rcvbuf) or restricting the
total number of challenges.

Since rxrpc_encap_rcv() intercepts these packets before standard UDP memory
accounting occurs, could a remote attacker flood the host with valid
CHALLENGE packets?

If the application is slow to process them or ignores them, will these
accumulate infinitely in recvmsg_oobq and cause a Denial of Service?

