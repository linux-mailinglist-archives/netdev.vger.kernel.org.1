Return-Path: <netdev+bounces-12953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B0273991F
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 10:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E05F1C2104F
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 08:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A4815ACA;
	Thu, 22 Jun 2023 08:15:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C03613A
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:15:10 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FF81BC3
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:15:08 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3fde9bfb3c8so93711cf.0
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687421707; x=1690013707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdY2rwLacxV8EH0PO6W4++582Ry3BSA7Uw2QqcmQ0U4=;
        b=hMIg/CI+Xo5q0HyGMKPf6gAmCbpK9PBORX3jvZMcuORWbozbkjgeW09yy0vd/ORPCo
         /x0qK8aq+pA2WbKNU8b853PAXVJI0U0bsZktGf2MkbA40NA1wkWPNplR4jS+2wdjjfMP
         7Il8gPxLuFaSLHVuFM7PicBdoS5A26L2+hmEw/axnNqUimIVFDJM+rut2cweNTPgnEcb
         Eo8cZVc3A5XbkOY4Swa2EE9Zz6gwAqF7N5fgE1lX/iEFjri3szbAEmIiajCmpRvAdIZe
         0rEmBXxvTdN6Dl1hZONqoa1lbaCvzWcHDqQ3IAGEOCQB50TnK4uUPyy6/ulCY2cgA+9l
         ilow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687421707; x=1690013707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdY2rwLacxV8EH0PO6W4++582Ry3BSA7Uw2QqcmQ0U4=;
        b=aChSxnvSNRZYg06GpGrd47QaGyYff+Kiy3NmyHmbpL7r8odbgnVcqZFst3WcmOgOLI
         sVXRnJNfT8CZZgzyjchWC5+EhUv5aeLMGzRyuvifvOWphgbWwLKA8xJ1R4EkPZsR6AD+
         8NB6+yWYWf9p+BkGe0FoDdniErdTukvBHRvms3qOUdb4koL7NSmyxF7oL4CWRHfpeckz
         8YZm1QJefCEWDK9MZSby89kxqa0X6uQKL4QhI7pGskI7eHyTmCnFcRbgCK1Qk0XGrMbh
         zWPagJS0FA2h8ClaeGqQ2GB4Wx38Dl2v0sXDszGeBBX38v8cXKNXuRhGAkGJrEcEOn9n
         X4ag==
X-Gm-Message-State: AC+VfDyU3VKqpS88DwgRrz8EOWtnrjGhav2J72B3EGDkNqhMj3nYYgTA
	AX6lg/p5IGLpy+i+Ax1lozRxXdtmK64okge+30o3rw==
X-Google-Smtp-Source: ACHHUZ5NsVabI2XB4uWQcC/w6umsaXLsQofk0AL6E2iNPj+DwcaHdw6Y2gZipVmXXLxutmgU88ISPGvcH6pi+tfbf+c=
X-Received: by 2002:a05:622a:589:b0:3ed:210b:e698 with SMTP id
 c9-20020a05622a058900b003ed210be698mr1481409qtb.7.1687421707307; Thu, 22 Jun
 2023 01:15:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621154337.1668594-1-edumazet@google.com> <ZJQAdLSkRi2s1FUv@nanopsycho>
In-Reply-To: <ZJQAdLSkRi2s1FUv@nanopsycho>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Jun 2023 10:14:56 +0200
Message-ID: <CANn89iLeU+pBrcHZyQoSRa-X_3G-Y8cjF6FJy4XwkJc7ronqMA@mail.gmail.com>
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

On Thu, Jun 22, 2023 at 10:04=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrot=
e:
>
> Wed, Jun 21, 2023 at 05:43:37PM CEST, edumazet@google.com wrote:
> >syzbot reported a possible deadlock in netlink_set_err() [1]
> >
> >A similar issue was fixed in commit 1d482e666b8e ("netlink: disable IRQs
> >for netlink_lock_table()") in netlink_lock_table()
> >
> >This patch adds IRQ safety to netlink_set_err() and __netlink_diag_dump(=
)
> >which were not covered by cited commit.
> >
> >[1]
> >
> >WARNING: possible irq lock inversion dependency detected
> >6.4.0-rc6-syzkaller-00240-g4e9f0ec38852 #0 Not tainted
> >
> >syz-executor.2/23011 just changed the state of lock:
> >ffffffff8e1a7a58 (nl_table_lock){.+.?}-{2:2}, at: netlink_set_err+0x2e/0=
x3a0 net/netlink/af_netlink.c:1612
> >but this lock was taken by another, SOFTIRQ-safe lock in the past:
> > (&local->queue_stop_reason_lock){..-.}-{2:2}
> >
> >and interrupts could create inverse lock ordering between them.
> >
> >other info that might help us debug this:
> > Possible interrupt unsafe locking scenario:
> >
> >       CPU0                    CPU1
> >       ----                    ----
> >  lock(nl_table_lock);
> >                               local_irq_disable();
> >                               lock(&local->queue_stop_reason_lock);
> >                               lock(nl_table_lock);
> >  <Interrupt>
> >    lock(&local->queue_stop_reason_lock);
> >
> > *** DEADLOCK ***
> >
> >Fixes: 1d482e666b8e ("netlink: disable IRQs for netlink_lock_table()")
>
> I don't think that this "fixes" tag is correct. The referenced commit
> is a fix to the same issue on a different codepath, not the one who
> actually introduced the issue.
>
> The code itself looks fine to me.

Note that the 1d482e666b8e had no Fixes: tag, otherwise I would have taken =
it.

I presume that it would make no sense to backport my patch on stable branch=
es
if the cited commit was not backported yet.

Now, if you think we can be more precise, I will let Johannes do the
archeology in ieee80211 code.

