Return-Path: <netdev+bounces-55313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A4280A531
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 15:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E42028177A
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 14:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E858A1DDFF;
	Fri,  8 Dec 2023 14:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EJaxmLR5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17305171D
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 06:12:18 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso7719a12.1
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 06:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702044736; x=1702649536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ABC8R/IhSJq1v/g+J7leg1/ZK2tJ16+5uzlBgeMWDk=;
        b=EJaxmLR5V6yud+2PaLx+l4h09Qf9gZSNcFIIZrr938Cs3ZgZ6SpGgpTm/1TiGWSZcw
         dLccmN44eYDEQ6wPQ85ObxmpPryxn/a4AJPFpZn2C/GDyvGSaVbDFOJNfEXfC02OpJ/C
         jdWEa5x0OuBsKGMMRDLgLMo//hxxFycdREL6eJeRFlPigGv6lDgAL/XKKjeD70azxJSN
         tVQHdthmZdvMVDCW+I1RMJ2kRRgo7HtTfmdwQ8uHELiwYy/dJOiDNcOBWbmbjuijY+w2
         AKpyPg/wNR3HJARpbQ1akl75OhQa2cyVzNdoiot6vtLJ7h3T8yMF8D9K9hVyCg6VYWDq
         MUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702044736; x=1702649536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ABC8R/IhSJq1v/g+J7leg1/ZK2tJ16+5uzlBgeMWDk=;
        b=oEZzh/HtW9J9vO5OWCvf9gao5xOO35mhLl06mxA+6NooYl0cph136MSC8cc34x4yyp
         /dDJdRS0IZgGgJZDjwohy77akmU2jp7TC2QWnR9y3V2LcLlNGuxzn/2E9K+1GEsHszPe
         1EUoQFsTodfHMs2u8eaSAsdAXsr/g3z3H/mfdlJRBG3381OMbNJrgB5LfMmyUq36DgMY
         eumE51SrTVOLbHeODNrP/aMoT4ZT1cQ4KdgHOdKYkB67D+D8BzypY2miQfJN/x8m1mCM
         ZMW4JjBHr4aU9AxyBaU60dsJ4ox/wxvlye1HU1VgbcR64EguWT9fQR/dCMdskw/3l9pP
         E4aQ==
X-Gm-Message-State: AOJu0YyeOQbmucXv8nhZfoo1d5Um2N3Jm/1/E+JgK1vUq0HJbZQCcT3F
	BwV0mxSe1LI+S2YKaYHeOtshbZ/vIV2MWm9qaAsxLQ==
X-Google-Smtp-Source: AGHT+IFUiwNJtELR2LOdUwBqhHceu0+lQwsc9S9bVzH1TniVpOsxIhVb55HaEcFpO/J3dhkzkXSaYntASjqvIfugTWM=
X-Received: by 2002:a50:f618:0:b0:54c:79ed:a018 with SMTP id
 c24-20020a50f618000000b0054c79eda018mr53716edn.2.1702044736317; Fri, 08 Dec
 2023 06:12:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000c84343060a850bd0@google.com> <87jzqb1133.ffs@tglx>
In-Reply-To: <87jzqb1133.ffs@tglx>
From: Jann Horn <jannh@google.com>
Date: Fri, 8 Dec 2023 15:11:38 +0100
Message-ID: <CAG48ez06TZft=ATH1qh2c5mpS5BT8UakwNkzi6nvK5_djC-4Nw@mail.gmail.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in copy_from_kernel_nofault
To: Thomas Gleixner <tglx@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	bpf <bpf@vger.kernel.org>
Cc: syzbot <syzbot+72aa0161922eba61b50e@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, bp@alien8.de, bp@suse.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, luto@kernel.org, mingo@redhat.com, netdev@vger.kernel.org, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 6:13=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
> On Sun, Nov 19 2023 at 09:53, syzbot wrote:
> > HEAD commit:    1fda5bb66ad8 bpf: Do not allocate percpu memory at init=
 st..
> > git tree:       bpf
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D12d99420e80=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D2ae0ccd6bfd=
e5eb0
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D72aa0161922eb=
a61b50e
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for=
 Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D16dff22f6=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1027dc70e80=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/3e24d257ce8d/d=
isk-1fda5bb6.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/eaa9caffb0e4/vmli=
nux-1fda5bb6.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/16182bbed726=
/bzImage-1fda5bb6.xz
> >
> > The issue was bisected to:
> >
> > commit ca247283781d754216395a41c5e8be8ec79a5f1c
> > Author: Andy Lutomirski <luto@kernel.org>
> > Date:   Wed Feb 10 02:33:45 2021 +0000
> >
> >     x86/fault: Don't run fixups for SMAP violations
>
> Reverting that makes the Ooops go away, but wrongly so.
>
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D103d92db=
680000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D123d92db=
680000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D143d92db680=
000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+72aa0161922eba61b50e@syzkaller.appspotmail.com
> > Fixes: ca247283781d ("x86/fault: Don't run fixups for SMAP violations")
> >
> > BUG: unable to handle page fault for address: ffffffffff600000
>
> This is VSYSCALL_ADDR.
>
> So the real question is why the BPF program tries to copy from the
> VSYSCALL page, which is not mapped.

The linked syz repro is:

r0 =3D bpf$PROG_LOAD(0x5, &(0x7f00000000c0)=3D{0x11, 0xb,
&(0x7f0000000180)=3D@framed=3D{{}, [@printk=3D{@integer, {}, {}, {}, {},
{0x7, 0x0, 0xb, 0x3, 0x0, 0x0, 0xff600000}, {0x85, 0x0, 0x0, 0x71}}]},
&(0x7f0000000200)=3D'GPL\x00', 0x0, 0x0, 0x0, 0x0, 0x0, '\x00', 0x0,
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0},
0x90)
bpf$BPF_RAW_TRACEPOINT_OPEN(0x11,
&(0x7f0000000540)=3D{&(0x7f0000000000)=3D'kfree\x00', r0}, 0x10)

So syzkaller generated a BPF tracing program. 0x85 is BPF_JMP |
BPF_CALL, which is used to invoke BPF helpers; 0x71 is 113, which is
the number of the probe_read_kernel helper, which basically takes
arbitrary values as input and casts them to kernel pointers, and then
probe-reads them. And before that is some kinda ALU op with 0xff600000
as immediate.

So it looks like the answer to that question is "the BPF program tries
to copy from the VSYSCALL page because syzkaller decided to write BPF
code that does specifically that, and the BPF helper let it do that".

copy_from_kernel_nofault() does check
copy_from_kernel_nofault_allowed() to make sure the pointer really is
a kernel pointer, and the X86 version of that rejects anything in the
userspace part of the address space. But it does not know about the
vsyscall area.

