Return-Path: <netdev+bounces-300379-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YuoIELG7M2pkFgYAu9opvQ
	(envelope-from <netdev+bounces-300379-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 11:34:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E07769EE88
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 11:34:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Y9MV890t;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300379-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300379-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00189300360F
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 09:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8929D3C414F;
	Thu, 18 Jun 2026 09:29:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCD03B71DD;
	Thu, 18 Jun 2026 09:29:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781774995; cv=none; b=PjCXDIGyTNuzaTu/2k1vUPShJHlUMlbqkuKIaBzwgauqHM47/RK86/6/tMSxTKRmoCzXTMSRm3nn1Fde7df2ZUsqxsgx6sfLxfOmfEflo8N6+oZBOMJKY9+OvuWLcfLQJN43yi5Zche52/PfeQLGKUxnxFNizCRCLHAWfVzqP9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781774995; c=relaxed/simple;
	bh=ilR+EZ8AS65fpi/jJMtHjhvLmFr7HFjqHwCTNIp6Xsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VrCnWHGszPWirYFwVgbNGl53j10t6SU3s4qoe2IfLtSFGTB8vVZImXCHucDl5JMEL+xwE81tQc8zXIfz7p44a3v0GyrHNZT88qR+8XjgsAvbRD7Sy5JalmjKynQ3GPOqIfhCZ2Ui+lyGTWwMsSvopKKWIgsIqDqq3d4oxrXzMQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9MV890t; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF761F000E9;
	Thu, 18 Jun 2026 09:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781774994;
	bh=xY3E02itJZ/3guyWQm3b0qgZmBwdEEtON2CPCiTjekI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y9MV890t52WmmXty1o236vJxVmhjV9mdo++QRAv+YS0h3xqI9wqrIMDpzLag4MaHO
	 O0J3xGqyy23YnmUAiAvaJ7d2RVzXPe7IOTwXevMsssLf2uYop+2kaWO1L18dxwg2aA
	 kHuvFS21Hq0uIz5GkkCVbe7ceny979gXr6doloOxJZU16kFHvdKJf9yrYAt2+JZFMj
	 ETfbiAlVmBZjWwz4/ZNcvomosa6iCEZdBRrOAO2M3oUuXjF3Xz/oVsA4Zv8zZSupEj
	 +ux9gSl61nInkSuSj0F3PgrXP7PcWuHb2eHN368+xzr5Z9AEAy0a9XcwQVDZqQxNC4
	 DFruqbVxpFrew==
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
	d4n.for.sec@gmail.com,
	n05ec@lzu.edu.cn,
	jaltman@auristor.com,
	stable@kernel.org
Subject: Re: [PATCH net 5/5] afs: Fix uncancelled rxrpc OOB message handler
Date: Thu, 18 Jun 2026 10:29:29 +0100
Message-ID: <20260618092929.888053-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616155749.2125907-6-dhowells@redhat.com>
References: <20260616155749.2125907-6-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300379-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dhowells@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:marc.dionne@auristor.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-afs@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:d4n.for.sec@gmail.com,m:n05ec@lzu.edu.cn,m:jaltman@auristor.com,m:stable@kernel.org,m:d4nforsec@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,auristor.com,davemloft.net,google.com,redhat.com,lists.infradead.org,gmail.com,lzu.edu.cn];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E07769EE88

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
afs: Fix uncancelled rxrpc OOB message handler

This commit cancels AFS OOB message processing during shutdown and moves it
to afs_wq. It also prevents queuing if the net namespace is no longer live.

Link: https://sashiko.dev/#/patchset/20260609140911.838677-1-dhowells%40redhat.com

> diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
> index fd2d260fb25f9..6241f9349f6b6 100644
> --- a/fs/afs/rxrpc.c
> +++ b/fs/afs/rxrpc.c
[ ... ]
> @@ -128,6 +128,7 @@ void afs_close_socket(struct afs_net *net)
>  	_enter("");
>  
>  	cancel_work_sync(&net->charge_preallocation_work);
> +	cancel_work_sync(&net->rx_oob_work);
>  	kernel_listen(net->socket, 0);
>  	flush_workqueue(afs_async_calls);
>  	flush_workqueue(afs_wq);

[Severity: High]
This is a pre-existing issue, but does placing the cancellation and flush
before kernel_sock_shutdown() leave a window open for the work to be queued
afterwards?

If kernel_sock_shutdown() is what synchronously disables the notify_oob
callback from firing, couldn't a delayed callback still queue work on afs_wq
after we've already flushed it here?

[ ... ]
> @@ -985,5 +986,6 @@ static void afs_rx_notify_oob(struct sock *sk, struct sk_buff *oob)
>  {
>  	struct afs_net *net = sk->sk_user_data;
>  
> -	schedule_work(&net->rx_oob_work);
> +	if (net->live)
> +		queue_work(afs_wq, &net->rx_oob_work);
>  }

[Severity: High]
This is a pre-existing issue, but does this lockless check of net->live allow
a race condition that leads to a use-after-free?

Consider this sequence:

CPU1 (teardown)
afs_net_exit()
    net->live = false;
    afs_close_socket()
        cancel_work_sync(&net->rx_oob_work);
        flush_workqueue(afs_wq);
        kernel_sock_shutdown()  // blocks waiting for recvmsg_lock

CPU2 (incoming OOB)
rxrpc_notify_socket_oob()
    spin_lock_irq(&rx->recvmsg_lock);
    afs_rx_notify_oob()
        // Reads net->live == true (stale read, or delayed execution)
        queue_work(afs_wq, &net->rx_oob_work);
    spin_unlock_irq(&rx->recvmsg_lock);

CPU1 then finishes kernel_sock_shutdown() and frees the net namespace, but
afs_wq is never flushed again.

Would moving cancel_work_sync() and flush_workqueue() to the end of
afs_close_socket(), after kernel_sock_shutdown() completes, prevent this race?

