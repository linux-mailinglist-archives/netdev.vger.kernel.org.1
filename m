Return-Path: <netdev+bounces-35144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D957A741A
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 09:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FC1A1C20AD0
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 07:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3614F8C15;
	Wed, 20 Sep 2023 07:29:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0091C26
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 07:29:31 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8C7C9
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 00:29:30 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-41761e9181eso200381cf.1
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 00:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695194969; x=1695799769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8CBGO1I/tDVZ3US3iYHvNzW5AeogXVILN8LHzMcHOE=;
        b=36hQ0jWZSsQBeD6E5KlLx1TUvzI+bH03QnUqNj9P8b/E7/6HewdS3EXQWPKxn/8JaA
         KlxiAv/oXo1ZQp49QAO/ZBrP3k6wOoS+ATdx8c4dckY9muR/V0CGXPU85J0Z4aLnLgvT
         8RLVcXYsTbsUoJ/E5r9yHigFfAGAPoQ4DEH233re14mpK6ZABG5AoFH84BsHfiNryv1X
         GycrAH89FPisN/nCkTyqFtsNUToa4x9gzPqle7MjpW3nBaKKW9mmGXAoWG85KwRlMKm4
         WcCKJ5rg1gpSzslZKysbeDxFhT1GoUWRwEINgQjoIPCpFU2Kr0NcfyAk94wR7EBm9aEE
         GR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695194969; x=1695799769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8CBGO1I/tDVZ3US3iYHvNzW5AeogXVILN8LHzMcHOE=;
        b=oYBgp67uA2O1i6A9icFaHTg8V8MuB1C7OVOkXdgFN7L0lxnBebIMF4JZ2KksyB3VRP
         5MyEV4J5p6AY8k3zoBtd1+BXWbPtdPB8mv282zESalcyG4H36tNtuZPJPUGUmrXRkeRq
         ZJk+7USAMfiIr63C0U/js6PDzVkyM+GbjvFe8DqK37j28am1iDVgR3S1cIX8AGjNDuCG
         lznSmSWccqeXgEGEtddu3QCElzLGvS2DhnpavY8g38vDn696Pen7fHcOTvMZZEi2nRvN
         qBSaK0ccoT2LAdGiTIEOmV0razsmOnxon+LA6zng6WbPzIL9awFx29WkQDF1jdkGoA/Y
         Vwtw==
X-Gm-Message-State: AOJu0YxRD45h2BAfxPfErhWwFT7O53DdS1SEGHvvhVOWpR3lR5OSl25W
	zhUsSFTbqi49GvDE1yewLAqwNUmf3a7PIEsJzmX7lQ==
X-Google-Smtp-Source: AGHT+IEmNp7iYwhpX0ipMJu8lXWl+bUUlXj6MEdDbPhow8vB4O+lJiSTl9l3uW61zvFNRVU9Q20UOWBKTvIEvkawyVo=
X-Received: by 2002:a05:622a:1d4:b0:416:6784:bd60 with SMTP id
 t20-20020a05622a01d400b004166784bd60mr123929qtw.21.1695194969239; Wed, 20 Sep
 2023 00:29:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <64CCB695-BA43-48F5-912A-AFD5B9C103A7@gmail.com>
 <51294220-A244-46A9-A5B8-34819CE30CF4@gmail.com> <67303CFE-1938-4510-B9AE-5038BF98ABB7@gmail.com>
 <8a62f57a9454b0592ab82248fca5a21fc963995b.camel@redhat.com>
 <CALidq=UR=3rOHZczCnb1bEhbt9So60UZ5y60Cdh4aP41FkB5Tw@mail.gmail.com>
 <43ED0333-18AB-4C38-A615-7755E5BE9C3E@gmail.com> <5A853CC5-F15C-4F30-B845-D9E5B43EC039@gmail.com>
 <A416E134-BFAA-45FE-9061-9545F6DCC246@gmail.com> <CANn89iKXxyAQG-N+mdhNA8H+LEf=OK+goMFxYCV6yU1BpE=Xvw@mail.gmail.com>
 <BB129799-E196-428C-909D-721670DD5E21@gmail.com> <ZQqOJOa_qTwz_k0V@debian.me>
 <94BC75CD-A34A-4FED-A2EA-C18A28512230@gmail.com> <CANn89iKvv7F9G8AbYTEu7wca_SDHEp4GVTOEWk7_Yq0KFJrWgw@mail.gmail.com>
In-Reply-To: <CANn89iKvv7F9G8AbYTEu7wca_SDHEp4GVTOEWk7_Yq0KFJrWgw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 20 Sep 2023 09:29:18 +0200
Message-ID: <CANn89iJCJhJ=RWqPGkdbPoXhoa1W9ovi0s1t4242vsz-1=0WLw@mail.gmail.com>
Subject: Re: Urgent Bug Report Kernel crash 6.5.2
To: Martin Zaharinov <micron10@gmail.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	netdev <netdev@vger.kernel.org>, patchwork-bot+netdevbpf@kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, kuba+netdrv@kernel.org, 
	dsahern@gmail.com, Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 9:25=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Sep 20, 2023 at 9:04=E2=80=AFAM Martin Zaharinov <micron10@gmail.=
com> wrote:
> >
> > Hi
> >
> > Ok on first see all is look come after in kernel 6.4 add : atomics: Pro=
vide rcuref - scalable reference counting  ( https://www.spinics.net/lists/=
linux-tip-commits/msg62042.html )
> >
> > I check all running machine with kernel 6.4.2 is minimal and have same =
bug report.
> >
> > i have fell machine with kernel 6.3.9 and not see problems there .
> >
> > and the problem may be is allocate in this part :
> >
> > [39651.444202] ? rcuref_put_slowpath (lib/rcuref.c:267 (discriminator 1=
))
> > [39651.444297] ? rcuref_put_slowpath (lib/rcuref.c:267 (discriminator 1=
))
> > [39651.444391] dst_release (./arch/x86/include/asm/preempt.h:95 ./inclu=
de/linux/rcuref.h:151 net/core/dst.c:166)
> > [39651.444487] __dev_queue_xmit (./include/net/dst.h:283 net/core/dev.c=
:4158)
> > [39651.444582] ? nf_hook_slow (./include/linux/netfilter.h:143 net/netf=
ilter/core.c:626)
> >
> > may be changes in dst.c make problem , I'm guessing at the moment.
> >
> > but in real with kernel 6.3 all is fine for now.
> >
> > dst.c changes 6.3.9 > 6.5.4 :
>
> Then start a real bisection. This is going to be the last time I say it.

Or stick to an older kernel for your production, and wait for others
to find the issue.

