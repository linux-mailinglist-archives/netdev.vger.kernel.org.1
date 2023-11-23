Return-Path: <netdev+bounces-50544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE847F60F3
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 15:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5384F281E58
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 14:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA522E82B;
	Thu, 23 Nov 2023 14:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="iPr0udDv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7ED71B2
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 06:03:05 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5cca8b559b3so9087067b3.0
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 06:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700748185; x=1701352985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ks4NgGWTRdOYTAWFkBw8ls2lopTY/knpPpxWc0eVjoY=;
        b=iPr0udDvMrnJdNyWiJ7V+SAybczUTCLS2Q2AfJXnJCl/3wXxE8u20Ku5ig86V6S28w
         b8r63DTBsBXGllgR4IXcohAH4B5/fsbFQu24OemxiHx0Sz76qp3j64ODNH2SVtY8C4BU
         m/tfzqa6ssmQf0N20ggvIwwXMshoPO8odLgWTpI8u+5ojLUjDuxZInQlnB48G2HMEMw2
         3nAOM/PLOTI5VvuI1Q/qqBjuvgIgG5Z+yJWlT8mjvQPHEtOImyN5WpW9DMuePE7hna+b
         SBSBRP9geuFWpRcWvPx7OvWIYrs1cVMtUU88/na+brxjYQez/JQAZBG7gsIvnj8wQvqw
         2Zsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700748185; x=1701352985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ks4NgGWTRdOYTAWFkBw8ls2lopTY/knpPpxWc0eVjoY=;
        b=F6OvGJztyIOrPKQ6TncCEfMXwzz9JqiSb/T9h10NYUMZ/Gt1pgCZWEAEnCKggSy1u3
         l1lxIIbvHfq6JUxPjE16l87pP1ZHD6rDeMoWYTHjzx3Konl/6OwuKt3n3DwbwaWE5Hcw
         EFgbSw76XEJGwl2iWaGQ0rKZibYC6oN1YXmWZTvF2D5xRlOYzegNrkYqPL9JEV4Hu7BS
         XXDQHxAn51v6uZFpez2IdsqbUwZOb7RFxOUifBq13Fd0e8+FGyp9aZu8sh2qRu5hmDpp
         20618N1hi3Yz0yDV3KGuT8uJGnzM5kzggnTzl6C3oS+HwqOu56xWfKe6+vDrNdO4xTLS
         bY+g==
X-Gm-Message-State: AOJu0YzNGeEt3lmdRZHlwazOetlr94IM3p77VMyZfzYRPr+0z8BPEd/2
	LIM/iY3GX686Yff9TflO5gGzeGzB3ykBA5wldoMiI1uVvke/nXm3
X-Google-Smtp-Source: AGHT+IFeSEGxpikKOaXB3asFlkH9hGTW6XLBLwkVFeX0TjwdUJ7Wr4g3A78xPkh92BHyjfhhWrmud0z7maI1MIusWd0=
X-Received: by 2002:a81:430a:0:b0:5cc:c649:85e7 with SMTP id
 q10-20020a81430a000000b005ccc64985e7mr3982399ywa.26.1700748184870; Thu, 23
 Nov 2023 06:03:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000029fce7060ad196ad@google.com>
In-Reply-To: <00000000000029fce7060ad196ad@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 23 Nov 2023 09:02:53 -0500
Message-ID: <CAM0EoM=20ATLfrRMGh-zqgx7BrHiyCUmiCYBX_f1ST69UFRfOA@mail.gmail.com>
Subject: Re: [syzbot] Monthly net report (Nov 2023)
To: syzbot <syzbot+listaba4d9d9775b9482e752@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 8:12=E2=80=AFAM syzbot
<syzbot+listaba4d9d9775b9482e752@syzkaller.appspotmail.com> wrote:
>
> Hello net maintainers/developers,
>
> This is a 31-day syzbot report for the net subsystem.
> All related reports/information can be found at:
> https://syzkaller.appspot.com/upstream/s/net
>

Hi,
Could you please Cc the stakeholders for each issue (especially when
there is a reproducer)? Not everybody reads every single message that
shows up in the kernel.

cheers,
jamal

> During the period, 5 new issues were detected and 13 were fixed.
> In total, 77 issues are still open and 1358 have been fixed so far.
>
> Some of the still happening issues:
>
> Ref  Crashes Repro Title
> <1>  3878    Yes   KMSAN: uninit-value in eth_type_trans (2)
>                    https://syzkaller.appspot.com/bug?extid=3D0901d0cc75c3=
d716a3a3
> <2>  892     Yes   possible deadlock in __dev_queue_xmit (3)
>                    https://syzkaller.appspot.com/bug?extid=3D3b165dac1509=
4065651e
> <3>  860     Yes   INFO: task hung in switchdev_deferred_process_work (2)
>                    https://syzkaller.appspot.com/bug?extid=3D8ecc009e206a=
956ab317
> <4>  590     Yes   INFO: task hung in rtnetlink_rcv_msg
>                    https://syzkaller.appspot.com/bug?extid=3D8218a8a0ff60=
c19b8eae
> <5>  390     Yes   WARNING in kcm_write_msgs
>                    https://syzkaller.appspot.com/bug?extid=3D52624bdfbf27=
46d37d70
> <6>  373     Yes   INFO: rcu detected stall in corrupted (4)
>                    https://syzkaller.appspot.com/bug?extid=3Daa7d098bd6fa=
788fae8e
> <7>  249     Yes   INFO: rcu detected stall in tc_modify_qdisc
>                    https://syzkaller.appspot.com/bug?extid=3D9f78d5c664a8=
c33f4cce
> <8>  240     Yes   BUG: corrupted list in p9_fd_cancelled (2)
>                    https://syzkaller.appspot.com/bug?extid=3D1d26c4ed77bc=
6c5ed5e6
> <9>  172     No    INFO: task hung in linkwatch_event (3)
>                    https://syzkaller.appspot.com/bug?extid=3Dd4b2f8282f84=
f54e87a1
> <10> 154     Yes   WARNING in print_bfs_bug (2)
>                    https://syzkaller.appspot.com/bug?extid=3D630f83b42d80=
1d922b8b
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> To disable reminders for individual bugs, reply with the following comman=
d:
> #syz set <Ref> no-reminders
>
> To change bug's subsystems, reply with:
> #syz set <Ref> subsystems: new-subsystem
>
> You may send multiple commands in a single email message.
>

