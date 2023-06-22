Return-Path: <netdev+bounces-13017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CC7739E0D
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 12:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0EEF281907
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 10:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACCC8BFE;
	Thu, 22 Jun 2023 10:10:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFCA3AA8D
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 10:10:32 +0000 (UTC)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF67DE
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 03:10:31 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3fde9bfb3c8so104321cf.0
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 03:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687428630; x=1690020630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkgsASzwNg72Z4flD/BJsv7lo2gLpLer9JEuetW15B8=;
        b=nWjlx0BqGuGWM4YnKTiAEHHNKWnxzaW57koF1m/lDUc3iM5ilPMdwR5Hr8lECOFH9K
         ja163HlBF6zc+5zHq9u2ToGCc9Rdimj5sh0OKaDlbOJnxDeRT0axNUQUQQIX1PcDlcVJ
         ODw9sp1TDOVwJcxWw7InZA4QQtbBIbtlnrHIXbLWOVaSyzexkFMKGB3eMGzWZ4S7eCPM
         1WWygFFxZY0hHpj6o73cHLErp1eOaN3G40uak9jUEzTNkwjkjOJtezcm7D5zbQlIl4/J
         G3r97jHKVTCZo3/o1aojI39GmgaS1DXigO3oJsGfVi2MuMHjXdnlo34D0Ym0PK45nCp1
         X6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687428630; x=1690020630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkgsASzwNg72Z4flD/BJsv7lo2gLpLer9JEuetW15B8=;
        b=jol15u4yUr9nx8WWUNMwp2/4UnkpUFku+u210R3FLSN3y50h/UBxQOW2vgh3DAV/TU
         RN1mcs9/ucZMG4+K98A2J2ztl6Bd5vKG5lD7KErqLCHIW4kYRn/UYXYkBldIt7gVuDJz
         mdLOD7wjCohBIw6I7giE4c5Dgb9yRVc5Ha/6D3ptcsOU4PdHpu2rJA3aMty+qeioD/r7
         1lnC/aBwGlTrDQ8DknkIM/OZDp7fr90aUPl9QHe5rslICxBb3fIGMrZHDL5gWNe1cVN5
         y7DhY+2icolEindc/kRoW7dLR/fmhT6jFy6jpSR/0VW0m45spl1KAilvfGkqbK6H8VyZ
         0DxA==
X-Gm-Message-State: AC+VfDyk7mlpRQtNor2RuUXzXnkwmerHzxO4KYljNaUnMCpogQYTXJxL
	vBH0JArtitDD245RoPo+S6AV/JN2qo/lu2YsG2XzPg==
X-Google-Smtp-Source: ACHHUZ6Q1QcBAYct77Mou1FTkmW7Ny6SP5E4ENYRGZuu77uLgIom4hh9ZTzjmE3i8oGrQ793EsKARYXdxva/xRZ1+uQ=
X-Received: by 2002:a05:622a:85:b0:3f8:5b2:aeed with SMTP id
 o5-20020a05622a008500b003f805b2aeedmr1503046qtw.21.1687428630458; Thu, 22 Jun
 2023 03:10:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621154337.1668594-1-edumazet@google.com> <ZJQAdLSkRi2s1FUv@nanopsycho>
 <CANn89iLeU+pBrcHZyQoSRa-X_3G-Y8cjF6FJy4XwkJc7ronqMA@mail.gmail.com>
 <ZJQGTnqo6IgMGZ4j@nanopsycho> <CANn89iK8p7SuGE7rrOKZ6bxoZZhQXBHufj8+YnbNoE-ivKopiw@mail.gmail.com>
 <ZJQT4/SZJN7qGUHI@nanopsycho>
In-Reply-To: <ZJQT4/SZJN7qGUHI@nanopsycho>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Jun 2023 12:10:19 +0200
Message-ID: <CANn89iLio4+ik5qAQwd7SKr8ihS+y7fvkYYc=ZuuGqJ4BVfgdQ@mail.gmail.com>
Subject: Re: [PATCH net] netlink: fix potential deadlock in netlink_set_err()
To: Jiri Pirko <jiri@resnulli.us>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+a7d200a347f912723e5c@syzkaller.appspotmail.com, 
	Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 11:27=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrot=
e:
>
> Thu, Jun 22, 2023 at 10:42:34AM CEST, edumazet@google.com wrote:
> >On Thu, Jun 22, 2023 at 10:29=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> w=
rote:
> >>
> >> Thu, Jun 22, 2023 at 10:14:56AM CEST, edumazet@google.com wrote:
> >> >On Thu, Jun 22, 2023 at 10:04=E2=80=AFAM Jiri Pirko <jiri@resnulli.us=
> wrote:
> >> >>
> >> >> Wed, Jun 21, 2023 at 05:43:37PM CEST, edumazet@google.com wrote:
> >> >> >syzbot reported a possible deadlock in netlink_set_err() [1]
> >> >> >
> >> >> >A similar issue was fixed in commit 1d482e666b8e ("netlink: disabl=
e IRQs
> >> >> >for netlink_lock_table()") in netlink_lock_table()
> >> >> >
> >> >> >This patch adds IRQ safety to netlink_set_err() and __netlink_diag=
_dump()
> >> >> >which were not covered by cited commit.
> >> >> >
> >> >> >[1]
> >> >> >
> >> >> >WARNING: possible irq lock inversion dependency detected
> >> >> >6.4.0-rc6-syzkaller-00240-g4e9f0ec38852 #0 Not tainted
> >> >> >
> >> >> >syz-executor.2/23011 just changed the state of lock:
> >> >> >ffffffff8e1a7a58 (nl_table_lock){.+.?}-{2:2}, at: netlink_set_err+=
0x2e/0x3a0 net/netlink/af_netlink.c:1612
> >> >> >but this lock was taken by another, SOFTIRQ-safe lock in the past:
> >> >> > (&local->queue_stop_reason_lock){..-.}-{2:2}
> >> >> >
> >> >> >and interrupts could create inverse lock ordering between them.
> >> >> >
> >> >> >other info that might help us debug this:
> >> >> > Possible interrupt unsafe locking scenario:
> >> >> >
> >> >> >       CPU0                    CPU1
> >> >> >       ----                    ----
> >> >> >  lock(nl_table_lock);
> >> >> >                               local_irq_disable();
> >> >> >                               lock(&local->queue_stop_reason_lock=
);
> >> >> >                               lock(nl_table_lock);
> >> >> >  <Interrupt>
> >> >> >    lock(&local->queue_stop_reason_lock);
> >> >> >
> >> >> > *** DEADLOCK ***
> >> >> >
> >> >> >Fixes: 1d482e666b8e ("netlink: disable IRQs for netlink_lock_table=
()")
> >> >>
> >> >> I don't think that this "fixes" tag is correct. The referenced comm=
it
> >> >> is a fix to the same issue on a different codepath, not the one who
> >> >> actually introduced the issue.
> >> >>
> >> >> The code itself looks fine to me.
> >> >
> >> >Note that the 1d482e666b8e had no Fixes: tag, otherwise I would have =
taken it.
> >>
> >> I'm aware it didn't. But that does not implicate this patch should hav=
e
> >> that commit as a "Fixes:" tag. Either have the correct one pointing ou=
t
> >> which commit introduced the issue or omit the "Fixes:" tag entirely.
> >> That's my point.
> >
> >My point is that the cited commit should have fixed all points
> >where the nl_table_lock was read locked.
>
> Yeah, it was incomplete. I agree. I don't argue with that.
>
> >
> >When we do locking changes, we have to look at the whole picture,
> >not the precise point where lockdep complained.
> >
> >For instance, this is the reason this patch also changes  __netlink_diag=
_dump(),
> >even if the report had nothing to do about it yet.
> >
> >So this Fixes: tag is fine, thank you.
>
> Then we have to agree to disagree I guess. It is not fine.
>
> Quoting from Documentation/process/handling-regressions.rst:
>   Add a "Fixes:" tag to specify the commit causing the regression.
>
> Quoting from Documentation/process/submitting-patches.rst:
>   A Fixes: tag indicates that the patch fixes an issue in a previous comm=
it. It
>   is used to make it easy to determine where a bug originated, which can =
help
>   review a bug fix.

The previous commit definitely had an issue, because it was not complete.

We have many other cases of commits that complete the work started earlier.

I will continue doing so, and I will continue writing changelogs that
displease you.

>
> 1d482e666b8e is not causing any regression (to be known of), definitelly
> not the one this patch is fixing.

>
> Misusing "Fixes" tag like this only adds unnecessary confusion.
> That is my point from the beginning. I don't understand your resistance
> to be honest.

To be honest, I do not understand you either, I suggest we move on,
we obviously are not on the same page.

