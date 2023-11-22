Return-Path: <netdev+bounces-50273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 135C47F52D8
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 22:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C25462813F1
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 21:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0D71C683;
	Wed, 22 Nov 2023 21:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CGHoq7DN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0311D1
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 13:47:34 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-548db776f6cso957a12.1
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 13:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700689653; x=1701294453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ri0TUxs1iJqPSw8JjPihazxc0yv5DIGj36AegZR8pU=;
        b=CGHoq7DN45zDRTTgfGvRS3N6DqyYLdFdlSYrxFiqosZifIlVValLjnvSaqMvakjvvf
         V7m+26w3FTCgc5ybxSnXEIVUZXRjIoNO7WzOW1hpasyemIGDv5wo/oew4paEj1iQnpuf
         qcw2EQAndjzPNG+E8SGfeNv0JD0zyrfAsL9MohfhsEikwOvjcBPIIZQBeXSTO4hV3KKX
         KIYn7EhQcr3eTW4/8x1rBPZ33VOwOcFsrSkSKPncsxiZAdVxu8eUZINxRoEU/S0q4gDz
         IL1Z/oxPEUp+FZSnQscfaXboLHeR9ESeB8FM+B6jIc6Krlp6yJm425RiucytkXe7NYWm
         SSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700689653; x=1701294453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ri0TUxs1iJqPSw8JjPihazxc0yv5DIGj36AegZR8pU=;
        b=nF8wLDlZmVHuBZloqSOUNM1ci22aQDrtvvsXnDrjBwHcZIW1Zeg1cy8yc307Sf6NUw
         CvcxbMbCmUCup5UeqR9eFnOt6TkyepoEVOeKFLGanmC16Rr9IKxRjmHjwbB/0/1E4y0q
         aUJCd6gljvzikgpfvA3ix7bdDU1vOx8zmCo+bFSGP08IB5SSnmVtOC7hyf20jJgVUzz0
         JUS19/R+fOgOQxZJY7AuSXGkl43ruCxOs05aPwtz4FF4dy9E/7VrQ68/JOZHJsXAVVmF
         0C59WXuEP5EXp2DRCtlEueKHvgVJcdBa4BxrithUFaFdqRjJJkKNszz0gIhlqSNfFvX9
         jRQQ==
X-Gm-Message-State: AOJu0Yyl4fjTLsLew/wnmjb0UgjQeF72KPLUwgTZbxG3yzCr4iQjMDP6
	ciqAN0GZgNxlRjSV+qpJaEt+WnHM5yznEGE+pNHGEg==
X-Google-Smtp-Source: AGHT+IFfH3uoulBs1CB0xxsfIZbO4jIU2TGV/xlmcswW6Z3QOAFt4A1CZNUt+arbkGuS54JvgazffJ+DWiJdcIctgg4=
X-Received: by 2002:a05:6402:3815:b0:544:466b:3b20 with SMTP id
 es21-20020a056402381500b00544466b3b20mr192428edb.5.1700689653211; Wed, 22 Nov
 2023 13:47:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000347a250608e8a4d1@google.com>
In-Reply-To: <000000000000347a250608e8a4d1@google.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 22 Nov 2023 22:46:55 +0100
Message-ID: <CAG48ez1_kkR6-tSkmzBu0Z-Jex0MoKQ5OJSQaK3mcHc-aT+G+w@mail.gmail.com>
Subject: Re: [syzbot] [net?] general protection fault in tls_merge_open_record
To: syzbot <syzbot+40d43509a099ea756317@syzkaller.appspotmail.com>
Cc: borisp@nvidia.com, davem@davemloft.net, edumazet@google.com, 
	john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 6:52=E2=80=AFAM syzbot
<syzbot+40d43509a099ea756317@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    66f1e1ea3548 Add linux-next specific files for 20231027
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D11b621fd68000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D2911330219149=
de4
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D40d43509a099ea7=
56317
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1552332d680=
000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/e0bf12f215f2/dis=
k-66f1e1ea.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5e854ca6e2c3/vmlinu=
x-66f1e1ea.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/25e8c098714e/b=
zImage-66f1e1ea.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+40d43509a099ea756317@syzkaller.appspotmail.com
>
> general protection fault, probably for non-canonical address 0xdffffc0000=
000001: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> CPU: 1 PID: 12569 Comm: syz-executor.0 Not tainted 6.6.0-rc7-next-2023102=
7-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 10/09/2023
> RIP: 0010:_compound_head include/linux/page-flags.h:247 [inline]
> RIP: 0010:put_page include/linux/mm.h:1544 [inline]
> RIP: 0010:tls_merge_open_record+0x4b9/0x7f0 net/tls/tls_sw.c:669

I've posted an analysis and suggested fix for the issue at
<https://lore.kernel.org/lkml/20231122214447.675768-1-jannh@google.com/>.

