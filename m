Return-Path: <netdev+bounces-260324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hJbgOKEgnWniMwQAu9opvQ
	(envelope-from <netdev+bounces-260324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 04:53:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A651817AA
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 04:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D7EF130185C6
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 03:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A42B4AEE2;
	Tue, 24 Feb 2026 03:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mi+AgkAr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB24F1C01
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 03:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771905181; cv=pass; b=P0xK/hDbv+N2oWcbTS3CeBd16AFIN4Vv1YowCPn6FpQr9xgyfTgptb8kor/eZvr6PKDsV2RJY7IUiGeS+n3B4n59ZpOK7ssO5wkS34JnP3c3iRMFyFg52Q2jWNpGJOxkAgZLOUrQDEwvnv0VjfK9hfI3ORmENhlSFh8WBVKxePI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771905181; c=relaxed/simple;
	bh=cvIjcAGifOKZ1KPkeA03JAlum4LG7BQNB9KJy/HA8EY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADE8qq87Ds+3joQ7TF8L8ACQnGJNiSS9yVz0e3/xq+nteOLKmFJ/I411ZaxUk//gqNaNMjGG9O9Jaqhval4dAyzrWonqSBPJn2onTyys+NcK+/8r/Un0Uzo8OpdAF2QvRRhqBc7H+va5trZR3QphWeI634e7O5XaTWW5YOqdA3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mi+AgkAr; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59e64657f0cso5443852e87.2
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 19:52:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771905178; cv=none;
        d=google.com; s=arc-20240605;
        b=dtbpOT1zeebtwGS92rQl3Se5fSv7eP8YBz+keca7EayIMHhkS22a50Pzx26Oz4NWB4
         UxrtCuHIfuddv/KIzyuezs7Oww4uI09JVNmd+PcwMuZLTHM6pYV6IFlFyhNFEwBkjFd7
         eUdc7cSfBFh/IczDJHmRieVWBgBzicmYXwhNUXchyM+y73pa0szTuXImK0BSFXlUo7St
         TLoHsivWd1avoZkO79fzPAtuQGxhvEvsqHcvv8AL7KP89cYVWe6SuNA77RIOxQKOgBqe
         Tfm90AJkYvOWepDhdKIZpQ6fRJuHEO+KOjX1UcDNrk+wshZPJZcNf2W39MeUdNjNjzHr
         GOuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Rkv3FCccFOdEwJg9FjVL53Y2/y6gY6xgZY6SWC3pFBc=;
        fh=JMB8IKbAFaonXyxNJj4R1l6G9j8SsDOe4nbhhObNHGk=;
        b=i+RmzlrbiNpq9ckQsYznaf6IF4Slxc4AoXqn8Xxga3TsMolOl4GzTLxOphJiQ5j1Cu
         /dCvIu94T+iuufTzVUFfD1oyZ0eAr50GE9vvcztXHVu/gGM+WTC467smLPblwpj7jmCg
         FznvX3MKEjpo/V4ldMvByWKaT0dyQWTVdn0M0mhc+ZiTGJoQxMrPoYIUET8vs/xHXsPA
         MHvZTz/AsHWGdwVNMpsr6y2nwR6ULtoEe+ts2VPT6oDbsjSDJbJaA2irfauB+KVC9XaQ
         +1J8PrMp9bIm8fHKVlpSE4W++cfebH3+EfsYo+UT1DzMFy93sfxiV8lnM+WspOFvZJGX
         CPZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771905178; x=1772509978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rkv3FCccFOdEwJg9FjVL53Y2/y6gY6xgZY6SWC3pFBc=;
        b=mi+AgkArcvcjbHXBGqVXtya281tJwqClSjxm9wBhnE6ODKeMoLn/hjkSDgaSHIl0w3
         PAmLpjhjri9gT7gKiSQUsZ8sPzP9ogtjj/7uyIP3aoo3pKWLIEflLIXefnZZKAqomCZJ
         HzHVq4VaXkBLJI52zyfFddipD0Mrb9O777sshQhG4oen15FVJci0eW5ZSb/mKp4na1dc
         fd250weqXgQa2jtrmA/W1p/XkkAGXqYpucFulXQTwOR0TjBYZpG4rZeUrlbFZAQ3NOyF
         WOuwXkhkhBP5zjvUyLg3CvRkjwVSgv9sq+6Lk8bGdQ/iThAPSU2flyV8DgWb1TKAdmt5
         sWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771905178; x=1772509978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rkv3FCccFOdEwJg9FjVL53Y2/y6gY6xgZY6SWC3pFBc=;
        b=vTNAwtP0SDCk06IcVbj7zuG8TWtV0vgT/N4aK9t9GuxuKabpsHr6cwi7k8ZqIiomKW
         H9TKnV9D0hk8brl9FKqoaalBqynIIOibJDH+5x6Jzv5GSkKpo3BJ9qudISXjsRvkbQI6
         g+VzuCGYLcerdEJc61vTJxhCYE4Ds2TTWxuqzKTXNxYLv/N5UjWEl5k8DpBhKXQZ5iiE
         CcGEHYOrof0G4VRnawDR5lMaA1RsO6ntr3G+Y6hOiXYqJaqC6TWhnr5CC4gdINKoX284
         5niK156M8WoQY3GU7shXqiKqYQv5iOr9LBaKYxxVKeWdRtG4Tp5wULt+ycGiWzhPJj07
         4TkA==
X-Gm-Message-State: AOJu0YyUGq41opBUYwbZUcXjmNP8Q+y+8OLy0cdg67cIk5G6wYhzoyt/
	XcJZv8cD8Ghgav61cpTVXHWMSt4jpHlexCzMhot6tYznybKtDi756zafo3TvuKIDUMqGpkJNio3
	kTsjGH/eWopRWnQa+8PG7NGzh5s0YSNM=
X-Gm-Gg: ATEYQzztYYOjFF93KVXT/ljoY9kvnx4EClCvAG9rxIMQknYISV1/3k9uxwEHznunjIG
	nTTZEGIRNY9JPrk6RTcF+JjBrznfSwolBgepHtcCL0aVyVCV4RgJNwrY8jYmCLtUTvX4YGYLWnF
	qIlPAwR1hyDBIR5TSnEXwTL+w68AMQzJFRxryUTOgHGR+TaCd/2u1cI2Ih3vnk7V6j/XO319vaO
	i2A6DHPLMabN38r4NVO/CJRMeCu1Xk43IJaKlJ/OiCfPKLlEYu+oatMhoxK44sGMRklgXsDPuLB
	isJ+Bx94
X-Received: by 2002:a05:6512:239a:b0:59e:64d4:12b8 with SMTP id
 2adb3069b0e04-5a0ed99c7cemr3006164e87.30.1771905177558; Mon, 23 Feb 2026
 19:52:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e8355c0d7fd48981ba505e455387971f91210fa8.1771734206.git.tonghao@bamaicloud.com>
 <CAL+tcoDR2-WTmhBakWcvEuLCwAU7RGRA8syfor-+RJJq7_ZOKw@mail.gmail.com> <65307E32-7AFF-44EF-B2BB-89AA15F3D0D1@bamaicloud.com>
In-Reply-To: <65307E32-7AFF-44EF-B2BB-89AA15F3D0D1@bamaicloud.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 24 Feb 2026 11:52:20 +0800
X-Gm-Features: AaiRm53AeQuRnGCQqDZpWy61v0RkWJkdXt5gJhVUWQNxHqr3pOkpkRpi0i99yh4
Message-ID: <CAL+tcoB0uV0E9cDCfw58kAuzNcanstx_OT3h=dkQVOW1b-nN+A@mail.gmail.com>
Subject: Re: [PATCH net-next] net: core: introduce the netdev_fetch_core_stats()
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Ahmed Zaki <ahmed.zaki@intel.com>, Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260324-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bamaicloud.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,intel.com:email,fomichev.me:email,davemloft.net:email]
X-Rspamd-Queue-Id: F2A651817AA
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 11:22=E2=80=AFAM Tonghao Zhang <tonghao@bamaicloud.=
com> wrote:
>
>
>
> > On Feb 23, 2026, at 08:20, Jason Xing <kerneljasonxing@gmail.com> wrote=
:
> >
> > On Sun, Feb 22, 2026 at 12:38=E2=80=AFPM Tonghao Zhang <tonghao@bamaicl=
oud.com> wrote:
> >>
> >> Network device statistics retrieved via procfs, sysfs, and netlink
> >> represent the combined total of core_stats + driver, hardware statisti=
cs.
> >>
> >> However, in some scenarios, when monitoring netdev metrics, it is valu=
able
> >> to clearly distinguish whether the values originate from the networkin=
g
> >> stack's core statistics or from the driver, hardware layer. This helps
> >> improve debugging and addressing issues.
> >>
> >> Approaches were considered:
> >> - commit 5247dbf16cee ("net/core: Introduce netdev_core_stats_inc()").
> >>  This allows tracking increments to core_stats and helps identify spec=
ific
> >>  causes of changes, but not provide the total counters.
> >> - extending rtnl_link_stats64 with new core_xxx fields.
> >>  This would likely confuse or break existing userspace applications re=
lying
> >>  on this struct.
> >> - adding a tracepoint inside dev_get_stats().
> >>  This implementation is not simple or straightforward enough.
> >>
> >> The solution in this patch is therefore to introduce a new dedicated f=
unction
> >> for collecting core statistics and mark it noinline. This approach is =
simple,
> >> clean, and maintainable to obtain driver, hardware statistics separate=
ly when needed.
> >>
> >> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> >> Cc: "David S. Miller" <davem@davemloft.net>
> >> Cc: Eric Dumazet <edumazet@google.com>
> >> Cc: Jakub Kicinski <kuba@kernel.org>
> >> Cc: Paolo Abeni <pabeni@redhat.com>
> >> Cc: Simon Horman <horms@kernel.org>
> >> Cc: Stanislav Fomichev <sdf@fomichev.me>
> >> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> >> Cc: Samiullah Khawaja <skhawaja@google.com>
> >> Cc: Ahmed Zaki <ahmed.zaki@intel.com>
> >> Cc: Alexander Lobakin <aleksander.lobakin@intel.com>
> >
> > It's a simple refactor patch that only moves that logic to a new
> > helper. I don't see any new possible callers right now so could you
> > provide more straightward/clear use cases and intentions behind this
> > patch? For example, give us what kind of dumping stats you want to
> > tweak and your next movements.
> Thanks, Jason
> This patch tries to add one helper function which marked as noinline for =
bpf tracing (this commit 5247dbf16cee also use the noinline for tracing). T=
his helper is not used other place in kernel.
>
> For example,
> sudo bpftrace -e '
>   kprobe:netdev_core_stats_fetch {printf("%d\n", ((struct rtnl_link_stats=
64 *)arg1)->rx_dropped);}
>   kretprobe:netdev_core_stats_fetch {printf("%d\n", ((struct rtnl_link_st=
ats64 *)retval)->rx_dropped);}
> '

Can't we use the global symbol dev_get_stats() instead? It should be the sa=
me.

Thanks,
Jason

