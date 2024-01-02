Return-Path: <netdev+bounces-60975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDB6822115
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 19:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE0C2842D4
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 18:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2551B14F9D;
	Tue,  2 Jan 2024 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yIutmAYk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4E615AC2
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso1202a12.0
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 10:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704220417; x=1704825217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcAbBzTZy/cwBJVkLr8s6Y3WY23Q0YFRyyWOj4s6ib8=;
        b=yIutmAYkKyJZkO+vficrBTfxMhkIcORQAEtwZrGRB1vXT+SFW4JaZwp0+YK2XwE+Ii
         gxkiprMxmp/WAwH1RPuhLhKA4HqeUziCNw3+PKC1AkoTxArwKRGpXYfLvKTsBOHzseBD
         6E9O/gvrdkPh4Tft/ielPsGrxzPlHmdkx70AigNxZ86FLxbopnKtEZmHf5z70bp/KdcY
         E2g+mcPBGP3A/9ibYliezte3CMqsY83WPshDjFvzxlh8lkL0SSiaxmkHZzEP5o8rWd2S
         C07s+MwmYGxSYs42ZEfc+KcRy5jdNO2XluS/SQbYNu7RiIfEjbhwSwEoRMItIuphQPJS
         Uudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704220417; x=1704825217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YcAbBzTZy/cwBJVkLr8s6Y3WY23Q0YFRyyWOj4s6ib8=;
        b=hcog7fuexf6lT1GGz+vn33z4f+quLYh5Ojrzo3iUS/0Mzxiv+7jNaDGYSlqb+xzy00
         VqQp8YynYwm50r3Zn5CkhK/43CiZMb/cUjxgHM/SWRbYOrELVLIRt70tNWqiTZdkXcF2
         8PaO9yuv3nGNg5zydSgM3VUGMf6ndgBm54XDEV0x+i+WCwrAEUQy3YHs8/W+tl1b7OQq
         CI7qEZIkV9z5jnprQ51wsXSh0UGgXpRxWfJeAJh9VRYkh2ykQCPd+9KmqAs6jWBeMUPG
         gQiDdXGNqjcbrjQrU1wZnXkQ8FxhmPDYwFiC46hKjU+TWBUtV4Fq6Ue0TQvrrpUoXVFH
         z/iA==
X-Gm-Message-State: AOJu0YyqhS5D9AIwJLkFY9K3jQd97kpgEbJZbvJy5VogtZIf+2WbM/E1
	ZwTrKzXDFoPMriKVxT/3Nokm/lD0mLb+b/qGjYG64CwN9mvU
X-Google-Smtp-Source: AGHT+IFMMYAsrpycRKvYiz7NGfwtOm4xfv+ygiRUtgU9ZHZEYciNvmx/YcgXdNvTEzSAR3HGIFR/XAiYI5JWeO1ZbbU=
X-Received: by 2002:a50:9b51:0:b0:554:1b1c:72c4 with SMTP id
 a17-20020a509b51000000b005541b1c72c4mr715805edj.1.1704220416498; Tue, 02 Jan
 2024 10:33:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <14459261ea9f9c7d7dfb28eb004ce8734fa83ade.1704185904.git.leonro@nvidia.com>
 <CANn89iLVg3H-GuZ6=_-Rc5Jk14T59pZcx1DF-3HApvsPuSpNXg@mail.gmail.com>
 <20240102095835.GF6361@unreal> <CANn89iLd6EeC3b8DTXBP=cDw8ri+k_uGiCrAS6BOoG3FMuAxmg@mail.gmail.com>
 <20240102114147.GG6361@unreal> <CANn89iJzBzcU=-ybbvOjNeNBqx2ap=uoS1dbYJEY59oWsSTUtg@mail.gmail.com>
 <20240102180102.GA5160@unreal>
In-Reply-To: <20240102180102.GA5160@unreal>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Jan 2024 19:33:23 +0100
Message-ID: <CANn89iKcStXqo9rxpO_Dq3HQ0Sj8Ce_5YmjaKx7n9EF+9GjTmA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: Revert no longer abort SYN_SENT when
 receiving some ICMP
To: Leon Romanovsky <leon@kernel.org>
Cc: Gal Pressman <gal@nvidia.com>, David Ahern <dsahern@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shachar Kagan <skagan@nvidia.com>, netdev@vger.kernel.org, 
	Bagas Sanjaya <bagasdotme@gmail.com>, 
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 7:01=E2=80=AFPM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Tue, Jan 02, 2024 at 04:31:15PM +0100, Eric Dumazet wrote:
> > On Tue, Jan 2, 2024 at 12:41=E2=80=AFPM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > >
> > > On Tue, Jan 02, 2024 at 11:03:55AM +0100, Eric Dumazet wrote:
> > > > On Tue, Jan 2, 2024 at 10:58=E2=80=AFAM Leon Romanovsky <leon@kerne=
l.org> wrote:
> > > > >
> > > > > On Tue, Jan 02, 2024 at 10:46:13AM +0100, Eric Dumazet wrote:
> > > > > > On Tue, Jan 2, 2024 at 10:01=E2=80=AFAM Leon Romanovsky <leon@k=
ernel.org> wrote:
> > > > > > >
> > > > > > > From: Shachar Kagan <skagan@nvidia.com>
> > > > > > >
> > > > > > > This reverts commit 0a8de364ff7a14558e9676f424283148110384d6.
> > > > > > >
> > > > > > > Shachar reported that Vagrant (https://www.vagrantup.com/), w=
hich is
> > > > > > > very popular tool to manage fleet of VMs stopped to work afte=
r commit
> > > > > > > citied in Fixes line.
> > > > > > >
> > > > > > > The issue appears while using Vagrant to manage nested VMs.
> > > > > > > The steps are:
> > > > > > > * create vagrant file
> > > > > > > * vagrant up
> > > > > > > * vagrant halt (VM is created but shut down)
> > > > > > > * vagrant up - fail
> > > > > > >
> > > > > >
> > > > > > I would rather have an explanation, instead of reverting a vali=
d patch.
> > > > > >
> > > > > > I have been on vacation for some time. I may have missed a deta=
iled
> > > > > > explanation, please repost if needed.
> > > > >
> > > > > Our detailed explanation that revert worked. You provided the pat=
ch that
> > > > > broke, so please let's not require from users to debug it.
> > > > >
> > > > > If you need a help to reproduce and/or test some hypothesis, Shac=
har
> > > > > will be happy to help you, just ask.
> > > >
> > > > I have asked already, and received files that showed no ICMP releva=
nt
> > > > interactions.
> > > >
> > > > Can someone from your team help Shachar to get  a packet capture of
> > > > both TCP _and_ ICMP packets ?
> > >
> > > I or Gal will help her, but for now let's revert it, before we will s=
ee
> > > this breakage in merge window and later in all other branches which w=
ill
> > > be based on -rc1.
> >
> > Patch is in net-next, we have at least four weeks to find the root caus=
e.
>
> I saw more than once claims that netdev is fast to take patches but also
> fast in reverts. There is no need to keep patch with known regression,
> while we are in -rc8.

This patch is not in rc8, unless I am mistaken ?

>
> >
> > I am a TCP maintainer, I will ask you to respect my choice, we have
> > tests and reverting the patch is breaking one of them.
>
> At least for ipv6, you changed code from 2016 and the patch which I'm ask=
ing
> to revert is not even marked as a fix. So I don't understand the urgency =
to keep
> the patch.

Do you have an issue with IPv4 code or IPv6 ?

It would help to have details.
>
> There are two things to consider:
> 1. Linux rule number one is "do not break userspace".

No released kernel contains the issue yet. Nothing broke yet.

net-next is for developers.

> 2. Linux is a community project and people can have different opinions,
> which can be different from your/mine.
>
> Thanks

I think we have time, and getting this patch with potential users on
it will help to debug the issue.

