Return-Path: <netdev+bounces-14742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E49C743932
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 12:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9977280E7D
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 10:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D7B111A1;
	Fri, 30 Jun 2023 10:18:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7446F101C7
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 10:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F7CC433C9;
	Fri, 30 Jun 2023 10:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688120294;
	bh=qayM9oDvTxb6Xm9+IkHuSoW95s/Sz5bR3jRGXkuJO58=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SOMLE+INYiJ/acA/1G0GDI9Nk0eD+qUeVm/P78PDMCShmxklOilp8PCpsvV96tjF6
	 chGnze4z5z+9g1jFh3fQczUXBEPS/zcDdmW6LQkDyWSCpfFhXyz6Bm5Pxppdne4DCa
	 9kuwukULHA8cBeMJHPY5dm3pr5bg2dZ4yElNTFHksFj33ayNtWuWemSPCEfLreyGG5
	 EzjFaqBU0NHpNP5q1eFioEG9YiqmLO2m7TUAFnel0UsF0yDPQC3BiEErEABv4ZIKoz
	 fCvkMA6xBC3zw02FDrQOVGisGNnKh4A3a9MHnvZ7jIuYI/n4xlW3DKML+Z9EwHWTH5
	 GB0Al6XTNL5lg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4fba03becc6so1465660e87.0;
        Fri, 30 Jun 2023 03:18:14 -0700 (PDT)
X-Gm-Message-State: AC+VfDwToh3xTVmVWOBD0+n3WceHRMVwQO285FyyIwXUSLQq47Y3saHi
	Pd11CBjwkK9QQyIklK0DhtH/q//lsMTPLIgwGz8=
X-Google-Smtp-Source: ACHHUZ62yhrg41OHYzO4jrmZmKlJ6tK+5JXq/WaWUIgKYUeiQTh9M/8eJuf0/P2mCB1KfN6YWSXtThd0s/Yqdt4Dius=
X-Received: by 2002:a05:6512:3d87:b0:4fb:7bf8:51c8 with SMTP id
 k7-20020a0565123d8700b004fb7bf851c8mr2590243lfv.1.1688120292812; Fri, 30 Jun
 2023 03:18:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000008a7ae505aef61db1@google.com> <20200911170150.GA889@sol.localdomain>
 <c16e9ab9-13e0-b911-e33a-c9ae81e93a8d@I-love.SAKURA.ne.jp>
 <CAMj1kXFqYozjJ+qPeSApESb0Cb6CUaGXBrs5LP81ERRvb3+TAw@mail.gmail.com>
 <59e1d5c0-aedb-7b5b-f37f-0c20185d7e9b@I-love.SAKURA.ne.jp>
 <CAMj1kXGHRUUFYL09Lm-mO6MfGc19rC=-7mSJ1eDTcbw7QuEkaw@mail.gmail.com> <CAG_fn=X+eU=-WLXASidBCHWS3L7RvtN=mx3Bj8GD9GcA=Htf2w@mail.gmail.com>
In-Reply-To: <CAG_fn=X+eU=-WLXASidBCHWS3L7RvtN=mx3Bj8GD9GcA=Htf2w@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 30 Jun 2023 12:18:01 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFrsc7bsjo2i0=9AqVNSCvXEnYAukzoXeaYEH9EpNviBA@mail.gmail.com>
Message-ID: <CAMj1kXFrsc7bsjo2i0=9AqVNSCvXEnYAukzoXeaYEH9EpNviBA@mail.gmail.com>
Subject: Re: [PATCH] net: tls: enable __GFP_ZERO upon tls_init()
To: Alexander Potapenko <glider@google.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+828dfc12440b4f6f305d@syzkaller.appspotmail.com>, 
	Eric Biggers <ebiggers@kernel.org>, Aviad Yehezkel <aviadye@nvidia.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 30 Jun 2023 at 12:11, Alexander Potapenko <glider@google.com> wrote=
:
>
> On Fri, Jun 30, 2023 at 12:02=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org>=
 wrote:
> >
> > On Fri, 30 Jun 2023 at 11:53, Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > >
> > > On 2023/06/30 18:36, Ard Biesheuvel wrote:
> > > > Why are you sending this now?
> > >
> > > Just because this is currently top crasher and I can reproduce locall=
y.
> > >
> > > > Do you have a reproducer for this issue?
> > >
> > > Yes. https://syzkaller.appspot.com/text?tag=3DReproC&x=3D129316219000=
00 works.
> > >
> >
> > Could you please share your kernel config and the resulting kernel log
> > when running the reproducer? I'll try to reproduce locally as well,
> > and see if I can figure out what is going on in the crypto layer
>
> The config together with the repro is available at
> https://syzkaller.appspot.com/bug?extid=3D828dfc12440b4f6f305d, see the
> latest row of the "Crashes" table that contains a C repro.

Could you explain why that bug contains ~50 reports that seem entirely
unrelated? AIUI, this actual issue has not been reproduced since
2020??


> Config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3Dee5f7a0=
b2e48ed66
> Report: https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D1325260d=
900000
> Syz repro: https://syzkaller.appspot.com/text?tag=3DReproSyz&x=3D11af973e=
900000
> C repro: https://syzkaller.appspot.com/text?tag=3DReproC&x=3D163a1e459000=
00
>
> The bug is reproducible for me locally as well (and Tetsuo's patch
> makes it disappear, although I have no opinion on its correctness).

What I'd like to do is run a kernel plus initrd locally in OVMF and
reproduce the issue - can I do that without all the syzkaller
machinery?

