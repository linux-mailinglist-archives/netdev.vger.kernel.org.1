Return-Path: <netdev+bounces-251528-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKOlHyLPb2mgMQAAu9opvQ
	(envelope-from <netdev+bounces-251528-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:53:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E136349D5D
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B5DC250FA20
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36F343E491;
	Tue, 20 Jan 2026 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FwxXgM9W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4DD43CEE4
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 15:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768923906; cv=pass; b=THc3nYUR16GQkgNayuVQw7Stjf3mwJ/Qp03BCpJR3HZnQYYdhlvvUfX9DC8iFq8hE0MnO8YktEa1dHBUAkD0qiDZCSJzqa13J3V1IuLHwEOzzvu1m9DYVKRUwD3LKB8QCBlHZBg/5UUr8gFHmsIFvetDAltPiRavRVrC068w3CM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768923906; c=relaxed/simple;
	bh=hq1HcNtG4nLMiC2jLDvnknnLkJESIm4k7UOyKj00KCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQhxaFZy8TaQNee0mrHtkiF7snvIIDlquFEqyGPNF/yCZ2sPpdRyaucxXNfbRwvs1u8htNJLSZM4YitCg6HanfnQrVGXvJjw1rW7iDzOw0iczP428Tha0Y4rEaHo+9fSbdGWsbFM6LgPeJ216NKN4vDnsmHmQAu0lE43rnRjqzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FwxXgM9W; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5014f383df6so39589791cf.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 07:45:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768923904; cv=none;
        d=google.com; s=arc-20240605;
        b=gISl57UbNJjzEM4q7Oiz3QB/IrhtUFkocgRaWhgt7FQXZYZ88M3+yBzlWfNJ7xtlkE
         LIYtelvdVZxJWg+kH755Atm1fkq0wU9NJlzhO4BGXDUorNOOb91/1YpB18HdVslLVOGT
         PEpQXQDrKPtdunOEUvZb+EvLXOVwPjhXm4u57HCDNhA5SvujyNKkVzFRDg0a1TSjcZki
         Vt5FOmAsu0kQlSEIj4fCJ4vKynlNVHi0Yr67HXYrifOZa5pxzYiXD0DdU1dlanr31bOn
         bru01tJGmvRtZsluljP2nUw/OJfDIlTjZ2bdj24r8vPmDq7xG7MipvPWlqyXp6EJHHaP
         C6DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=byB0MJhf+brpId2ejr9ZS9HPU2xuE8ldD1tYbhtA+4c=;
        fh=ZSfxoL80tOBXntDWjTqc/VmDLZnhrGlqWIniV9jT05w=;
        b=jAtbWCqMV26FkXHWdxCmOP9Q6e/F5vDG0tMWpwDwSpz53zKCyywp0uWNortcKAsIPb
         zBmkd6af5ThdDNteqCFKC+ALRsNjzhdW8OUa0UqEFytTEvjHaBZZYZvtOy39HuoDx6kC
         GJ3+HpuLLEeGj1eQ8TMX2Nc/a8zeRttx9AV8z7zoDKEVo7ghhDMFglkhgI0bG4kR5W+N
         kjyF2TvCsjmv/z/PbOYb/PzbcjqaRHVe6q2dGU4QfnzOB8jC4322STA5i/OXXtP49wAq
         QqjZtJtpBoXytrGtfdaap2aeXqc/muBZS4gWYB01K6SWVujycPjIkvrVq9fa2l5+eROE
         0Vxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768923904; x=1769528704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byB0MJhf+brpId2ejr9ZS9HPU2xuE8ldD1tYbhtA+4c=;
        b=FwxXgM9WF3vqFAM0X/uOq4tKTGfNnnoQq86svJmzi2mFmsoGh4Ny8i4hjhx2oj5FyB
         9Kk70eqa6eXyL+JXzdUUMF5ckxOHuYRxQfJuoTmAkn2bUX9JFtwwtLlWjhgRvZK9hx6h
         AhZwtml/wwfUGOh9RTmNgUoY4y5qCr87oOgy9XS5MG1Fgc47kXw5h1skHGOW2vApu0Ju
         cs4gEoGM7S6QSGv6sBlAr/Cq28e8ntWBF3Z07FIr3A2hAB3MtI2AOPeP37g+F14SbUz9
         jcWAZ+09Zmym9EVv4pjs6iqTNWI6Mva7b+6HpcojkAD3eD6EndsthlJ/Pmu1dSpJnMtM
         lUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768923904; x=1769528704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=byB0MJhf+brpId2ejr9ZS9HPU2xuE8ldD1tYbhtA+4c=;
        b=bibY1Xhc4y66xTHA4Oh1DcJ0uSXzebJuB7RiDFRo86Xq5At4LP1dR9FMtxYMmH3COG
         L9N4hNwuXxGIw6geo7y/npcFGzGYTERG1pTBAYIh7PvgLtb2/khPF0k3avBU4Gjy+mSD
         KMKlTTUkYzPPaLIevzWBLrlJsCnrB5al2mmNwRJU7LbEcY4q+SleEUPBtzRuL9kTF8zS
         IZ8FluVr9kl2vnl5JNba8/phpJ8qwwfFWH/4t6M2dT6muW8MeUavYJho+Vb43uOSmTAl
         TejastCmVqhM5eWpexG9NJ1vrIrW4llxkwNP2ZJFZ6kWGVaZA4ieS7x/OKZ5F1/Y2gKI
         HwuA==
X-Forwarded-Encrypted: i=1; AJvYcCXhLry6kkcMHN5aqOeCxG/0MzRog7gqd1r17/FAK5sMWTcX9ZQQ9N5rlhja6OnGnnJbBjizpno=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiOWGijdbD7YCQXlw1jQRHrrHkvjqk3NpbjrustM+svqVryFR/
	Fu26FzDo/V4O6cZm5LLF28eZqu45P/F65C7SI3qikc2XBEp32QPl8cyqzVFtQ6qSsXT2v80WvwB
	G0AokyrjjxTeRpHBq+OO21wGsqk0rwh8ibZ5lUM4U
X-Gm-Gg: AY/fxX4Yf3fr+SPQt3/gJi2iJzL7vk2Q5o0WuCD9hu+u5KxwZ25RqpRGd/zke4DRD5/
	wNh4IwiwXH+E/gAcROK5AfsgQMPKh0ieE+aLTEwXXdeJ6EkFfnc5CLIY38a2T5mAxREuZgZktXu
	43wfIjzgRReB4jXuIHAWuHPI7UfXId+1YPFjFjmgBw+NLUdKAxJiQfpyNTZIXv0yUp/gOyrgwSh
	kO/iaxJq2817mKGQ2QJtduKVN512Wbm8CisfqHXy2SjPmiAoVvAbF/6ktXN4tihBl14JOVq
X-Received: by 2002:a05:622a:10f:b0:502:9d:ec61 with SMTP id
 d75a77b69052e-502d84de8f4mr25005401cf.29.1768923903612; Tue, 20 Jan 2026
 07:45:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118175215.2871535-1-edumazet@google.com> <20260120073057.5ef3a5e1@kernel.org>
 <CANn89iL-w7ES=OsNQhLTZjxVdfOJxU2s7wRXJF6HkKSAZM2FBg@mail.gmail.com>
In-Reply-To: <CANn89iL-w7ES=OsNQhLTZjxVdfOJxU2s7wRXJF6HkKSAZM2FBg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 16:44:52 +0100
X-Gm-Features: AZwV_QjXmri310o26nBBr4bzfvqpCT7peZZ2h2tUAMmhMBNVGmOiwqWYBJ9vvJs
Message-ID: <CANn89iJUh-3xDWkXhNatmBj2tWd1dLHXLbE6YT9EA2Lmb_yCLQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 0/3] gro: inline tcp6_gro_{receive,complete}
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251528-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E136349D5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 4:41=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Jan 20, 2026 at 4:30=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Sun, 18 Jan 2026 17:52:12 +0000 Eric Dumazet wrote:
> > > On some platforms, GRO stack is too deep and causes cpu stalls.
> > >
> > > Decreasing call depths by one shows a 1.5 % gain on Zen2 cpus.
> > > (32 RX queues, 100Gbit NIC, RFS enabled, tcp_rr with 128 threads and =
10,000 flows)
> > >
> > > We can go further by inlining ipv6_gro_{receive,complete}
> > > and take care of IPv4 if there is interest.
> > >
> > > Note: two temporary __always_inline will be replaced with
> > >       inline_for_performance when available.
> > >
> > > v2: dealt with udp6_gro_receive()/udp6_gro_complete()
> > >     missing declarations (kernel test robot <lkp@intel.com>)
> > >     for CONFIG_MITIGATION_RETPOLINE=3Dn
> >
> > Still not good?
> >
> > net/ipv6/udp_offload.c:136:17: error: static declaration of =E2=80=98ud=
p6_gro_receive=E2=80=99 follows non-static declaration
> >   136 | struct sk_buff *udp6_gro_receive(struct list_head *head, struct=
 sk_buff *skb)
> >       |                 ^~~~~~~~~~~~~~~~
> > In file included from net/ipv6/udp_offload.c:16:
> > ./include/net/gro.h:408:17: note: previous declaration of =E2=80=98udp6=
_gro_receive=E2=80=99 with type =E2=80=98struct sk_buff *(struct list_head =
*, struct sk_buff *)=E2=80=99
> >   408 | struct sk_buff *udp6_gro_receive(struct list_head *, struct sk_=
buff *);
> >       |                 ^~~~~~~~~~~~~~~~
> > net/ipv6/udp_offload.c:168:29: error: static declaration of =E2=80=98ud=
p6_gro_complete=E2=80=99 follows non-static declaration
> >   168 | INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk_buff *s=
kb, int nhoff)
> >       |                             ^~~~~~~~~~~~~~~~~
> > ./include/net/gro.h:409:5: note: previous declaration of =E2=80=98udp6_=
gro_complete=E2=80=99 with type =E2=80=98int(struct sk_buff *, int)=E2=80=
=99
> >   409 | int udp6_gro_complete(struct sk_buff *, int);
> >       |     ^~~~~~~~~~~~~~~~~
>
> Oh well, I thought I tested this stuff.

Interesting... clang (our default compiler for kernel) does not complain at=
 all.

