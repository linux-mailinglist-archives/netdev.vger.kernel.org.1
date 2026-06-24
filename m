Return-Path: <netdev+bounces-301610-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MLHZMLCsO2qvbAgAu9opvQ
	(envelope-from <netdev+bounces-301610-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 12:08:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6107F6BD37C
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 12:08:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=Ie+Gx05T;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=ObC5D9bb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301610-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301610-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C8BC2300B1B9
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 10:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8274D3B840E;
	Wed, 24 Jun 2026 10:08:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9013B71C6;
	Wed, 24 Jun 2026 10:08:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782295726; cv=none; b=RMsRIH0oUbty6/bTyrP3BblKQWjhVn96yd6ejaqHppnb1JgUlPUQBiUmumqltzQ01zmDczhpFDtd6B9vQZalwWf1qPO+4g2iDYsGeYLPmkeWW+MlDosI2FGRylxvUnnngFcFPjNQ361VGCaBmA//venLUnY9N7/DCvO+ZMrnbu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782295726; c=relaxed/simple;
	bh=Zgq0HceP4qnVEiXOOc7bhS8RStlam2Jmor0wsOciRiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZwf3vGEcCxMNjkrUhPm5A0pDw+vtyPn0sGVVtBq77MOoGOUa6+2ZYa6u6YYy/jsm3ZRXtTX9evWaKBvULd8/1OmOnDCiqwaj8N3RivLBoypbgFYXPoiL1jkaG8XNm6tyRPxSG3QLJKyx9DxCxX26uCIbSZYSm33wfEk8MXNEBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ie+Gx05T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ObC5D9bb; arc=none smtp.client-ip=193.142.43.55
Date: Wed, 24 Jun 2026 12:08:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782295722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xn0h6VOL/cdoKYPxSepbduPQBw6kBDF1WxhF/z0UW7Y=;
	b=Ie+Gx05T8M23x7bJzrMK2MWptU0vHip0oyTQvuPFUgWsDKpCmZksVEcVfnxxA6d/PQLScl
	rI45s4KZMsDfMRY8ysL3w9fRA/NtG7VK+g6I1xz3/gMLJttFFL2WFnXXUV8/YJTe8thBQY
	Qf5y4rRLeauo/kJaUBrjHulczdTlHum1Pjyu9d1ikel9LA9G9pqns+8gi5gfkDw/0fPW+p
	HAOBcDvlaw0j/brtNJ/63ueQ4HHzgcBIY7sztfCfVmK/HMSmgbrSONvH5mf4267F9Vl+Jv
	ZtKzYWIAQK8vuJRTynGfqP/W/wIX2uqXhNg13ZzoUKWh2zio38ymGp9tbDVb0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782295722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xn0h6VOL/cdoKYPxSepbduPQBw6kBDF1WxhF/z0UW7Y=;
	b=ObC5D9bbUWMoq2zqZJkHwNc6RZ8DTjjcUpKSr3VjK2xHvs0BzkFlm3YAJYg/fJF7Ba6atC
	0iZH/dKSumbrHwDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20260624100839.XS5R23mk@linutronix.de>
References: <20260623142650.265721-1-bigeasy@linutronix.de>
 <20260623142650.265721-2-bigeasy@linutronix.de>
 <20260624093117.GY48970@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260624093117.GY48970@noisy.programming.kicks-ass.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301610-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_RECIPIENTS(0.00)[m:peterz@infradead.org,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sched-ext@lists.linux.dev,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:arighi@nvidia.com,m:akpm@linux-foundation.org,m:arnd@arndb.de,m:bsegall@google.com,m:leitao@debian.org,m:changwoo@igalia.com,m:void@manifault.com,m:dietmar.eggemann@arm.com,m:edumazet@google.com,m:mingo@redhat.com,m:kuba@kernel.org,m:john.ogness@linutronix.de,m:juri.lelli@redhat.com,m:kprateek.nayak@amd.com,m:pabeni@redhat.com,m:pmladek@suse.com,m:senozhatsky@chromium.org,m:horms@kernel.org,m:rostedt@goodmis.org,m:tj@kernel.org,m:vincent.guittot@linaro.org,m:vlad.wing@gmail.com,m:vladwing@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,davemloft.net,nvidia.com,linux-foundation.org,arndb.de,google.com,debian.org,igalia.com,manifault.com,arm.com,redhat.com,kernel.org,linutronix.de,amd.com,suse.com,chromium.org,goodmis.org,linaro.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linutronix.de:dkim,linutronix.de:mid,linutronix.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6107F6BD37C

On 2026-06-24 11:31:17 [+0200], Peter Zijlstra wrote:
> On Tue, Jun 23, 2026 at 04:26:49PM +0200, Sebastian Andrzej Siewior wrote:
> 
> > +#ifndef WARN_ON_DEFERRED
> > +#define WARN_ON_DEFERRED(condition) ({					\
> > +	int __ret_warn_on = !!(condition);				\
> > +	if (unlikely(__ret_warn_on)) {					\
> > +		guard(preempt)();					\
> > +		printk_deferred_enter()					\
> > +		__WARN();						\
> > +		printk_deferred_exit()					\
> > +	}								\
> > +	unlikely(__ret_warn_on);					\
> > +})
> > +#endif
> 
> This will generate atrocious shite at the WARN sites.

You mean the missing semicolon and huge size increase?
On x86 with these guard+deffered in the upper variant, before:
    text    data     bss     dec   filename
   93910   37424     832  132166   kernel/sched/core.o
   61802    4945     152   66899   kernel/sched/fair.o
  215108   24453    3768  243329   kernel/sched/build_policy.o
   86128   30092   12704  128924   kernel/sched/build_utility.o
  456948   96914   17456  571318   total
After:
   96140   37408     832  134380   kernel/sched/core.o
   64490    4937     152   69579   kernel/sched/fair.o
  222980   24157    3768  250905   kernel/sched/build_policy.o
   86544   30100   12704  129348   kernel/sched/build_utility.o
  470154   96602   17456  584212   total + 1.3%

total went up by 1.3% or 12.59KiB.
This effects:  alpha, arc, arm, csky, hexagon, m68k, microblaze, mips,
nios2, openrisc, sparc, um, xtensa
and could motivate them to implement __WARN_FLAGS which would lower size
in general and this stunt would have no effect.

Just looked at arm and it has support for invalid opcodes somehow but
not for this.

Sebastian

