Return-Path: <netdev+bounces-33919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F037A0A72
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 18:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5F91F211AC
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 16:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FEA21351;
	Thu, 14 Sep 2023 16:06:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356F618E17
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 16:06:43 +0000 (UTC)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9647A1FD0
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 09:06:42 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7926b7f8636so30439639f.1
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 09:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694707602; x=1695312402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WsLMEgy42yaBiT7+peH789YpkE1cZSDVdqIV9tFkDJs=;
        b=ZwiKhsSkmTCyf5TvYHer9x9UIqGqff+gaCcfpMlKqeyNEPkf5i4dYn1j452qOWD8eL
         Ll64+SLu7OMuBztJhHhkwr5KFxloQk28bGcnSoQx15Dk7xyiHmVQmd1Gv+HqtnPTKUAd
         ztB+9tFxZl8mmsJYKvWBgsU0yKcJuEOKON1kAtrYtWDBvHkwxCHzggoTgr1KP8nsMqNN
         F94gYqRCBj8KGHcY4q+e9YyRPafQOASTidXDlott5g6saGhp7TNrIWT48XDZJchwjyNT
         0qfJ0T3i1pQRbxvE6XiGTPiRBXeJizURbdID82jf9JgUK80XEf3QX6V9pR58ii49Rd0A
         OS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694707602; x=1695312402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WsLMEgy42yaBiT7+peH789YpkE1cZSDVdqIV9tFkDJs=;
        b=FCXMYoIUfhxm8XLEHBQmlT4qh1vRzPAfv1LbcJNqhA3xJCugDYOSbAQ9TEhWSpQlky
         J+OvExnEykg7QN+F1sZzMtkX7FC6oeDzJDFgNXFkcpvfGlfXB4EoaefBtIX2x8LLrKjs
         HRvPJ0GRGEn5aI06KlvbjNJh51QUd7q7EmaoX3c1Jmh8J0DIn6keFn7JpiiTK3J8O9Db
         osBls/pgQlJs/4HOMqSUHxRSIIy0ctt3eH//nOCJKXoBIGgOZ9GUVjA15WP3piNU/Lno
         BMmBZXMZcuXvYFIHUoF2Lx6/fMVYHMpd0UBNXZlFYotB8m4VZ5/P79tTgMNcasgtpAA6
         EUVg==
X-Gm-Message-State: AOJu0YwhuHP8WgkpS2BoZS8H0RTW2sGOXN1aV4VDCZ1kZKhAmGhjw0L0
	y1tARTv5b4iXTY4aymazkKekvzHpomDMemBNSIEnqw==
X-Google-Smtp-Source: AGHT+IG5uiQN1/JqfzfqQfLLWnTjs7aRdbIZbEZdBy/k86sXDjNlmcQiA459x+Nf/3/c0H14MFVFDk8eX4l2uRqCEMk=
X-Received: by 2002:a05:6602:1b09:b0:790:b44f:b9ee with SMTP id
 dk9-20020a0566021b0900b00790b44fb9eemr2328524iob.10.1694707601790; Thu, 14
 Sep 2023 09:06:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000007285dd0604a053db@google.com> <cbakbuszcnwtfkdavtif3lwfncelm2ugn6eyd5pd5dmdocxqh5@3op6br7uaxd7>
In-Reply-To: <cbakbuszcnwtfkdavtif3lwfncelm2ugn6eyd5pd5dmdocxqh5@3op6br7uaxd7>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 14 Sep 2023 18:06:01 +0200
Message-ID: <CAG_fn=Umt5Gm1aFa2Tr8LCXboDZvBx9WBw_AvvkN3_7eyXSsRg@mail.gmail.com>
Subject: Re: [syzbot] [sctp?] [reiserfs?] KMSAN: uninit-value in __schedule (4)
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: syzbot <syzbot+00f1a932d27258b183e7@syzkaller.appspotmail.com>, bp@alien8.de, 
	brauner@kernel.org, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, lucien.xin@gmail.com, mingo@redhat.com, 
	netdev@vger.kernel.org, reiserfs-devel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 5:25=E2=80=AFPM Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
>
> On Tue, Sep 05, 2023 at 10:55:01AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    a47fc304d2b6 Add linux-next specific files for 20230831
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D131da298680=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6ecd2a74f20=
953b9
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D00f1a932d2725=
8b183e7
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for=
 Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D116e5fcba=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D118e912fa80=
000
>
> Not sure why sctp got tagged here. I could not find anything network
> related on this reproducer or console output.

I am afraid this is the effect of reports from different tools being
clustered together: https://github.com/google/syzkaller/issues/4168
The relevant KMSAN report can be viewed on the dashboard:
https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D144ba287a80000 -
that's where sctp was deduced from.

I suspect there's still nothing specific to sctp though: looks like
schedule_debug() somehow accidentally reads past the end of the task
stack.

>   Marcelo
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/cbakbuszcnwtfkdavtif3lwfncelm2ugn6eyd5pd5dmdocxqh5%403op6b=
r7uaxd7.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

