Return-Path: <netdev+bounces-262786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KBjFgHkpWkvHgAAu9opvQ
	(envelope-from <netdev+bounces-262786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 20:24:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5053C1DECF8
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 20:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3626E3001CD9
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 19:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB384389E04;
	Mon,  2 Mar 2026 19:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HIall6e+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0A937C107
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 19:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772479482; cv=pass; b=tYS8JY0T/kJw3hMqiPNp7zWEDo/1Myxvs9C9aj/tziAJrcEBiQO0Iqn3SSHe4xM7+rgWdpRywmJCqIjhRpTP5TGXi4XV1sMB4D166IFOHt2Bf7o3wCajhZ52gjTkwyFFAFKbH+kdFMdprqWOcnyiL/QRPCXSygdMcdiKnMOx8QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772479482; c=relaxed/simple;
	bh=Ufc18w1fIQI3K6svHUxteBYxBuwIXJsqlvn87gUkiwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EBTL6k52hC8XGskZNe8KFM6XrvARfwTsFx7/Z1ePsUUpNvnfKiwlbYhqHrFqs7rzGFYoTC9kDoWY0SHOEO9MsSEi3PsvQ5ckncBq77tJETh7h2EhJIEzkhok1YMMHcHe7+ZiFeRpk3XbFIFrqkuWQYk67Q/YNdslsEoqtwpEYTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HIall6e+; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1271195d2a7so594548c88.0
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 11:24:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772479476; cv=none;
        d=google.com; s=arc-20240605;
        b=DhLPqbFK2deQxGLlb+4V/t0tnB8JbITrTLu00XZQZmslpbJU0BPUopPubXZN3g75bg
         6sU3SV4SrJ+R6K6cOL3VclmHtmg5rMmTpeRwmTWJk5jUwg+a8f30+lrZksYN6MgiysH7
         Bn9XcuKDpVSe1lKXYqYH/CFYxj9PHuH+L41IHymU7NYD1TZufWvJK6DlUegTQhikPCSj
         /fUzHgG/wkEox48kJf1JK6wFq1RdtAyR6RpEGR9NJTyGzn/uYitRDTsrmSzOxafXNTLd
         r+b/W+ppfLuOX4I+WSHIPHuBZ+y6HOfeNsUHx6ZZwXdoRdkfTm9On5Zk27/i7x3hA7ia
         N2Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2oVILOrwcgzWRHf3vPBhPYrM20R3FLlzX0FIswchBUE=;
        fh=EMD/j6lbtjqpQdH1sKHmpjbPeRLg+j1SzVvZyex74Lg=;
        b=P1AFi6N9R6W+MJQ+z/rbulvv8FnRRG+Zbe9eB18lWpzPMbApSvnDClV0uUQI0Bid8g
         MK+7ZyBmSfJOf7PDUj6DQioZZEH8GDK+f985Wbc2iw6dVAKJV5/8I5yTU+AUuiR20J+1
         L13Dz+UXVoz1Shn7CMHuYeNkp1BkLhR2K8jtbdZT1T2YbV/UQrkPawkJIAEBRu5fysyZ
         dWxB4iLcoOUexzFWRaWa943Mm7k5jD3PVnmnBlKQvvFXqpWU1DOaisGjd8Gz7jeXRWjR
         +/PGJwpi3f0RI/2Wu6F5/jFPsz71lyiR5PPeAojgQp6MSPYsq9UPDbwz5jWLOEUDwukQ
         +rZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772479476; x=1773084276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oVILOrwcgzWRHf3vPBhPYrM20R3FLlzX0FIswchBUE=;
        b=HIall6e+SA36Hl8FaR0OKZvqQAzA1sBkOitr7h41jkTLDwqqTe/73NomQxsZyt59si
         /vseOVXCAaxn1BTrktqEuI4rrKM96XOGiFSJl+08yIRoTQ3S7hyZI6K3VIBNksklhuXL
         0IIca7rk6uMOPDMlrTPEPodA1gxX9r8R817VowyvvSan0Wg8prV2Jn05w0eQrc5UU6Dt
         lBJQx1fY/2vPCDP4J7gbZWW0m+rwmhNznfubrTXutzk8KxA0aBhZVMl0+zm+Jd6F5pCy
         +xmjuB2T/Wc/CuoC+xJ+T7MntDeZxANqimkSaXwnjINMOpNvuaENN+2zGT2n26DtNu+z
         SngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772479476; x=1773084276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2oVILOrwcgzWRHf3vPBhPYrM20R3FLlzX0FIswchBUE=;
        b=gZjY4LmBxzPT9TWI7GRFgT6jE4YN/xs7MLY3hubRsVkiBDRlbLao2XH+M5MX6Prg97
         alWBBA8bO9B8f8Sa656goBPSrLnUhT/T88anuSG0AzchJoJ2FOauuCGVhqaasOcW6uCa
         twq9GhM14UqoEaM4XrP+Iqcc9FpSr0b69XOAAab00nk7mpATLp6wG1oP9P/J3gYvXZ3m
         ExbvqqcDxF2lvwCj7+SxJRElyu1c59NQUj6OfaREiEblu2ffJqJTGZFl0/gRY1rL7oWm
         BC0J4vKcVtx465gOj1sE8Bk5nvdo6KFeQIHvmZiFrMje74rZWOACNOdKRg7tMkxVKHb2
         Blyw==
X-Forwarded-Encrypted: i=1; AJvYcCWDxEXGzgRl51GVHKIutNRxYpbrw5AzHnzNk5BeE8MnAyfZzBgmpiS6PKrZJsuCCd6KPyar/MI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWhGIU03TVF/pYFsNI/1WmgFbHPoyavklg2bK0a9b9aQqh+cOJ
	1XLMsXUFqspgOw85O0iRSkW3niHpuwiJ/yvFXqIaNDh8IirqWAWDrqG7jxyyS52TmLAEa02ygB5
	KF82a54rGWvie2dC6V26KOdgnu+p45lfBeCA4tkZm
X-Gm-Gg: ATEYQzwaJdfBFv+vPHd7P/OwTDJ9582AD49pLhZJFzK/Cmsi4WQIogsdJP80zQfXgDs
	hVYE5XXHUG3WU4559WzD8kLqYiaEaaSRkbz99nTTb63YUDx/JXd6g5dsCQqRBgdXf3H54v3Oe/1
	PL+FTEQGely58pztDyQPxAmdJj0n+OIx1wGWKvAwTdaeIVHEQSgn8xuffdKSdAPE/PkXd1Em3uh
	fIwOYH2WuyltKMYINPw/hElR1O0Lo4awpNzhxc/AsAgEE8w1FJIjE1Jg6iysr3vgZ1ZMybF6TmN
	Q5WvK/MHdT85CR+OkZ8L4c47T9euwUwuC3IiUZMsC+T//K1eArISXZUzqpdzy0uqr24tM1VHREA
	fZLmqEQ==
X-Received: by 2002:a05:7022:458c:b0:123:3462:3758 with SMTP id
 a92af1059eb24-1278fcf4a70mr6316208c88.28.1772479475369; Mon, 02 Mar 2026
 11:24:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228221800.1082070-9-kuniyu@google.com> <20260302131218.679806-2-horms@kernel.org>
 <CAAVpQUBPkufdBby+WdQx4Tsbz_UwaziENX6V1tW64ao2v79qhQ@mail.gmail.com>
In-Reply-To: <CAAVpQUBPkufdBby+WdQx4Tsbz_UwaziENX6V1tW64ao2v79qhQ@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 2 Mar 2026 11:24:24 -0800
X-Gm-Features: AaiRm50qLVhFtSGPM0WCMbzSOx4AyQ_p0PPkHdteY2unmmvr5C5DQIFLMV2m1uA
Message-ID: <CAAVpQUAatHFaPxXNqC7HL-JgqRDayVfQpR80nq-_Y5eaWHBoRg@mail.gmail.com>
Subject: Re: [v3,net-next,08/15] ipmr: Move unregister_netdevice_many() out of ipmr_free_table().
To: Simon Horman <horms@kernel.org>
Cc: edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org, 
	netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net, 
	kuni1840@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5053C1DECF8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,redhat.com,kernel.org,vger.kernel.org,davemloft.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-262786-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 11:04=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Mon, Mar 2, 2026 at 5:12=E2=80=AFAM Simon Horman <horms@kernel.org> wr=
ote:
> >
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> >
> > For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-lo=
cal.html
> > ---
> > ipmr: Move unregister_netdevice_many() out of ipmr_free_table().
> >
> > This commit refactors network device cleanup in the IP multicast routin=
g
> > code by moving unregister_netdevice_many() from ipmr_free_table() to it=
s
> > callers, enabling batched cleanup across multiple tables per netns.
> >
> > > diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> > > index d15e05662b09..7e2aa2026f01 100644
> > > --- a/net/ipv4/ipmr.c
> > > +++ b/net/ipv4/ipmr.c
> >
> > [ ... ]
> >
> > > @@ -349,8 +355,13 @@ static int __net_init ipmr_rules_init(struct net=
 *net)
> > >
> > >  static void __net_exit ipmr_rules_exit(struct net *net)
> > >  {
> > > +     LIST_HEAD(dev_kill_list);
> > > +
> > >       ASSERT_RTNL();
> > > -     ipmr_free_table(net->ipv4.mrt);
> > > +
> > > +     ipmr_free_table(net->ipv4.mrt, &dev_kill_list);
> > > +     unregister_netdevice_many(&dev_kill_list);
> > > +
> > >       net->ipv4.mrt =3D NULL;
> > >  }
> >
> > In the !CONFIG_IP_MROUTE_MULTIPLE_TABLES version of ipmr_rules_exit(),
> > does this sequence lead to a use-after-free?
> >
> > ipmr_free_table() calls kfree(mrt) to free the table:
> >
> > net/ipv4/ipmr.c:ipmr_free_table() {
> >     ...
> >     rhltable_destroy(&mrt->mfc_hash);
> >     kfree(mrt);
> > }
> >
> > Then unregister_netdevice_many() is called, which triggers NETDEV_UNREG=
ISTER
> > notifications. The global notifier ipmr_device_event() handles this eve=
nt
> > and calls ipmr_for_each_table().
> >
> > In the non-MULTIPLE_TABLES case, ipmr_for_each_table() expands to:
> >
> >     for (mrt =3D net->ipv4.mrt; mrt; mrt =3D NULL)
> >
> > Since net->ipv4.mrt still points to the freed memory at this point (it'=
s
> > only set to NULL after unregister_netdevice_many() completes), won't
> > ipmr_device_event() access mrt->vif_table and mrt->maxvif from a freed
> > slab object?
> >
> > The CONFIG_IP_MROUTE_MULTIPLE_TABLES version appears safe because
> > list_del(&mrt->list) removes the table from the iteration list before
> > kfree().
> >
> > Should net->ipv4.mrt =3D NULL be moved before calling
> > unregister_netdevice_many(), or before calling ipmr_free_table()?
>
> Exactly, although the bug disappears in the next patch,
> I'll fix this in v4.

No, this AI review is false-positive.

Because ipmr_rules_exit() is still set at exit_batch(), and it is
always called after default_device_exit_batch(), which removes
all devices including vif.

So, unregister_netdevice_many() called from ipmr_rules_exit()
does nothing and does not trigger any NETDEV_UNREGISTER
event, so net->ipv4.mrt is not touched thus no UAF.



>
> Thanks !
>
>
> >
> > > @@ -425,18 +436,16 @@ static struct mr_table *ipmr_new_table(struct n=
et *net, u32 id)
> > >                             ipmr_expire_process, ipmr_new_table_set);
> > >  }
> > >
> > > -static void ipmr_free_table(struct mr_table *mrt)
> > > +static void ipmr_free_table(struct mr_table *mrt, struct list_head *=
dev_kill_list)
> > >  {
> > >       struct net *net =3D read_pnet(&mrt->net);
> > > -     LIST_HEAD(dev_kill_list);
> > >
> > >       WARN_ON_ONCE(!mr_can_free_table(net));
> > >
> > >       timer_shutdown_sync(&mrt->ipmr_expire_timer);
> > >       mroute_clean_tables(mrt, MRT_FLUSH_VIFS | MRT_FLUSH_VIFS_STATIC=
 |
> > >                           MRT_FLUSH_MFC | MRT_FLUSH_MFC_STATIC,
> > > -                         &dev_kill_list);
> > > -     unregister_netdevice_many(&dev_kill_list);
> > > +                         dev_kill_list);
> > >       rhltable_destroy(&mrt->mfc_hash);
> > >       kfree(mrt);
> > >  }

