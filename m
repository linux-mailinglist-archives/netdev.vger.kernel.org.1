Return-Path: <netdev+bounces-47100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DED87E7C65
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 14:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084502812FC
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 13:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45442156C1;
	Fri, 10 Nov 2023 13:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="DYeJoR9/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8211A14A97
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 13:11:14 +0000 (UTC)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1B236C47
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 05:11:12 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a877e0f0d8so26754837b3.1
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 05:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1699621872; x=1700226672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVsBLmhFioAqkAGu3vwmlejEIxBaHnvJlFfO7ZNdcnQ=;
        b=DYeJoR9/t72f5FAAAi44KJbDnELHAmYODnqu5zWKR/mHzyhOB+SQIiSW2gVzWJ6ubA
         E0w0I6Ub2MXJFt23AcTOeJSVCsjL4E1uNd9FsNka4m8b9zYgXawRhKD5wnoNr7fiCPh/
         oA/AhUFN9TFd2HYVUK+xoTvrSkE98GU41xjv0UD+ZTNd9sByoFV9eTaGoHuKObIrJPXj
         lFDlq0G1lb27bhXyTVb8hkePJZrJoHUo5Tl6/eFyeSmE7Ga+HAvglb4LPHP9B25cqkJw
         h8uSG484yN1mTPOFxB0+jmm34GOun2VV8+vDM9ZzDWFhjT1ALSCVwDFMDYvVkIGL46Ef
         yl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699621872; x=1700226672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVsBLmhFioAqkAGu3vwmlejEIxBaHnvJlFfO7ZNdcnQ=;
        b=gY1CEaPPocK/VRiCtUe+VmepX7bRhW0LydJUadb3AR8WjAXprhJCxD2UDKWeoWiAIW
         FD8hzcZzaUPOzPuYxe7NlNR/EK4pw2+pQoJbhFIskGsUzSSxsXCUYYU3cYi4DZLlVUBw
         7e+0eNrMMDFkQQeg7GhT8slpXpdV80sYUX0Vx00k4eI0ejC3JqoobFr2TSWRMJwdjp5t
         S1DiWheRf8yxIBCOcE70iCHr5dp2xPJfRdZlXcc2//ffoBqJ+8Sm4P5JKuvnYEqbRppw
         FLMXbmDawqK80iFLTueahKUek6rFNc0w7omw2FUIJLepKPlQsTIN/qfUaGmYfY0nrlVG
         VSqg==
X-Gm-Message-State: AOJu0Yycu1QpgsRheLv7wopVQioGs8ETpD5+/yGbim0Gq4GsfRzugrd2
	gy6bDefqcVj7HnBOFmHLoFD1QZy/+JhtE1sqrDQawTtH0Qy2JPm3
X-Google-Smtp-Source: AGHT+IHnUObuqEMP/xCxXfqptw3K5+1pi/Jf7KPfGszuh3hfo52igBJGC4ciazB+qP4AT5a2fpWclTtgmwNqsPFe6wc=
X-Received: by 2002:a0d:cb94:0:b0:5a7:ba3e:d1d1 with SMTP id
 n142-20020a0dcb94000000b005a7ba3ed1d1mr1314800ywd.25.1699621871820; Fri, 10
 Nov 2023 05:11:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109000901.949152-1-kuba@kernel.org>
In-Reply-To: <20231109000901.949152-1-kuba@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 10 Nov 2023 08:11:00 -0500
Message-ID: <CAM0EoM=DUtju91y_0zsyyJJ+bPxTRAAWyBA_1tM+RwY8VXbbRw@mail.gmail.com>
Subject: Re: [RFC net-next] net: don't dump stack on queue timeout
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, syzbot+d55372214aff0faa1f1f@syzkaller.appspotmail.com, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 7:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> The top syzbot report for networking (#14 for the entire kernel)
> is the queue timeout splat. We kept it around for a long time,
> because in real life it provides pretty strong signal that
> something is wrong with the driver or the device.
>
> Removing it is also likely to break monitoring for those who
> track it as a kernel warning.
>
> Nevertheless, WARN()ings are best suited for catching kernel
> programming bugs. If a Tx queue gets starved due to a pause
> storm, priority configuration, or other weirdness - that's
> obviously a problem, but not a problem we can fix at
> the kernel level.
>
> Bite the bullet and convert the WARN() to a print.
>
> Before:
>
>   NETDEV WATCHDOG: eni1np1 (netdevsim): transmit queue 0 timed out 1975 m=
s
>   WARNING: CPU: 0 PID: 0 at net/sched/sch_generic.c:525 dev_watchdog+0x39=
e/0x3b0
>   [... completely pointless stack trace of a timer follows ...]
>
> Now:
>
>   netdevsim netdevsim1 eni1np1: NETDEV WATCHDOG: CPU: 0: transmit queue 0=
 timed out 1769 ms
>
> Alternatively we could mark the drivers which syzbot has
> learned to abuse as "print-instead-of-WARN" selectively.
>
> Reported-by: syzbot+d55372214aff0faa1f1f@syzkaller.appspotmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
> CC: jhs@mojatatu.com
> CC: xiyou.wangcong@gmail.com
> CC: jiri@resnulli.us
> ---
>  net/sched/sch_generic.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index 4195a4bc26ca..8dd0e5925342 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -522,8 +522,9 @@ static void dev_watchdog(struct timer_list *t)
>
>                         if (unlikely(timedout_ms)) {
>                                 trace_net_dev_xmit_timeout(dev, i);
> -                               WARN_ONCE(1, "NETDEV WATCHDOG: %s (%s): t=
ransmit queue %u timed out %u ms\n",
> -                                         dev->name, netdev_drivername(de=
v), i, timedout_ms);
> +                               netdev_crit(dev, "NETDEV WATCHDOG: CPU: %=
d: transmit queue %u timed out %u ms\n",
> +                                           raw_smp_processor_id(),
> +                                           i, timedout_ms);
>                                 netif_freeze_queues(dev);
>                                 dev->netdev_ops->ndo_tx_timeout(dev, i);
>                                 netif_unfreeze_queues(dev);
> --
> 2.41.0
>

