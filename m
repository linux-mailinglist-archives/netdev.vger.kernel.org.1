Return-Path: <netdev+bounces-14760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DECF0743AF3
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 13:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F74D280EE7
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 11:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215B6134DF;
	Fri, 30 Jun 2023 11:38:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0275AC8DF
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 11:38:16 +0000 (UTC)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A3E2690
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 04:38:14 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7836272f36eso73368939f.1
        for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 04:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688125094; x=1690717094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+owkzL4O5o9w2hz2hl4JHbpHLfF4qU7pBPxUSJyFh4=;
        b=rQwKY+lGviryfTCy3jDOrYtAsmncK4h5ei3E5XGhlPFhTh7DqHup7GOzW10Q/0uweH
         a9HQGDXBUZ4XW+j5rP9gWPqGn2Yz87a4fFXcNpOqHwIefM15aarmlinUIHjU/W4Abr/b
         DyMLj9knwDNCW4EFCVB0h6UPP7RqgaPwx9bNkzrHLVx9ERj0iuDBFhKNmj/3gxh9KqAg
         MOvNr91Cd8lwZxINUmUDQBSNLghqeY7gdZZWFy2PsxELjM0Foei7GNI+dHBBcLZqXeIq
         6uEoPxC1SlkB9DAf+wxqOebODDCUy10ekx9z33nQRpfoshIMKhK2fVbofaJW81DWxbPk
         1jGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688125094; x=1690717094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+owkzL4O5o9w2hz2hl4JHbpHLfF4qU7pBPxUSJyFh4=;
        b=FhqzVmYk1Dzx7VaMIIGpgNxvjxnNljYf2QITKRrPFpzBNF2d0nhnY87qaMti5IWoNK
         +jMZBwWp71cFMOLqmXXt6jF+3A8tfhHtvaI7JrgKUvTFRignJFF+Sc0uwsVbR2mn9KxG
         itbm4SPNVEgMOVmn6x1cwImSXk7FzcrZGFwkZDPEdy1o58aqywGlefJhfW4A1A0mHSse
         ywrk/oyMRllElbSvWkYZ9z+Aaw0fGOcuMtUQPBm812jSANo8+TCkL2/Q+XxyfCOEq5HQ
         +Z89Y2keEMbrTSihil7S0BPGXaCQBj7dohTjgsPCcVsZgHLpBG4a5qVJj/Jt9jsUhBxf
         uJpg==
X-Gm-Message-State: AC+VfDza7f26bbgpHqTDSKxHgd7cbmZ8lbdJKP8200sAckmfQb/gZnjb
	n5Gqy22N1es4iSrisN44tjWvjRiWKzSq0DfwmlhnJg==
X-Google-Smtp-Source: ACHHUZ4HxzByp6NFWxts7p3+5juF8VC/L3S74Q6wsACF9uaOH4H2Uqkx92N+4tOd+M5q1xsjjSnBobFonnml7zxdIM0=
X-Received: by 2002:a05:6602:4243:b0:785:cf42:af31 with SMTP id
 cc3-20020a056602424300b00785cf42af31mr2349680iob.10.1688125093705; Fri, 30
 Jun 2023 04:38:13 -0700 (PDT)
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
 <CAG_fn=X+eU=-WLXASidBCHWS3L7RvtN=mx3Bj8GD9GcA=Htf2w@mail.gmail.com> <CAMj1kXFrsc7bsjo2i0=9AqVNSCvXEnYAukzoXeaYEH9EpNviBA@mail.gmail.com>
In-Reply-To: <CAMj1kXFrsc7bsjo2i0=9AqVNSCvXEnYAukzoXeaYEH9EpNviBA@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 30 Jun 2023 13:37:37 +0200
Message-ID: <CAG_fn=VFa2yeiZmdyuVRmZYtWn6Tkox8UVrOrCv4tEec3BFYbQ@mail.gmail.com>
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
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 12:18=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> On Fri, 30 Jun 2023 at 12:11, Alexander Potapenko <glider@google.com> wro=
te:
> >
> > On Fri, Jun 30, 2023 at 12:02=E2=80=AFPM Ard Biesheuvel <ardb@kernel.or=
g> wrote:
> > >
> > > On Fri, 30 Jun 2023 at 11:53, Tetsuo Handa
> > > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > > >
> > > > On 2023/06/30 18:36, Ard Biesheuvel wrote:
> > > > > Why are you sending this now?
> > > >
> > > > Just because this is currently top crasher and I can reproduce loca=
lly.
> > > >
> > > > > Do you have a reproducer for this issue?
> > > >
> > > > Yes. https://syzkaller.appspot.com/text?tag=3DReproC&x=3D1293162190=
0000 works.
> > > >
> > >
> > > Could you please share your kernel config and the resulting kernel lo=
g
> > > when running the reproducer? I'll try to reproduce locally as well,
> > > and see if I can figure out what is going on in the crypto layer
> >
> > The config together with the repro is available at
> > https://syzkaller.appspot.com/bug?extid=3D828dfc12440b4f6f305d, see the
> > latest row of the "Crashes" table that contains a C repro.
>
> Could you explain why that bug contains ~50 reports that seem entirely
> unrelated?

These are some unfortunate effects of syzbot trying to deduplicate
bugs. There's a tradeoff between reporting every single crash
separately and grouping together those that have e.g. the same origin.
Applying this algorithm transitively results in bigger clusters
containing unwanted reports.
We'll look closer.

> AIUI, this actual issue has not been reproduced since
> 2020??

Oh, sorry, I misread the table and misinformed you. The topmost row of
the table is indeed the _oldest_ one.
Another manifestation of the bug was on 2023/05/23
(https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D146f66b1280000)


>
> > Config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3Dee5f7=
a0b2e48ed66
> > Report: https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D132526=
0d900000
> > Syz repro: https://syzkaller.appspot.com/text?tag=3DReproSyz&x=3D11af97=
3e900000
> > C repro: https://syzkaller.appspot.com/text?tag=3DReproC&x=3D163a1e4590=
0000
> >
> > The bug is reproducible for me locally as well (and Tetsuo's patch
> > makes it disappear, although I have no opinion on its correctness).
>
> What I'd like to do is run a kernel plus initrd locally in OVMF and
> reproduce the issue - can I do that without all the syzkaller
> machinery?

You can build the kernel from the config linked above, that's what I
did to reproduce it locally.
As for initrd, there are disk images attached to the reports, will that hel=
p?

E.g.
  $ wget https://storage.googleapis.com/syzbot-assets/79bb4ff7cc58/disk-f93=
f2fed.raw.xz
  $ unxz disk-f93f2fed.raw.xz
  $ qemu-system-x86_64 -smp 2,sockets=3D2,cores=3D1 -m 4G -drive
file=3Ddisk-f93f2fed.raw -snapshot -nographic -enable-kvm

lets me boot syzkaller with the disk/kernel from that report of 2023/05/23.
Adding "-net user,hostfwd=3Dtcp::10022-:22 -net nic,model=3De1000" I am
also able to SSH into the machine (there's no password):

$ ssh -o "StrictHostKeyChecking no"  -p 10022     root@localhost

Then the repro can be downloaded and executed:

$ wget "https://syzkaller.appspot.com/text?tag=3DReproC&x=3D163a1e45900000"=
 -O t.c
$ gcc t.c -static -o t
$ scp -o "StrictHostKeyChecking no" -P 10022   t  root@localhost:
$ ssh -o "StrictHostKeyChecking no"  -p 10022     root@localhost ./t

Within a couple minutes the kernel crashes with the report:

[  151.522472][ T5865] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  151.523843][ T5865] BUG: KMSAN: uninit-value in aes_encrypt+0x15cc/0x1db=
0
[  151.525120][ T5865]  aes_encrypt+0x15cc/0x1db0
[  151.526113][ T5865]  aesti_encrypt+0x7d/0xf0
[  151.527057][ T5865]  crypto_cipher_encrypt_one+0x112/0x200
[  151.528224][ T5865]  crypto_cbcmac_digest_update+0x301/0x4b0

The vmlinux binary (also available at the syzbot page) can be used to
symbolize this report, but perhaps at this point you'd love to switch
to your own kernel.

--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

