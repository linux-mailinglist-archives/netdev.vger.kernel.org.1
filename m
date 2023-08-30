Return-Path: <netdev+bounces-31322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5146978D263
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 05:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814521C20A96
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 03:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440261111;
	Wed, 30 Aug 2023 03:16:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3224D1106
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 03:16:52 +0000 (UTC)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F332113
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 20:16:50 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4036bd4fff1so184471cf.0
        for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 20:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693365410; x=1693970210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsbp1MTEU+V1uOgThW4ZCQMBGCH501XSWX0uFO9d4wk=;
        b=GKFskmJC3Usb6QiGv+3yx0kgppdm44yW/f8dC2G6LBI2VHgUM8eobmnwgDBN4MXmpc
         0SfxbVKTzwjl5Cc0zhTdquN+YYPDR5Xjj/+ADs6faqFiF7lyMxOLSmYrSHOewPgOaldE
         zBx1vBozNn0tUpEoUFGfksMHZC3a5ZAjTKaZiVVZQXxgS1bsLnh7glj+Xx9cO568AEBC
         qCmS8y8nW3+tgUYl0yzA7loqSnnZKjrC2KpbCtXWhFxt9NAM6xDC+2j4b1TZll4axyxL
         6FsPWNYGEBDD0xZ88dPgT/B15vfWJOmlSM1qUK2R9vPtY9xCZ89Uq2pptxsBebZLXr8s
         I3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693365410; x=1693970210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsbp1MTEU+V1uOgThW4ZCQMBGCH501XSWX0uFO9d4wk=;
        b=XiAIjwuucTvDvcsB8gvfhax9cyIO5OtlLhY9cWO1wcwkcXcFgohKX23JknorB7XWpn
         AAxrtgo8A8hAtOTuevZUKw52xw1DcA6UQNN9cbIJ9J0mqEbVcE0rnqqff0OCHz9nxewP
         UI+Cmcz/ha68GRfZtqSH5LVK6qAIRngdwK+YC95q87paHEDG7dK57awpiWA3WdA+D+nC
         0ic7bNhE7i55WJtWTNDhezf+CuBQ6h1Il1gqwtV04sjmthSjZHuqRgkNYoQoqMhzLR78
         rgtK/5zu8LrsSwgvlzqY3/+nOFD2dxxfNR28/bdUOGK4qX+Xxy3d8CjhmdKQWCaMimE0
         rx7Q==
X-Gm-Message-State: AOJu0YyMZOhQlwH9td1Xn26TPgU0skIpr2jo56zQMM3bgI+gevw0rLih
	RbQA2d6zS2NDgQg1KKug595SyLpNqshFz03CYbdZMw==
X-Google-Smtp-Source: AGHT+IF74n41/IyZQfm4cGgTZ3BY5g18F983kAFuueLTtIFcKMZXThCPPHh/XvC4DdWCgr9yJ12Qbcdr/jIjAsCG0/M=
X-Received: by 2002:a05:622a:1910:b0:403:aa88:cf7e with SMTP id
 w16-20020a05622a191000b00403aa88cf7emr323298qtc.29.1693365409601; Tue, 29 Aug
 2023 20:16:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000017ad3f06040bf394@google.com> <0000000000000c97a4060417bcaf@google.com>
In-Reply-To: <0000000000000c97a4060417bcaf@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 30 Aug 2023 05:16:38 +0200
Message-ID: <CANn89iKB_fnWYT6UH3SsjArRT2424gVo2FjLoMyDrpixts+m2Q@mail.gmail.com>
Subject: Re: [syzbot] [net] INFO: rcu detected stall in sys_close (5)
To: syzbot <syzbot+e46fbd5289363464bc13@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, davem@davemloft.net, eric.dumazet@gmail.com, 
	gautamramk@gmail.com, hdanton@sina.com, jhs@mojatatu.com, jiri@resnulli.us, 
	kuba@kernel.org, lesliemonis@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mohitbhasi1998@gmail.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdp.sachin@gmail.com, 
	syzkaller-bugs@googlegroups.com, tahiliani@nitk.edu.in, 
	viro@zeniv.linux.org.uk, vsaicharan1998@gmail.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 30, 2023 at 12:57=E2=80=AFAM syzbot
<syzbot+e46fbd5289363464bc13@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit ec97ecf1ebe485a17cd8395a5f35e6b80b57665a
> Author: Mohit P. Tahiliani <tahiliani@nitk.edu.in>
> Date:   Wed Jan 22 18:22:33 2020 +0000
>
>     net: sched: add Flow Queue PIE packet scheduler
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D101bb71868=
0000
> start commit:   727dbda16b83 Merge tag 'hardening-v6.6-rc1' of git://git.=
k..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D121bb71868=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D141bb71868000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D45047a5b8c295=
201
> dashboard link: https://syzkaller.appspot.com/bug?extid=3De46fbd528936346=
4bc13
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14780797a80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D17c1fc9fa8000=
0
>
> Reported-by: syzbot+e46fbd5289363464bc13@syzkaller.appspotmail.com
> Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

Yeah, I figured that out, and sent :

https://patchwork.kernel.org/project/netdevbpf/patch/20230829123541.3745013=
-1-edumazet@google.com/

