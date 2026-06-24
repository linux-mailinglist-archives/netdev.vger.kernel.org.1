Return-Path: <netdev+bounces-301591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kHymCKSkO2oIawgAu9opvQ
	(envelope-from <netdev+bounces-301591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:34:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F5B6BCFAA
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:34:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=casper.20170209 header.b="t8/Yy0mI";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301591-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301591-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E91830465E1
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7C43ACEF0;
	Wed, 24 Jun 2026 09:31:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2BC3AB47A;
	Wed, 24 Jun 2026 09:31:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293502; cv=none; b=YL3j3bCcskjRPH2W1xjYboZur9TR0kGHnKKKtcOph3odW7I3tpDu9v3fEyVBVEa+JiEhxONSQ3JCt+N9boQK7o6i/ndAXpJLvaOHFkaUJgOlvxkfeJAqfSMyza4hqUDSdvpkkABXfQK+Ff820+fSwgKZWKKDy/d1kNHxiaiZKBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293502; c=relaxed/simple;
	bh=LXAhiv9uMDR5KZUpJYWfBKgBStf79Ym8y8D0o9y6Ig8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1N1RqIrFi8RM8Tq69pN4Og079HQTNDdQAP5CvGBx/NBQ77/1OfRJ2o3pSA0cIji0BhxU9gm6f0oH9DvkxUIIjYFvraTIfvDPzaWbrlDw7U9vUXxUHNsj88X2DlD9pd76zd6J7Hh2901C3Xmeizl3mPBxZNGAz6AytbsQXkhSuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t8/Yy0mI; arc=none smtp.client-ip=90.155.50.34
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kLqXXZs9onJoXzsYuF3jxG2RendiUVx/zExDnofxiR0=; b=t8/Yy0mI0pa8bagHbsK7o/+V4K
	9o3VIlIjZlPUrAjdJiOc8cJB1e/HL7DhchwIC5Nyjh3Bbtl24eyuCEoQqpRgtzvWY1Qjb/aW9+2DJ
	gjUuGXSv45P9/gGZJn0dl70H2Hyo8TUrz6RMjKU04grFArQ6aGa2Cdv1DXyAV9aLHfPyNACxy4KiM
	af3QQfMClBHSnMbSKdFGZlJO+zpNenFGMW+Tf0/r37nV5jNPocnNz4H6j9dtFc5WLjPwwL4Y6LPNy
	SDVHqcKB8vA0I/ktct48yI5ggDmjYOhbXxHKNPPlfmRoHBacOd8Ni1gntuz4i4CiBBfFZFqSnQJoz
	kU8O9/QA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcJwz-00000007mkC-3b66;
	Wed, 24 Jun 2026 09:31:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 67AB7300400; Wed, 24 Jun 2026 11:31:17 +0200 (CEST)
Date: Wed, 24 Jun 2026 11:31:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Andrea Righi <arighi@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Ben Segall <bsegall@google.com>,
	Breno Leitao <leitao@debian.org>,
	Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Eric Dumazet <edumazet@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Paolo Abeni <pabeni@redhat.com>, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vlad Poenaru <vlad.wing@gmail.com>
Subject: Re: [PATCH 1/2] bug: Provide WARN_ON.*DEFERRED() macros for console
 deferred output
Message-ID: <20260624093117.GY48970@noisy.programming.kicks-ass.net>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301591-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bigeasy@linutronix.de,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sched-ext@lists.linux.dev,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:arighi@nvidia.com,m:akpm@linux-foundation.org,m:arnd@arndb.de,m:bsegall@google.com,m:leitao@debian.org,m:changwoo@igalia.com,m:void@manifault.com,m:dietmar.eggemann@arm.com,m:edumazet@google.com,m:mingo@redhat.com,m:kuba@kernel.org,m:john.ogness@linutronix.de,m:juri.lelli@redhat.com,m:kprateek.nayak@amd.com,m:pabeni@redhat.com,m:pmladek@suse.com,m:senozhatsky@chromium.org,m:horms@kernel.org,m:rostedt@goodmis.org,m:tj@kernel.org,m:vincent.guittot@linaro.org,m:vlad.wing@gmail.com,m:vladwing@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[peterz@infradead.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,davemloft.net,nvidia.com,linux-foundation.org,arndb.de,google.com,debian.org,igalia.com,manifault.com,arm.com,redhat.com,kernel.org,linutronix.de,amd.com,suse.com,chromium.org,goodmis.org,linaro.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 81F5B6BCFAA

On Tue, Jun 23, 2026 at 04:26:49PM +0200, Sebastian Andrzej Siewior wrote:

> +#ifndef WARN_ON_DEFERRED
> +#define WARN_ON_DEFERRED(condition) ({					\
> +	int __ret_warn_on = !!(condition);				\
> +	if (unlikely(__ret_warn_on)) {					\
> +		guard(preempt)();					\
> +		printk_deferred_enter()					\
> +		__WARN();						\
> +		printk_deferred_exit()					\
> +	}								\
> +	unlikely(__ret_warn_on);					\
> +})
> +#endif

This will generate atrocious shite at the WARN sites.

