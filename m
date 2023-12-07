Return-Path: <netdev+bounces-54839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6DF8087FD
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 13:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A451F225C8
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 12:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731303D0A9;
	Thu,  7 Dec 2023 12:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UGT3K/P1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD88710F5
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 04:38:38 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54c79cca895so11129a12.0
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 04:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701952717; x=1702557517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVBZCf3TgeI02nQQV5CCOYKQC9SbHiL7ittHkRbpBQE=;
        b=UGT3K/P1NseVpJxzpShnooTKmUUr37XaqD4hUw2p4L06Xh+pOvChsxAkGOAj6g6voV
         A05LVHwYykM4jQ+r23gZHManXr/zsPOe5xoVB7DzejApvCjqIqoRPTqrgIliATyS8A7m
         ugTZkdU8a5c7uzTBwlc6LqxLQjvcp39DZop7fdP0IlKzvUHV+vR/QZXYomAzj1wJRic9
         Zd6vODMcofQWZBNMAHqxM1wonQFRyAi6N1E4MQG5rDB22y305NyHGu/yhTG1DxU/5agd
         8uDYOl69hFW/OZvA5pPBhcn4jn3cPoxeOte29Lr9/vsPEdMSzP8Jd/oXFD+yShq3Sbxs
         gMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701952717; x=1702557517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVBZCf3TgeI02nQQV5CCOYKQC9SbHiL7ittHkRbpBQE=;
        b=SQS99a/NRz4Bs1MHFeW7r8jLbh3+jBGOK/ESoSa9MvQlelmpcav4jMJfUJDZLXGqLz
         JizPfebrbqQ46UFSAS5KBvVypbfg91yr1D8vJWmfir5N4OD8uS2BqYhFSC1LqVkF3H49
         5gBOvPHGnOtHAyWWc7BF8Fws8hvluS+BODqjNVPwnTuawzeDnOS6TwWM2hVaqJC2721D
         3MtcuMyLZF6cgrbyQcX/MRHUjmbU9c4z2LuOhhF7f9PN2DqIKWWxRmIGbmrMAh/ONpr+
         w1uXM3/46JeB7gHgooOpeyqWtXm+Ff438F53UkTR1ZXRMQzZgZKh+djGYsNuxXt4/iDj
         MCyg==
X-Gm-Message-State: AOJu0YyrFJhi9eO/qN15mMWZHf3+WaE8oLooeD9CAcNWmxrkMV2SQkuR
	3GW6+mTcgZ0qs9rIqXWpo9LVe4FkUHDGoP6244OFDA==
X-Google-Smtp-Source: AGHT+IG108n6oOMzARf8k0VvhVx8+XyO7y+V7XEYJAEa6UVaZ3jz/wxRl4dG8SXDRH1FMfMjTv8qr5GWK68QDnSvnAU=
X-Received: by 2002:a50:c35d:0:b0:54c:79ed:a018 with SMTP id
 q29-20020a50c35d000000b0054c79eda018mr240271edb.2.1701952716962; Thu, 07 Dec
 2023 04:38:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABOYnLwn2wOR-OG5fG1eS5Az12S15Tf8GbWVut5xtFj-SsOnjw@mail.gmail.com>
In-Reply-To: <CABOYnLwn2wOR-OG5fG1eS5Az12S15Tf8GbWVut5xtFj-SsOnjw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Dec 2023 13:38:23 +0100
Message-ID: <CANn89i+KiP+=WzXJvqTjRt1a3GNr1iyn+BTAJ0puYbOLkC+cHA@mail.gmail.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in ipgre_xmit
To: xingwei lee <xrivendell7@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syoshida@redhat.com, syzbot+2cb7b1bd08dc77ae7f89@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 6:03=E2=80=AFAM xingwei lee <xrivendell7@gmail.com> =
wrote:
>
> Hello Eric.
> I reproduced this bug with repro.c and repro.txt
> HEAD commit: 815fb87b753055df2d9e50f6cd80eb10235fe3e9
> kernel config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3D=
f711bc2a7eb1db25
> as the same in https://syzkaller.appspot.com/bug?extid=3D2cb7b1bd08dc77ae=
7f89
>

I think the patch has been merged in net tree, thanks.

commit 80d875cfc9d3711a029f234ef7d680db79e8fa4b
Author:     Shigeru Yoshida <syoshida@redhat.com>
AuthorDate: Sun Dec 3 01:14:41 2023 +0900
Commit:     Paolo Abeni <pabeni@redhat.com>
CommitDate: Wed Dec 6 10:08:05 2023 +0100

    ipv4: ip_gre: Avoid skb_pull() failure in ipgre_xmit()

    In ipgre_xmit(), skb_pull() may fail even if pskb_inet_may_pull() retur=
ns
    true. For example, applications can use PF_PACKET to create a malformed
    packet with no IP header. This type of packet causes a problem such as
    uninit-value access.

    This patch ensures that skb_pull() can pull the required size by checki=
ng
    the skb with pskb_network_may_pull() before skb_pull().

    Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
    Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
    Reviewed-by: Eric Dumazet <edumazet@google.com>
    Reviewed-by: Suman Ghosh <sumang@marvell.com>
    Link: https://lore.kernel.org/r/20231202161441.221135-1-syoshida@redhat=
.com
    Signed-off-by: Paolo Abeni <pabeni@redhat.com>

