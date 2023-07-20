Return-Path: <netdev+bounces-19472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E3F75ACEE
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 13:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED92D1C2133B
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 11:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3AC17744;
	Thu, 20 Jul 2023 11:26:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AE317729
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 11:26:11 +0000 (UTC)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B8F10E
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 04:26:09 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4036bd4fff1so283071cf.0
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 04:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689852368; x=1690457168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2MQuw8Dxgx9roDvjU2BN2mY103293qsRDuml6/qqIQ=;
        b=jPMEoPysjbHqWgLXcHDSEXQDIHkF3VfRD39krR/lmEk++0stlV4zN6H59jOpxWKYXq
         ep+EmnY7Zk3cJ9WWk6KK/0qoqYMgEFmQ9XykC1MXjUmASsKFGt3HxLrkyjnxMJdgOwo0
         MjIsZPKBmt+2DPErkXmHMrvyuN10vEq38bL0MBxs4N/+RAGkAQ/Ql74UJveZXkWyWG2U
         pb/TlntTA5NGxU2CBq/+KsFnhyvMwVzFU28aDTEAZEmkgo2asB0Dttt/AJz55BW2YFkU
         tceAq3Mfi5GMB8umambkr/CVoAAYVj09j72gPiz840JFJVGLTG4RGBaBVFOWBSearRwV
         79Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689852368; x=1690457168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2MQuw8Dxgx9roDvjU2BN2mY103293qsRDuml6/qqIQ=;
        b=g//M+Q93qyBAEIk15rfa6VK/nXXmbj2o0njlnwrf28n2kiegBdHUx5XeINW3wVj83n
         kKkrhzcmafypFz4sSW4A+0snw/ohFMpPR9GKfkqVhBoPxu5OUc5QgaMLdz0QQoEMWGl3
         MZlXYmGg6bWl1sa2D5D9iiOSAINoC3orrKwGuP5iP2BwFPRGt4andgDcj/iKWdKux5o8
         tu+LluY8L9KLJw0UKQaXNkQpEeAUpVFC9Y3JxJFW8L1LYuz3QrVZHAz9nMG0UmSMul+T
         hkfmxWjzHKDgeYbu8Ndu14xIhUUVhaEWpAigSGwc7OZqttZVcq5CUblMxDeE/NZ/1ZdG
         U2Ow==
X-Gm-Message-State: ABy/qLZqVURynrO4pM3fnCRqAEa7NLtgu3x/N0TrD27a+yuF6DLBkOf6
	JPwl75mMa28s/cpyF7+ffQXABHkKnEs2PBv7x2NflA==
X-Google-Smtp-Source: APBJJlFUUUF0CJwIRK7aVYOKXyc90+vnfOJ/rVwe6i4oWGffAtXVNtER7F4inW8FsyhFjYPXpQBHZR2EWwqFfA6aIiM=
X-Received: by 2002:a05:622a:1756:b0:403:eb3c:37af with SMTP id
 l22-20020a05622a175600b00403eb3c37afmr274138qtk.26.1689852368426; Thu, 20 Jul
 2023 04:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230719175424.75717-1-alexei.starovoitov@gmail.com> <168981062676.16059.265161693073743539.git-patchwork-notify@kernel.org>
In-Reply-To: <168981062676.16059.265161693073743539.git-patchwork-notify@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Jul 2023 13:25:57 +0200
Message-ID: <CANn89iKLtOcYyqytxH6zrR4P7MJ-t0FwSKL=Wt7UwYWdQeJ1KA@mail.gmail.com>
Subject: Re: pull-request: bpf-next 2023-07-19
To: patchwork-bot+netdevbpf@kernel.org
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, daniel@iogearbox.net, andrii@kernel.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 1:50=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This pull request was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
>
> On Wed, 19 Jul 2023 10:54:24 -0700 you wrote:
> > Hi David, hi Jakub, hi Paolo, hi Eric,
> >
> > The following pull-request contains BPF updates for your *net-next* tre=
e.
> >
> > We've added 45 non-merge commits during the last 3 day(s) which contain
> > a total of 71 files changed, 7808 insertions(+), 592 deletions(-).
> >
> > [...]
>
> Here is the summary with links:
>   - pull-request: bpf-next 2023-07-19
>     https://git.kernel.org/netdev/net-next/c/e93165d5e75d
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>

"bpf: Add fd-based tcx multi-prog infra with link support" seems to
cause a bunch of syzbot reports.

I am waiting a bit for more entropy before releasing them to the public.

