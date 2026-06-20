Return-Path: <netdev+bounces-300788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WboRMLFaNmqd+QYAu9opvQ
	(envelope-from <netdev+bounces-300788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 11:17:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECF76A8A81
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 11:17:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PEW1qCez;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300788-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300788-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC11F30078B3
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 09:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B3F2F8EAF;
	Sat, 20 Jun 2026 09:17:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3382BCF46;
	Sat, 20 Jun 2026 09:17:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781947055; cv=none; b=QX2F0ihng+gIhQJiNar/HCp97RIUYeCXu5eKYeNm/5T9UczofF3Vj7vXIt9z1LE9dawtkeGCjznrztzk46Ak0kom0F21eHrhyx+7Jt3AE3Niw9iRhlZHTr1TTENeJM74yJk3NOBI9MGmZUOxJBd1vhKNDdWeyymQclhR8N3/4lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781947055; c=relaxed/simple;
	bh=KWmsyD/X3k/8rcKVI53WRBWIl6lXavblj3hdYUQXJkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTviMQ5zzyhdsUEy+sKmEXkWbVb0iTuRMEel0xsmvhkxdGGjSbu+vO6yz0rrsh68IJv9TCEEo1BJYTHxW2qqtNNPljW8u6sA+rY2wwjGFFkgvkyARzBCRA/2vFA4jtL00CC+O4Fsg0SDrIZEFSeetUhhLwVc8//ORBsseEyY/x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEW1qCez; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FAF1F000E9;
	Sat, 20 Jun 2026 09:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781947054;
	bh=52UGiw0pljVUCEtt+4CfSQ3Di7O6dhazHYVYTOXCYEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PEW1qCezRQmYJa99Do6+YMKwD9JkU3+OD53HC6MGsUGQG5eHFpkei0JbZCi1Yt6NC
	 DljpsxfMw6pHkAGAOej1UZEnScxvVWObSg1OQCPa2dMFv3MVbY6LHw9n0A/fx1W1jf
	 37ac5M/PcjJE/D5PBye443EX5B7+Kh9U3ogPY7ffTSOgw+2Eydx3AEyNmhJN4g1qOu
	 oqEZgAjJDeHCAWLeAnTHoVaemtk0TApwT4PgI73LwP8h6v9rJdrTNf6E8JFd0lUgJB
	 izjDbxN0et13m+Dvknqd+9xspEUuJe2ZED1pAostjE+1barOxchHcelLsq92FTxf0q
	 7eQ3T4JGLQoAA==
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
Subject: Re: [PATCH net v2 06/10] rxrpc: Fix the reception of a reply packet before data transmission
Date: Sat, 20 Jun 2026 10:17:27 +0100
Message-ID: <20260620091727.969517-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618134802.2477777-7-dhowells@redhat.com>
References: <20260618134802.2477777-7-dhowells@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300788-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5ECF76A8A81

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
rxrpc: Fix the reception of a reply packet before data transmission

This commit fixes rxrpc_receiving_reply() to handle the reception of an
apparent reply DATA packet before rxrpc has had a chance to send any request
DATA packets. It also adjusts rxrpc_rotate_tx_window() to handle an empty
Tx queue by changing the do...while loop into a while loop.

Link: https://sashiko.dev/#/patchset/20260616155749.2125907-1-dhowells%40redhat.com

> diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
> index 37881dffa898b..01ccd2d2fe92c 100644
> --- a/net/rxrpc/input.c
> +++ b/net/rxrpc/input.c
> @@ -247,7 +247,7 @@ static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
>  		tq = call->tx_queue;
>  	}
>  
> -	do {
> +	while (before_eq(seq, to)) {

[Severity: Critical]
This is a pre-existing issue, but can this trigger a use-after-free write
during a concurrent sendmsg() if the remote peer sends an early reply?

Right before this loop in rxrpc_rotate_tx_window(), the code unconditionally
frees the active transmission queue buffer:

	if (seq == call->tx_qbase + RXRPC_NR_TXQUEUE) {
		call->tx_qbase += RXRPC_NR_TXQUEUE;
		call->tx_queue = tq->next;
		...
		kfree(tq);
		tq = call->tx_queue;
	}

If a full block of 63 packets is transmitted and ACKed, call->tx_bottom
reaches 63. If the remote peer then sends an early reply,
rxrpc_receiving_reply() calls rxrpc_rotate_tx_window() with to = 63 and seq
starting at 64.

This triggers the condition above and frees the active block (tq) without
verifying if it is still being written to. If it is still the tail
(tq == call->tx_qtail), call->send_queue and call->tx_qtail are left as
dangling pointers.

Concurrently, if the client is still sending data via sendmsg(), it might call
rxrpc_alloc_txqueue() for the 64th packet:

net/rxrpc/sendmsg.c:rxrpc_alloc_txqueue() {
	...
	if (call->send_queue) {
		tq->qbase = call->send_top + 1;
		call->send_queue->next = tq;
		call->send_queue = tq;
	}
	...
}

Will call->send_queue->next = tq write a newly allocated pointer into the
recently freed memory block?

[ ... ]

