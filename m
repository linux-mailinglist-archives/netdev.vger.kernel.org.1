Return-Path: <netdev+bounces-14741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24B174390F
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 12:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74A55281081
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 10:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB2F111A1;
	Fri, 30 Jun 2023 10:11:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE771079C
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 10:11:04 +0000 (UTC)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9331FE7
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 03:11:02 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-78372625badso68306439f.3
        for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 03:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688119861; x=1690711861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPgv2wjYUy5dqqrgnRN0xY0ydItBAFdyM2i3QC0UNps=;
        b=2bPx93RprgLnbiRKrzjsqjj+vifT+CCfzTNk3XaX+rnPFSveZGYvKMaWmHvF/aMr6J
         naURugz+pnX6tvBDsPl+f0qHAFPvpJGHUV6P9f4K2P1ZFOB6s7logboprIK4kfRBlz6q
         NgIE6RElJA+wlYPoTfSgMw5Pm5bSyPtgx8u/MDqvxaMlTZU6y11mo0aDQvxN/pQ5WQn3
         6XSKjaLAGUy15l/czMvayi/tQQDxbzMVW3RLIvNCEha+VDDWLx3vgP5tA7BWvym617T7
         4+Wm2JsvRG1+QTgq2DPP2L3n1KI7SFDkZVT5Mrt4eIyCWT/WmaKoRjaAiEx117+yBd1Q
         l5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688119861; x=1690711861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPgv2wjYUy5dqqrgnRN0xY0ydItBAFdyM2i3QC0UNps=;
        b=Mj6z5DM/ou9ijVad4yJENbAteJBG+DFQV5kOed6T+HYFi4zoWTJzfps6/kUVnmPgVF
         xUY+Z9PioY/4zrL8Addmuyst3M14LAmybkCbf3XSfblFbIR0uOBZR/JpnXRyusLiepI4
         0/jP4DGNcFCMHperNKk4fT3LT0zMUV0Kip5inV5feY4wUHjSPJ5GXt/0hzqeBbW57zA5
         o7d3GC+/zOyn1o8QnsFx3Gi7HxsSq71Loyd69jWfIxI9K9wDZmLd1Qv+6LDOATYxZ8Q6
         QuOfn3/a4vPlgw7NGReJyEZqygjedIBFEIIPzYiqjQ9fskkwqoS97jDR2MY1/iIxInct
         rWAg==
X-Gm-Message-State: AC+VfDxygbKi9kglvneSQ+RrH4KIbyphOadhMyQVTiDv45LqNd1g9n6g
	nXhHpIuw9Z8Q/+UroHovLK7pbdYLg6oKSp8k6nm/tQ==
X-Google-Smtp-Source: ACHHUZ4+dc69o9vQKPPPDgt5vUwiBfzzawcNELYwqgULuYMz3I09WnUqxE7mt9iM8JnsPzAnc+seS+TgUyU4JpzNoRo=
X-Received: by 2002:a6b:db16:0:b0:783:606b:740f with SMTP id
 t22-20020a6bdb16000000b00783606b740fmr2300876ioc.15.1688119861642; Fri, 30
 Jun 2023 03:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000008a7ae505aef61db1@google.com> <20200911170150.GA889@sol.localdomain>
 <c16e9ab9-13e0-b911-e33a-c9ae81e93a8d@I-love.SAKURA.ne.jp>
 <CAMj1kXFqYozjJ+qPeSApESb0Cb6CUaGXBrs5LP81ERRvb3+TAw@mail.gmail.com>
 <59e1d5c0-aedb-7b5b-f37f-0c20185d7e9b@I-love.SAKURA.ne.jp> <CAMj1kXGHRUUFYL09Lm-mO6MfGc19rC=-7mSJ1eDTcbw7QuEkaw@mail.gmail.com>
In-Reply-To: <CAMj1kXGHRUUFYL09Lm-mO6MfGc19rC=-7mSJ1eDTcbw7QuEkaw@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 30 Jun 2023 12:10:25 +0200
Message-ID: <CAG_fn=X+eU=-WLXASidBCHWS3L7RvtN=mx3Bj8GD9GcA=Htf2w@mail.gmail.com>
Subject: Re: [PATCH] net: tls: enable __GFP_ZERO upon tls_init()
To: Ard Biesheuvel <ardb@kernel.org>
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 12:02=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> On Fri, 30 Jun 2023 at 11:53, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >
> > On 2023/06/30 18:36, Ard Biesheuvel wrote:
> > > Why are you sending this now?
> >
> > Just because this is currently top crasher and I can reproduce locally.
> >
> > > Do you have a reproducer for this issue?
> >
> > Yes. https://syzkaller.appspot.com/text?tag=3DReproC&x=3D12931621900000=
 works.
> >
>
> Could you please share your kernel config and the resulting kernel log
> when running the reproducer? I'll try to reproduce locally as well,
> and see if I can figure out what is going on in the crypto layer

The config together with the repro is available at
https://syzkaller.appspot.com/bug?extid=3D828dfc12440b4f6f305d, see the
latest row of the "Crashes" table that contains a C repro.
Config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3Dee5f7a0b2=
e48ed66
Report: https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D1325260d90=
0000
Syz repro: https://syzkaller.appspot.com/text?tag=3DReproSyz&x=3D11af973e90=
0000
C repro: https://syzkaller.appspot.com/text?tag=3DReproC&x=3D163a1e45900000

The bug is reproducible for me locally as well (and Tetsuo's patch
makes it disappear, although I have no opinion on its correctness).

