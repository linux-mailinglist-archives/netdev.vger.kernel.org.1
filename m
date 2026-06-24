Return-Path: <netdev+bounces-301567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bL3BIXGXO2puaAgAu9opvQ
	(envelope-from <netdev+bounces-301567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 10:38:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D71EE6BC9B1
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 10:38:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=UwPcbFdW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301567-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301567-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9493F3033FB0
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 08:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E997438CFE5;
	Wed, 24 Jun 2026 08:38:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F5E35E948;
	Wed, 24 Jun 2026 08:38:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782290286; cv=none; b=NYZy2sqk6TMar/VpCYjWQyB35pv++UvNlc0FWhkChZcW3nHC2YGWAzBvDNciIEFaexKOnECkg5kU1UiZB+bR5kTstkGHanopDM0RlbR/eQjC1Tj2jTLoAKTI01pvuKdpF4rKR+McYVjQSwzZgD//w4gKvzo4JhyMZclrF4te5kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782290286; c=relaxed/simple;
	bh=KlM5yogVMhIXTv+B3rV0s7TuRhXvoT81UdkAG2ASrzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAwfYlySpEQ0TpGvq+JClov++uuekHMyswZ9TzKZsepQ1kgQq4d0xNUqsWCr7JG0XxOXBHSl6RonIsgCE+KlFx0sAjZaAShfUjoiURfLVA3wPYzvpJpIyR5OF9JO2X/munfy6MSFBPl04osfCrPdtWKx21/AJcNRsJxn2IUBkic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=UwPcbFdW; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aEazna9X9qXpRzWUlsf1N0DIi34mvX0sBoa5oim2SL4=; b=UwPcbFdWw498Vk6i1aHeTOp78O
	IFwUzE97Rev1Sjs4dOSsIKF7VwbpQZNQHveEg+t2ph4+H1jJxPBHYsHFUVKBE5CnMdWxEbNXrP0p5
	VBa8Wfia5HdW+As3B8iu3bg/R/nshH/ajlkOgnn3ihH7XNVh5Xponnfi7PBZfka9Fy5TnZohGkeda
	44e29NoXXNW3jmeEJ/Wb7Jq5y8eTLlEUMf5rOYZF3mwbQHy96n3+XrnLQrJgwWkYlxp0W9baUkzXd
	JYUEl7UZ7KrMuCdrRbrNx1H3ufOBa3MuPMAP8ep2q1yp3PpdBbRjz0JlOEFk6Tl03j+bzOusmF3hG
	UHJqdgFg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wcJ7P-002IXb-2X;
	Wed, 24 Jun 2026 08:38:00 +0000
Date: Wed, 24 Jun 2026 01:37:53 -0700
From: Breno Leitao <leitao@debian.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Andrea Righi <arighi@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Ben Segall <bsegall@google.com>, 
	Changwoo Min <changwoo@igalia.com>, David Vernet <void@manifault.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Eric Dumazet <edumazet@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	John Ogness <john.ogness@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Paolo Abeni <pabeni@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Simon Horman <horms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Vlad Poenaru <vlad.wing@gmail.com>
Subject: Re: [PATCH 1/2] bug: Provide WARN_ON.*DEFERRED() macros for console
 deferred output
Message-ID: <ajuWnKsQR0Z825Wn@gmail.com>
References: <20260623142650.265721-1-bigeasy@linutronix.de>
 <20260623142650.265721-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623142650.265721-2-bigeasy@linutronix.de>
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-301567-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bigeasy@linutronix.de,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sched-ext@lists.linux.dev,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:arighi@nvidia.com,m:akpm@linux-foundation.org,m:arnd@arndb.de,m:bsegall@google.com,m:changwoo@igalia.com,m:void@manifault.com,m:dietmar.eggemann@arm.com,m:edumazet@google.com,m:mingo@redhat.com,m:kuba@kernel.org,m:john.ogness@linutronix.de,m:juri.lelli@redhat.com,m:kprateek.nayak@amd.com,m:pabeni@redhat.com,m:peterz@infradead.org,m:pmladek@suse.com,m:senozhatsky@chromium.org,m:horms@kernel.org,m:rostedt@goodmis.org,m:tj@kernel.org,m:vincent.guittot@linaro.org,m:vlad.wing@gmail.com,m:vladwing@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,davemloft.net,nvidia.com,linux-foundation.org,arndb.de,google.com,igalia.com,manifault.com,arm.com,redhat.com,kernel.org,linutronix.de,amd.com,infradead.org,suse.com,chromium.org,goodmis.org,linaro.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D71EE6BC9B1

Hello Sebastian,

First of all thanks for working on it.

On Tue, Jun 23, 2026 at 04:26:49PM +0200, Sebastian Andrzej Siewior wrote:
> Provide a deferred version of the WARN_ON() macro. It will delay
> flushing the console until a later context. It is needed in a context
> where the caller holds locks which can lead to a deadlock content is
> flushed to the console driver.
> An example would from a warning from within the scheduler resulting in a
> wake-up of a task.
> 
> Deferring the output works by using printk_deferred_enter/ exit() around
> the printing output. This must be used in a context where the task can't
> migrate to another CPU. This should be the case usually, since the
> scheduler would acquire the rq lock whith disabled interrupts, but to be
> safe preemption is disabled to guarantee this.
> 
> In order not to bloat the code on architectures which provide an
> optimized __WARN_FLAGS() define BUGFLAG_DEFERRED which is handled by
> __report_bug() and does not increase the code size.
> 
> Provide the DEFERRED macros based on __WARN_FLAGS and __WARN_FLAGS
> macros. Extend __report_bug() to handle the deferred case.

Have you considered an approach similar to printk_deferred_enter(),
where you mark the code region that needs deferral and all WARN() calls
within that region are automatically deferred?

The current proposal requires changing individual WARN() call sites,
but whether they need deferral might depend on the calling context. This
means you'd need to convert many call sites and ensure all nested
warnings are also converted to the deferred variant.


Thanks,
--breno

