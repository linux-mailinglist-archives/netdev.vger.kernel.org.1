Return-Path: <netdev+bounces-303051-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eXTfJ2WMQ2qWbAoAu9opvQ
	(envelope-from <netdev+bounces-303051-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:29:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC77A6E22F1
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:29:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=Rv6B8YEB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303051-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303051-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20FE8310A29E
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EE3385D80;
	Tue, 30 Jun 2026 09:21:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7414F391849
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 09:21:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782811319; cv=none; b=MgrVwP9+IzV1bB9IsrmynT9meNGGggBXPWYBGc6ukVXiFKhwF9DqfH7ebgb73EShQOzApK6XzLNbo2nm4c7q5m7SlVtsYLOgHHpSgp8Iq7+Da6IDLNAG85lvvxhBBEC4ZUp4nUSDczz8UNQuiV77uzkm7hTM4cUWFV+Ky9Wa364=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782811319; c=relaxed/simple;
	bh=ZsgfwaWQ/k/9S7dCTq9cmP+83fNx4+hdg55zwZq3nX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5/Q+a4JVDwgAtdTAy1tC88a5L0BITcIZpp9ZZy+/00UX85Lwxnlu+M3EeQM+gIDKnyHcouzwm4eqkF7uMwpmbV0ZiIAW9oxMpBfAw2sev7vsGeQDdxZtAyo51gwK1WplfBwIdOWIRRiJlH41aKgJPr26oBKvSyNf4EG9mIf/uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Rv6B8YEB; arc=none smtp.client-ip=209.85.221.44
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-475881b9a4bso661123f8f.3
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 02:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782811317; x=1783416117; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lNTfDa2UJEPkdFDHQ+TrUrTOUtTro7Mdn22skuoNakY=;
        b=Rv6B8YEBJ5YtDrk2luKaz+nZvi38TVRnvCBjWQfFCXqHhR0lakEtuvpqNrDuGLLXrf
         5eYLgpo/n/uto5OjHVFOrPI2/SICLYmSPJ5jotp1QfVO+toMHKKFYOXb5k8EfnoJ+y9M
         a+LCRZ6bMQLMaSEhO+NftsGisUSnhxsRtWCykPKFTq0TJ+NvHqUl03WqKKhAaapN6XWy
         MZqjhuTuxL58hhIsLLFd6vebZchxps/3zrodvApf4ia5Tf1j8txgU6EVvdILIbKzlya7
         3Btf/t9ZGsFpQnnqhwhsYA+w+lnlGApfXZTSFlZp0+ymEGKC1s0c97GCeU18CiLuuQuz
         iTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782811317; x=1783416117;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lNTfDa2UJEPkdFDHQ+TrUrTOUtTro7Mdn22skuoNakY=;
        b=Iw+UFovlwyBEUhQYlXY1fRVHwlWJoqyr1ZDu6tO13YLNwPrAUd+Mz8xOgDoKTiLCaZ
         i+MYNmjuG96oAxhSNR8CtPwnYuSlhz4ewCWJs/nzmwKqCEHq9u7WgP92gGEkdAalAYfj
         Q/+f9S62kjC5AY1BHo9fPc6+B9Kwzw0RFNstcVuvTeg7gUsCqlhWw1xy8aRIExJCxGIM
         qYpnmFfXC/5HduICeij36W1Z8y3w+R8DOvjOfMDfggfIeCYohgHF/w8Qd1ZCG3OoV/u7
         iFEsNHVxhGEsdV66FzZijm4R1XNvDd5P+1/D65QTg9YBROxHGQgKC3wVX4zXNX4lqrP9
         VBJg==
X-Forwarded-Encrypted: i=1; AHgh+Rr304I+2zK21EHO0+c+Pva+wkwCFPWt5Ls3ACbS4BGyV1lNx4L2k5y6x2DWy22oKT5CgRvTzEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpQ2yyWz7xzPdYmsCuYaBfPPQc+fxH25u/MVN3zB7BEHriCohw
	AtNkSatUtLY0XA4slQJZCxgIrdswQTZV8NnuQFUuUKMrcMVZFhGX7y8AIsWKlU2lock=
X-Gm-Gg: AfdE7cn6TXDtq3LBPpUwqjYe90s6IlXvCHuzSk/aUzL3Tr/jBfZLPUUsTfDmY3EaPCa
	SDwudAoZB02GZeBufsLNnA7yJMhlQOrUpWMbW8aZY8xa3bg1lw/MGTGdV32NUYPT0lKK76Fs/dO
	dbNfQSC5M+fgVDOOfqklo45wbWo5k9XTIht1vD/LWKJj8bM5gimhscV1QkkHz8YrBiB6WyfuIVu
	Kk1oGfvuajnLfJpYf6t6SE62ImUC3KQQqWG+c3ubKny+8FlhDBo29r0LILp0aAg7yFS5kjQt5Tt
	dwr2e1sDAqI8S+RQHkG44zO0JT5bACLYmEUvAemLJozh/7nD8K/DNtt/TlHs1te1OlvFWc2nvDP
	6Ked9py6GrOAmv8WJNtqAtWs2YVZwyqUIJdJR4ostDU/gRnwhycWqjwyMN0Vo/mZORgFKDvcsQo
	yU0BRSLhIUTHuMqQM=
X-Received: by 2002:a05:6000:240c:b0:475:f100:35f9 with SMTP id ffacd0b85a97d-475f10036efmr1371196f8f.54.1782811316975;
        Tue, 30 Jun 2026 02:21:56 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47566743895sm5924944f8f.25.2026.06.30.02.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 02:21:56 -0700 (PDT)
Date: Tue, 30 Jun 2026 11:21:53 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
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
	Juri Lelli <juri.lelli@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vlad Poenaru <vlad.wing@gmail.com>
Subject: Re: [PATCH 1/2] bug: Provide WARN_ON.*DEFERRED() macros for console
 deferred output
Message-ID: <akOKsdOhfBBqVUhI@pathway.suse.cz>
References: <20260623142650.265721-1-bigeasy@linutronix.de>
 <20260623142650.265721-2-bigeasy@linutronix.de>
 <038a11a7-4ced-49ae-b605-2058733e841a@amd.com>
 <20260624062642.5DER6vrP@linutronix.de>
 <ajugq8VAciqtMx9F@pathway.suse.cz>
 <20260624152431.Ufq0jT8r@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260624152431.Ufq0jT8r@linutronix.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303051-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bigeasy@linutronix.de,m:kprateek.nayak@amd.com,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sched-ext@lists.linux.dev,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:arighi@nvidia.com,m:akpm@linux-foundation.org,m:arnd@arndb.de,m:bsegall@google.com,m:leitao@debian.org,m:changwoo@igalia.com,m:void@manifault.com,m:dietmar.eggemann@arm.com,m:edumazet@google.com,m:mingo@redhat.com,m:kuba@kernel.org,m:john.ogness@linutronix.de,m:juri.lelli@redhat.com,m:pabeni@redhat.com,m:peterz@infradead.org,m:senozhatsky@chromium.org,m:horms@kernel.org,m:rostedt@goodmis.org,m:tj@kernel.org,m:vincent.guittot@linaro.org,m:vlad.wing@gmail.com,m:vladwing@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pmladek@suse.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[amd.com,vger.kernel.org,lists.linux.dev,davemloft.net,nvidia.com,linux-foundation.org,arndb.de,google.com,debian.org,igalia.com,manifault.com,arm.com,redhat.com,kernel.org,linutronix.de,infradead.org,chromium.org,goodmis.org,linaro.org,gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:from_mime,pathway.suse.cz:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC77A6E22F1

On Wed 2026-06-24 17:24:31, Sebastian Andrzej Siewior wrote:
> On 2026-06-24 11:17:31 [+0200], Petr Mladek wrote:
> > For Linus, it was a no-go, definitely.
> …
> > I would vote for adding the WARN_*DEFERRED() into the scheduler code
> > at least until majority of console drivers are converted to nbcon API.
> 
> I see four nbcon serial console drivers (+netconsole, + drm_log). We
> have at least four times that many console drivers. What is the
> majority from your point of view? The 8250 should cover all of x86.

Good question. IMHO, there are about 100 console drivers:

$> git grep "struct console.*= {" | wc -l
107

But I guess that many of them are some old rarely used ones.

I tried to google amount of market share from various architectures
and it seems that most spread are: arm, x86_64, and risc-v.

Arm might already be mostly covered by pl011.
x86_64 will be covered by 8250.

I am not sure about risc-v. It seems that it might use 8250 as well
at least in virtual machines. Also there is drivers/tty/hvc/hvc_riscv_sbi.c.

Hmm, 8250 might the breakpoint. Maybe, we could leave the rest as a
motivation to convert the console driver instead of adding workarounds
using the printk_deferred() mechanism.

That said, AFAIK, the netconsole is often used when the device does
not have a serial console. And it is pity that it does not have
the .write_atomic callbacks implemented.

Best Regards,
Petr

