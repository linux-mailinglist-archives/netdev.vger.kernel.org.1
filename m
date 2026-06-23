Return-Path: <netdev+bounces-301401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ux1KKG6sOmppDQgAu9opvQ
	(envelope-from <netdev+bounces-301401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 17:55:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5596B87AD
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 17:55:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b="WToBBs/c";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301401-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301401-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26DAE30F30A8
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 15:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A164D2FDC30;
	Tue, 23 Jun 2026 15:49:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDF02609EE
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 15:49:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782229761; cv=none; b=O0qqraeVuarAxA38sKS81VnHzI+BvDC81u1XeaZlKwG9eyksdD1Tzxu84PH7NZSpzoSJ2Rio7Z0aIRltgm7Iv/WZB/CJrCJsm3BEDFHglzfAesz1G/u6NdAN8rRKwiZJzMTbWnU9ehOwic8addCVE/QGEoJDe1ZBtD4G5XdCHK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782229761; c=relaxed/simple;
	bh=g9OjuwiWr9vNABcvV89aTygb82dl7YZP7O2hr7eKPA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNmsof32e9f1VnuQWnNtJmYQS+Wqe8c3VJwnD6tt9xDtlBo7VpWu98fCFq7hw5h/QnrgSbEDumRH4N+JF/MuA2S/GpgoGRO0e08K5HcCfBqSiM+6D/2kULWtrzNWPXtsERGR9+xs/U9ajKoMIxzLrVA3rHXEf0qOih/co88PG9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WToBBs/c; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4924593f45dso555155e9.1
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 08:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782229757; x=1782834557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nEBncOkZvwmf0mpGBSEvmRcxysNfgxHVM0De27/H3fk=;
        b=WToBBs/c481BBnRlI6zyEPk0kQ3GKh0VamraAzOyB0K8zhHa3/SEFf7YCy1hi2j2wz
         ufJzLTbx0HSi+LDZnpvu8s7MYO0mQUG8FmZONXY2af8LD8fLcbzFaMwbsBKZheMWrJsZ
         qGucYVf7mNAYF/VwfLHL93sMzOWEGeNzbQ3cGEXIZpfcdQrKPwj4JJUjdma3z2tzAr92
         gJQonpEpgsEMf44ADuP4Ne+QkFiZ6Wdtc1OjfPXVyO3V0c2sWnqY4mU38dQHYhTfpY+C
         FvK8qvA2i5YdSBB7g6hU0YiN/77M113ArQz1gyYl5DAzolwR5c4ZXuW8oIM+rOJayHNE
         V1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782229757; x=1782834557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nEBncOkZvwmf0mpGBSEvmRcxysNfgxHVM0De27/H3fk=;
        b=PZ3jaUdS62dLwcIgHNVgnj2JxxuFHPwcMkCu2n86mRQuIOtd1zk+2A+QkWsKjpvP6v
         DbVkFykFPqt19C77ROXR0zDmRiLinmOVX9fB6tFnIXwd/Z162oPhO13tSLYiq5/Bxf1a
         YNn6W3378cRTU0q7mPOu7BynaQx6agk4IhmaC/nNREH8c6Wag18LsQ6LHkWCXn9uqfKg
         cAGizXl4M8fUsB3vwjRvUQCMw2TWIINVf5ADqEqOYiXBgB382ActVcRyDOrjZ4oKtaCa
         zyF6mPJ1LLP1yvOsjZVOF4vLQcBdWLnFEFfUgaa18qeMIjObmY87m4kFkYQ5GZVyS2q2
         5pCA==
X-Forwarded-Encrypted: i=1; AFNElJ//VNPHVDVQxo4vYI9jXi/YqbEQo2ylZvSkxk13x4T8cF35Zmc7mxd7fVcWwVD7OInoGZP7vDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCxO8fsbA/b5aa673b9ZTP0eyrdLyYnBwLWm4Z06XjDuenaivC
	5LBHDAteJx/636Fz8aIe9VvYzPZvBlAlY8lBNx/iPP8u0jBcdZDEptDnAku3k84U9uk=
X-Gm-Gg: AfdE7clHuozJ9I7OmjxdIsg2ItLjGJB9ScU9ByUPdppLgRjO0g283bu7FsqyCu3O7KJ
	9uD8CvCw8NSRauqRUrMHg4KhJzweYWvMetVfGIdKCPsCsUbGIjDPUqo1zyRR6VtFA8E0TSBmx8f
	PQAn2uhGLpUPCA1M5mZhXqq/OG7aNMQqIzU6FKU4OtMz4Oc6WAq2NnhQG8sxEjoXqE2wGUeulwz
	PYu7GOhy2Zue8JO2cxNlZUknAJIATSx5aHdYKFYSKuZsdJBpPV7Ued/iybk1ZMVADOMovSFsduh
	snKypxWFFiVtVYUcjzUDInzfphrxKLZwx14vOzmkCCM5MftjsAQ70EzXfX9RvNFKl6By+R9+GOH
	8Rgib+Nb2urQFljHs9mrWBm56tH46toqI9AyXOJeaGy61aOtXFBi8wD1UAKO7RvqwoeKX5ad+Uy
	fACAGoa+bbhH9lLXrypEo+NSbyGQ==
X-Received: by 2002:a05:600c:3495:b0:490:e196:e8df with SMTP id 5b1f17b1804b1-4925b3aa15bmr52076835e9.23.1782229757310;
        Tue, 23 Jun 2026 08:49:17 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4924923914fsm313673405e9.6.2026.06.23.08.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 08:49:16 -0700 (PDT)
Date: Tue, 23 Jun 2026 17:49:14 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Andrea Righi <arighi@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
	Ben Segall <bsegall@google.com>, Breno Leitao <leitao@debian.org>,
	Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Eric Dumazet <edumazet@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vlad Poenaru <vlad.wing@gmail.com>
Subject: Re: [PATCH 1/2] bug: Provide WARN_ON.*DEFERRED() macros for console
 deferred output
Message-ID: <ajqq-ihAiU2VEaOp@pathway.suse.cz>
References: <20260623142650.265721-1-bigeasy@linutronix.de>
 <20260623142650.265721-2-bigeasy@linutronix.de>
 <20260623081258.580e034fdb5b98f4f8dba44a@linux-foundation.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623081258.580e034fdb5b98f4f8dba44a@linux-foundation.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301401-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:bigeasy@linutronix.de,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sched-ext@lists.linux.dev,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:arighi@nvidia.com,m:arnd@arndb.de,m:bsegall@google.com,m:leitao@debian.org,m:changwoo@igalia.com,m:void@manifault.com,m:dietmar.eggemann@arm.com,m:edumazet@google.com,m:mingo@redhat.com,m:kuba@kernel.org,m:john.ogness@linutronix.de,m:juri.lelli@redhat.com,m:kprateek.nayak@amd.com,m:pabeni@redhat.com,m:peterz@infradead.org,m:senozhatsky@chromium.org,m:horms@kernel.org,m:rostedt@goodmis.org,m:tj@kernel.org,m:vincent.guittot@linaro.org,m:vlad.wing@gmail.com,m:vladwing@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pmladek@suse.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linutronix.de,vger.kernel.org,lists.linux.dev,davemloft.net,nvidia.com,arndb.de,google.com,debian.org,igalia.com,manifault.com,arm.com,redhat.com,kernel.org,amd.com,infradead.org,chromium.org,goodmis.org,linaro.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmladek@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E5596B87AD

On Tue 2026-06-23 08:12:58, Andrew Morton wrote:
> On Tue, 23 Jun 2026 16:26:49 +0200 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > Provide a deferred version of the WARN_ON() macro. It will delay
> > flushing the console until a later context. It is needed in a context
> > where the caller holds locks which can lead to a deadlock content is
> > flushed to the console driver.
> > An example would from a warning from within the scheduler resulting in a
> > wake-up of a task.
> > 
> > Deferring the output works by using printk_deferred_enter/ exit() around
> > the printing output. This must be used in a context where the task can't
> > migrate to another CPU. This should be the case usually, since the
> > scheduler would acquire the rq lock whith disabled interrupts, but to be
> > safe preemption is disabled to guarantee this.
> > 
> > In order not to bloat the code on architectures which provide an
> > optimized __WARN_FLAGS() define BUGFLAG_DEFERRED which is handled by
> > __report_bug() and does not increase the code size.
> > 
> > Provide the DEFERRED macros based on __WARN_FLAGS and __WARN_FLAGS
> > macros. Extend __report_bug() to handle the deferred case.
> > 
> > ...
> >
> > --- a/include/asm-generic/bug.h
> > +++ b/include/asm-generic/bug.h
> > @@ -229,7 +230,10 @@ static enum bug_trap_type __report_bug(struct bug_entry *bug, unsigned long buga
> >  		 */
> >  		bug->flags |= BUGFLAG_DONE;
> >  	}
> > -
> > +	if (deferred) {
> > +		preempt_disable_notrace();
> > +		printk_deferred_enter();
> > +	}
> 
> For some reason the comment over printk_deferred_enter() says
> "Interrupts must be disabled for the deferred duration".  Is that the
> case for all the printk_deferred_enter() calls which this patch adds?

Strictly speaking, "only" CPU migration must be disabled around
printk_deferred_enter()/exit() call because the state is stored
in a per-CPU variable.

It means that preempt_disable() would work.

I do not recall whether we mentioned interrupts by mistake or
on purpose. It is possible that we suggested to disable interrupts
because we did not want to deffer messages from unrelated (interrupt)
context.

Best Regards,
Petr

