Return-Path: <netdev+bounces-20164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA4B75E041
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 09:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF58281D4F
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 07:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A747AECF;
	Sun, 23 Jul 2023 07:25:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCA0EBD
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 07:25:50 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B9D1BE2
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 00:25:44 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fdd515cebcso4891327e87.0
        for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 00:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-sg.20221208.gappssmtp.com; s=20221208; t=1690097143; x=1690701943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0iffa6uW+CBPzOMt7qh5A0ZCk4wrtyQIY4miIwW/+0=;
        b=At3alvTPhq5F4Y0D4mtTD6nDvaI5DBPUUD0Q2zmSotWqGMEcsSA+lhc8YPfLeeJida
         jjnxjqM45JtjHblVJUcA57UNzbKU+M64y6ExbThwK4iAvVLMTRbONLG8DX01eyLUdKlh
         VUpCdtXk2/rDoyezlJWMQP825DubM6mLBwQEQDRRaKrKRgT7o0kMpR8MeYZA/Ue8HBTt
         RBR63HrJSUG1QvP5q0MDIINmxfuQvg1Nj+xqtJ5nGdjK6aiTvGQsfcxVnkgV+r5N8pd2
         A3gDdprtegE7G8XqDS6ZI4OT7pEhzeyi2xi54KB2mqqBdYKwAoKKqbLo3SGqcO86qjaX
         5gFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690097143; x=1690701943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0iffa6uW+CBPzOMt7qh5A0ZCk4wrtyQIY4miIwW/+0=;
        b=Awk37MF2VpDZS/vKVg01QYyLLT+bMbJyGardH5qZZ55xKrPr8IurlOZNAFI8vdMMoy
         +t+16jFepZavmHx2Kze1IRXyuchPUT/2jyEdUh9omSqf2n0n68UoF1A/i4hy9DLru9KJ
         0ZgW5j0AC5GM7Xxb9E/h+KUxCS9WjTWxXGya4XBI+sx2VwKFg3vkjLMLiiw4nBzJ5ZDY
         xCTi5HqNbCwkcCcYVCMAPyX32t0Zkg5ezII/RvxFN7b9/uitoRj1eDrPxJwc2U0Feccl
         +VvJdjtoktCYbODQ+w/Z+O9jdBHQjSYM8gBmTOev6HasBgWQ0CXQ6UGnmgcvINd0Yw2q
         IT5Q==
X-Gm-Message-State: ABy/qLb28efzM4IJVeYc0Mh15rEANj9kdIooztLiMn9319fahRHOqxc6
	EkhgqbjK503PcCkFVUEDxEzjYbPoLWMasnR8biNVqdfLRCfW0huFaA==
X-Google-Smtp-Source: APBJJlE5pHWAGpA+sg4ahURxMh1Bn4nRh3BbzkFEY5cm8aoKoq3IglVu0SZaAl3Q2eVMakWjlhv0EKT/D9a1Gp1pWew=
X-Received: by 2002:ac2:4213:0:b0:4f9:5ca0:9334 with SMTP id
 y19-20020ac24213000000b004f95ca09334mr3030974lfh.34.1690097142890; Sun, 23
 Jul 2023 00:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230721174856.3045-1-sec@valis.email> <9a51c82f-6884-4853-8e8a-3796c9051ca8@mojatatu.com>
 <CAM0EoMkVVdHjU1aUxmjN7ah_iE2Beuwgf4r6ddxCWN5d77t-=A@mail.gmail.com>
In-Reply-To: <CAM0EoMkVVdHjU1aUxmjN7ah_iE2Beuwgf4r6ddxCWN5d77t-=A@mail.gmail.com>
From: M A Ramdhan <ramdhan@starlabs.sg>
Date: Sun, 23 Jul 2023 14:25:07 +0700
Message-ID: <CACSEBQTamxnS0w=TTJObV8f_X=9oLBWEv2xtkzWhYqWb_w+gWA@mail.gmail.com>
Subject: Re: [PATCH net 0/3] net/sched Bind logic fixes for cls_fw, cls_u32
 and cls_route
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Pedro Tammela <pctammela@mojatatu.com>, valis <sec@valis.email>, netdev@vger.kernel.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, victor@mojatatu.com, 
	billy@starlabs.sg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 22, 2023 at 2:56=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Fri, Jul 21, 2023 at 3:00=E2=80=AFPM Pedro Tammela <pctammela@mojatatu=
.com> wrote:
> >
> > On 21/07/2023 14:48, valis wrote:
> > > Three classifiers (cls_fw, cls_u32 and cls_route) always copy
> > > tcf_result struct into the new instance of the filter on update.
> > >
> > > This causes a problem when updating a filter bound to a class,
> > > as tcf_unbind_filter() is always called on the old instance in the
> > > success path, decreasing filter_cnt of the still referenced class
> > > and allowing it to be deleted, leading to a use-after-free.
> > >
> > > This patch set fixes this issue in all affected classifiers by no lon=
ger
> > > copying the tcf_result struct from the old filter.
> > >
> > > valis (3):
> > >    net/sched: cls_u32: No longer copy tcf_result on update to avoid
> > >      use-after-free
> > >    net/sched: cls_fw: No longer copy tcf_result on update to avoid
> > >      use-after-free
> > >    net/sched: cls_route: No longer copy tcf_result on update to avoid
> > >      use-after-free
> > >
> > >   net/sched/cls_fw.c    | 1 -
> > >   net/sched/cls_route.c | 1 -
> > >   net/sched/cls_u32.c   | 1 -
> > >   3 files changed, 3 deletions(-)
> > >
> >
> > For the series,
> >
> > Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
> > Tested-by: Pedro Tammela <pctammela@mojatatu.com>
>
> For the series:
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

For the series:
Reviewed-by: M A Ramdhan <ramdhan@starlabs.sg>
Tested-by: M A Ramdhan <ramdhan@starlabs.sg>

Regards,
M A Ramdhan

>
> cheers,
> jamal

