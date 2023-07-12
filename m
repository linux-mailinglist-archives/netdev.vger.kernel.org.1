Return-Path: <netdev+bounces-17147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DADF775094A
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 15:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8F01C20D9E
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 13:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38EC2AB41;
	Wed, 12 Jul 2023 13:12:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9629B200DA
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 13:12:01 +0000 (UTC)
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499211984
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 06:11:59 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-47e4d002e0bso2510039e0c.0
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 06:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689167518; x=1691759518;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mMTX55rsuAtxs8eoTMF0zmRGfyj0Pb2SnfXciWnbDRk=;
        b=oODGvdD932AIbLChg31AWvPktzZ4m7FTZ6aQ1gLyUuWlnI3wXkOvvrIbbIi8uCqd6K
         2DqwWEDw/fQbtPRvLRedVPOOzTHHsf/4HRHxNFxP2Pk6AD3zGU495vP9iEFnx3zwtWlR
         2U9wGjnFkQAVowaGRwGExOWZmczAT6UqND7v5XIqWbDiLIB4+pd1kEjNyEUPRXB2t+cd
         KSbQccVpwUXW9MgFExadDhAfNc6PtxFhlmkd9Qf3Xr8zxwO/yEbyTLdJSY2y1F+sI6hw
         OZ0Z6hSly9/ApfbBL7ai06kUQFpp3+K3Qd325h0IqPNZ3Q4h3cKxEYPBZU3Hr9g2pzfX
         0XEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689167518; x=1691759518;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mMTX55rsuAtxs8eoTMF0zmRGfyj0Pb2SnfXciWnbDRk=;
        b=QPWmlZ9onPN2b7oDmXH3mj6ibESf0ezZZbE5tR9inwld4dAO0p4N6A1gYEmaWYareP
         0ApC1jgjB/22sYUY7Sel4WHlepiTaekD40/u9YnxbJgGCGMC5oTqotTVd/65iZVG4uBq
         Pzx8Xzv2VRBuOdEUKF4tH6KEt36ZqsYusX8EWMqVfESZkz0FWziPPlznUoIXs12SG9CF
         1W58uopGLhv9Uv0KJZuX+UcrZzyP0jprZMqnsjcOwgvXt+56ceZnYQM/1qVFo3MJvlbt
         qYkyA1ORK7yIgtWoGKo+hL8d2zwgyqRSuCnGHojc8RHBOJunOuVi7eLYikN72xlULlcO
         JxXA==
X-Gm-Message-State: ABy/qLajPd19g6Sy39FoJtphHFw4QrcOtgI6wy+X/OwJh1brUQSJPB0j
	vexEloVyqNFSaQ0QM3+YrEJmfTv6UpNjvl+sIEa4IQ==
X-Google-Smtp-Source: APBJJlHszP/BzjPgRktgE9ZmebvyBVKr6pfvWwTZjRe8dSb5sh4qROzT6nYqpk/0QxLKUnz2CT1ElQ7dwOmGZ7kEQMc=
X-Received: by 2002:a1f:3fd0:0:b0:481:2ff5:c9a9 with SMTP id
 m199-20020a1f3fd0000000b004812ff5c9a9mr938260vka.13.1689167518233; Wed, 12
 Jul 2023 06:11:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230709203826.141774942@linuxfoundation.org> <CA+G9fYtEr-=GbcXNDYo3XOkwR+uYgehVoDjsP0pFLUpZ_AZcyg@mail.gmail.com>
 <20230711201506.25cc464d@kernel.org> <ZK5k7YnVA39sSXOv@duo.ucw.cz>
In-Reply-To: <ZK5k7YnVA39sSXOv@duo.ucw.cz>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 12 Jul 2023 18:41:46 +0530
Message-ID: <CA+G9fYvEJgcNhvJk6pvdQOkaS_+x105ZgSM1BVvYy0RRW+1TvA@mail.gmail.com>
Subject: Re: [PATCH 6.4 0/6] 6.4.3-rc2 review
To: Jakub Kicinski <kuba@kernel.org>, Netdev <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	Qingfang DENG <qingfang.deng@siflower.com.cn>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>, Masahide NAKAMURA <nakam@linux-ipv6.org>, 
	Ville Nuorvala <vnuorval@tcs.hut.fi>, Arnd Bergmann <arnd@arndb.de>, Pavel Machek <pavel@denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 12 Jul 2023 at 14:01, Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > >   git_repo: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
> > >   git_sha: 3e37df3ffd9a648c9f88f6bbca158e43d5077bef
> >
> > I can't find this sha :( Please report back if you can still repro this
> > and how we get get the relevant code
>
> That sha seems to be:
>
> commit 3e37df3ffd9a648c9f88f6bbca158e43d5077bef
> Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date:   Sun Jul 9 22:38:22 2023 +0200
>
>     Linux 6.4.3-rc2

That is the commit id from stable-rc tree.

I have re-tested the reported issues multiple times and
it seems that it is intermittently reproducible.
Following list of links shows kernel crashes while testing
selftest net pmtu.sh

1)
Unable to handle kernel paging request at virtual address
https://lkft.validation.linaro.org/scheduler/job/6579624#L4648


2)
include/net/neighbour.h:302 suspicious rcu_dereference_check() usage!

https://lkft.validation.linaro.org/scheduler/job/6579625#L7500
https://lkft.validation.linaro.org/scheduler/job/6579626#L7509
https://lkft.validation.linaro.org/scheduler/job/6579622#L7537
https://lkft.validation.linaro.org/scheduler/job/6579623#L7469

- Naresh

