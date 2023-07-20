Return-Path: <netdev+bounces-19530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AEE75B1C1
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 16:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F47C281D3E
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 14:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE84018AEB;
	Thu, 20 Jul 2023 14:53:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A137C18AE4
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 14:53:54 +0000 (UTC)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8718D196
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 07:53:53 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-4036bd4fff1so347701cf.0
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 07:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689864832; x=1690469632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpVfDd3TmC+58MrJZc4rMEANE9/cqkqPncrw/o/Hhys=;
        b=S/9JhYrjIyt04VHrEQ6P4doCapVUDdA8T+vST8TVP44C25C3h0Rn8kzoETVKiRMBpo
         Y+ZEc9J5hngor3G8OI/37eFKcZnZAzQp527H2DJGejq8R0yFF0rtL8AI7SQkzmlJmjzH
         dKY9kLUT0OKqLFhlPUeuG7UZWJTEnGuYAcgMq+xGsgGtVCp7bXGIpi1rODpRm1UJaTJN
         ystUmMZ8Xc+7/9VxdqZFPUV3q3/rLfWfZ7bwwBk9afoFzagGI0fPa0DiqEgIl3abpLO0
         93wxMY+ckCQFwa7BsWBOuieWXQqgEh2lUDx9W5Xn7XJk2/ZY1xKV1yThbYzbR1hRHzFq
         CDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689864832; x=1690469632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SpVfDd3TmC+58MrJZc4rMEANE9/cqkqPncrw/o/Hhys=;
        b=B6b1vgkNkzBTbrChQbfWnnI1EpyR83Twea7kioX6lCd8JrQsVP7oGPdWLOVwkQBaOP
         tqYOvmNeWM0cp3RjvL1EdKMXGQbbQlwVehm4Au8rpd04LJkpugXqF7Jaz1RDIV8ghzqp
         TOglvLMPsXWAm4egzkY6n/QwEQRBTYmIy2swNQ1sVMFH8/wQMuIyvl20acCCy34lferI
         xCsyBP9IGQQ7WjPJv+uR3UzKS72JcXrU2Z329xgP6XMK7vguLz+DsOXN/9Jff29ZvvJd
         QpNLIiRq0D+p57nSv4SRuEKGUkCh42o7j1Z3U3jkTGNv6bBiV7HhXAHPzJiW8Pjmq11Q
         IKjg==
X-Gm-Message-State: ABy/qLYAKQ/uj4zRVDwLoHmPRVk6ECl+yvJxrTmfQZgDebqO6SOtnATS
	HtAEYPaU3kBrlr+/tNbMjg+am/MpaSyGg0YtpgVdpQ==
X-Google-Smtp-Source: APBJJlFGuZzkHfCDJ8Wpn2Y9Fnl0Z15RKT+2mcFyhBHWJUldw8Z+I50LgUqDjNwuismUdAvHYugvg2dDvJnkiQk09bY=
X-Received: by 2002:a05:622a:48:b0:403:eeb9:a76 with SMTP id
 y8-20020a05622a004800b00403eeb90a76mr251043qtw.17.1689864832504; Thu, 20 Jul
 2023 07:53:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230719175424.75717-1-alexei.starovoitov@gmail.com>
 <168981062676.16059.265161693073743539.git-patchwork-notify@kernel.org> <CANn89iKLtOcYyqytxH6zrR4P7MJ-t0FwSKL=Wt7UwYWdQeJ1KA@mail.gmail.com>
In-Reply-To: <CANn89iKLtOcYyqytxH6zrR4P7MJ-t0FwSKL=Wt7UwYWdQeJ1KA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Jul 2023 16:53:40 +0200
Message-ID: <CANn89iJNxwWZEfThm_hJKhTRRq8akKN3boaLG1XAc_WuWDp8TQ@mail.gmail.com>
Subject: Re: pull-request: bpf-next 2023-07-19
To: patchwork-bot+netdevbpf@kernel.org
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, daniel@iogearbox.net, andrii@kernel.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 1:25=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Jul 20, 2023 at 1:50=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.o=
rg> wrote:
> >
> > Hello:
> >
> > This pull request was applied to netdev/net-next.git (main)
> > by Jakub Kicinski <kuba@kernel.org>:
> >
> > On Wed, 19 Jul 2023 10:54:24 -0700 you wrote:
> > > Hi David, hi Jakub, hi Paolo, hi Eric,
> > >
> > > The following pull-request contains BPF updates for your *net-next* t=
ree.
> > >
> > > We've added 45 non-merge commits during the last 3 day(s) which conta=
in
> > > a total of 71 files changed, 7808 insertions(+), 592 deletions(-).
> > >
> > > [...]
> >
> > Here is the summary with links:
> >   - pull-request: bpf-next 2023-07-19
> >     https://git.kernel.org/netdev/net-next/c/e93165d5e75d
> >
> > You are awesome, thank you!
> > --
> > Deet-doot-dot, I am a bot.
> > https://korg.docs.kernel.org/patchwork/pwbot.html
> >
> >
>
> "bpf: Add fd-based tcx multi-prog infra with link support" seems to
> cause a bunch of syzbot reports.
>
> I am waiting a bit for more entropy before releasing them to the public.

OK, syzbot found one repro for one of the reports, time to release it
for investigations.

