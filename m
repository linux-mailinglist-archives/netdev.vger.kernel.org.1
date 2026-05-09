Return-Path: <netdev+bounces-286217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id P+YXKz2h/2mw8gAAu9opvQ
	(envelope-from <netdev+bounces-286217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 23:03:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC375016BB
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 23:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A38A5300381B
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 21:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243A537C927;
	Sat,  9 May 2026 21:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="XKx1w1nB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B79634F479
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 21:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778360633; cv=pass; b=Fb1hQdH0xShGvUJSJmTqYZM1vO6pttj+3mGGX/eqX/dzC2XreYro09Q++XOdXTDEfZ6M5s31LaXb7NjmwcDHluHklxhLaL7TZvbryUb+ISpe035gOcNKDrlj9eZ9zjXi1e6BHlK5bcjdsufn6u2vOo4KL4X19wmqTPqVOmEMDJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778360633; c=relaxed/simple;
	bh=PxwmTw2cZ8X5Rse2nPySPXmuP6gvLtPzrJcrTGriioM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkzP5lpOzvco+FN+LJjn988HkT1qHNtGphran6SSoK2P51plM1ZmsMpSN+MYHFLGDtt9NlufHzsX9xzGRuscq/Awfx+lu1uSCxY7U/SbLeVjHuP1uH/Gncx1TCS1MAQd8t0QekCHSP0iKdtHdVrMdurCqe5Wzb0dOT6yuRL0OTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=XKx1w1nB; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7bd87e5d8ffso45827857b3.1
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 14:03:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778360629; cv=none;
        d=google.com; s=arc-20240605;
        b=Xo5FCo1BDmxQ186jLl11QKWQxdAawz9CJjHFOJGXjUY1deQxhLywdnXnOpYYlMnD5s
         zsNXRiz5w3BIeaVbVJbxVoxQEbOzFPT6L7/j/wpA1CakcBrlsnH2a5FO55Tqrv7xyuCT
         hGoC7N+0IBz6xX14ZeW60c0/2P5NZr3r+uWSBFLz1ATqZO4JBE0osYFJ2YqGyxITJFl/
         +0URMaVWHtzF+sOt/ey3mgIzDkPIGUiRqpjKR1shEQ6KoQ/d2Sg0L8DwMMoFszfLmHoL
         OKVJ/uTD57XRPabvV2K8sZNMCG+RJDjFmRpvJUaiSR1mbSOBtovd/zIcjLvW9P5s9gVt
         rNAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3Hgcm2XESHpuTekaIUaBfVFqK4X+Fc2qjFkrFyUDlzI=;
        fh=3W7TwQl6gJwB951YYi4HN/Y+7o51f5w3IYBhDpdQFz8=;
        b=ER8Ga0N2hLCKCyFL1MsACuRLz61NdxZePpTclw7vpBfQHda4UVNjGWLa7Ncb1fquNL
         aF6zGEkTN46qWWJvEkJvnu/3MjAcfXNHOvyHQQf+b13eu/+mqysitAoGVb9V0hHu6PdS
         0/ZfW9Km3ndjI/XM03P67KDZfIK7t7X2FcTa4HXPRl5bETKf442bQkMI5/EI4K8/d9Io
         AHMnhCERoAciUIj5RrRzKqjqmEFiuSmRq8tklxXNyyWau624UYppnqsyIk54HA7xHd+j
         uZLH+HhfHIybEoWztHT+cqK8f82ujza/HGR5WNO4t9VZbpUZ0cA0wsMrlfg7SBILpVs0
         REvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1778360629; x=1778965429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Hgcm2XESHpuTekaIUaBfVFqK4X+Fc2qjFkrFyUDlzI=;
        b=XKx1w1nBeH16Rt3eUrg7M8LQt+E17htkqMIV1774xxdLyzOMZzrEqxdHgEL6TzKg6L
         IDLXqXgl6qp0XRdScYaCXxEVlJDaQSfM3BHMmZKjNaoQCPOKQh9r7gX1GR56PmrKEkvN
         qqX8ngLVPLRvme27++YZI2UsOaRIF68/cRDOa+U/XjO3qk8ubHGXyyKozceSaguI5acU
         M/PKw2zhGz8RD2oSrz96Ti8fXc+haPx2eg0/SgUAf4Qw6j18AaBtG7o1SHl0kywXR79z
         3gwlhTXgq5orpEngKojKg6SZH0VS7sw57NXCF9DLfk6vKWDP0TYWgKAPUpDpJLqCohy0
         Midw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778360629; x=1778965429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Hgcm2XESHpuTekaIUaBfVFqK4X+Fc2qjFkrFyUDlzI=;
        b=HH9eYSds4HvYfwPXsqJMPw608eLigj1f8Jf3kxqO2JpXTfg0s7QNdNCovxFSw5xiU0
         VMSHr54uTzRlaBBFZlv1/44eJBclBYxmXoOooXLsD+mnkUDeJm8wJtEAD0wO7g/JIYaB
         GKikS7tmVQLTaYy7hfg1PtZycobKpjPqbqKy3rXeK3xvxk7hWXU3XOxeOfnJLvImesvh
         L/hU57FuYvNVw6eRbrOxnY8j5K9jPXozWyIbLtOI3EqY9XlOYobApLiIMptCESVjY/YS
         aTdHIblpAWKGK/M+k/3MwT9hvls19v6hJEtM/qXY3HscbL54J6IJ5OIRL/6NrsRE96kd
         xMgA==
X-Forwarded-Encrypted: i=1; AFNElJ+LpBv7p3dBD52NQmDcv8ptm1Jop/WWKljliZqY7QPPpqGZA5kBA0ZfnZBprvJ3bMilMDXJmTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5BTNFYaIBYpjI/enCZaRtgtKs4H6DrnIQ1Q5tn4YKgB+VUTua
	Xnas6muW19tkwTlVh5Mclj99SCyhsUsM6Mbdpfwq3udiVJQtIqEFB4NO7UvpCX0Ae5wUt3Gk+d9
	q/BdyDrdshqr2rNwEPRaq6ZonypcKJ3a1pFVooBaa
X-Gm-Gg: Acq92OEWn49u1qliA82vFZf3VSIhs5zXtssESut5EtdxGiULm9znsSn/JEboIaGtEd6
	PVIDJIDM4Qng8o3NZFcM0eJ4FfDFH1ERArV0vma+862m9tMNndfDnYQWdPmhzvoGWFKOmmt0w5b
	SvG1vCkreKXvKpCQrAT+Kz9t+7FMobshWp1AiZ7PuOYlPZTPNnIOMXUvyc6DojWjqaCP4ZS6FL8
	lJb9CuoQIflH/Pg2uukfwGVnDtzV4lBsFU0L0QZ/+K8fb55xTXNyAK7oIFtYJZITRqr+91KDFIX
	6g3RioLGZQ3nnaAk6QazBCpPJu+oh7yK
X-Received: by 2002:a05:690c:660c:b0:7bd:7e01:8d58 with SMTP id
 00721157ae682-7bf04c7b1c4mr96556957b3.29.1778360629523; Sat, 09 May 2026
 14:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507221948.335726-1-edumazet@google.com> <20260507221948.335726-6-edumazet@google.com>
 <6b5d2268-ffaa-4746-87d0-8f16135aba44@mojatatu.com> <CANn89i+eK7w_VXW+vva_4Uy50mBPN-pT_oijYN0T-US-AK-dZA@mail.gmail.com>
In-Reply-To: <CANn89i+eK7w_VXW+vva_4Uy50mBPN-pT_oijYN0T-US-AK-dZA@mail.gmail.com>
From: Victor Nogueira <victor@mojatatu.com>
Date: Sat, 9 May 2026 18:03:38 -0300
X-Gm-Features: AVHnY4I98TffYGf3dgr7XX4SR2y-JGJHZrP1sO0_WTgnLHMHAt_T99eWHS6wm-Q
Message-ID: <CA+NMeC-wn-ikFgyH3MabnXwcSrJzEwdXQmuHkXd=QboNq2vONA@mail.gmail.com>
Subject: Re: [PATCH net-next 5/8] net/sched: add const qualifiers to
 gnet_stats helpers
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2FC375016BB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286217-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mojatatu.com:email]
X-Rspamd-Action: no action

On Sat, May 9, 2026 at 2:53=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Fri, May 8, 2026 at 11:33=E2=80=AFAM Victor Nogueira <victor@mojatatu.=
com> wrote:
> >
> > On 07/05/2026 19:19, Eric Dumazet wrote:
> > > In preparation of lockless qdisc dumps, add const qualifiers to:
> > >
> > > - gnet_stats_add_basic()
> > > - gnet_stats_copy_basic()
> > > - gnet_stats_copy_queue()
> > > - gnet_stats_read_basic()
> > > - ___gnet_stats_copy_basic()
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > [...]
> > > diff --git a/net/core/gen_stats.c b/net/core/gen_stats.c
> > > index 1a2380e74272de8eaf3d4ef453e56105a31e9edf..3b2f9ea2eb072dde792aa=
d5b60cf00dcc2efa76d 100644
> > > --- a/net/core/gen_stats.c
> > > +++ b/net/core/gen_stats.c
> > > @@ -124,7 +124,7 @@ void gnet_stats_basic_sync_init(struct gnet_stats=
_basic_sync *b)
> > >   EXPORT_SYMBOL(gnet_stats_basic_sync_init);
> > >
> > >   static void gnet_stats_add_basic_cpu(struct gnet_stats_basic_sync *=
bstats,
> > > -                                  struct gnet_stats_basic_sync __per=
cpu *cpu)
> > > +                                  const struct gnet_stats_basic_sync=
 __percpu *cpu)
> >
> > This seems to be causing a compilation error:
> >
> > net/core/gen_stats.c: In function =E2=80=98gnet_stats_add_basic_cpu=E2=
=80=99:
> > ./include/linux/percpu-defs.h:238:1: error: initialization discards
> > =E2=80=98const=E2=80=99 qualifier from pointer target type [-Werror=3Dd=
iscarded-qualifiers]
> >    238 | ({
> >          \
> >        | ^
> > net/core/gen_stats.c:133:54: note: in expansion of macro =E2=80=98per_c=
pu_ptr=E2=80=99
> >    133 |                 struct gnet_stats_basic_sync *bcpu =3D
> > per_cpu_ptr(cpu, i);
>
> Interesting, no error on my side wth gcc or clang.

Yes, it's weird.
I can reproduce with the gcc versions below:
gcc (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0
gcc (Ubuntu 11.4.0-1ubuntu1~22.04.3) 11.4.0

However with gcc 15 it's not reproducing.
There's probably been an update in gcc
that's masking the issue now.

cheers,
Victor

