Return-Path: <netdev+bounces-60935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F85821EBA
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 16:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916A31C22405
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 15:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37B81401B;
	Tue,  2 Jan 2024 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="apP98S5Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434CD14F8B
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so100155a12.0
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 07:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704209488; x=1704814288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fferZRiTEAFaD0pQSlQpWKaiPPNizEMqLvDOLfV7mRc=;
        b=apP98S5Z+bxkMGjdWuQygTQSyWJmgcDNTfKypKOz7ss7ilqgD4wa9uoSagZs39Vf9b
         4RcM4jotFovM0uHKPLH1E3pd5stTE4byq+iaTh5Jfl24M1QKfPVcPUe7Xo6AFRY25t7b
         hQU3BeDytQk/vDa9qM/TfEpBGYAtbmnJgJt0zvBUPp8kWGCogpwqXBOTxsqp9aXrmvTb
         XmbOMCtQiiM5tHjhkZinq/OvH9X/z25RlboFZiiQHyv/qWUEHucHCJzx1sHAayGtlrfh
         ss0FB7mluLidGR5U+ObaamsXp0uH1eERJURz5ZrsDKifKS2DWICTuW4jP5ekvZgQbaTM
         Xe6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704209488; x=1704814288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fferZRiTEAFaD0pQSlQpWKaiPPNizEMqLvDOLfV7mRc=;
        b=c+GmqudcQE9lmMnR9S4225w8F/kL8uRiHzMkoxItCgJTrADGTRf7zsek+/aWjWYFR6
         A6BTHt/4AXDV6pwv+H1J67wXsfTwLOVeEt/KeVwOumuyelAZ85YhJNgc5hgGTsC/E5Co
         g4AsUbpHr8ahur8e2w+cNBorLRb0+oqYDl+3/5h7cErtNVYxPTVvGqX+iI1ikga113Ss
         rWEWL2ZRAhxUgq+3RL3yKX6WVzGF/ZiWTqIOZsLHX+arT9/OzrEnXjGstnvxgqyJx5QL
         J3i31ABYgucFgKYxttEE15LaE4o9c325YiEt9bCOwWNvArnKjCxdu8mtPHiURSLVmHbn
         H1uw==
X-Gm-Message-State: AOJu0YzfU9YU5qn7V1Z26FGNZjQNp0a8AcbgvdwLcUsaJw/DJXeknXFH
	O5y70LnD/uC10riHWpe1W9LozP/8zlxLX+KMR4MXtWYS158C
X-Google-Smtp-Source: AGHT+IFrRa0Q28FGTt2MM04VT3ncHfvB0xNL/qu9Mu4jt/LNFIo+vm/09L1jgw8WuHiOKuRXS2yfkwOqf5/ZaNZLO4I=
X-Received: by 2002:aa7:da89:0:b0:555:6529:3bfe with SMTP id
 q9-20020aa7da89000000b0055565293bfemr536045eds.1.1704209488281; Tue, 02 Jan
 2024 07:31:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <14459261ea9f9c7d7dfb28eb004ce8734fa83ade.1704185904.git.leonro@nvidia.com>
 <CANn89iLVg3H-GuZ6=_-Rc5Jk14T59pZcx1DF-3HApvsPuSpNXg@mail.gmail.com>
 <20240102095835.GF6361@unreal> <CANn89iLd6EeC3b8DTXBP=cDw8ri+k_uGiCrAS6BOoG3FMuAxmg@mail.gmail.com>
 <20240102114147.GG6361@unreal>
In-Reply-To: <20240102114147.GG6361@unreal>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Jan 2024 16:31:15 +0100
Message-ID: <CANn89iJzBzcU=-ybbvOjNeNBqx2ap=uoS1dbYJEY59oWsSTUtg@mail.gmail.com>
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

On Tue, Jan 2, 2024 at 12:41=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Tue, Jan 02, 2024 at 11:03:55AM +0100, Eric Dumazet wrote:
> > On Tue, Jan 2, 2024 at 10:58=E2=80=AFAM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > >
> > > On Tue, Jan 02, 2024 at 10:46:13AM +0100, Eric Dumazet wrote:
> > > > On Tue, Jan 2, 2024 at 10:01=E2=80=AFAM Leon Romanovsky <leon@kerne=
l.org> wrote:
> > > > >
> > > > > From: Shachar Kagan <skagan@nvidia.com>
> > > > >
> > > > > This reverts commit 0a8de364ff7a14558e9676f424283148110384d6.
> > > > >
> > > > > Shachar reported that Vagrant (https://www.vagrantup.com/), which=
 is
> > > > > very popular tool to manage fleet of VMs stopped to work after co=
mmit
> > > > > citied in Fixes line.
> > > > >
> > > > > The issue appears while using Vagrant to manage nested VMs.
> > > > > The steps are:
> > > > > * create vagrant file
> > > > > * vagrant up
> > > > > * vagrant halt (VM is created but shut down)
> > > > > * vagrant up - fail
> > > > >
> > > >
> > > > I would rather have an explanation, instead of reverting a valid pa=
tch.
> > > >
> > > > I have been on vacation for some time. I may have missed a detailed
> > > > explanation, please repost if needed.
> > >
> > > Our detailed explanation that revert worked. You provided the patch t=
hat
> > > broke, so please let's not require from users to debug it.
> > >
> > > If you need a help to reproduce and/or test some hypothesis, Shachar
> > > will be happy to help you, just ask.
> >
> > I have asked already, and received files that showed no ICMP relevant
> > interactions.
> >
> > Can someone from your team help Shachar to get  a packet capture of
> > both TCP _and_ ICMP packets ?
>
> I or Gal will help her, but for now let's revert it, before we will see
> this breakage in merge window and later in all other branches which will
> be based on -rc1.

Patch is in net-next, we have at least four weeks to find the root cause.

I am a TCP maintainer, I will ask you to respect my choice, we have
tests and reverting the patch is breaking one of them.

