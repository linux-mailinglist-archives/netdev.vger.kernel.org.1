Return-Path: <netdev+bounces-300378-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H5Z9KIu7M2pgFgYAu9opvQ
	(envelope-from <netdev+bounces-300378-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 11:34:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF39B69EE76
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 11:34:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=R+BfFysw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300378-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300378-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78D7730B7F70
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 09:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723493C6A2B;
	Thu, 18 Jun 2026 09:29:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C8E3C0A0F;
	Thu, 18 Jun 2026 09:29:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781774958; cv=none; b=DKdhZECIkcztE2ucZR1fYIZdahFmMp+yDFZ5+xKBFrHNiNj61uJ9Ft6PAUE+on4cO4BbjUyLJYPlo+pQcKE/eUFBsewnO4JPnjn9BNPF5zGwgJZqo/g8eDnCkey7gK0BWWetqw9GbQJE2qv0cqe4P6QfhMVWr6J6HlB19FlyZPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781774958; c=relaxed/simple;
	bh=c8gqHcV+x26aMaGy/roPIbZdgkOvaUiZUVWoVDqRuCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iz7M+lNLEcIOtQENaAeYT8ePbAlVUUMN617u/TeLn+3kd9eCgwPKxanXztcNe/rFhnT7IVnt7cTXw37AqCwg1LlXU9m1G5YaVsLO2HkzdE6NaT4vErHl/3J4504WduzUBtgbV6hDw82Y4bVhQrEPUimy7bbBsww1CGm0sz1lVMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+BfFysw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0361F000E9;
	Thu, 18 Jun 2026 09:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781774957;
	bh=sI3OajoS+qnU1/n61HNxOgvTgUraUb6h6oeRCaIbYvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R+BfFysw6R7tgdFX7oD/+7LLjas0ow78Vi3GyCt97EKj5SRxHZDh4JaY8LADC/OhU
	 rzv9ueUHr9Upyhfdw8pVT12mxW+Gx8EIpaxxMdJOZWA7Fts/8ngNofpgpKLelIEXOh
	 NVxpfpCv5T1wmWTdIEVqWNvtuAyCc08aeyRHUfcZ5Z3AUud5iQtMXWRp2CF93bddeR
	 6j+IV4b9OD7tMg0ZWvsq9P0INH8zebWz3S8FrW4v8SR5wzwoUZik6hQIK5XmYAToxX
	 2qAHF3yCk4cTEApzOzDH2Fite5IHup48KCU5nkeVH1hzpUvZerv5qESfaUIzJ4lgWV
	 ZvksFKUBqHxKA==
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
Subject: Re: [PATCH net 4/5] afs: Fix further netns teardown to cancel the preallocation charger
Date: Thu, 18 Jun 2026 10:29:09 +0100
Message-ID: <20260618092909.888006-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616155749.2125907-5-dhowells@redhat.com>
References: <20260616155749.2125907-5-dhowells@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300378-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF39B69EE76

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
afs: Fix further netns teardown to cancel the preallocation charger

This commit modifies the afs network namespace teardown process to wait for
the preallocation charger work item. It addresses a small window where the
work item could be requeued after being cancelled by flushing the workqueue
on which the charger runs.

Link: https://sashiko.dev/#/patchset/20260609140911.838677-1-dhowells%40redhat.com

> diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
> --- a/fs/afs/rxrpc.c
> +++ b/fs/afs/rxrpc.c
> @@ -130,6 +130,7 @@ void afs_close_socket(struct afs_net *net)
>  	cancel_work_sync(&net->charge_preallocation_work);
>  	kernel_listen(net->socket, 0);
>  	flush_workqueue(afs_async_calls);
> +	flush_workqueue(afs_wq);

[Severity: High]
Will flushing the system-wide global workqueue here cause cross-namespace
stalls during teardown?

It appears afs_wq is allocated once in afs_init() as a system-wide workqueue
shared by all AFS network namespaces:

fs/afs/main.c:afs_init() {
    ...
    afs_wq = alloc_workqueue("afs", WQ_PERCPU, 0);
    ...
}

Other namespaces use afs_wq for operations like cell management, which can
block for tens of seconds waiting for userspace DNS lookups via the
request_key mechanism.

Since afs_close_socket() runs in the context of the global cleanup_net
worker thread, does this stall the destruction of all network namespaces
system-wide until unrelated AFS work across the entire system finishes?

Would it be safer to explicitly call
cancel_work_sync(&net->charge_preallocation_work) a second time here instead
of flushing the shared queue?

