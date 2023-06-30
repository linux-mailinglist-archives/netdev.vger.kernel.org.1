Return-Path: <netdev+bounces-14757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40141743AC5
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 13:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5DC2280FEA
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 11:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01122134BF;
	Fri, 30 Jun 2023 11:24:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BE1C8DF
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 11:24:39 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA1E3C0B
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 04:24:36 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-401d1d967beso236071cf.0
        for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 04:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688124276; x=1690716276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBu5cobzaIIszKw8PqMrQerCBUrk/84QgCZoRtB7nuY=;
        b=RtCKK2KAlY4OiHyya1PKFV7l1X2zYZHbimqrltg18ADEf1ZdE/PLPOYB2MfXak5S/k
         D4OnrURRksMi6do7vybc7BYwSCuNPIeJXtNdkJ0cTtGzKkAFIicaNQo+FFxCrnE12PvN
         LMOAf67h7774RElPLckuFpWfzGYzWn+8yw+QBezBjeROmysL9vDk97lYIrgSxQG4+f3M
         5i1OBqqUraItBxjbD/sChSaPjE6kVDpQRBoX2t7f5w5yl44hCWPts2sLNcB/NP+4lpzD
         wACB/oEcDAormIAtKcZePVU4PryvwLx5tiT8+cuTTohXMSfRNiO3R+4fRNk4Rf0oGfPg
         ky+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688124276; x=1690716276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBu5cobzaIIszKw8PqMrQerCBUrk/84QgCZoRtB7nuY=;
        b=hHsAkIQHr7zmd3pLOHApB9EuYzH0S+JwboByaMWZLUrCMQW7pfwOHIDb01yLUndBLT
         lt9cZ6qTkqb1sECGN+SbT2204gj2pVvJeND8CF0eCWPLxHLdquHjFjt69dCmeiWocGcN
         jSEKT/QVcv3bqSFiZyY3RReROYTkWFgyDblhQoPsq9JHdZk9t7Vjy5022G7mIQPQy7gl
         dxblFLZbddU1bQ6zBoQ8fdLzfpuJ25oKZ1uEJ6VbtfoIYFj0oy4vjZ9MEr2f7K6domF+
         o9fouIvkurlKAXKhwfBCvmAERmlrngOAQpd3bzMZLZ/+WdkSI6WuHsWXF7UdFimNUAci
         ORUA==
X-Gm-Message-State: AC+VfDz1SrZ0v2bInFZUPEWR7MHnd6xHmtZBoPr1/BM1/Ne4fgTffZg9
	mxzLa25A9XfLx2btiM8scU1AgTNdpaXJOJi5NdyJbQ==
X-Google-Smtp-Source: ACHHUZ789bReloK9d8GYumvavJx4SHtDUxk87KNrBhWUYu0hePItfCq6UQ1XMD5ewYh09iGoXDgIAvtqsIjZ966DEls=
X-Received: by 2002:ac8:5882:0:b0:3ef:4319:c6c5 with SMTP id
 t2-20020ac85882000000b003ef4319c6c5mr611889qta.19.1688124275638; Fri, 30 Jun
 2023 04:24:35 -0700 (PDT)
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
 <CAMj1kXGHRUUFYL09Lm-mO6MfGc19rC=-7mSJ1eDTcbw7QuEkaw@mail.gmail.com>
 <CAG_fn=X+eU=-WLXASidBCHWS3L7RvtN=mx3Bj8GD9GcA=Htf2w@mail.gmail.com>
 <CAMj1kXFrsc7bsjo2i0=9AqVNSCvXEnYAukzoXeaYEH9EpNviBA@mail.gmail.com> <f5c2d592-4b97-93f8-b62e-402eeeaa70d9@I-love.SAKURA.ne.jp>
In-Reply-To: <f5c2d592-4b97-93f8-b62e-402eeeaa70d9@I-love.SAKURA.ne.jp>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 30 Jun 2023 13:24:23 +0200
Message-ID: <CANn89i+-JH6xgNW=2+ywp-urUMpOJ-vkCKvUyVFTuyJTTojvUQ@mail.gmail.com>
Subject: Re: [PATCH] net: tls: enable __GFP_ZERO upon tls_init()
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Ard Biesheuvel <ardb@kernel.org>, Alexander Potapenko <glider@google.com>, 
	Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+828dfc12440b4f6f305d@syzkaller.appspotmail.com>, 
	Eric Biggers <ebiggers@kernel.org>, Aviad Yehezkel <aviadye@nvidia.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>
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

On Fri, Jun 30, 2023 at 1:11=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2023/06/30 19:18, Ard Biesheuvel wrote:
> > On Fri, 30 Jun 2023 at 12:11, Alexander Potapenko <glider@google.com> w=
rote:
> >>
> >> On Fri, Jun 30, 2023 at 12:02=E2=80=AFPM Ard Biesheuvel <ardb@kernel.o=
rg> wrote:
> >>>
> >>> On Fri, 30 Jun 2023 at 11:53, Tetsuo Handa
> >>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>>>
> >>>> On 2023/06/30 18:36, Ard Biesheuvel wrote:
> >>>>> Why are you sending this now?
> >>>>
> >>>> Just because this is currently top crasher and I can reproduce local=
ly.
> >>>>
> >>>>> Do you have a reproducer for this issue?
> >>>>
> >>>> Yes. https://syzkaller.appspot.com/text?tag=3DReproC&x=3D12931621900=
000 works.
> >>>>
> >>>
> >>> Could you please share your kernel config and the resulting kernel lo=
g
> >>> when running the reproducer? I'll try to reproduce locally as well,
> >>> and see if I can figure out what is going on in the crypto layer
> >>
> >> The config together with the repro is available at
> >> https://syzkaller.appspot.com/bug?extid=3D828dfc12440b4f6f305d, see th=
e
> >> latest row of the "Crashes" table that contains a C repro.
>
> Kernel is commit e6bc8833d80f of https://github.com/google/kmsan/commits/=
master .
> Config is available in the dashboard page, but a smaller one is available=
 at
> https://I-love.SAKURA.ne.jp/tmp/config-6.4.0-rc7-kmsan .
>
> I'm using a debug printk() patch shown below.
>

Please note that your patch is not correct, unless I am missing something.

sk_page_frag() will use a per-thread frag allocator
(current->task_frag), which might be fed with pages
allocated from other sockets (standard TCP ones), without __GFP_ZERO.

If we must (and I am not saying we should) take this route, we also
need to force
"sk->sk_use_task_frag =3D false" for TLS sockets.

