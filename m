Return-Path: <netdev+bounces-300787-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gXOcAahaNmqW+QYAu9opvQ
	(envelope-from <netdev+bounces-300787-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 11:17:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3B56A8A7D
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 11:17:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GrlpPCsE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300787-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300787-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E53D33006832
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 09:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004502BCF46;
	Sat, 20 Jun 2026 09:17:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D671A683C;
	Sat, 20 Jun 2026 09:17:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781947042; cv=none; b=lrRs9uM7eoXM1jN5ezRVUyrKW8eGoVBGTvu9BzHEGklg8eZA0WXREiPWlfA+rWy25xHUw0IWwBWbHeFahBktK78LXaoUC+BiJ3HVZWO91vaTXRDp1hzvPK1C4wxpuB8qdYgUnwyqrj1sl+ywMt7MJYytBXFgDhLl7XXoPcafUvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781947042; c=relaxed/simple;
	bh=EOCB8xo3rVILzW1qjjgMgKPftgbH7tnb6gWpGc+zsmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mluEGoyFViPVPsRfxIF7SvXwzvdYbfsN5kh/zqHZ1HJ+ORg0CTUmvoZtxar+JTvrwDmJAYc92Oee8FzYrsR5yj2mJW54eLbjStC9PLgE5tGv+hAU2xYo8mT7u22UdTliHhiSN0fJNMn6zKL2eK9/8Bs30614fH1kl4uiEYc47ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrlpPCsE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DAD01F000E9;
	Sat, 20 Jun 2026 09:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781947041;
	bh=r7geqYyv8+f3DiaKGtDrb/gnvNARRDuyFbnRUDWByfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GrlpPCsEgtzT6AnYYQu3TYDofzeGoVb42iFqvsPrT2QxvxjmnRvT+YhzbxQmNMIYz
	 +YIjQ2/ryF3LW+KenfxEdgZQ/lxoRCAGma3dsjNqL9f8w/mWx5eePOkol1tn5OgRwI
	 3uht1LnWe0dcoEssKkyfdwCHn0SDXZLCRslQikjy4/+h7RwQsB6BggBluik1icLmZl
	 nP3Xupi56R7/VDpgREXMekORDnby9Ytp9jtfjv0+jxlkBLo9JCYEx9xdzTsfGZRwq9
	 MEcdPVlSKqsGGsHmO7IqtUNGy/Wwg+VHzxteJa+oqlI/5Dkprc35JUYB1IN4FnJGVx
	 eDF1M8MbvlIRg==
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
Subject: Re: [PATCH net v2 05/10] afs: Fix uncancelled rxrpc OOB message handler
Date: Sat, 20 Jun 2026 10:13:46 +0100
Message-ID: <20260620091345.967317-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618134802.2477777-6-dhowells@redhat.com>
References: <20260618134802.2477777-6-dhowells@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300787-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD3B56A8A7D

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
afs: Fix uncancelled rxrpc OOB message handler

This patch modifies AFS to cancel its OOB message processing during
shutdown. It moves OOB message processing to afs_wq and adds checks
for the net namespace's live state to prevent processing when no
longer live.

Link: https://sashiko.dev/#/patchset/20260609140911.838677-1-dhowells%40redhat.com

> diff --git a/fs/afs/cm_security.c b/fs/afs/cm_security.c
> index edcbd249d2024..103168c70dd4d 100644
> --- a/fs/afs/cm_security.c
> +++ b/fs/afs/cm_security.c

[ ... ]

> @@ -101,7 +101,8 @@ void afs_process_oob_queue(struct work_struct *work)
>  	struct sk_buff *oob;
>  	enum rxrpc_oob_type type;
>  
> -	while ((oob = rxrpc_kernel_dequeue_oob(net->socket, &type))) {
> +	while (READ_ONCE(net->live) &&
> +	       (oob = rxrpc_kernel_dequeue_oob(net->socket, &type))) {
>  		switch (type) {
>  		case RXRPC_OOB_CHALLENGE:
>  			afs_respond_to_challenge(oob);

[Severity: Critical]
This isn't a bug introduced by this patch, but can afs_respond_to_challenge()
cause a null pointer dereference or use-after-free here?

When afs_respond_to_challenge() queries peer_data and casts it to an
afs_server pointer, it unconditionally dereferences it and locks its mutex:

fs/afs/cm_security.c:afs_respond_to_challenge() {
    ...
    server = (struct afs_server *)peer_data;
    if (!server->cm_rxgk_appdata.data) {
        mutex_lock(&server->cm_token_lock);
    ...
}

If a challenge is received for an unknown peer, or if afs_server_destroyer()
concurrently clears the peer app_data to null during teardown, could 
peer_data be null?

If the pointer was read just before being cleared, could the server object
be freed concurrently since no RCU read lock or refcount is held?

> diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
> index 6714a189d58fb..e8af2a6614405 100644
> --- a/fs/afs/rxrpc.c
> +++ b/fs/afs/rxrpc.c

[ ... ]

> @@ -989,5 +991,6 @@ static void afs_rx_notify_oob(struct sock *sk, struct sk_buff *oob)
>  {
>  	struct afs_net *net = sk->sk_user_data;
>  
> -	schedule_work(&net->rx_oob_work);
> +	if (net->live)
> +		queue_work(afs_wq, &net->rx_oob_work);
>  }

[Severity: Medium]
Should net->live be read with READ_ONCE() here?

Since net->live can be modified concurrently by namespace teardown code
such as afs_close_socket() or afs_net_exit(), reading it without READ_ONCE()
might allow the compiler to optimize the read, leading to a stale evaluation.

The updated afs_process_oob_queue() function correctly uses READ_ONCE().
Should afs_rx_notify_oob() do the same to prevent data races?

[Severity: High]
This isn't a bug introduced by this patch, but there appears to be a similar
issue in fs/afs/server.c when retrieving the server pointer.

Can afs_find_server() increment the refcount of a freed object?

afs_find_server() fetches the pointer and increments its refcount:

fs/afs/server.c:afs_find_server() {
    ...
    struct afs_server *server = (struct afs_server *)rxrpc_kernel_get_peer_data(peer);
    
    if (!server)
        return NULL;
    return afs_use_server(server, false, afs_server_trace_use_cm_call);
    ...
}

If afs_server_destroyer() runs concurrently, unbinds the peer, and frees
the server, could afs_find_server() fetch the pointer just before it is
cleared?

If preempted, it seems this operation lacks RCU read lock protection and
could increment the refcount of a freed object without using
refcount_inc_not_zero().

