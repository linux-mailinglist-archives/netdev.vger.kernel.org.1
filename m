Return-Path: <netdev+bounces-13125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3716E73A619
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 18:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8E61C211B3
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 16:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7571D2B9;
	Thu, 22 Jun 2023 16:31:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD845200A7
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 16:31:50 +0000 (UTC)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6242D1BD9
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 09:31:49 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-40079620a83so751cf.0
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 09:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687451508; x=1690043508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVCRH+Baj+izPpVFpgalsrYNjRKaRlGm1q8gXLdFNYk=;
        b=IKqP0bbto2sIwQ4Ce+m51z7ICd8aCjwC4yXLfUsFYynphMhaxRQ8T7mmWd8cIbIYGs
         Bzw4Zr6sekuetHVCN+I0vE1ycTeK3D91HIP2lZTNT66YtwrRfHGBWGUj5uuKCBkkvAvu
         TIfQIMjv0JuQCssMpg6fRtLcvuFAkGIKcdQ48TZEsIlpLJeGaq9aTVi0NEOk8PWx22sj
         bFPxIqXQBoErbH3C5k8P0DpbgsPFGaiCdWzfKP+yxp8USUq9H9e6EwYPj596bS3AcXO/
         K3Rd07/SdSjwM/neG1Z9/kM3AWLYcFhoRuvvj2yl+eMtX1WRhkk2AeABWDvIeFc+Bwey
         uAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687451508; x=1690043508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVCRH+Baj+izPpVFpgalsrYNjRKaRlGm1q8gXLdFNYk=;
        b=cw0P387r+hvQzt0wSJeaB2v8zXl+WqaYEXtGtbJA3hMwJ/XediQTBgpkXn7r4t/49O
         GS9mSBROOfLuDqfNQmteT46MNMfKHNJz0ckwmWU3rdZa7bnF/fX6lO2GJc9ADX7+9G0b
         FWOztHUAIhJPFJxrxgD62iYH2mhkACvvP+8HRVOyLuJZOsS5JQShqcc+CZjBtMp9chdz
         fjK70YgRKFZrbB910Q+zoO5aJFkqNCL2ze0TPKHCCqvu+25qyBX+0acbu+mzTjd3dRrZ
         HDLrVN0Pd65IsgLPPD4oX1Sqau37H1zGl5t5zSFsXjEuIxEBoxm+gJjbN3AUmIrR4lQQ
         DM4A==
X-Gm-Message-State: AC+VfDyzBMelmfr15okI4lSRdutqt/3MJzqYiNjYpVHIFBGl812nEg1h
	q4lGLDX+Yv366PUkxvpBSmIVFyi0iUlNBXHTx7/n927R84bm/ubEVyBczg==
X-Google-Smtp-Source: ACHHUZ4ge5fPDe0Q/rQTxF/dDQZSQuVIu/wGNHAJQPYv7jvmR9B181ZRv/qC9q00bioecS4X4KZG4aXH2hpdHpTa4CY=
X-Received: by 2002:ac8:7f45:0:b0:3fc:7fb0:ad3a with SMTP id
 g5-20020ac87f45000000b003fc7fb0ad3amr825717qtk.24.1687451508397; Thu, 22 Jun
 2023 09:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230620184425.1179809-1-edumazet@google.com> <168742562084.21100.5779776053254524891.git-patchwork-notify@kernel.org>
In-Reply-To: <168742562084.21100.5779776053254524891.git-patchwork-notify@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Jun 2023 18:31:37 +0200
Message-ID: <CANn89iJ6qHJC9NZx-u9Mm6am3OVNPP2u2xjpmUspDaAnq3Sh3w@mail.gmail.com>
Subject: Re: [PATCH net] sch_netem: acquire qdisc lock in netem_change()
To: patchwork-bot+netdevbpf@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com, 
	stephen@networkplumber.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 11:20=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.or=
g> wrote:
>
> Hello:
>
> This patch was applied to netdev/net.git (main)
> by Paolo Abeni <pabeni@redhat.com>:
>
> On Tue, 20 Jun 2023 18:44:25 +0000 you wrote:
> > syzbot managed to trigger a divide error [1] in netem.
> >
> > It could happen if q->rate changes while netem_enqueue()
> > is running, since q->rate is read twice.
> >
> > It turns out netem_change() always lacked proper synchronization.
> >
> > [...]
>
> Here is the summary with links:
>   - [net] sch_netem: acquire qdisc lock in netem_change()
>     https://git.kernel.org/netdev/net/c/2174a08db80d
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html

I missed the fact that get_dist_table() was called from netem_change()

This function uses GFP_KERNEL and also acquires the qdisc lock.

I will send a fix soon.

