Return-Path: <netdev+bounces-20674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1557608F0
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 06:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0627F1C20DA6
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 04:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AA14C9F;
	Tue, 25 Jul 2023 04:59:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A1F186F
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 04:59:47 +0000 (UTC)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6456310F9
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 21:59:45 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-40540a8a3bbso109441cf.1
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 21:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690261184; x=1690865984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYaJ5c1tc9cd0YXHt9mj7vR8nSUxuWPePixNhYNpe48=;
        b=TNHO0ncSGztDn+acffDs9b7xMz+8qYQm4UBtviY+lQJkKwTrb8ceR1Tj4srczpW8K+
         7UNUSVnvF9X/7O9saMCZTCR1RVRJq50qqv4Yc3cIFP71IcrsMloV/rAKGCXvdWOUUhP5
         LtCEeexqwz+HtOxy3/OhYfPcri193V1YOWTtMdLCOZNcL1WAvrj/wkwo2nmqwNNRJwYs
         ESbAIyY+Nt9BXThLW+nJrlBlLh4HcuMwOCA0npn6+zmrExPw/NKOdqNp1fIQ47BlUOpi
         R/AHn+/qNVcSvtu2vGI91+gB3CdcqwfaKwCL/pjUQL8M91j4g/dMgnzh5zx5nFMZ9Nq6
         IkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690261184; x=1690865984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYaJ5c1tc9cd0YXHt9mj7vR8nSUxuWPePixNhYNpe48=;
        b=SeGRqQ/h3loJ2nHZw74g4fPrhoe+iDDHQ59//Y1zH+2sknOMhmFWhr/4nvwNNKY2Tq
         LNnX1mBPmFjx+MmrijDNbQ11MihyY92m3jb7TlHPWDvR6kKi2JYFO29m6ZGPfLJPKdza
         UkS/PW37lJ3n37n0R/djQD2nC5PNiUq1zAD9KPj1wd+j+0TKwQdxy7vpSJWuhHQ9q6lT
         4NhFGfnHqqsJitBXPc53UgCr6bh9xCZCd93lmpeJckvq2hqBGlJQ0r+L8uNoXNQhZOxV
         dsGf7IgWlwIaRNTCALPONYtiZJ0s2wlv9AYW1fpj0fKgzT3SmtX7PT3/itKN9xOjJRID
         1IWw==
X-Gm-Message-State: ABy/qLYuI6tJvfv2m1woI2d6YxpDjEWsxl9ohnwqdJqVMf4d48hozgRc
	YLlfKyDmEmjxQOBk2BFiqQj4nMpZf/duuLqcEyzcaQ==
X-Google-Smtp-Source: APBJJlEMFGb7B/jeQr1nRgTW8dFbqEFlIjsITi4TCeIDfYa0HoZb0erQ2Bbmyko7FWcv+SDn450HRGGHCMeleWlfus8=
X-Received: by 2002:a05:622a:1009:b0:3f8:8c06:c53b with SMTP id
 d9-20020a05622a100900b003f88c06c53bmr96356qte.0.1690261184414; Mon, 24 Jul
 2023 21:59:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230720160022.1887942-1-maze@google.com> <169023961954.9367.14490573749061190250.git-patchwork-notify@kernel.org>
In-Reply-To: <169023961954.9367.14490573749061190250.git-patchwork-notify@kernel.org>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date: Tue, 25 Jul 2023 06:59:31 +0200
Message-ID: <CANP3RGcJsR_GctQzfPvO3OWFstoh0m8Lhf=AU9+8XjpXOWVV-g@mail.gmail.com>
Subject: Re: [PATCH net v2] ipv6 addrconf: fix bug where deleting a mngtmpaddr
 can create a new temporary address
To: patchwork-bot+netdevbpf@kernel.org
Cc: netdev@vger.kernel.org, kuba@kernel.org, thaller@redhat.com, 
	edumazet@google.com, pabeni@redhat.com, davem@davemloft.net, 
	dsahern@kernel.org, jiri@resnulli.us, xiaom@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 1:00=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This patch was applied to netdev/net.git (main)
> by Jakub Kicinski <kuba@kernel.org>:

Thank you.

> On Thu, 20 Jul 2023 09:00:22 -0700 you wrote:
> > currently on 6.4 net/main:
> >
> >   # ip link add dummy1 type dummy
> >   # echo 1 > /proc/sys/net/ipv6/conf/dummy1/use_tempaddr
> >   # ip link set dummy1 up
> >   # ip -6 addr add 2000::1/64 mngtmpaddr dev dummy1
> >   # ip -6 addr show dev dummy1
> >
> > [...]
>
> Here is the summary with links:
>   - [net,v2] ipv6 addrconf: fix bug where deleting a mngtmpaddr can creat=
e a new temporary address
>     https://git.kernel.org/netdev/net/c/69172f0bcb6a
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google

