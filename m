Return-Path: <netdev+bounces-31811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 529C67905A0
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 08:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC0B1C208F6
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 06:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796811FD8;
	Sat,  2 Sep 2023 06:39:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6867C1FC5
	for <netdev@vger.kernel.org>; Sat,  2 Sep 2023 06:39:51 +0000 (UTC)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1181702
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 23:39:50 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-407db3e9669so105761cf.1
        for <netdev@vger.kernel.org>; Fri, 01 Sep 2023 23:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693636789; x=1694241589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKeCgMFTclzutCgRiJYlB9DA4BMs3ax9fKPFalXWCvs=;
        b=04ZVAOTodXvwTy6BLg0U9vSHFb7uGyitUr7iSMbx24n/APVrSrIwHw5W017dSuOMkP
         gS3WLbqV22qAE35baiT2aCvSAxklyHq3g9E5KY75hSKMObiNqwKG94P/gNObN963d349
         RffGlHsewa6VLsi6tgh70OS9mdRW1TqBCgMG3X+dMjhgip9K5v4BSuJds+cUByX7SO5H
         54qqC6ENfU6qJQROM4ELxPH7uT/uoxOww1AH+dNOvfwipaQb3ByzwZ0ye0hnnVWeul5Q
         g2zOnfuTXCxlpE6cvS+qsNL5yZ8LvXBx9ms7Enw88azd8xlWKa9TYeu/UAt7TeqeWQRh
         0x0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693636789; x=1694241589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKeCgMFTclzutCgRiJYlB9DA4BMs3ax9fKPFalXWCvs=;
        b=Ordv5IvDhR2TDQHNGSesgonKQPgueINvfgbVt8JU2FwCQB/M7SEvWpe14vDAmLN3+h
         JyyQbfR/oM+/aidsF7M5nj0UFsHN8MD/PRWa8356LmLb1d+saNUD3P0xN2f3KdT4XsSJ
         JONAOtC1H1FD6nVrLbIWy5SZ0WiGGwX4lfhWPWfoE/W+3mQFaoLrrlKsaW+ZL5whn8Hs
         rX4rNaAmIYNTOks1FgobkK7HbdvOv31T2JGXo9bRNERWrmari+e4pZm4nhvHNyDrrJzB
         8E+N4jILcSOZcKeqpo2q9AEAMaKMwmCZoE1v1pSEjNLe7viUosZzSI6/nC+slOysImFZ
         JRdw==
X-Gm-Message-State: AOJu0YzC5OhfjOYqHoqoMTByRAGo4Rq6G0zK8NZSRXGf9PU5azBtpoWm
	nSeKz9OrSJsAd5RKOCPVGKHH667ln2rxngKqGUqMCA==
X-Google-Smtp-Source: AGHT+IHfw+FUIzTjOKnUkx5nU9gmqaNDNpgkwGBJWminz73tstDgdlpEOp8d/OhaTbtV1pntWANnWPBzjoCVcEpP8/A=
X-Received: by 2002:ac8:5852:0:b0:410:385c:d1e0 with SMTP id
 h18-20020ac85852000000b00410385cd1e0mr93808qth.25.1693636789035; Fri, 01 Sep
 2023 23:39:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230902002708.91816-1-kuniyu@amazon.com> <20230902002708.91816-2-kuniyu@amazon.com>
In-Reply-To: <20230902002708.91816-2-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 2 Sep 2023 08:39:37 +0200
Message-ID: <CANn89i+H-R7+GYvxgqoc0NCgpKSuZUrY20U+oAkiRWqsbFyt0Q@mail.gmail.com>
Subject: Re: [PATCH v1 net 1/4] af_unix: Fix data-races around user->unix_inflight.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzkaller <syzkaller@googlegroups.com>, Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 2, 2023 at 2:28=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> user->unix_inflight is changed under spin_lock(unix_gc_lock),
> but too_many_unix_fds() reads it locklessly.
>
> Let's annotate the write/read accesses to user->unix_inflight.
>
> BUG: KCSAN: data-race in unix_attach_fds / unix_inflight
>
> write to 0xffffffff8546f2d0 of 8 bytes by task 44798 on cpu 1:
>  unix_inflight+0x157/0x180 net/unix/scm.c:66
>  unix_attach_fds+0x147/0x1e0 net/unix/scm.c:123
>  unix_scm_to_skb net/unix/af_unix.c:1827 [inline]
>  unix_dgram_sendmsg+0x46a/0x14f0 net/unix/af_unix.c:1950
>  unix_seqpacket_sendmsg net/unix/af_unix.c:2308 [inline]
>  unix_seqpacket_sendmsg+0xba/0x130 net/unix/af_unix.c:2292
>  sock_sendmsg_nosec net/socket.c:725 [inline]
>  sock_sendmsg+0x148/0x160 net/socket.c:748
>  ____sys_sendmsg+0x4e4/0x610 net/socket.c:2494
>  ___sys_sendmsg+0xc6/0x140 net/socket.c:2548
>  __sys_sendmsg+0x94/0x140 net/socket.c:2577
>  __do_sys_sendmsg net/socket.c:2586 [inline]
>  __se_sys_sendmsg net/socket.c:2584 [inline]
>  __x64_sys_sendmsg+0x45/0x50 net/socket.c:2584
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3b/0x90 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>
> read to 0xffffffff8546f2d0 of 8 bytes by task 44814 on cpu 0:
>  too_many_unix_fds net/unix/scm.c:101 [inline]
>  unix_attach_fds+0x54/0x1e0 net/unix/scm.c:110
>  unix_scm_to_skb net/unix/af_unix.c:1827 [inline]
>  unix_dgram_sendmsg+0x46a/0x14f0 net/unix/af_unix.c:1950
>  unix_seqpacket_sendmsg net/unix/af_unix.c:2308 [inline]
>  unix_seqpacket_sendmsg+0xba/0x130 net/unix/af_unix.c:2292
>  sock_sendmsg_nosec net/socket.c:725 [inline]
>  sock_sendmsg+0x148/0x160 net/socket.c:748
>  ____sys_sendmsg+0x4e4/0x610 net/socket.c:2494
>  ___sys_sendmsg+0xc6/0x140 net/socket.c:2548
>  __sys_sendmsg+0x94/0x140 net/socket.c:2577
>  __do_sys_sendmsg net/socket.c:2586 [inline]
>  __se_sys_sendmsg net/socket.c:2584 [inline]
>  __x64_sys_sendmsg+0x45/0x50 net/socket.c:2584
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3b/0x90 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>
> value changed: 0x000000000000000c -> 0x000000000000000d
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 44814 Comm: systemd-coredum Not tainted 6.4.0-11989-g68433066=
89af #6
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-=
gd239552ce722-prebuilt.qemu.org 04/01/2014
>
> Fixes: 712f4aad406b ("unix: properly account for FDs passed over unix soc=
kets")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

