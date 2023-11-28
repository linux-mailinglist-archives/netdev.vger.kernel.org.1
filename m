Return-Path: <netdev+bounces-51719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D48AD7FBDAD
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D43F91C20AEB
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0328A5C91B;
	Tue, 28 Nov 2023 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XYACjMUB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B34D60
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:05:42 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cfd9ce0745so131405ad.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701183942; x=1701788742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIyfxB2pi1DD/xFaz4h7up8NvJi6wi3KWQr5MkbyogY=;
        b=XYACjMUBcKtzd73PNVSbY7odkcNloAHL4x4+yCQl9nrMJNGi8WAUlwKkcn63Hm74q/
         owd8eAlyDuMh1xoLNh7NlHGqRPE0OgNAhFEt205JlyGkkZa8dYYbLGOkkyQE8BRahvy/
         BfsZeQoxusV/48HKvuefFSYxfFUCXKL3M1LYDqynLDXFWjRoSxhrFA3AiFAUrekk5/FJ
         ZJgMC2uanJIaWyVDyP3qpYHK4sFH9NQxzECkKxNcMiZmNwk81CHfBscWqMuWkUlRJJ4d
         /FEIzhxvZBJhcHsTZ2KTRAkHqx0ibCIGOy96UJSTHqF/nrgollAnp6zcG3sTwzdFqK2H
         wf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183942; x=1701788742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIyfxB2pi1DD/xFaz4h7up8NvJi6wi3KWQr5MkbyogY=;
        b=kj1r9EAGZUw3EVQy6ZriQkR9ZZlB1DNXTDgh0e6HZQJHtHeMigR3nQ7RTMgXqs7WUU
         qL17BF2d7OaiKOA1/SV89UzBQy7GmjN3XscyQGe08Re7SuT4fV/GqknGaH2PLk5goz6f
         FuSAy5oOydImkBdc2ATfmxht60bFFBKToLin8ytQoZB3FH9lRZIiBCWzX7uz67rAiMTT
         vZOKPVAI9jCBXu4IGQQnhpcxdDZk5Y7au0IKgPQQi+kxJ/5vObbQxfBIS2I4e2NX6kPu
         I4OtSPt8koRcw5e1nawyEI669Zh65qpWn1U542KaRtthHtaJlyY4+ommlNZyplh201uN
         kmyA==
X-Gm-Message-State: AOJu0YyODgXz/S0FZcfUKjSwBwY1ok3tOT1eaOhVlCg67dW8+5sOjW8y
	TLNyZEUj9o+BujvcGduBTl/hhscsMOKirakxyKKbLoolIIzVMCPWyzvzhw==
X-Google-Smtp-Source: AGHT+IGrQdlGKDgA9FHhDONGBYH9TrWtTN+htijQaz06c0I9y8Wie/gSN4rLC6ODCVB86yKfb2AlxQrSgbGy8HeQXRo=
X-Received: by 2002:a17:902:c113:b0:1cf:b1d3:72ab with SMTP id
 19-20020a170902c11300b001cfb1d372abmr709344pli.27.1701183942051; Tue, 28 Nov
 2023 07:05:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000029fce7060ad196ad@google.com> <CAM0EoM=20ATLfrRMGh-zqgx7BrHiyCUmiCYBX_f1ST69UFRfOA@mail.gmail.com>
In-Reply-To: <CAM0EoM=20ATLfrRMGh-zqgx7BrHiyCUmiCYBX_f1ST69UFRfOA@mail.gmail.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 28 Nov 2023 16:05:25 +0100
Message-ID: <CANp29Y6UOHhvwf=hh7PFRsyZspJx=w==4=A8TjPEQqXeYvBD+A@mail.gmail.com>
Subject: Re: [syzbot] Monthly net report (Nov 2023)
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: syzbot <syzbot+listaba4d9d9775b9482e752@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jamal,

This sounds interesting, thanks for the suggestion!

It would be a lot of emails though, so maybe we could randomly pick a
few of them each time.
I've filed https://github.com/google/syzkaller/issues/4369

--=20
Aleksandr

On Thu, Nov 23, 2023 at 3:03=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Thu, Nov 23, 2023 at 8:12=E2=80=AFAM syzbot
> <syzbot+listaba4d9d9775b9482e752@syzkaller.appspotmail.com> wrote:
> >
> > Hello net maintainers/developers,
> >
> > This is a 31-day syzbot report for the net subsystem.
> > All related reports/information can be found at:
> > https://syzkaller.appspot.com/upstream/s/net
> >
>
> Hi,
> Could you please Cc the stakeholders for each issue (especially when
> there is a reproducer)? Not everybody reads every single message that
> shows up in the kernel.
>
> cheers,
> jamal
>
> > During the period, 5 new issues were detected and 13 were fixed.
> > In total, 77 issues are still open and 1358 have been fixed so far.
> >
> > Some of the still happening issues:
> >
> > Ref  Crashes Repro Title
> > <1>  3878    Yes   KMSAN: uninit-value in eth_type_trans (2)
> >                    https://syzkaller.appspot.com/bug?extid=3D0901d0cc75=
c3d716a3a3
> > <2>  892     Yes   possible deadlock in __dev_queue_xmit (3)
> >                    https://syzkaller.appspot.com/bug?extid=3D3b165dac15=
094065651e
> > <3>  860     Yes   INFO: task hung in switchdev_deferred_process_work (=
2)
> >                    https://syzkaller.appspot.com/bug?extid=3D8ecc009e20=
6a956ab317
> > <4>  590     Yes   INFO: task hung in rtnetlink_rcv_msg
> >                    https://syzkaller.appspot.com/bug?extid=3D8218a8a0ff=
60c19b8eae
> > <5>  390     Yes   WARNING in kcm_write_msgs
> >                    https://syzkaller.appspot.com/bug?extid=3D52624bdfbf=
2746d37d70
> > <6>  373     Yes   INFO: rcu detected stall in corrupted (4)
> >                    https://syzkaller.appspot.com/bug?extid=3Daa7d098bd6=
fa788fae8e
> > <7>  249     Yes   INFO: rcu detected stall in tc_modify_qdisc
> >                    https://syzkaller.appspot.com/bug?extid=3D9f78d5c664=
a8c33f4cce
> > <8>  240     Yes   BUG: corrupted list in p9_fd_cancelled (2)
> >                    https://syzkaller.appspot.com/bug?extid=3D1d26c4ed77=
bc6c5ed5e6
> > <9>  172     No    INFO: task hung in linkwatch_event (3)
> >                    https://syzkaller.appspot.com/bug?extid=3Dd4b2f8282f=
84f54e87a1
> > <10> 154     Yes   WARNING in print_bfs_bug (2)
> >                    https://syzkaller.appspot.com/bug?extid=3D630f83b42d=
801d922b8b
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > To disable reminders for individual bugs, reply with the following comm=
and:
> > #syz set <Ref> no-reminders
> >
> > To change bug's subsystems, reply with:
> > #syz set <Ref> subsystems: new-subsystem
> >
> > You may send multiple commands in a single email message.
> >
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/CAM0EoM%3D20ATLfrRMGh-zqgx7BrHiyCUmiCYBX_f1ST69UFRfOA%40ma=
il.gmail.com.

