Return-Path: <netdev+bounces-24561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F407709B8
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 22:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E64A32826B3
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 20:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B660419891;
	Fri,  4 Aug 2023 20:33:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7475CA4C
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 20:33:33 +0000 (UTC)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410724C2D
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 13:33:32 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40a47e8e38dso13061cf.1
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 13:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691181211; x=1691786011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7PS2lORrxkckFy/e4X4dHnbYFeTLe3OPz4ClTrKxb8=;
        b=Zmr3IVRT62e/l4UM8MY/yDCoyzUQrjwmxhw+49SVgA3m7PitBGPEfVnkc8VP65EWvC
         PkLgW97dS43QYkmUohY1SWk8y0PfBIGpAsnXsOskG9vLz6pDoKFKCAXSWiydAfRmeFIC
         rTq1IpzCiHTDYnpOujL5UEGlhoSGPUI4ITTxdTUspJ+Xpgdl6oGgSIM3b1vU0jLP1AS/
         YtZBBdF4/Pj6heaeNg1TVZ1FOzwakJRzkS04iwTjPvUun5wy4sHwlEiVoNU+B1hghVTe
         b9R5nd/x3iqFm8eGodWNsMdP3yem6Kvn3P49UUqlfH5Ds3KV7WWWiiqrMeE8XAe420RL
         KWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691181211; x=1691786011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7PS2lORrxkckFy/e4X4dHnbYFeTLe3OPz4ClTrKxb8=;
        b=JJkIEHgnsn0n2UnSxDtQUh2ncVnG+i/wFZiuninrfw7E25iSJiydauhTj1V7PNGCmx
         fqNELXqnoItLcHOwxgB15G2RkkLTVkgp2H86rkAbpnoc/bOwAGQZIccQEdwZR4/6hvN2
         u8eWD92l1P3fcUxz07Gf8uMgM+03LQjig/QMiqiurZSIgrkpTzi56xmW2+qe/s1wlDvr
         WHFxuP4ULlmym8FYiUBEAnMZBZU/jwbzcgGz21LuPsnD/zCKe1lVY4kb/Kgl7d4QI02m
         iULPWwCF890tpryo0kwxA0p3Kg3/jXZ3L/UnB2gWizlDfQ4iZL1Ir67yBWz6eAOdyUnN
         hPGg==
X-Gm-Message-State: AOJu0YzQaSlgRITgWfrEkdPIlnlH8WTEGeKYRRVVIp/Kj0ZuyuJljop7
	fCZu3HqYUAT3CHeO8B8D6np8CbI4x00C4/y+B1Yg20LkXslXk+vhAuOiWg==
X-Google-Smtp-Source: AGHT+IGFTuPdvL4BwPtWJoZL/kFWcsStrne7djNZzfruByaeZvAZKJuxWWEFaN3ZQ+ugk8inc75XNalVObjHx+cCjGc=
X-Received: by 2002:a05:622a:390:b0:3fa:3c8f:3435 with SMTP id
 j16-20020a05622a039000b003fa3c8f3435mr24025qtx.27.1691181211118; Fri, 04 Aug
 2023 13:33:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230803075334.2321561-1-edumazet@google.com> <169113782026.32170.17783946876020996348.git-patchwork-notify@kernel.org>
In-Reply-To: <169113782026.32170.17783946876020996348.git-patchwork-notify@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 4 Aug 2023 22:33:20 +0200
Message-ID: <CANn89iKhp6ghj6-+n9RXvP-Bc33kOdSMSTM1KQj=WSQ2DhgPWQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp/dccp: cache line align inet_hashinfo
To: patchwork-bot+netdevbpf@kernel.org, Martin KaFai Lau <kafai@fb.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 4, 2023 at 10:30=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This patch was applied to netdev/net-next.git (main)
> by David S. Miller <davem@davemloft.net>:
>
> On Thu,  3 Aug 2023 07:53:34 +0000 you wrote:
> > I have seen tcp_hashinfo starting at a non optimal location,
> > forcing input handlers to pull two cache lines instead of one,
> > and sharing a cache line that was dirtied more than necessary:
> >
> > ffffffff83680600 b tcp_orphan_timer
> > ffffffff83680628 b tcp_orphan_cache
> > ffffffff8368062c b tcp_enable_tx_delay.__tcp_tx_delay_enabled
> > ffffffff83680630 B tcp_hashinfo
> > ffffffff83680680 b tcp_cong_list_lock
> >
> > [...]
>
> Here is the summary with links:
>   - [net-next] tcp/dccp: cache line align inet_hashinfo
>     https://git.kernel.org/netdev/net-next/c/6f5ca184cbef
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>

Thanks !

Apparently this misalignment came with

commit cae3873c5b3a4fcd9706fb461ff4e91bdf1f0120
Author: Martin KaFai Lau <kafai@fb.com>
Date:   Wed May 11 17:06:05 2022 -0700

    net: inet: Retire port only listening_hash

