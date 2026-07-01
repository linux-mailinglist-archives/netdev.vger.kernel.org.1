Return-Path: <netdev+bounces-303774-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cZf6BDJGRWqL9woAu9opvQ
	(envelope-from <netdev+bounces-303774-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:54:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F7F6F0059
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:54:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=SY7lMG2e;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303774-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303774-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D626C306435B
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 16:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAC8372064;
	Wed,  1 Jul 2026 16:54:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC61374A0F
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 16:54:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924846; cv=pass; b=ZEtgMk6RNytUy+eGW85iSl6qq4p4T//M3SmdhK71CEuiniKDrHK87Jh2p4agfr5OUc1qzxEjaWuNjZMzl6WhmsIHVYKQ4ZbVin0B57s9hbhRDUiYL9iiI8kSOIO4s6KNqgOugJb+5CMfSDkEVc3prLvWHzhie640CY2aEDTaHJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924846; c=relaxed/simple;
	bh=pmMe+XE9jN0CKyg5axgbC8Jb3/Wp+YoJaN1c2si7KEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oj/m4c9Ud4gN9YHUTU/wzr4Y4bka6SR9zeUzD6Um82aqSfD6g4lQsrMvET/vZVSRsw89Q+aRPJefTJ0K3a+WvGb/mVQnb8g3aTHA+mir80CUfB5KUzfGxnZAgYd2wMrI1IYHW9XwDh4DHlsrIqQxhcOdLeMs/0DCZYsNB9Njq2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SY7lMG2e; arc=pass smtp.client-ip=209.85.210.169
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8424b00710aso642602b3a.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 09:54:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782924844; cv=none;
        d=google.com; s=arc-20260327;
        b=iXkKFi1A05g5N9MGYQNzOD9pxB8EPAFNxjQGtPm6VXALpcMjxYehOej0WFELW7rJ4A
         obnEVoDSgcoOke+Nhtile0g6NrmbGb3nbhoFjNV9LTdEdUfi1AAaJSvKYuWS8d9f47FP
         E27KhNqMUG3JzsSxiPdT8695v8ARYVG1mJS/BafQTtrli8W6okH33Fv+0f7JMdz7yfLo
         kmwO3bs+EQ9r9EblUoyTryZOytIdidVRWTWmu4ftJFmHRmvu0j1GnK8DdjSGtpm1VSvj
         KoV4vvDS8QySDoC26Oqt41sR4JAufRXpZjlloe0gYwWPc5dDr3C4o0eQd4gByF7EuKQs
         c/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YayhL2FmmS1aLnJiD0T/fjIcbm1hHsWeF4sEJijFSCw=;
        fh=UpQsuZgxvoaDvMX5NrOYlaX/GL9oiERhGXtOuV/mdJE=;
        b=aSeEIDZsLNgg2eIjcsrHBIjM9HUeFVj5d2ueKWGCOUDewxuNJO3Ri8urPmqjDV6rXT
         p/tdR8vQTcrapzhq/qXxhqiCpO0WxH+mrAdahaPp8SG3qbX74yYRVPWvN5TE8kdwQxMM
         jbsJNDHbLXqhROWoL4A0Q5w7cWtSyhxWnbFOIljm0VUuvaaf37Kh8p3LoBiTlZbk1yt9
         xcArAAzbIdBTRIydb1jSNmyIDk68iGghGHKoZrekWf77g0eVFSSjN70Af2ljtcBHBYOG
         Jqc/8rFf5lKH2g0ezcgRFfKcbM8Dp9V8Y9qfWy1l/wJgFytezFTnydzhIX8hKqCX8+vc
         MLdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782924844; x=1783529644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YayhL2FmmS1aLnJiD0T/fjIcbm1hHsWeF4sEJijFSCw=;
        b=SY7lMG2eaIibq0NqNmy6Z+pEMOm7wmchc1Eghg0Jcb6vZz3em60z7k1zur9q2vAMxJ
         lsJq1gW7tZOHJJB8t91Pwsj+w7djMByTBI7mbgU8MZvKVZswByYUxZzNOEAJlfaHzQMC
         kae107uHpJhQkxNDduGRNckQcc/VsmDG93K7LtHc96DnjvkBiukmxYJR48I9jfItTxq3
         a/KVNjpPsYcvbLOFYDCgdVsJ1yW1H1jDuo/2E0j3QyteX4vazcYMj5lKSo3frGtGcTk+
         bpiw95CPuAAywpJrCRd0omwLGYu2NxOAuDepoEOGyNIMWl5OCVE+Kvcu/dUZNUyV5UsM
         WP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782924844; x=1783529644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YayhL2FmmS1aLnJiD0T/fjIcbm1hHsWeF4sEJijFSCw=;
        b=Ze59jE3NNp1ZWUzJQoX1z/+awWkHH73728r9LnKx3VozxbvqK/rTln2JXY2SvBWkVr
         6R1kTMu7Dz9DkRR/ZoUCmyJsTIZ3IYAq8s3Phz7T+0xTw+hlKVP/GqXV+/aKIqUWSPcU
         2aOyNyBqCnAabjN02pU9M9E8N1heAmzMl/DTRmA7plm8FHZ78zXJvIG5etVkPaFn2YtM
         uzgR47vLGaFvYt0Q2JDCNkZZ5Zs20TzFpeUTe7QsLS5Eg10zm9acovka08wcUe9gf506
         jmdVq4KDLoMC5+a6Pf15/loD/z617hbjz4TT4w96F81JDuuyDkZjAaIcN0LLFaO6GBBY
         MPfg==
X-Forwarded-Encrypted: i=1; AFNElJ92dP3gHvHCShCJuU53OB7EQvEkVqor+5FELBxJH/AHBqowj5oFTCU3rQZI/uFPROq+kr0CUEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRGt/DPHv7WWZa95+NkUJ7ujNMXYU5QKoy7/8yh2RpReFhBoK/
	bAlf06xaezc07d+2MxCyOkPP6Oy8nMuKFEgp2XpzaKOq/oF/rEmAh+XVwudyVamUEg5+90L6Ud3
	+/fBCcoHteHi7e4ZPfryZ3NF4vQk1MG4ks95reQBR
X-Gm-Gg: AfdE7cnPmiZtDH+vw0n20lbNyAmem6Kt/1cbb7qn38xk3zb9vcJwJ2z/6qZBWGCQUmk
	CrbcLaIzCUut1u9qO7Vhwt9GoEGZbLG5JZeapX0/s+hAhBMqlpoypDn3p0oxdnDIedpcvIQUAIg
	6LTY7zoP+oAQ1erHTNxkQ/FXPChMEIEJCUktH5GC0c/YF24wmejrayrCS5I7ydaZoRtsO6Dj3zU
	/sIAeDI9OpoYH0wIT58sB7DoCPnb0DN0r2SwVjcyaZOsbPrAloH7fNrUa9gjw9B4gYpKtR+C/p+
	Tov1lQOF+bnBg+R/QQpdJA+S86JyEtm5ylj56fyzndloaWVyuCusWi4ZX+ogez2ur6ssyg9gaNG
	X5jMuGzzuZjwtOY/NUL/cvpKyRuB6/d1ggAdWVyt94TvmF9yprAL6
X-Received: by 2002:a05:6a21:4c11:b0:3bf:bcef:fedd with SMTP id
 adf61e73a8af0-3bff42278a8mr1665966637.39.1782924843325; Wed, 01 Jul 2026
 09:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629181226.1929658-1-kuniyu@google.com> <20260701133858.GA1439085@shredder>
In-Reply-To: <20260701133858.GA1439085@shredder>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 1 Jul 2026 09:53:52 -0700
X-Gm-Features: AVVi8CfGqb1SrBId5UTMcYGwGl6CFSQGgErqwsUofTrQQ1BYJFUAeBH_LvpMfsU
Message-ID: <CAAVpQUAyJ0rJv5CyTccsYKM+FWAKusZ9x_PkWxPyhZiMFht9Eg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 00/10] net: fib_rules: RTNL-less RTM_NEWRULE
 and RTM_DELRULE.
To: Ido Schimmel <idosch@nvidia.com>
Cc: David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303774-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,mail.gmail.com:mid,nvidia.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67F7F6F0059

On Wed, Jul 1, 2026 at 6:39=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
> On Mon, Jun 29, 2026 at 06:10:52PM +0000, Kuniyuki Iwashima wrote:
> > RTM_NEWRULE and RTM_DELRULE acquire rtnl_net_lock(), but this is
> > only for fib_unmerge() in IPv4.
> >
> > Since commit d954a67a7dfa ("ipv4: fib_rule: Move fib4_rules_exit()
> > to ->exit()."), RTM_DELRULE no longer needs RTNL.
> >
> > fib_unmerge() is one-time event for each netns, so we only need
> > RTNL for the first IPv4 rule.
> >
> > This series introduces per-fib_rules_ops mutex and drops RTNL
> > from fib_rules code except for the first IPv4 RTM_NEWRULE.
>
> LGTM, thanks:
>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks Ido !

>
> A few nits that can be addressed in a follow-up:
>
> 1. Patch #3:
>
> The comment at the top of netns_ipv4 suggests that we should document
> the new lock in
> Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
>
> Related: Did you consider moving this lock under
> CONFIG_IP_MULTIPLE_TABLES?

I put it just after fib_table_hash but it can be moved there indeed.
I will follow up.

>
> 2. Patch #5:
>
> Sashiko suggests a mutex_destroy() in fib_rules_unregister():
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260629181226.192965=
8-1-kuniyu%40google.com?part=3D5

I had an impression that many core code do not use mutex_destroy(),
but didn't know mutex_destroy() is nop w/o debug config.  Probably it's
a kind of new (I mean not 90s) function and that's the reason ?

I will follow up on this too :)

