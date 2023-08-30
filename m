Return-Path: <netdev+bounces-31326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2889A78D2BF
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 06:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20162812E3
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 04:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A971859;
	Wed, 30 Aug 2023 04:30:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF21A1852
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 04:30:36 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721EACD2;
	Tue, 29 Aug 2023 21:30:29 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-26d4e1ba2dbso2948818a91.1;
        Tue, 29 Aug 2023 21:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693369829; x=1693974629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnYWkTXfRyVeeYgLLXstaC/GdYz4SXqmNKJW5ZQfQUY=;
        b=EPjYGsWPMkgYt/AxO7whMJDlqvelgLkVFUrZ8qQE6myMc+ofmngI6Icv34tUGpPlyE
         FDGBL3gk8GPBZ7WDWeLRz3kG2ZjVQubicPgW9xEZW5X71Edtt2U1F6Aytjzz4yx8iISh
         Id22lh0NIsIUwq7rOqOINxeT+pr/9OB44djTgCnkVwVjkYX91c18ecTPLXBuSo59cvmA
         2GrqyYR9ezsnpgqZ0BqjGYXWjm4L6Db2aaBAkCUZSzvlFr6Shr0RYz4rOJq0+Yp/HphP
         7FDouuldACO1r1gkFVJPnnCuFGC2DVfbv8wWhnCzrievHnjOBcRoxFUOQyxD1I2t9AdT
         MqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693369829; x=1693974629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnYWkTXfRyVeeYgLLXstaC/GdYz4SXqmNKJW5ZQfQUY=;
        b=OLsGALp43GDwQW/ja9gdPOJCQi+X0mCdygqURF4sh6QuVTH4woVktELEod9sjtCVDV
         PtUcuNxvGYicmx7wiZOEX8iaZZ4beQD4tESXyVGKdNx5Xd66H29VJWiO5r6zrMDmCVQJ
         NnIJV/wxx4ueHOPCvN1Yj01dbAryRZpsFIaluXGJPMVBmPYJX/PRQE9qZ9JLdEtbo567
         oSvXkVnkXRo+SzU6UF7n+UK/bsNsFfEx3N2aM3Xb6WL1v4gJRSuugRbT9g+kQNpkw+Rq
         tcRvQ3L2gnILVvquzmL/Vk2XXS2xVHbmhhLpFsxpgLWPFKIXeh+iqZcixfBzWeWq7CG1
         Ul/w==
X-Gm-Message-State: AOJu0Yx2Q+U71WoGpw8Lx0XdvNNv53rYmaShdhfcLI6mQtOwMe7WCLAM
	KCjRrNI3+b9ZBMepLNFfMQImzLdkss7Wr9YWEzo=
X-Google-Smtp-Source: AGHT+IE0m+TewUb+YqF0jpT02UbdDTlFCmxrBqWej0lVTwR0+LgjXhBZv2n+y7uiJVQsMLe65g+JCU7iKaA3NgWgddw=
X-Received: by 2002:a17:90a:e2c9:b0:26b:f18:799a with SMTP id
 fr9-20020a17090ae2c900b0026b0f18799amr1065576pjb.16.1693369828648; Tue, 29
 Aug 2023 21:30:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230725030026.1664873-1-zyytlz.wz@163.com> <20230815100844.GA495519@google.com>
 <20230829134616.GA215597@google.com>
In-Reply-To: <20230829134616.GA215597@google.com>
From: Zheng Hacker <hackerzheng666@gmail.com>
Date: Wed, 30 Aug 2023 12:30:17 +0800
Message-ID: <CAJedcCyFqJiXa9QHM6-Mg1ezF2tOKkyv2ukoOu+_T3YAdEhWdQ@mail.gmail.com>
Subject: Re: [PATCH v4] net: ravb: Fix possible UAF bug in ravb_remove
To: Lee Jones <lee@kernel.org>
Cc: Zheng Wang <zyytlz.wz@163.com>, s.shtylyov@omp.ru, linyunsheng@huawei.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, p.zabel@pengutronix.de, geert+renesas@glider.be, 
	magnus.damm@gmail.com, yoshihiro.shimoda.uh@renesas.com, 
	biju.das.jz@bp.renesas.com, wsa+renesas@sang-engineering.com, 
	netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 1395428693sheep@gmail.com, 
	alex000young@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sorry for my late reply. I'll update another patch later today.

Best regards,
Zheng

Lee Jones <lee@kernel.org> =E4=BA=8E2023=E5=B9=B48=E6=9C=8829=E6=97=A5=E5=
=91=A8=E4=BA=8C 21:46=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 15 Aug 2023, Lee Jones wrote:
>
> > On Tue, 25 Jul 2023, Zheng Wang wrote:
> >
> > > In ravb_probe, priv->work was bound with ravb_tx_timeout_work.
> > > If timeout occurs, it will start the work. And if we call
> > > ravb_remove without finishing the work, there may be a
> > > use-after-free bug on ndev.
> > >
> > > Fix it by finishing the job before cleanup in ravb_remove.
> > >
> > > Note that this bug is found by static analysis, it might be
> > > false positive.
> > >
> > > Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
> > > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > > Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> > > ---
> > > v4:
> > > - add information about the bug was found suggested by Yunsheng Lin
> > > v3:
> > > - fix typo in commit message
> > > v2:
> > > - stop dev_watchdog so that handle no more timeout work suggested by =
Yunsheng Lin,
> > > add an empty line to make code clear suggested by Sergey Shtylyov
> > > ---
> > >  drivers/net/ethernet/renesas/ravb_main.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> >
> > Trying my best not to sound like a broken record, but ...
> >
> > What's the latest with this fix?  Is a v5 en route?
>
> Any update please Zheng Wang?
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]

